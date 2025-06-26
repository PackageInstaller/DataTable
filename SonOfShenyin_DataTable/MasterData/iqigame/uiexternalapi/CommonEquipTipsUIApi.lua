-- chunkname: @IQIGame\\UIExternalApi\\CommonEquipTipsUIApi.lua

CommonEquipTipsUIApi = BaseLangApi:Extend()

function CommonEquipTipsUIApi:GetEquipName(name, quality)
	return name
end

function CommonEquipTipsUIApi:GetEquipPartText(subType)
	if subType == 1 then
		return self:GetCfgText(120001)
	elseif subType == 2 then
		return self:GetCfgText(120002)
	elseif subType == 3 then
		return self:GetCfgText(120003)
	elseif subType == 4 then
		return self:GetCfgText(120004)
	elseif subType == 5 then
		return self:GetCfgText(120005)
	elseif subType == 6 then
		return self:GetCfgText(120016)
	end

	return ""
end

function CommonEquipTipsUIApi:GetEquipLevelText(level)
	return string.format(self:GetCfgText(120006), level)
end

function CommonEquipTipsUIApi:GetEquipTypeText()
	return self:GetCfgText(120007)
end

function CommonEquipTipsUIApi:GetEquipSuitTitleText()
	return self:GetCfgText(120008)
end

function CommonEquipTipsUIApi:GetMainAttributeText(value)
	return string.format(self:GetCfgText(6000024), value)
end

function CommonEquipTipsUIApi:GetEquipPartImg(partIndex)
	return string.format(self:GetResUrl(1200113), partIndex)
end

function CommonEquipTipsUIApi:GetEquipQualityImg(quality)
	return string.format(self:GetResUrl(1100035), quality)
end
