-- chunkname: @IQIGame\\UIExternalApi\\BattleUIApi.lua

BattleUIApi = BaseLangApi:Extend()

function BattleUIApi:Init()
	self:RegisterApi("outBattleBtnTxt", self.GetOutBattleBtnTxt)
	self:RegisterApi("SpeedBtnValueText", self.GetSpeedBtnValueText)
	self:RegisterApi("HpText", self.GetHpText)
	self:RegisterApi("EnergyShieldImage", self.GetEnergyShieldImage)
	self:RegisterApi("EnergyShieldDescText", self.GetEnergyShieldDescText)
	self:RegisterApi("StandbyTipTexts", self.GetStandbyTipTexts)
	self:RegisterApi("SkillGroupEnergyText", self.GetSkillGroupEnergyText)
	self:RegisterApi("SkillReleaseTypePassiveLabel", self.GetSkillReleaseTypePassiveLabel)
	self:RegisterApi("EnergyShieldMatchEffect", self.GetEnergyShieldMatchEffect)
	self:RegisterApi("EnergyShieldBeHitEffect", self.GetEnergyShieldBeHitEffect)
	self:RegisterApi("EnergyShieldBreakEffect", self.GetEnergyShieldBreakEffect)
	self:RegisterApi("SkillTipNameText", self.GetSkillTipNameText)
	self:RegisterApi("SkillTipDescText", self.GetSkillTipDescText)
	self:RegisterApi("AutoNormalAtkToggleText", self.GetAutoNormalAtkToggleText)
	self:RegisterApi("AutoSkillAtkToggleText", self.GetAutoSkillAtkToggleText)
	self:RegisterApi("SkipSkillCGBtnText", self.GetSkipSkillCGBtnText)
	self:RegisterApi("AutoModeLabel", self.GetAutoModeLabel)
	self:RegisterApi("HelpBtnText", self.GetHelpBtnText)
	self:RegisterApi("SpeedBtnLabelText", self.GetSpeedBtnLabelText)
	self:RegisterApi("SettingBtnText", self.GetSettingBtnText)
	self:RegisterApi("GiveUpBtnText", self.GetGiveUpBtnText)
	self:RegisterApi("TotalDamageLabelText", self.GetTotalDamageLabelText)
end

function BattleUIApi:GetOutBattleBtnTxt()
	return self:GetCfgText(1150032)
end

function BattleUIApi:GetSpeedBtnValueText(speed)
	return "x" .. speed
end

function BattleUIApi:GetHpText(hp, shield, maxHp)
	if shield > 0 then
		return hp .. "(+" .. shield .. ")/" .. maxHp
	end

	return hp .. "/" .. maxHp
end

function BattleUIApi:GetEnergyShieldImage(type)
	if type == 1 then
		return self:GetResUrl(2200005)
	elseif type == 2 then
		return self:GetResUrl(2200002)
	elseif type == 3 then
		return self:GetResUrl(2200003)
	elseif type == 4 then
		return self:GetResUrl(2200005)
	elseif type == 5 then
		return self:GetResUrl(2200001)
	elseif type == 6 then
		return self:GetResUrl(2200004)
	end

	return nil
end

function BattleUIApi:GetEnergyShieldDescText(type)
	if type == 1 then
		return self:GetCfgText(2000100)
	elseif type == 2 then
		return self:GetCfgText(2000101)
	elseif type == 3 then
		return self:GetCfgText(2000102)
	elseif type == 4 then
		return self:GetCfgText(2000103)
	elseif type == 5 then
		return self:GetCfgText(2000104)
	elseif type == 6 then
		return self:GetCfgText(2000105)
	end

	return ""
end

function BattleUIApi:GetStandbyTipTexts()
	return self:GetCfgText(2000108), self:GetCfgText(2000109)
end

function BattleUIApi:GetSkillGroupEnergyText(energy, maxEnergy)
	return energy
end

function BattleUIApi:GetSkillReleaseTypePassiveLabel()
	return self:GetCfgText(2000111)
end

function BattleUIApi:GetEnergyShieldMatchEffect(elementType)
	if elementType == 1 then
		return 9005106
	elseif elementType == 2 then
		return 9005107
	elseif elementType == 3 then
		return 9005108
	elseif elementType == 4 then
		return 9005108
	elseif elementType == 5 then
		return 9005109
	elseif elementType == 6 then
		return 9005110
	else
		return 9005110
	end
end

function BattleUIApi:GetEnergyShieldBeHitEffect(elementType)
	return 9005111
end

function BattleUIApi:GetEnergyShieldBreakEffect(elementType)
	return 9005112
end

function BattleUIApi:GetSkillTipNameText(text)
	return self:SkillValueColor(text, 29)
end

function BattleUIApi:GetSkillTipDescText(text)
	return self:SkillValueColor(text, 29)
end

function BattleUIApi:GetAutoNormalAtkToggleText()
	return self:GetCfgText(2000112)
end

function BattleUIApi:GetAutoSkillAtkToggleText()
	return self:GetCfgText(2000113)
end

function BattleUIApi:GetSkipSkillCGBtnText()
	return self:GetCfgText(1317026)
end

function BattleUIApi:GetAutoModeLabel()
	return "AUTO MODE"
end

function BattleUIApi:GetHelpBtnText()
	return self:GetCfgText(2000114)
end

function BattleUIApi:GetSpeedBtnLabelText()
	return self:GetCfgText(2000115)
end

function BattleUIApi:GetSettingBtnText()
	return self:GetCfgText(2000116)
end

function BattleUIApi:GetGiveUpBtnText()
	return self:GetCfgText(2000110)
end

function BattleUIApi:GetTotalDamageLabelText()
	return self:GetCfgText(2000117)
end

BattleUIApi:Init()
