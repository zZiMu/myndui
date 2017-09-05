local B, C, L, DB = unpack(select(2, ...))

local iconSize = 33

local fontSizeItem = math.floor(select(2, GameFontWhite:GetFont()) + .5)

local point = {"CENTER", 300, 0}
local slots = {}

local LightLoot = CreateFrame("Button", "LightLoot")
B.CreateBD(LightLoot, .5, 1, true)
B.CreateSD(LightLoot, 2, 3)
B.CreateTex(LightLoot)
LightLoot:RegisterForClicks("AnyUp")
LightLoot:SetClampedToScreen(true)
LightLoot:SetClampRectInsets(0, 0, 14, 0)
LightLoot:SetFrameStrata("DIALOG")
LightLoot:SetHitRectInsets(0, 0, -14, 0)
LightLoot:SetMovable(true)
LightLoot:SetParent(UIParent)
LightLoot:SetToplevel(true)

LightLoot:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

LightLoot:SetScript("OnHide", function(self)
	StaticPopup_Hide("CONFIRM_LOOT_DISTRIBUTION")
	CloseLoot()
end)

local Title = B.CreateFS(LightLoot, 18, "", true, "TOPLEFT", 4, 20)
LightLoot.Title = Title

local function OnEnter(self)
	local slot = self:GetID()
	if GetLootSlotType(slot) == LOOT_SLOT_ITEM then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetLootItem(slot)
		CursorUpdate(self)
	end
	self.glow:Show()
end

local function OnLeave(self)
	self.glow:Hide()
	GameTooltip:Hide()
	ResetCursor()
end

local function OnClick(self)
	if IsModifiedClick() then
		HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
	else
		StaticPopup_Hide("CONFIRM_LOOT_DISTRIBUTION")

		LootFrame.selectedLootButton = self
		LootFrame.selectedSlot = self:GetID()
		LootFrame.selectedQuality = self.quality
		LootFrame.selectedItemName = self.name:GetText()

		LootSlot(self:GetID())
	end
end

local function OnUpdate(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetLootItem(self:GetID())
		CursorOnUpdate(self)
	end
end

local function CreateSlot(id)
	local cr, cg, cb = DB.ClassColor.r, DB.ClassColor.g, DB.ClassColor.b

	local button = CreateFrame("Button", "LightLootSlot"..id, LightLoot)
	button:SetHeight(math.max(fontSizeItem, iconSize))
	button:SetPoint("LEFT", 5, 0)
	button:SetPoint("RIGHT", -5, 0)
	button:SetID(id)

	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnClick", OnClick)
	button:SetScript("OnUpdate", OnUpdate)

	local iconBorder = CreateFrame("Frame", nil, button)
	iconBorder:SetSize(iconSize, iconSize)
	iconBorder:SetPoint("LEFT", button)
	B.CreateBD(iconBorder, 1, 1, true)
	button.iconBorder = iconBorder

	local icon = iconBorder:CreateTexture(nil, "ARTWORK")
	icon:SetAlpha(.8)
	icon:SetTexCoord(.08, .92, .08, .92)
	icon:SetPoint("TOPLEFT", 1, -1)
	icon:SetPoint("BOTTOMRIGHT", -1, 1)
	button.icon = icon

	local glow = button:CreateTexture(nil, "ARTWORK")
	glow:SetAlpha(.5)
	glow:SetPoint("TOPLEFT", icon, "TOPRIGHT", 3, 0)
	glow:SetPoint("BOTTOMRIGHT", button)
	glow:SetTexture(DB.bdTex)
	glow:SetVertexColor(cr, cg, cb)
	glow:Hide()
	button.glow = glow

	local bind = B.CreateFS(iconBorder, 14, "", false, "TOPLEFT", 1, -1)
	bind:SetJustifyH("LEFT")
	button.bind = bind

	local ilvl = B.CreateFS(iconBorder, 14, "", false, "BOTTOMRIGHT", -1, 1)
	ilvl:SetJustifyH("RIGHT")
	button.ilvl = ilvl

	local count = B.CreateFS(iconBorder, 14, "", false, "BOTTOMRIGHT", -1, 1)
	count:SetJustifyH("RIGHT")
	button.count = count

	local name = B.CreateFS(iconBorder, 14, "")
	name:SetJustifyH("LEFT")
	name:SetPoint("LEFT", icon, "RIGHT", 5, 0)
	name:SetNonSpaceWrap(true)
	button.name = name

	slots[id] = button
	return button
end

function LightLoot:UpdateWidth()
	local maxWidth = 0
	for _, slot in next, slots do
		if slot:IsShown() then
			local width = slot.name:GetStringWidth()
			if width > maxWidth then
				maxWidth = width
			end
		end
	end

	self:SetWidth(math.max(maxWidth + 16 + iconSize, self.Title:GetStringWidth() + 5))
end

function LightLoot:AnchorSlots()
	local buttonSize = math.max(iconSize, fontSizeItem)
	local shownSlots = 0

	for i = 1, #slots do
		local button = slots[i]
		if button:IsShown() then
			shownSlots = shownSlots + 1
			button:SetPoint("TOP", LightLoot, 0, (-5 + iconSize) - (shownSlots * iconSize) - (shownSlots - 1) * 5)
		end
	end

	self:SetHeight(math.max(shownSlots * iconSize + 10 + (shownSlots - 1) * 5 , iconSize))
end

function LightLoot:LOOT_OPENED(event, autoloot)
	self:Show()

	if not self:IsShown() then
		CloseLoot(not autoLoot)
	end

	if IsFishingLoot() then
		self.Title:SetText(GetSpellInfo(131474))
	elseif UnitIsDead("target") then
		self.Title:SetText(UnitName("target"))
	else
		self.Title:SetText(LOOT)
	end

	if GetCVar("lootUnderMouse") == "1" then
		local x, y = GetCursorPosition()
		x = x / self:GetEffectiveScale()
		y = y / self:GetEffectiveScale()

		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x - 40, y + 20)
		self:GetCenter()
		self:Raise()
	else
		self:ClearAllPoints()
		self:SetUserPlaced(false)
		self:SetPoint(unpack(point))
	end

	local maxQuality = 0
	local items = GetNumLootItems()
	if items > 0 then
		for i = 1, items do
			local slot = slots[i] or CreateSlot(i)
			local texture, item, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(i)
			if texture then
				local color = BAG_ITEM_QUALITY_COLORS[quality]
				local link = GetLootSlotLink(i)
				local itemLvl = NDui:GetItemLevel(link, quality)
				local bindType = select(14, GetItemInfo(link))

				local slotType = GetLootSlotType(i)
				if slotType == LOOT_SLOT_MONEY then
					item = item:gsub("\n", "，")
				end

				if quantity and quantity > 1 then
					slot.count:SetText(B.Numb(quantity))
					slot.count:Show()
				else
					slot.count:Hide()
				end

				if quality and quality >= 0 then
					slot.name:SetTextColor(color.r, color.g, color.b)
					slot.iconBorder:SetBackdropBorderColor(color.r, color.g, color.b)
					slot.quality = quality
				else
					slot.name:SetTextColor(.5, .5, .5)
					slot.iconBorder:SetBackdropBorderColor(.5, .5, .5)
				end

				if link and (quality and quality > 0) then
					slot.ilvl:SetText(itemLvl)
				else
					slot.ilvl:SetText("")
				end

				if bindType and (bindType == 2 or bindType == 3) then
					slot.bind:SetText(bindType == 2 and "BoE" or "BoU")
				else
					slot.bind:SetText("")
				end

				slot.name:SetText(item)
				slot.icon:SetTexture(texture)

				maxQuality = math.max(maxQuality, quality)

				slot:Enable()
				slot:Show()
			end
		end
	else
		local slot = slots[1] or CreateSlot(1)

		slot.name:SetText(NONE)
		slot.name:SetTextColor(.5, .5, .5)
		slot.icon:SetTexture(nil)

		slot.count:Hide()
		slot.glow:Hide()
		slot:Disable()
		slot:Show()
	end

	local color = BAG_ITEM_QUALITY_COLORS[maxQuality]
	self:SetBackdropBorderColor(color.r, color.g, color.b)
	self.Shadow:SetBackdropBorderColor(color.r, color.g, color.b)

	self:AnchorSlots()
	self:UpdateWidth()
end
LightLoot:RegisterEvent("LOOT_OPENED")

function LightLoot:LOOT_SLOT_CLEARED(event, slot)
	if not self:IsShown() then return end

	slots[slot]:Hide()
	self:AnchorSlots()
end
LightLoot:RegisterEvent("LOOT_SLOT_CLEARED")

function LightLoot:LOOT_CLOSED()
	StaticPopup_Hide("LOOT_BIND")
	self:Hide()

	for _, v in pairs(slots) do
		v:Hide()
	end
end
LightLoot:RegisterEvent("LOOT_CLOSED")

function LightLoot:OPEN_MASTER_LOOT_LIST()
	ToggleDropDownMenu(1, nil, GroupLootDropDown, LootFrame.selectedLootButton, 0, 0)
end
LightLoot:RegisterEvent("OPEN_MASTER_LOOT_LIST")

function LightLoot:UPDATE_MASTER_LOOT_LIST()
	UIDropDownMenu_Refresh(GroupLootDropDown)
end
LightLoot:RegisterEvent("UPDATE_MASTER_LOOT_LIST")

LootFrame:UnregisterAllEvents()
table.insert(UISpecialFrames, "LightLoot")