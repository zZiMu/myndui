local _, ns = ...
local B, C, L, DB = unpack(ns)
local module = B:GetModule("Misc")

--[[
	一个工具条用来替代系统的经验条、声望条、神器经验等等
]]
local function UpdateBar(bar)
	local rest = bar.restBar
	if rest then rest:Hide() end

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local xp, mxp, rxp = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
		bar:SetStatusBarColor(0, .7, 1)
		bar:SetMinMaxValues(0, mxp)
		bar:SetValue(xp)
		bar:Show()
		if rxp then
			rest:SetMinMaxValues(0, mxp)
			rest:SetValue(math.min(xp + rxp, mxp))
			rest:Show()
		end
		if IsXPUserDisabled() then bar:SetStatusBarColor(.7, 0, 0) end
	elseif GetWatchedFactionInfo() then
		local _, standing, min, max, value, factionID = GetWatchedFactionInfo()
		local friendID, friendRep, _, _, _, _, _, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
		if friendID then
			if nextFriendThreshold then
				min, max, value = friendThreshold, nextFriendThreshold, friendRep
			else
				min, max, value = 0, 1, 1
			end
			standing = 5
		elseif C_Reputation.IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID)
			currentValue = mod(currentValue, threshold)
			min, max, value = 0, threshold, currentValue
		else
			if standing == MAX_REPUTATION_REACTION then min, max, value = 0, 1, 1 end
		end
		bar:SetStatusBarColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b, .85)
		bar:SetMinMaxValues(min, max)
		bar:SetValue(value)
		bar:Show()
	elseif C_AzeriteItem.HasActiveAzeriteItem() then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		bar:SetStatusBarColor(.9, .8, .6)
		bar:SetMinMaxValues(0, totalLevelXP)
		bar:SetValue(xp)
		bar:Show()
	elseif HasArtifactEquipped() then
		local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
		local _, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, artifactTier)
		xp = xpForNextPoint == 0 and 0 or xp
		bar:SetStatusBarColor(.9, .8, .6)
		bar:SetMinMaxValues(0, xpForNextPoint)
		bar:SetValue(xp)
		bar:Show()
	else
		bar:Hide()
	end

	-- Available ArtfactPoint
	if bar.newPoint then
		bar.newPoint:SetAlpha(0)
		if HasArtifactEquipped() then
			local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
			local num = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, artifactTier)
			if num > 0 then bar.newPoint:SetAlpha(1) end
		end
	end
end

local function UpdateTooltip(bar)
	GameTooltip:SetOwner(bar, "ANCHOR_LEFT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(LEVEL.." "..UnitLevel("player"), 0,.6,1)

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local xp, mxp, rxp = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
			GameTooltip:AddDoubleLine(XP..L[":"], B.Numb(xp).." / "..B.Numb(mxp)..string.format("(%.1f%%)", xp/mxp*100), .6,.8,1, 1,1,1)
			GameTooltip:AddDoubleLine(L["Need XP"]..L[":"], B.Numb(mxp-xp)..string.format(" (%.1f%%)", (1-xp/mxp)*100), .6,.8,1, 1,1,1)
		if rxp then
			GameTooltip:AddDoubleLine(TUTORIAL_TITLE26..L[":"], "+"..B.Numb(rxp)..string.format(" (%.1f%%)", rxp/mxp*100), .6,.8,1, 1,1,1)
		end
		if IsXPUserDisabled() then GameTooltip:AddLine("|cffff0000"..XP..LOCKED) end
	end

	if GetWatchedFactionInfo() then
		local name, standing, min, max, value, factionID = GetWatchedFactionInfo()
		local friendID, _, _, _, _, _, friendTextLevel, _, nextFriendThreshold = GetFriendshipReputation(factionID)
		local currentRank, maxRank = GetFriendshipReputationRanks(friendID)
		local standingtext
		if friendID then
			if maxRank > 0 then
				name = name.." ("..currentRank.." / "..maxRank..")"
			end
			if not nextFriendThreshold then
				value = max - 1
			end
			standingtext = friendTextLevel
		else
			if standing == MAX_REPUTATION_REACTION then
				max = min + 1e3
				value = max - 1
			end
			standingtext = GetText("FACTION_STANDING_LABEL"..standing, UnitSex("player"))
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(name, 0,.6,1)
		GameTooltip:AddDoubleLine(standingtext, value - min.." / "..max - min..string.format(" (%.1f%%)", (value - min)/(max - min)*100), .6,.8,1, 1,1,1)

		if C_Reputation.IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID)
			local paraCount = floor(currentValue/threshold)
			currentValue = mod(currentValue, threshold)
			GameTooltip:AddDoubleLine(L["ParagonRep"]..paraCount, currentValue.." / "..threshold..string.format(" (%.1f%%)", (currentValue/threshold*100)), .6,.8,1, 1,1,1)
		end
	end

	if IsWatchingHonorAsXP() then
		local current, max, level = UnitHonor("player"), UnitHonorMax("player"), UnitHonorLevel("player")
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(HONOR, .0,.6,1)
		GameTooltip:AddDoubleLine(LEVEL.." "..level, current.." / "..max, .6,.8,1, 1,1,1)
	end

	if C_AzeriteItem.HasActiveAzeriteItem() then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		local azeriteItemName = azeriteItem:GetItemName()
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(C_AzeriteItem.FindActiveAzeriteItem())
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(azeriteItemName.." ("..format(SPELLBOOK_AVAILABLE_AT, currentLevel)..")", 0,.6,1)
		GameTooltip:AddDoubleLine(ARTIFACT_POWER, B.Numb(xp).." / "..B.Numb(totalLevelXP).." ("..floor(xp/totalLevelXP*100).."%)", .6,.8,1, 1,1,1)
	end

	if HasArtifactEquipped() then
		local _, _, name, _, totalXP, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
		local num, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, artifactTier)
		GameTooltip:AddLine(" ")
		if pointsSpent > 51 then
			GameTooltip:AddLine(name.." ("..format(SPELLBOOK_AVAILABLE_AT.." - "..SPELLBOOK_AVAILABLE_AT, pointsSpent, pointsSpent - 51)..")", 0,.6,1)
		else
			GameTooltip:AddLine(name.." ("..format(SPELLBOOK_AVAILABLE_AT, pointsSpent)..")", 0,.6,1)
		end
		if xpForNextPoint ~= 0 then
			local numText = num > 0 and " ("..num..")" or ""
			GameTooltip:AddDoubleLine(ARTIFACT_POWER..L[":"], B.Numb(totalXP)..numText, .6,.8,1, 1,1,1)
			GameTooltip:AddDoubleLine(L["Next Trait"]..L[":"], B.Numb(xp).." / "..B.Numb(xpForNextPoint)..string.format(" (%.1f%%)", xp/xpForNextPoint*100), .6,.8,1, 1,1,1)
			GameTooltip:AddDoubleLine(L["Need Trait"]..L[":"], B.Numb(xpForNextPoint-xp)..string.format(" (%.1f%%)", (1-xp/xpForNextPoint)*100), .6,.8,1, 1,1,1)
		end
	end

	GameTooltip:Show()
end

function module:SetupScript(bar)
	bar.eventList = {
		"PLAYER_XP_UPDATE",
		"PLAYER_LEVEL_UP",
		"UPDATE_EXHAUSTION",
		"PLAYER_ENTERING_WORLD",
		"UPDATE_FACTION",
		"ARTIFACT_XP_UPDATE",
		"UNIT_INVENTORY_CHANGED",
		"ENABLE_XP_GAIN",
		"DISABLE_XP_GAIN",
		"AZERITE_ITEM_EXPERIENCE_CHANGED",
	}
	for _, event in pairs(bar.eventList) do
		bar:RegisterEvent(event)
	end
	bar:SetScript("OnEvent", UpdateBar)
	bar:SetScript("OnEnter", UpdateTooltip)
	bar:SetScript("OnLeave", GameTooltip_Hide)
	bar:SetScript("OnMouseUp", function(_, btn)
		if not HasArtifactEquipped() or btn ~= "LeftButton" then return end
		if not ArtifactFrame or not ArtifactFrame:IsShown() then
			SocketInventoryItem(16)
		else
			ToggleFrame(ArtifactFrame)
		end
	end)
end

function module:Expbar()
	if not NDuiDB["Misc"]["ExpRep"] then return end

	local bar = CreateFrame("StatusBar", nil, Minimap)
	bar:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)
	bar:SetSize(Minimap:GetWidth() - 10, 4)
	bar:SetHitRectInsets(0, 0, 0, -10)
	B.CreateSB(bar, true)

	local rest = CreateFrame("StatusBar", nil, bar)
	rest:SetAllPoints()
	rest:SetStatusBarTexture(DB.normTex)
	rest:SetStatusBarColor(0, .4, 1, .6)
	rest:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar.restBar = rest

	local newPoint = bar:CreateTexture(nil, "OVERLAY")
	newPoint:SetTexture("Interface\\COMMON\\ReputationStar")
	newPoint:SetTexCoord(.5, 1, .5, 1)
	newPoint:SetSize(18, 18)
	newPoint:SetPoint("CENTER", 0, -2)
	bar.newPoint = newPoint

	self:SetupScript(bar)
end