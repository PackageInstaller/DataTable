-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademySelectPanelUIApi.lua

MonsterAcademySelectPanelUIApi = BaseLangApi:Extend()

function MonsterAcademySelectPanelUIApi:Init()
	self:RegisterApi("CloseBtnLabel", self.GetCloseBtnLabel)
	self:RegisterApi("AttrValueText", self.GetAttrValueText)
	self:RegisterApi("RewardText", self.GetRewardText)
end

function MonsterAcademySelectPanelUIApi:GetRewardText(name)
	return name
end

function MonsterAcademySelectPanelUIApi:GetCloseBtnLabel()
	return self:GetCfgText(3420081)
end

function MonsterAcademySelectPanelUIApi:GetAttrValueText()
	return "3000000"
end

MonsterAcademySelectPanelUIApi:Init()
