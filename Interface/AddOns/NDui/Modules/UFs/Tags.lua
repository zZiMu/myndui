local _, ns = ...
local B, C, L, DB = unpack(ns)
local oUF = ns.oUF or oUF

local function ColorPercent(value)
	local r, g, b
	if value < 20 then
		r, g, b = 1, .1, .1
	elseif value < 35 then
		r, g, b = 1, .5, 0
	elseif value < 80 then
		r, g, b = 1, .9, .3
	else
		r, g, b = 1, 1, 1
	end
	return B.HexRGB(r, g, b)..value
end

oUF.Tags.Methods["hp"] = function(unit)
	if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
		return oUF.Tags.Methods["DDG"](unit)
	else
		local per = oUF.Tags.Methods["perhp"](unit).."%" or 0
		local cur, max = UnitHealth(unit), UnitHealthMax(unit)

		if unit == "player" or unit == "target" or unit == "focus" then
			if cur < max then
				if NDuiDB["Extras"]["OtherUFs"] and unit == "player" then
					return per.." | "..B.Numb(cur)
				else
					return B.Numb(cur).." | "..per
				end
			else
				return B.Numb(cur)
			end
		elseif UnitInParty(unit) and unit:match("party") then
			return B.Numb(cur)
		else
			return per
		end
	end
end
oUF.Tags.Events["hp"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags.Methods["power"] = function(unit)
	local cur, max = UnitPower(unit), UnitPowerMax(unit)
	local per = oUF.Tags.Methods["perpp"](unit).."%" or 0

	if unit == "player" or unit == "target" or unit == "focus" then
		if cur < max and UnitPowerType(unit) == 0 then
			if NDuiDB["Extras"]["OtherUFs"] and unit == "player" then
				return per.." | "..B.Numb(cur)
			else
				return B.Numb(cur).." | "..per
			end
		else
			return B.Numb(cur)
		end
	else
		return per
	end
end
oUF.Tags.Events["power"] = "UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_DISPLAYPOWER"

oUF.Tags.Methods["color"] = function(unit)
	local class = select(2, UnitClass(unit))
	local reaction = UnitReaction(unit, "player")

	if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
		return "|cffC0C0C0"
	elseif UnitIsTapDenied(unit) then
		return B.HexRGB(oUF.colors.tapped)
	elseif UnitIsPlayer(unit) then
		return B.HexRGB(oUF.colors.class[class])
	elseif reaction then
		return B.HexRGB(oUF.colors.reaction[reaction])
	else
		return B.HexRGB(1, 1, 1)
	end
end
oUF.Tags.Events["color"] = "UNIT_HEALTH UNIT_CONNECTION"

oUF.Tags.Methods["afkdnd"] = function(unit)
	if UnitIsAFK(unit) then
		return " |cffC0C0C0<"..AFK..">|r"
	elseif UnitIsDND(unit) then
		return " |cffC0C0C0<"..DND..">|r"
	else
		return ""
	end
end
oUF.Tags.Events["afkdnd"] = "PLAYER_FLAGS_CHANGED"

oUF.Tags.Methods["DDG"] = function(unit)
	if UnitIsDead(unit) then
		return "|cffC0C0C0"..DEAD.."|r"
	elseif UnitIsGhost(unit) then
		return "|cffC0C0C0"..L["Ghost"].."|r"
	elseif not UnitIsConnected(unit) then
		return "|cffC0C0C0"..PLAYER_OFFLINE.."|r"
	end
end
oUF.Tags.Events["DDG"] = "UNIT_HEALTH UNIT_CONNECTION"

-- Level tags
oUF.Tags.Methods["fulllevel"] = function(unit)
	local level = UnitLevel(unit)
	local class = UnitClassification(unit)
	local color = B.HexRGB(GetCreatureDifficultyColor(level))

	if UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) then
		level = UnitBattlePetLevel(unit)
	end

	if not NDuiDB["Extras"]["OtherUFs"] then
		if level ~= UnitLevel("player") then
			if level > 0 then
				level = color..level.."|r"
			else
				level = "|cffFF0000"..BOSS.."|r"
			end
		else
			level = ""
		end
	else
		if level > 0 then
			level = "Lv"..color..level.."|r"
		else
			level = "|cffFF0000"..BOSS.."|r"
		end
	end

	local str = level
	if class == "elite" then
		str = level.." |cffFFFF00"..ELITE.."|r"
	elseif class == "rare" then
		str = level.." |cffFF00FF"..L["Rare"].."|r"
	elseif class == "rareelite" then
		str = level.." |cff00FFFF"..L["Rare"]..ELITE.."|r"
	elseif class == "worldboss" then
		str = " |cffFF0000"..BOSS.."|r"
	end

	return str
end
oUF.Tags.Events["fulllevel"] = "UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED"

-- RaidFrame tags
oUF.Tags.Methods["raidhp"] = function(unit)
	if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
		return oUF.Tags.Methods["DDG"](unit)
	else
		return oUF.Tags.Methods["perhp"](unit).."%" or 0
	end
end
oUF.Tags.Events["raidhp"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION"

-- Nameplate tags
oUF.Tags.Methods["nphp"] = function(unit)
	local per = oUF.Tags.Methods["perhp"](unit).."%" or 0
	local min, max = UnitHealth(unit), UnitHealthMax(unit)

	if min < max then
		return "|cff00FFFF"..per.."|r"
	end
end
oUF.Tags.Events["nphp"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags.Methods["nppp"] = function(unit)
	if not C.ShowPowerList[UnitName(unit)] then return end
	local per = oUF.Tags.Methods["perpp"](unit).."%" or 0
	local min, max = UnitPower(unit), UnitPowerMax(unit)

	if min > 0 then
		return "|cffFFFF00"..per.."|r"
	end
end
oUF.Tags.Events["nppp"] = "UNIT_POWER_FREQUENT UNIT_MAXPOWER"

oUF.Tags.Methods["nplevel"] = function(unit)
	local level = UnitLevel(unit)
	local color = B.HexRGB(GetCreatureDifficultyColor(level))

	if level and level ~= UnitLevel("player") then
		if level > 0 then
			level = color..level.."|r "
		else
			level = "|cffFF0000"..BOSS.."|r "
		end
	else
		level = ""
	end

	return level
end
oUF.Tags.Events["nplevel"] = "UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED"

-- AltPower value tag
oUF.Tags.Methods["altpower"] = function(unit)
	local cur = UnitPower(unit, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)

	if max > 0 and not UnitIsDeadOrGhost(unit) then
		return ("%.1f%%"):format(cur / max*100)
	end
end
oUF.Tags.Events["altpower"] = "UNIT_POWER_UPDATE"