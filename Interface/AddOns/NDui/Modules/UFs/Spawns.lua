local B, C, L, DB = unpack(select(2, ...))
local oUF = NDui.oUF or oUF
local UF = NDui:GetModule("UnitFrames")

-- Units
local function CreatePlayerStyle(self)
	self.mystyle = "player"
	self:SetSize(245, 24)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreatePortrait(self)
	UF:CreateCastBar(self)
	UF:CreateMirrorBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreatePrediction(self)

	if NDuiDB["UFs"]["ClassPower"] then UF:CreateClassPower(self) end
	if NDuiDB["UFs"]["AddPower"] then UF:CreateAddPower(self) end
	if NDuiDB["UFs"]["ExpRep"] then
		UF:CreateExpBar(self)
		UF:CreateRepBar(self)
	end
	if NDuiDB["UFs"]["PlayerDebuff"] then UF:CreateDebuffs(self) end
	if NDuiDB["UFs"]["SwingBar"] then UF:CreateSwing(self) end
end

local function CreateTargetStyle(self)
	self.mystyle = "target"
	self:SetSize(245, 24)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreatePortrait(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreatePrediction(self)
	UF:CreateAuras(self)
end

local function CreateFocusStyle(self)
	self.mystyle = "focus"
	self:SetSize(200, 22)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreatePortrait(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreatePrediction(self)
	UF:CreateDebuffs(self)
end

local function CreateToTStyle(self)
	self.mystyle = "tot"
	self:SetSize(120, 18)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)

	if NDuiDB["UFs"]["ToTAuras"] then UF:CreateDebuffs(self) end
end

local function CreateFocusTargetStyle(self)
	self.mystyle = "focustarget"
	self:SetSize(120, 18)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)
end

local function CreatePetStyle(self)
	self.mystyle = "pet"
	self:SetSize(120, 18)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
end

local function CreateBossStyle(self)
	self.mystyle = "boss"
	self:SetSize(157, 22)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreatePortrait(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateAltPower(self)
	UF:CreateBuffs(self)
	UF:CreateDebuffs(self)
	UF:CreateTargetBorder(self)
end

local function CreateArenaStyle(self)
	self.mystyle = "arena"
	self:SetSize(157, 22)

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePortrait(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateBuffs(self)
	UF:CreateDebuffs(self)
	UF:CreateTargetBorder(self)
end

local function CreateRaidStyle(self)
	self.mystyle = "raid"
	self.Range = {
		insideAlpha = 1, outsideAlpha = .35,
	}

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreateTargetBorder(self)
	UF:CreateRaidIcons(self)
	UF:CreatePrediction(self)
	UF:CreateClickSets(self)
	UF:CreateRaidDebuffs(self)

	if not NDuiDB["UFs"]["SimpleMode"] then UF:CreateBuffs(self) end
	if NDuiDB["UFs"]["ThreatBorder"] then UF:CreateThreatBorder(self) end
end

local function CreatePartyStyle(self)
	self.mystyle = "party"
	self.Range = {
		insideAlpha = 1, outsideAlpha = .35,
	}

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePortrait(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreateTargetBorder(self)
	UF:CreateRaidIcons(self)
	UF:CreatePrediction(self)
	UF:CreateClickSets(self)
	UF:CreateDebuffs(self)

	if NDuiDB["UFs"]["ThreatBorder"] then UF:CreateThreatBorder(self) end
end

oUF:RegisterStyle("Player", CreatePlayerStyle)
oUF:RegisterStyle("Target", CreateTargetStyle)
oUF:RegisterStyle("ToT", CreateToTStyle)
oUF:RegisterStyle("Focus", CreateFocusStyle)
oUF:RegisterStyle("FocusTarget", CreateFocusTargetStyle)
oUF:RegisterStyle("Pet", CreatePetStyle)
oUF:RegisterStyle("Boss", CreateBossStyle)
oUF:RegisterStyle("Arena", CreateArenaStyle)
oUF:RegisterStyle("Raid", CreateRaidStyle)
oUF:RegisterStyle("Party", CreatePartyStyle)
oUF:RegisterStyle("Nameplates", UF.CreatePlates)

-- Spawns
function UF:OnLogin()
	if NDuiDB["Nameplate"]["Enable"] then
		self:SetupCVars()
		self:BlockAddons()
		self:CreateUnitTable()
		self:CreatePowerUnitTable()
		self:CreateClassBar()

		oUF:SetActiveStyle("Nameplates")
		oUF:SpawnNamePlates("oUF_NPs", UF.PostUpdatePlates)
	end

	-- Default Clicksets for RaidFrame
	self:DefaultClickSets()

	if not NDuiDB["UFs"]["Enable"] then return end

	oUF:SetActiveStyle("Player")
	local player = oUF:Spawn("Player", "oUF_Player")
	B.Mover(player, L["PlayerUF"], "PlayerUF", C.UFs.PlayerPos, 245, 30)

	oUF:SetActiveStyle("Target")
	local target = oUF:Spawn("Target", "oUF_Target")
	B.Mover(target, L["TargetUF"], "TargetUF", C.UFs.TargetPos, 245, 30)

	oUF:SetActiveStyle("ToT")
	local targettarget = oUF:Spawn("TargetTarget", "oUF_ToT")
	B.Mover(targettarget, L["TotUF"], "TotUF", C.UFs.ToTPos, 120, 30)

	oUF:SetActiveStyle("Pet")
	local pet = oUF:Spawn("Pet", "oUF_Pet")
	B.Mover(pet, L["PetUF"], "PetUF", C.UFs.PetPos, 120, 30)

	oUF:SetActiveStyle("Focus")
	local focus = oUF:Spawn("Focus", "oUF_Focus")
	B.Mover(focus, L["FocusUF"], "FocusUF", C.UFs.FocusPos, 200, 30)

	oUF:SetActiveStyle("FocusTarget")
	local focustarget = oUF:Spawn("FocusTarget", "oUF_FocusTarget")
	B.Mover(focustarget, L["FotUF"], "FotUF", C.UFs.FoTPos, 120, 30)

	if NDuiDB["Extras"]["PartyFrame"] then
		oUF:SetActiveStyle("Party")
		local party = oUF:SpawnHeader('oUF_Party', nil, "solo,party",
			"showPlayer", false,
			"showSolo", false,
			"showParty", true,
			"yoffset", -16,
			"oUF-initialConfigFunction", ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(196, 19))
		B.Mover(party, L["PartyUF"], "PartyUF", {"LEFT", UIParent, "LEFT", 10, 0}, 196, (19 + 16) * 4)
	end

	if NDuiDB["UFs"]["Boss"] then
		oUF:SetActiveStyle("Boss")
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = oUF:Spawn("Boss"..i, "oUF_Boss"..i)
			if i == 1 then
				B.Mover(boss[i], L["Boss1"], "Boss1", {"TOPRIGHT", Minimap, "BOTTOMLEFT", 75, -100}, 157, 30)
			else
				B.Mover(boss[i], L["Boss"..i], "Boss"..i, {"TOPRIGHT", boss[i-1], "BOTTOMRIGHT", 0, -55}, 157, 30)
			end
		end
	end

	if NDuiDB["UFs"]["Arena"] then
		oUF:SetActiveStyle("Arena")
		local arena = {}
		for i = 1, 5 do
			arena[i] = oUF:Spawn("Arena"..i, "oUF_Arena"..i)
			if i == 1 then
				B.Mover(arena[i], L["Arena1"], "Arena1", {"TOPRIGHT", Minimap, "BOTTOMLEFT", -100, -100}, 157, 30)
			else
				B.Mover(arena[i], L["Arena"..i], "Arena"..i, {"TOPRIGHT", arena[i-1], "BOTTOMRIGHT", 0, -55}, 157, 30)
			end
		end

		local bars = {}
		for i = 1, 5 do
			bars[i] = CreateFrame("Frame", nil, UIParent)
			bars[i]:SetAllPoints(arena[i])
			B.CreateSD(bars[i], 3, 3)
			bars[i]:Hide()

			bars[i].Health = CreateFrame("StatusBar", nil, bars[i])
			bars[i].Health:SetAllPoints()
			bars[i].Health:SetStatusBarTexture(DB.normTex)
			bars[i].Health:SetStatusBarColor(.3, .3, .3)
			bars[i].SpecClass = B.CreateFS(bars[i].Health, 12, "")
		end

		local f = NDui:EventFrame({"PLAYER_ENTERING_WORLD", "ARENA_PREP_OPPONENT_SPECIALIZATIONS", "ARENA_OPPONENT_UPDATE"})
		f:SetScript("OnEvent", function(_, event)
			if event == "ARENA_OPPONENT_UPDATE" then
				for i = 1, 5 do
					bars[i]:Hide()
				end
			else
				local numOpps = GetNumArenaOpponentSpecs()
				if numOpps > 0 then
					for i = 1, 5 do
						local s = GetArenaOpponentSpec(i)
						local _, spec, class
						if s and s > 0 then
							_, spec, _, _, _, class = GetSpecializationInfoByID(s)
						end
						if (i <= numOpps) then
							if class and spec then
								bars[i].Health:SetStatusBarColor(B.ClassColor(class))
								bars[i].SpecClass:SetText(spec.."  -  "..LOCALIZED_CLASS_NAMES_MALE[class] or "UNKNOWN")
								bars[i]:Show()
							end
						else
							bars[i]:Hide()
						end
					end
				else
					for i = 1, 5 do
						bars[i]:Hide()
					end
				end
			end
		end)
	end

	if NDuiDB["UFs"]["RaidFrame"] then
		-- Disable Default RaidFrame
		CompactRaidFrameContainer:UnregisterAllEvents()
		CompactRaidFrameContainer:Hide()
		CompactRaidFrameContainer.Show = CompactRaidFrameContainer.Hide
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameManager:Hide()
		CompactRaidFrameManager.Show = CompactRaidFrameManager.Hide

		-- Group Styles
		oUF:SetActiveStyle("Raid")

		local numGroups = NDuiDB["UFs"]["NumGroups"]
		local horizon = NDuiDB["UFs"]["HorizonRaid"]
		local scale = NDuiDB["UFs"]["RaidScale"]
		local raidMover

		if NDuiDB["UFs"]["SimpleMode"] then
			local function CreateGroup(name, i)
				local group = oUF:SpawnHeader(name, nil, "solo,party,raid",
				"showPlayer", true,
				"showSolo", false,
				"showParty", not NDuiDB["Extras"]["PartyFrame"],
				"showRaid", true,
				"xoffset", 5,
				"yOffset", -10,
				"groupFilter", tostring(i),
				"groupingOrder", "1,2,3,4,5,6,7,8",
				"groupBy", "GROUP",
				"sortMethod", "INDEX",
				"maxColumns", 2,
				"unitsPerColumn", 20,
				"columnSpacing", 5,
				"point", "TOP",
				"columnAnchorPoint", "LEFT",
				"oUF-initialConfigFunction", ([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(100*scale, 20*scale))
				return group
			end

			local groupFilter
			if numGroups == 4 then
				groupFilter = "1,2,3,4"
			elseif numGroups == 5 then
				groupFilter = "1,2,3,4,5"
			elseif numGroups == 6 then
				groupFilter = "1,2,3,4,5,6"
			elseif numGroups == 7 then
				groupFilter = "1,2,3,4,5,7"
			elseif numGroups == 8 then
				groupFilter = "1,2,3,4,5,8"
			end

			local group = CreateGroup("oUF_Raid", groupFilter)
			raidMover = B.Mover(group, L["RaidFrame"], "RaidFrame", {"TOPLEFT", UIParent, 35, -50}, 140*scale, 30*20*scale)
		else
			local function CreateGroup(name, i)
				local group = oUF:SpawnHeader(name, nil, "solo,party,raid",
				"showPlayer", true,
				"showSolo", false,
				"showParty", not NDuiDB["Extras"]["PartyFrame"],
				"showRaid", true,
				"xoffset", 5,
				"yOffset", -10,
				"groupFilter", tostring(i),
				"groupingOrder", "1,2,3,4,5,6,7,8",
				"groupBy", "GROUP",
				"sortMethod", "INDEX",
				"maxColumns", 1,
				"unitsPerColumn", 5,
				"columnSpacing", 5,
				"point", horizon and "LEFT" or "TOP",
				"columnAnchorPoint", "LEFT",
				"oUF-initialConfigFunction", ([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(80*scale, 32*scale))
				return group
			end

			local groups = {}
			for i = 1, numGroups do
				groups[i] = CreateGroup("oUF_Raid"..i, i)
				if i == 1 then
					if horizon then
						raidMover = B.Mover(groups[i], L["RaidFrame"], "RaidFrame", {"TOPLEFT", UIParent, 35, -50}, 84*5*scale, 40*numGroups*scale)
					else
						raidMover = B.Mover(groups[i], L["RaidFrame"], "RaidFrame", {"TOPLEFT", UIParent, 35, -50}, 85*numGroups*scale, 42*5*scale)
					end
				else
					if horizon then
						groups[i]:SetPoint("TOPLEFT", groups[i-1], "BOTTOMLEFT", 0, -10)
					else
						groups[i]:SetPoint("TOPLEFT", groups[i-1], "TOPRIGHT", 5, 0)
					end
				end
			end
		end

		if raidMover then
			if not NDuiDB["UFs"]["SpecRaidPos"] then return end

			NDui:EventFrame({"UNIT_SPELLCAST_SUCCEEDED", "PLAYER_ENTERING_WORLD"}):SetScript("OnEvent", function(_, event, ...)
				local unit, _, _, _, spellID = ...
				if (event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and spellID == 200749) or event == "PLAYER_ENTERING_WORLD" then
					if not GetSpecialization() then return end
					local specIndex = GetSpecialization()
					if not NDuiDB["Mover"]["RaidPos"..specIndex] then
						NDuiDB["Mover"]["RaidPos"..specIndex] = {"TOPLEFT", "UIParent", "TOPLEFT", 35, -50}
					end
					raidMover:ClearAllPoints()
					raidMover:SetPoint(unpack(NDuiDB["Mover"]["RaidPos"..specIndex]))
				end
			end)

			raidMover:HookScript("OnDragStop", function()
				if not GetSpecialization() then return end
				local specIndex = GetSpecialization()
				NDuiDB["Mover"]["RaidPos"..specIndex] = NDuiDB["Mover"]["RaidFrame"]
			end)
		end
	end
end