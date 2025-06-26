-- chunkname: @IQIGame\\UIExternalApi\\BattleDamageUIApi.lua

BattleDamageUIApi = BaseLangApi:Extend()

local BattleDamageType = {
	Shield = 11,
	Magic = 6,
	Resist = 8,
	Miss = 7,
	Heal = 9,
	SuckBlood = 10,
	Parry = 13,
	Poison = 4,
	Thorns = 12,
	Fire = 2,
	Thunder = 3,
	Immune = 15,
	Block = 14,
	AddSkillEnergy = 16,
	Physic = 5,
	Ice = 1
}

function BattleDamageUIApi:Init()
	self:RegisterApi("BuffText", self.GetBuffText)
	self:RegisterApi("DamageTextAndColor", self.GetDamageTextAndColor)
	self:RegisterApi("ImmuneToBuffText", self.GetImmuneToBuffText)
end

function BattleDamageUIApi:GetBuffText(text, stack)
	if stack == 1 then
		return text
	end

	return text
end

function BattleDamageUIApi:GetDamageTextAndColor(skillType, damageType, value, hasEnergyShield, isMonster)
	local text, colorTop, colorBottom, outlineColor

	if damageType == BattleDamageType.Miss then
		text = self:GetCfgText(122)
		colorTop = Color(1, 0.965, 0.055, 1)
		colorBottom = Color(0.863, 0.725, 0.031, 1)
		outlineColor = Color(0.29, 0.259, 0.039, 1)
	elseif damageType == BattleDamageType.Resist then
		text = self:GetCfgText(122)
		colorTop = Color(1, 0.965, 0.055, 1)
		colorBottom = Color(0.863, 0.725, 0.031, 1)
		outlineColor = Color(0.29, 0.259, 0.039, 1)
	elseif damageType == BattleDamageType.Heal then
		text = "+" .. value
		colorTop = Color(0.435, 0.894, 0.384, 1)
		colorBottom = Color(0.435, 0.894, 0.384, 1)
		outlineColor = Color(0, 0, 0, 1)
	elseif damageType == BattleDamageType.SuckBlood then
		text = self:GetCfgText(1318097) .. "+" .. value
		colorTop = Color(0.435, 0.894, 0.384, 1)
		colorBottom = Color(0.435, 0.894, 0.384, 1)
		outlineColor = Color(0, 0, 0, 1)
	elseif damageType == BattleDamageType.Shield then
		text = self:GetCfgText(1318096) .. "-" .. value
		colorTop = Color(0.988, 0.969, 1, 1)
		colorBottom = Color(0.698, 0.698, 0.698, 1)
		outlineColor = Color(0.196, 0.196, 0.196, 1)
	elseif damageType == BattleDamageType.Thorns then
		text = self:GetCfgText(1318095) .. "-" .. value
		colorTop = Color(1, 0.208, 0.161, 1)
		colorBottom = Color(0.757, 0.09, 0.051, 1)
		outlineColor = Color(0.141, 0.016, 0.016, 1)
	elseif damageType == BattleDamageType.Parry then
		text = self:GetCfgText(1318094) .. "-" .. value
		colorTop = Color(1, 0.965, 0.055, 1)
		colorBottom = Color(0.863, 0.725, 0.031, 1)
		outlineColor = Color(0.29, 0.259, 0.039, 1)
	elseif damageType == BattleDamageType.Block then
		text = self:GetCfgText(1318093) .. "-" .. value
		colorTop = Color(1, 0.965, 0.055, 1)
		colorBottom = Color(0.863, 0.725, 0.031, 1)
		outlineColor = Color(0.29, 0.259, 0.039, 1)
	elseif damageType == BattleDamageType.Immune then
		text = self:GetCfgText(1318098)
		colorTop = Color(1, 0.965, 0.055, 1)
		colorBottom = Color(0.863, 0.725, 0.031, 1)
		outlineColor = Color(0.29, 0.259, 0.039, 1)
	elseif hasEnergyShield then
		if skillType == 5 then
			text = "-" .. value
			colorTop = Color(1, 1, 1, 1)
			colorBottom = Color(1, 1, 1, 1)
			outlineColor = Color(0, 0, 0, 1)
		else
			text = "-" .. value
			colorTop = Color(1, 0.835, 0.173, 1)
			colorBottom = Color(1, 0.835, 0.173, 1)
			outlineColor = Color(0, 0, 0, 1)
		end
	elseif isMonster then
		text = "-" .. value
		colorTop = Color(0.8588, 0.039, 0.063, 1)
		colorBottom = Color(0.8588, 0.039, 0.063, 1)
		outlineColor = Color(0, 0, 0, 1)
	elseif skillType == 5 then
		text = "-" .. value
		colorTop = Color(1, 1, 1, 1)
		colorBottom = Color(1, 1, 1, 1)
		outlineColor = Color(0, 0, 0, 1)
	else
		text = "-" .. value
		colorTop = Color(1, 0.835, 0.173, 1)
		colorBottom = Color(1, 0.835, 0.173, 1)
		outlineColor = Color(0, 0, 0, 1)
	end

	return text, colorTop, colorBottom, outlineColor
end

function BattleDamageUIApi:GetImmuneToBuffText(buffCid, isTrigger)
	if isTrigger then
		return self:GetCfgText(1318098)
	end

	return self:GetCfgText(1318099)
end

BattleDamageUIApi:Init()
