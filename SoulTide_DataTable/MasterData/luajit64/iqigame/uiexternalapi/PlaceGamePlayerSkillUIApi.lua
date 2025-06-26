-- chunkname: @IQIGame\\UIExternalApi\\PlaceGamePlayerSkillUIApi.lua

PlaceGamePlayerSkillUIApi = BaseLangApi:Extend()

function PlaceGamePlayerSkillUIApi:Init()
	self:RegisterApi("SoulHeadIcon", self.GetSoulHeadIcon)
	self:RegisterApi("SoulClassTxt", self.GetSoulClassTxt)
	self:RegisterApi("SoulClassBgImage", self.GetSoulClassBgImage)
	self:RegisterApi("SkillTag", self.GetSkillTagTxt)
	self:RegisterApi("SkillStrengthenLv", self.GetSkillStrengthenLv)
	self:RegisterApi("SkillEffectText", self.GetSkillEffectText)
	self:RegisterApi("ShowSkillType", self.CheckShowSkillType)
	self:RegisterApi("SkillTypeTxtInCellInfo", self.GetSkillTypeTxtInCellInfo)
	self:RegisterApi("SkillViewSkillSp", self.GetSkillViewSkillSp)
	self:RegisterApi("StrengthenTypeDesc", self.GetStrengthenTypeDesc)
	self:RegisterApi("SkillViewAttChangeDesc", self.GetSkillViewAttChangeDesc)
end

function PlaceGamePlayerSkillUIApi:GetSkillViewAttChangeDesc(name, value, id)
	return string.format("%s+%s%%", name, value * 100)
end

function PlaceGamePlayerSkillUIApi:GetStrengthenTypeDesc(name, desc, isLock, lv)
	if isLock then
		return self:Space(1) .. self:SkillValueColor(desc, 29)
	else
		return self.TextColor[34] .. string.format(self:GetCfgText(3820002), lv) .. self:SkillValueColor(desc, 29) .. self.TextColor[0]
	end
end

function PlaceGamePlayerSkillUIApi:GetSkillViewSkillSp(value)
	if value == 0 then
		return "--"
	end

	return tostring(value)
end

function PlaceGamePlayerSkillUIApi:GetSkillTypeTxtInCellInfo(type, noTitle)
	if noTitle then
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
	else
		return self:GetCfgText(1210003) .. self:GetSkillType(type)
	end
end

function PlaceGamePlayerSkillUIApi:CheckShowSkillType(type)
	if type == 1 or type == 2 or type == 3 or type == 4 or type == 5 or type == 6 then
		return true
	end

	return false
end

function PlaceGamePlayerSkillUIApi:GetSkillEffectText(desc)
	return self:SkillValueColor(desc, 29)
end

function PlaceGamePlayerSkillUIApi:GetSkillStrengthenLv(lv)
	if lv == 0 then
		return ""
	end

	return string.format("+%s", lv)
end

function PlaceGamePlayerSkillUIApi:GetSkillTagTxt(tag)
	if tag == 1 then
		return self:GetCfgText(2200030)
	elseif tag == 2 then
		return self:GetCfgText(2200031)
	elseif tag == 3 then
		return self:GetCfgText(1318037)
	elseif tag == 4 then
		return self:GetCfgText(1318022)
	elseif tag == 5 then
		return self:GetCfgText(1318023)
	elseif tag == 6 then
		return self:GetCfgText(1318029)
	elseif tag == 7 then
		return self:GetCfgText(2200032)
	elseif tag == 8 then
		return self:GetCfgText(2200025)
	elseif tag == 9 then
		return self:GetCfgText(2200036)
	elseif tag == 10 then
		return self:GetCfgText(1318034)
	elseif tag == 11 then
		return self:GetCfgText(1318035)
	elseif tag == 12 then
		return self:GetCfgText(1318033)
	elseif tag == 13 then
		return self:GetCfgText(1318031)
	elseif tag == 14 then
		return self:GetCfgText(1318032)
	end
end

function PlaceGamePlayerSkillUIApi:GetSoulClassBgImage(type)
	if type == 1 then
		return self:GetResUrl(1900011)
	elseif type == 2 then
		return self:GetResUrl(1900013)
	elseif type == 3 then
		return self:GetResUrl(1900012)
	elseif type == 4 then
		return self:GetResUrl(1900014)
	else
		return self:GetResUrl(1900014)
	end
end

function PlaceGamePlayerSkillUIApi:GetSoulClassTxt(type)
	if type == 1 then
		return self:GetCfgText(1318021)
	elseif type == 2 then
		return self:GetCfgText(1318022)
	elseif type == 3 then
		return self:GetCfgText(1318023)
	elseif type == 4 then
		return self:GetCfgText(1318024)
	end
end

function PlaceGamePlayerSkillUIApi:GetSoulHeadIcon(soulCid)
	local soulRange = 2001000

	soulRange = soulRange + soulCid % 10000

	return self:GetResUrl(soulRange)
end

PlaceGamePlayerSkillUIApi:Init()
