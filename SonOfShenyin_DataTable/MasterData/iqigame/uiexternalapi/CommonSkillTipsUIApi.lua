-- chunkname: @IQIGame\\UIExternalApi\\CommonSkillTipsUIApi.lua

CommonSkillTipsUIApi = BaseLangApi:Extend()

function CommonSkillTipsUIApi:GetSkillName(name, quality)
	return name
end

function CommonSkillTipsUIApi:GetSkillTypeText(skillReleaseType)
	if skillReleaseType == 2 then
		return self:GetCfgText(2001004)
	else
		return self:GetCfgText(2001005)
	end
end

function CommonSkillTipsUIApi:GetSkillLevelText(skillLevel)
	return string.format(self:GetCfgText(120006), skillLevel)
end

function CommonSkillTipsUIApi:GetSkillElementIconPath(elementId)
	return string.format(self:GetResUrl(1100033), elementId)
end

function CommonSkillTipsUIApi:GetSkillLimitImg(type, value)
	if type == Constant.SkillLimitType.Element then
		return string.format(self:GetResUrl(17001), value)
	elseif type == Constant.SkillLimitType.Force then
		return string.format(self:GetResUrl(1400005), value)
	elseif type == Constant.SkillLimitType.Profession then
		return string.format(self:GetResUrl(1100025), value)
	end
end

function CommonSkillTipsUIApi:GetTextUnEquip()
	return "未装备"
end

function CommonSkillTipsUIApi:GetTextElementLimit(type)
	return string.format(self:GetCfgText(130011), WarlockApi:GetTextElement(type))
end
