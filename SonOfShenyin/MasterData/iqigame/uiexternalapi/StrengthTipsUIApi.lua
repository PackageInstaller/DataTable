-- chunkname: @IQIGame\\UIExternalApi\\StrengthTipsUIApi.lua

StrengthTipsUIApi = BaseLangApi:Extend()

function StrengthTipsUIApi:GetContentText(type)
	if type == Constant.StrengthType.HeroUpgrade then
		return self:GetCfgText(1700000)
	elseif type == Constant.StrengthType.SkillUpgrade then
		return self:GetCfgText(1700001)
	elseif type == Constant.StrengthType.SkillBreach then
		return self:GetCfgText(1700002)
	elseif type == Constant.StrengthType.EquipUpgrade then
		return self:GetCfgText(1700003)
	end

	return ""
end
