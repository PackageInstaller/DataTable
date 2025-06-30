-- chunkname: @IQIGame\\UIExternalApi\\SkillTipApi.lua

SkillTipApi = BaseLangApi:Extend()

function SkillTipApi:Init()
	self:RegisterApi("goName", self.GetNameText)
	self:RegisterApi("goSkillTypeTxtInCellInfo", self.GetSkillTypeTxtInCellInfo)
	self:RegisterApi("goSkillLv", self.GetSkillLv)
	self:RegisterApi("typeFrame", self.GetTypeFrame)
	self:RegisterApi("goEffect", self.GetSkillEffectText)
	self:RegisterApi("goStrengthenTitle", self.GetStrengthenTitle)
	self:RegisterApi("goStrengthenTypeDesc", self.GetStrengthenTypeDesc)
	self:RegisterApi("showSkillType", self.CheckShowSkillType)
	self:RegisterApi("goReleaseType", self.GetReleaseType)
	self:RegisterApi("goCd", self.GetCd)
	self:RegisterApi("goAnger", self.GetAnger)
	self:RegisterApi("skillViewAttChangeDesc", self.GetSkillViewAttChangeDesc)
	self:RegisterApi("goAttChangeTitle", self.GetAttChangeTitle)
end

function SkillTipApi:GetAttChangeTitle()
	return self:GetCfgText(1210024)
end

function SkillTipApi:GetSkillViewAttChangeDesc(name, value, id)
	if id == 10 then
		return name .. "+" .. value
	else
		return name .. "+" .. value * 100 .. "%"
	end
end

function SkillTipApi:GetAnger(value)
	if value == 0 then
		return self:GetCfgText(1210016) .. self:GetCfgText(1210017)
	else
		return self:GetCfgText(1210016) .. value .. self:GetCfgText(1210018)
	end
end

function SkillTipApi:GetCd(cd)
	return ""
end

function SkillTipApi:GetReleaseType(type)
	if type == 1 then
		return self:GetCfgText(1210022)
	elseif type == 2 then
		return self:GetCfgText(1210023)
	end
end

function SkillTipApi:GetNameText(name)
	return self:FontSize(name, 30)
end

function SkillTipApi:GetSkillTypeTxtInCellInfo(type, noTitle)
	if noTitle then
		return self:GetSkillType(type)
	else
		return self:GetCfgText(1210003) .. self:GetSkillType(type)
	end
end

function SkillTipApi:GetSkillLv(lv, isMax)
	if isMax then
		lv = self.TextColor[29] .. "+" .. lv .. self.TextColor[0]
	else
		lv = "+" .. lv
	end

	return lv
end

function SkillTipApi:GetTypeFrame(showType)
	if showType == 1 then
		return self:GetResUrl(1800001)
	elseif showType == 2 then
		return self:GetResUrl(1800002)
	elseif showType == 3 then
		return self:GetResUrl(1800003)
	elseif showType == 4 then
		return self:GetResUrl(1800004)
	elseif showType == 5 then
		return self:GetResUrl(1800006)
	elseif showType == 6 then
		return self:GetResUrl(1800006)
	end
end

function SkillTipApi:GetSkillEffectText(desc)
	return self:SkillValueColor(desc, 29)
end

function SkillTipApi:GetStrengthenTitle()
	return self:GetCfgText(1210013)
end

function SkillTipApi:GetStrengthenTypeDesc(name, desc, isLock)
	if isLock then
		return self:Space(1) .. self:SkillValueColor(desc, 29)
	else
		return self.TextColor[34] .. self:Space(1) .. self:GetCfgText(1210025) .. self:SkillValueColor(desc, 29) .. self.TextColor[0]
	end
end

function SkillTipApi:GetSkillType(type)
	if type == 1 then
		return self:GetCfgText(1210006)
	elseif type == 2 then
		return self:GetCfgText(1210007)
	elseif type == 3 then
		return self:GetCfgText(1210008)
	elseif type == 4 then
		return self:GetCfgText(1210009)
	elseif type == 5 then
		return self:GetCfgText(1210010)
	elseif type == 6 then
		return self:GetCfgText(1210011)
	end
end

function SkillTipApi:CheckShowSkillType(type)
	if type == 1 or type == 2 or type == 3 or type == 4 or type == 5 or type == 6 then
		return true
	end

	return false
end

SkillTipApi:Init()
