-- chunkname: @IQIGame\\UIExternalApi\\SpecialSpiritUIApi.lua

SpecialSpiritUIApi = BaseLangApi:Extend()

function SpecialSpiritUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("attActiveViewCost", self.GetAttActiveViewCost)
	self:RegisterApi("attActiveViewBtnActiveTxt", self.GetAttActiveViewBtnActiveTxt)
	self:RegisterApi("attActiveViewCondition", self.GetAttActiveViewCondition)
	self:RegisterApi("attActiveViewAttName", self.GetAttActiveViewAttName)
	self:RegisterApi("attActiveViewAttVale", self.GetAttActiveViewAttValue)
	self:RegisterApi("skillActiveViewCost", self.GetSkillActiveViewCost)
	self:RegisterApi("skillActiveViewBtnActiveTxt", self.GetSkillActiveViewBtnActiveTxt)
	self:RegisterApi("skillActiveViewCondition", self.GetSkillActiveViewCondition)
	self:RegisterApi("skillActiveViewConditionOnStar", self.GetSkillActiveViewConditionOnStar)
	self:RegisterApi("skillViewSkillName", self.GetSkillViewSkillName)
	self:RegisterApi("skillViewSkillNameNext", self.GetSkillViewSkillNameNext)
	self:RegisterApi("skillViewSkillDesc", self.GetSkillViewSkillDesc)
	self:RegisterApi("skillViewSkillDescNext", self.GetSkillViewSkillDescNext)
	self:RegisterApi("skillViewSkillLv", self.GetSkillViewSkillLv)
	self:RegisterApi("skillViewSkillLvNext", self.GetSkillViewSkillLvNext)
end

function SpecialSpiritUIApi:GetSkillViewSkillLv(lv)
	return ""
end

function SpecialSpiritUIApi:GetSkillViewSkillLvNext(lv)
	lv = lv - 4

	if lv == 0 then
		return ""
	else
		return lv .. "<size=20>" .. "/" .. 5 .. "</size>"
	end
end

function SpecialSpiritUIApi:GetSkillViewSkillDesc(desc)
	return self:SkillValueColor(desc, 29)
end

function SpecialSpiritUIApi:GetSkillViewSkillDescNext(desc)
	if desc == "" then
		return desc
	end

	return self:SkillValueColor(desc, 29)
end

function SpecialSpiritUIApi:GetSkillViewSkillNameNext(name)
	return self:GetCfgText(1229900)
end

function SpecialSpiritUIApi:GetSkillViewSkillName(name)
	return name
end

function SpecialSpiritUIApi:GetAttActiveViewAttName(name)
	return name
end

function SpecialSpiritUIApi:GetAttActiveViewAttValue(value)
	return "+" .. tostring(value)
end

function SpecialSpiritUIApi:GetAttActiveViewCondition(lv)
	return lv
end

function SpecialSpiritUIApi:GetAttActiveViewBtnActiveTxt()
	return self:GetCfgText(1229901)
end

function SpecialSpiritUIApi:GetAttActiveViewCost(cost, own)
	if own < cost then
		return self.TextColor[41] .. tostring(own) .. self.TextColor[0] .. "/" .. tostring(cost)
	else
		return tostring(own) .. "/" .. tostring(cost)
	end
end

function SpecialSpiritUIApi:GetSkillActiveViewCondition(skillName, targetLv)
	return self:GetCfgText(1229902) .. " " .. skillName .. "+" .. tostring(targetLv)
end

function SpecialSpiritUIApi:GetSkillActiveViewConditionOnStar(targetLv)
	return self:GetCfgText(1229903) .. tostring(targetLv)
end

function SpecialSpiritUIApi:GetSkillActiveViewBtnActiveTxt()
	return self:GetCfgText(1229901)
end

function SpecialSpiritUIApi:GetSkillActiveViewCost(cost, own)
	if own < cost then
		return self.TextColor[41] .. tostring(own) .. self.TextColor[0] .. "/" .. tostring(cost)
	else
		return tostring(own) .. "/" .. tostring(cost)
	end
end

function SpecialSpiritUIApi:GetTitle()
	return self:GetCfgText(1229904)
end

function SpecialSpiritUIApi:GetEnhanceLvOverview_AttrLabel()
	return self:GetCfgText(1229904)
end

function SpecialSpiritUIApi:GetEnhanceLvOverview_AttrLvText(lv, maxLv)
	return string.format("%s/%s", lv, maxLv)
end

function SpecialSpiritUIApi:GetEnhanceLvOverview_SkillLabel(skillIndex, skillName)
	return string.format("%s", skillName)
end

function SpecialSpiritUIApi:GetEnhanceLvOverview_SkillLvText(skillIndex, lv, maxLv)
	return string.format("%s/%s", lv, maxLv)
end

SpecialSpiritUIApi:Init()
