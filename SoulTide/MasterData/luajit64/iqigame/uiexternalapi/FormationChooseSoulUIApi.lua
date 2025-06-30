-- chunkname: @IQIGame\\UIExternalApi\\FormationChooseSoulUIApi.lua

FormationChooseSoulUIApi = BaseLangApi:Extend()

function FormationChooseSoulUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SkillItemType", self.GetSkillItemType)
	self:RegisterApi("SkillItemReleaseType", self.GetSkillItemReleaseType)
	self:RegisterApi("SkillItemCost", self.GetSkillItemCost)
	self:RegisterApi("SkillItemCD", self.GetSkillItemCD)
	self:RegisterApi("RemoveBtnText", self.GetRemoveBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("SkillGroupTipText", self.GetSkillGroupTipText)
	self:RegisterApi("SoulCellInTeamText", self.GetSoulCellInTeamText)
	self:RegisterApi("SkillGroupUnlockText", self.GetSkillGroupUnlockText)
	self:RegisterApi("SkillLevelText", self.GetSkillLevelText)
	self:RegisterApi("GoEquipBtnText", self.GetGoEquipBtnText)
	self:RegisterApi("GoSoulText", self.GetGoSoulText)
	self:RegisterApi("ChooseSoulLabel", self.GetChooseSoulLabel)
end

function FormationChooseSoulUIApi:GetTitleText()
	return self:GetCfgText(1214301)
end

function FormationChooseSoulUIApi:GetSkillItemType(type)
	local desc = self:GetCfgText(1314330)

	if type == 1 then
		return desc .. ":" .. self:GetCfgText(1210006)
	elseif type == 2 then
		return desc .. ":" .. self:GetCfgText(1210007)
	elseif type == 3 then
		return desc .. ":" .. self:GetCfgText(1210008)
	elseif type == 4 then
		return desc .. ":" .. self:GetCfgText(1210009)
	elseif type == 5 then
		return desc .. ":" .. self:GetCfgText(1210010)
	elseif type == 6 then
		return desc .. ":" .. self:GetCfgText(1210011)
	end
end

function FormationChooseSoulUIApi:GetSkillItemReleaseType(releaseType)
	if releaseType == 1 then
		return self:GetCfgText(1210022)
	elseif releaseType == 2 then
		return self:GetCfgText(1210023)
	end
end

function FormationChooseSoulUIApi:GetSkillItemCost(cost)
	if cost == 0 then
		return self:GetCfgText(1229066) .. ":" .. self:GetCfgText(1210017)
	else
		return self:GetCfgText(1229066) .. ":" .. cost .. self:GetCfgText(1210018)
	end
end

function FormationChooseSoulUIApi:GetSkillItemCD(cd)
	return ""
end

function FormationChooseSoulUIApi:GetRemoveBtnText()
	return self:GetCfgText(1214302)
end

function FormationChooseSoulUIApi:GetConfirmBtnText()
	return self:GetCfgText(1214306)
end

function FormationChooseSoulUIApi:GetSkillGroupTipText()
	return self:GetCfgText(1214303)
end

function FormationChooseSoulUIApi:GetSoulCellInTeamText()
	return self:GetCfgText(1214309)
end

function FormationChooseSoulUIApi:GetSkillGroupUnlockText(unlockLv)
	return string.format(self:GetCfgText(1214310), unlockLv)
end

function FormationChooseSoulUIApi:GetSkillLevelText(level)
	if level == 0 then
		return ""
	end

	return "+" .. level
end

function FormationChooseSoulUIApi:GetGoEquipBtnText()
	return self:GetCfgText(1214069)
end

function FormationChooseSoulUIApi:GetGoSoulText()
	return self:GetCfgText(1214068)
end

function FormationChooseSoulUIApi:GetChooseSoulLabel()
	return self:GetCfgText(1214311)
end

function FormationChooseSoulUIApi:GetOptionalSpSkillUnlockText()
	return self:GetCfgText(1214312)
end

FormationChooseSoulUIApi:Init()
