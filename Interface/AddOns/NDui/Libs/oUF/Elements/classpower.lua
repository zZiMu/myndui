local _, ns = ...
local oUF = ns.oUF

local _, PlayerClass = UnitClass('player')

-- sourced from FrameXML/Constants.lua
local SPEC_MAGE_ARCANE = SPEC_MAGE_ARCANE or 1
local SPEC_MONK_WINDWALKER = SPEC_MONK_WINDWALKER or 3
local SPEC_PALADIN_RETRIBUTION = SPEC_PALADIN_RETRIBUTION or 3
local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION or 3
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY or 3
local SPELL_POWER_COMBO_POINTS = SPELL_POWER_COMBO_POINTS or 4
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS or 7
local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER or 9
local SPELL_POWER_CHI = SPELL_POWER_CHI or 12
local SPELL_POWER_ARCANE_CHARGES = SPELL_POWER_ARCANE_CHARGES or 16

-- sourced from FrameXML/TargetFrame.lua
local MAX_COMBO_POINTS = MAX_COMBO_POINTS or 5

-- Holds the class specific stuff.
local ClassPowerID, ClassPowerType
local ClassPowerEnable, ClassPowerDisable
local RequireSpec, RequirePower, RequireSpell

local function UpdateColor(element, powerType)
	local color = element.__owner.colors.power[powerType]
	local r, g, b = color[1], color[2], color[3]
	for i = 1, #element do
		local bar = element[i]
		bar:SetStatusBarColor(r, g, b)

		local bg = bar.bg
		if (bg) then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r * mu, g * mu, b * mu)
		end
	end
end

local function Update(self, event, unit, powerType)
	if (not (self.unit == unit and (unit == 'player' and powerType == ClassPowerType
		or unit == 'vehicle' and powerType == 'COMBO_POINTS'))) then
		return
	end

	local element = self.ClassPower

	if (element.PreUpdate) then
		element:PreUpdate()
	end

	local cur, max, mod, oldMax
	if (event ~= 'ClassPowerDisable') then
		if (unit == 'vehicle') then
			-- BUG: UnitPower always returns 0 combo points for vehicles
			cur = GetComboPoints(unit)
			max = MAX_COMBO_POINTS
			mod = 1
		else
			cur = UnitPower('player', ClassPowerID, true)
			max = UnitPowerMax('player', ClassPowerID)
			mod = UnitPowerDisplayMod(ClassPowerID)
		end

		-- mod should never be 0, but according to Blizz code it can actually happen
		cur = mod == 0 and 0 or cur / mod

		-- BUG: Destruction is supposed to show partial soulshards, but Affliction and Demonology should only show full ones
		if (ClassPowerType == 'SOUL_SHARDS' and GetSpecialization() ~= SPEC_WARLOCK_DESTRUCTION) then
			cur = cur - cur % 1
		end

		local numActive = cur + 0.9
		if max <= 6 then
			for i = 1, max do
				if (i > numActive) then
					element[i]:Hide()
					element[i]:SetValue(0)
				else
					element[i]:Show()
					element[i]:SetValue(cur - i + 1)
				end
			end
		else
			for i = 1, 5 do element[i]:SetValue(1) end
			element[6]:Hide()

			if cur <= 5 then
				for i = 1, 5 do
					if i <= cur then
						element[i]:Show()
					else
						element[i]:Hide()
					end
					element[i]:SetStatusBarColor(1, .96, .41)
				end
			else
				for i = 1, 5 do
					element[i]:Show()
				end
				for i = 1, cur - 5 do
					element[i]:SetStatusBarColor(1, 0, 0)
				end
				for i = cur - 4, 5 do
					element[i]:SetStatusBarColor(1, .96, .41)
				end
			end
		end

		oldMax = element.__max
		if (max ~= oldMax) then
			if (max < oldMax) then
				for i = max + 1, oldMax do
					if element[i] then
						element[i]:Hide()
						element[i]:SetValue(0)
					end
				end
				UpdateColor(element, powerType)
			end

			element.__max = max
		end
	end

	if (element.PostUpdate) then
		return element:PostUpdate(cur, max, oldMax ~= max, powerType)
	end
end

local function Path(self, ...)
	return (self.ClassPower.Override or Update) (self, ...)
end

local function Visibility(self, event, unit)
	local element = self.ClassPower
	local shouldEnable

	if (UnitHasVehicleUI('player')) then
		shouldEnable = true
		unit = 'vehicle'
	elseif (ClassPowerID) then
		if (not RequireSpec or RequireSpec == GetSpecialization()) then
			-- use 'player' instead of unit because 'SPELLS_CHANGED' is a unitless event
			if (not RequirePower or RequirePower == UnitPowerType('player')) then
				if (not RequireSpell or IsPlayerSpell(RequireSpell)) then
					self:UnregisterEvent('SPELLS_CHANGED', Visibility)
					shouldEnable = true
					unit = 'player'
				else
					self:RegisterEvent('SPELLS_CHANGED', Visibility, true)
				end
			end
		end
	end

	local isEnabled = element.isEnabled
	local powerType = unit == 'vehicle' and 'COMBO_POINTS' or ClassPowerType

	if (shouldEnable) then
		(element.UpdateColor or UpdateColor) (element, powerType)
	end

	if (shouldEnable and not isEnabled) then
		ClassPowerEnable(self)
	elseif (not shouldEnable and (isEnabled or isEnabled == nil)) then
		ClassPowerDisable(self)
	elseif (shouldEnable and isEnabled) then
		Path(self, event, unit, powerType)
	end
end

local function VisibilityPath(self, ...)
	return (self.ClassPower.OverrideVisibility or Visibility) (self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit)
end

do
	function ClassPowerEnable(self)
		self:RegisterEvent('UNIT_POWER_FREQUENT', Path)
		self:RegisterEvent('UNIT_MAXPOWER', Path)

		self.ClassPower.isEnabled = true

		if (UnitHasVehicleUI('player')) then
			Path(self, 'ClassPowerEnable', 'vehicle', 'COMBO_POINTS')
		else
			Path(self, 'ClassPowerEnable', 'player', ClassPowerType)
		end
	end

	function ClassPowerDisable(self)
		self:UnregisterEvent('UNIT_POWER_FREQUENT', Path)
		self:UnregisterEvent('UNIT_MAXPOWER', Path)

		local element = self.ClassPower
		for i = 1, #element do
			element[i]:Hide()
		end

		self.ClassPower.isEnabled = false
		Path(self, 'ClassPowerDisable', 'player', ClassPowerType)
	end

	if (PlayerClass == 'MONK') then
		ClassPowerID = SPELL_POWER_CHI
		ClassPowerType = 'CHI'
		RequireSpec = SPEC_MONK_WINDWALKER
	elseif (PlayerClass == 'PALADIN') then
		ClassPowerID = SPELL_POWER_HOLY_POWER
		ClassPowerType = 'HOLY_POWER'
		RequireSpec = SPEC_PALADIN_RETRIBUTION
	elseif (PlayerClass == 'WARLOCK') then
		ClassPowerID = SPELL_POWER_SOUL_SHARDS
		ClassPowerType = 'SOUL_SHARDS'
	elseif (PlayerClass == 'ROGUE' or PlayerClass == 'DRUID') then
		ClassPowerID = SPELL_POWER_COMBO_POINTS
		ClassPowerType = 'COMBO_POINTS'

		if (PlayerClass == 'DRUID') then
			RequirePower = SPELL_POWER_ENERGY
			RequireSpell = 5221 -- Shred
		end
	elseif (PlayerClass == 'MAGE') then
		ClassPowerID = SPELL_POWER_ARCANE_CHARGES
		ClassPowerType = 'ARCANE_CHARGES'
		RequireSpec = SPEC_MAGE_ARCANE
	end
end

local function Enable(self, unit)
	if (unit ~= 'player') then return end

	local element = self.ClassPower
	if (element) then
		element.__owner = self
		element.__max = #element
		element.ForceUpdate = ForceUpdate

		if (RequireSpec or RequireSpell) then
			self:RegisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath, true)
		end

		if (RequirePower) then
			self:RegisterEvent('UNIT_DISPLAYPOWER', VisibilityPath)
		end

		element.ClassPowerEnable = ClassPowerEnable
		element.ClassPowerDisable = ClassPowerDisable

		for i = 1, #element do
			local bar = element[i]
			if (bar:IsObjectType('StatusBar')) then
				if (not bar:GetStatusBarTexture()) then
					bar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
				end

				bar:SetMinMaxValues(0, 1)
			end
		end

		return true
	end
end

local function Disable(self)
	if (self.ClassPower) then
		ClassPowerDisable(self)

		self:UnregisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath)
		self:UnregisterEvent('UNIT_DISPLAYPOWER', VisibilityPath)
		self:UnregisterEvent('SPELLS_CHANGED', Visibility)
	end
end

oUF:AddElement('ClassPower', VisibilityPath, Enable, Disable)