-- chunkname: @IQIGame\\UIExternalApi\\CommonSlotUIApi.lua

CommonSlotUIApi = BaseLangApi:Extend()

function CommonSlotUIApi:GetRequireNum(needCount, allCount)
	if allCount < needCount then
		return self.TextColor[1] .. allCount .. self.TextColor[0] .. "/" .. needCount
	else
		return allCount .. "/" .. needCount
	end
end

function CommonSlotUIApi:GetQualityFramePath(quality)
	return UIGlobalApi.GetIconPath(string.format("/Common/Icon_QualityFrame_%s.png", tonumber(quality)))
end

function CommonSlotUIApi:GetQualityBackgroundPath(quality)
	return UIGlobalApi.GetIconPath("/Common/Icon_BottomBG.png")
end

function CommonSlotUIApi:GetItemFrame(itemType, quality)
	return string.format(self:GetResUrl(1100034), itemType, quality)
end

function CommonSlotUIApi:GetSkillFrame(quality)
	return string.format(self:GetResUrl(1100034), Constant.ItemType.Item, quality)
end

function CommonSlotUIApi:GetSkillElement(element)
	return string.format(self:GetResUrl(1100033), element)
end

function CommonSlotUIApi:GetSkillBreachStarImg(quality)
	return string.format(self:GetResUrl(1100037), quality)
end

function CommonSlotUIApi:GetSkillTypeImg(isManual)
	local manual = isManual == true and 1 or 0

	return string.format(self:GetResUrl(1100042), manual)
end

function CommonSlotUIApi:GetSkillTypeText(isManual)
	if isManual then
		return self:GetCfgText(1600014)
	else
		return self:GetCfgText(1600022)
	end
end

function CommonSlotUIApi:GetSkillRefineLevelImg(purifyLv)
	return UIGlobalApi.ImagePath .. "/DataResource/UIResource/DiyCommonImg/DiyCommonImg_RefineImg_0" .. tostring(purifyLv) .. ".png"
end

function CommonSlotUIApi:GetEquipFrame(quality)
	return string.format(self:GetResUrl(1100034), Constant.ItemType.Item, quality)
end
