local addon, ns = ...local cfg = ns.cfglocal init = ns.initif cfg.Positions == true then	local Stat = CreateFrame("Frame", nil, UIParent)	Stat:SetFrameStrata("BACKGROUND")	Stat:SetFrameLevel(3)	Stat:EnableMouse(true)	Stat:SetHitRectInsets(0, 0, 0, -10)	local Text = Stat:CreateFontString(nil, "OVERLAY")	Text:SetFont(unpack(cfg.Fonts))	Text:SetPoint(unpack(cfg.PositionsPoint))	Stat:SetAllPoints(Text)	local colorT = {		sanctuary = {SANCTUARY_TERRITORY, {.41, .8, .94}};		arena = {FREE_FOR_ALL_TERRITORY, {1, .1, .1}};		friendly = {FACTION_CONTROLLED_TERRITORY, {.1, 1, .1}};		hostile = {FACTION_CONTROLLED_TERRITORY, {1, .1, .1}};		contested = {CONTESTED_TERRITORY, {1, .7, 0}};		combat = {COMBAT_ZONE, {1, .1, .1}};		neutral = {format(FACTION_CONTROLLED_TERRITORY,FACTION_STANDING_LABEL4), {1, .93, .76}}	}	local function formatCoords()		local coords = ""		if IsInInstance() then			coords = select(4, GetInstanceInfo())		else			if not coordX or coordX == 0 or coordY == 0 then				coords = "-- , -- "			else				coords = format("%.1f , %.1f ", coordX*100, coordY*100)			end		end		return coords	end	local function currentZone()		local currentzone = ""		if subzone and subzone ~= "" and subzone ~= zone then			currentzone = subzone		else			currentzone = zone		end		return currentzone	end	local function totalZone()		local totalzone = ""		if subzone and subzone ~= "" and subzone ~= zone then			totalzone = zone.." - "..subzone		else			totalzone = zone		end		return totalzone	end	local function OnUpdate()		coordX, coordY = GetPlayerMapPosition("player")		subzone, zone, pvp = GetSubZoneText(), GetZoneText(), {GetZonePVPInfo()}		if not pvp[1] then			pvp[1] = "neutral"		end		local r,g,b = unpack(colorT[pvp[1]][2])		Text:SetFormattedText("%s：%s", currentZone(), formatCoords(), 0,.6,1, 1,1,1)		Text:SetTextColor(r, g, b)	end	Stat:RegisterEvent("ZONE_CHANGED")	Stat:RegisterEvent("ZONE_CHANGED_INDOORS")	Stat:RegisterEvent("ZONE_CHANGED_NEW_AREA")	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")	Stat:SetScript("OnUpdate", OnUpdate)	Stat:SetScript("OnEnter",function(self)		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -15)		GameTooltip:ClearLines()		GameTooltip:AddDoubleLine(format("%s", zone), format("|cffffffff<%s>", formatCoords()), 0, .6, 1, 1, 1, 1)		if pvp[1] and not IsInInstance() then			local r, g, b = unpack(colorT[pvp[1]][2])			if subzone and subzone ~= "" and subzone ~= zone then				GameTooltip:AddLine(" ")				GameTooltip:AddLine(subzone, r, g, b)			end			GameTooltip:AddLine(format(colorT[pvp[1]][1], pvp[3] or ""), r, g, b)		end		GameTooltip:AddDoubleLine(" ", "--------------", 1,1,1, .5,.5,.5)		GameTooltip:AddDoubleLine(" ", init.LeftButton..infoL["WorldMap"], 1,1,1, .6,.8,1)		GameTooltip:AddDoubleLine(" ", init.RightButton..infoL["Send My Pos"], 1,1,1, .6,.8,1)		GameTooltip:Show()	end)	Stat:SetScript("OnLeave", function()		GameTooltip_Hide()	end)	Stat:SetScript("OnMouseUp", function(_, btn)		if btn == "LeftButton" then			ToggleFrame(WorldMapFrame)		else			ChatFrame_OpenChat(format("%s：%s <%s>", infoL["My Position"], totalZone(), formatCoords()), chatFrame)		end	end)end