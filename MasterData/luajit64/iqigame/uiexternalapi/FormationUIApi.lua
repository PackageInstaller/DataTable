-- chunkname: @IQIGame\\UIExternalApi\\FormationUIApi.lua

FormationUIApi = BaseLangApi:Extend()

function FormationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("PowerLabel", self.GetPowerLabel)
	self:RegisterApi("FormationTabLabelText", self.GetFormationTabLabelText)
	self:RegisterApi("FormationTabOrderText", self.GetFormationTabOrderText)
	self:RegisterApi("EquipSmallCellQualityImage", self.GetEquipSmallCellQualityImage)
	self:RegisterApi("DefaultFormationName", self.GetDefaultFormationName)
	self:RegisterApi("InputNameNoticeText", self.GetInputNameNoticeText)
	self:RegisterApi("PositionUnlockCondition", self.GetPositionUnlockCondition)
	self:RegisterApi("SoulPositionLabelText", self.GetSoulPositionLabelText)
	self:RegisterApi("UnloadAllToggleText", self.GetUnloadAllToggleText)
	self:RegisterApi("UnloadAllSoulBtnText", self.GetUnloadAllSoulBtnText)
	self:RegisterApi("UnloadAllEquipBtnText", self.GetUnloadAllEquipBtnText)
	self:RegisterApi("SwitchInfoViewBtnText", self.GetSwitchInfoViewBtnText)
	self:RegisterApi("SkillGroupIndexText", self.GetSkillGroupIndexText)
	self:RegisterApi("SoulCellSkillGroupLabel", self.GetSoulCellSkillGroupLabel)
	self:RegisterApi("SoulCellEquipLabel", self.GetSoulCellEquipLabel)
	self:RegisterApi("SoulCellPowerLabel", self.GetSoulCellPowerLabel)
	self:RegisterApi("SoulInfoLevelText", self.GetSoulInfoLevelText)
	self:RegisterApi("SoulInfoPowerLabel", self.GetSoulInfoPowerLabel)
	self:RegisterApi("SoulInfoAttrValue", self.GetSoulInfoAttrValue)
	self:RegisterApi("SoulInfoEmptyLabel", self.GetSoulInfoEmptyLabel)
	self:RegisterApi("SoulInfoInfoBtnText", self.GetSoulInfoInfoBtnText)
	self:RegisterApi("FormationIndexText", self.GetFormationIndexText)
	self:RegisterApi("SmallEquipCellQualityIconPath", self.GetSmallEquipCellQualityIconPath)
	self:RegisterApi("SmallEquipCellLevelText", self.GetSmallEquipCellLevelText)
	self:RegisterApi("SwitchSkillLabel", self.GetSwitchSkillLabel)
	self:RegisterApi("PasteBtnText", self.GetPasteBtnText)
	self:RegisterApi("CopyToggleTexts", self.GetCopyToggleTexts)
	self:RegisterApi("SwitchPageBtnText", self.GetSwitchPageBtnText)
end

function FormationUIApi:GetTitleText()
	return self:GetCfgText(1214060)
end

function FormationUIApi:GetFormationTabLabelText()
	return self:GetCfgText(1214060)
end

function FormationUIApi:GetFormationTabOrderText(order)
	return tostring(order)
end

function FormationUIApi:GetEquipSmallCellQualityImage(quality)
	if quality == 1 then
		return self:GetResUrl(1300007)
	elseif quality == 2 then
		return self:GetResUrl(1300008)
	elseif quality == 3 then
		return self:GetResUrl(1300009)
	elseif quality == 4 then
		return self:GetResUrl(1300010)
	elseif quality == 5 then
		return self:GetResUrl(1300011)
	end

	return self:GetResUrl(1300006)
end

function FormationUIApi:GetDefaultFormationName(index, name)
	if name ~= nil and name ~= "" then
		return name
	end

	return self:GetCfgText(1214051) .. index
end

function FormationUIApi:GetInputNameNoticeText()
	return self:GetCfgText(1214052)
end

function FormationUIApi:GetPositionUnlockCondition(unlockLv)
	return "Lv " .. self.TextColor[203] .. unlockLv .. self.TextColor[0]
end

function FormationUIApi:GetSoulPositionLabelText(isFront)
	if isFront then
		return self:GetCfgText(1214061), self:Blank(self:GetCfgText(1214062), 1)
	else
		return self:GetCfgText(1214063), self:Blank(self:GetCfgText(1214064), 1)
	end
end

function FormationUIApi:GetUnloadAllToggleText()
	return self:GetCfgText(1214065)
end

function FormationUIApi:GetUnloadAllSoulBtnText()
	return self:GetCfgText(1214076)
end

function FormationUIApi:GetUnloadAllEquipBtnText()
	return self:GetCfgText(1214075)
end

function FormationUIApi:GetSwitchInfoViewBtnText()
	return self:GetCfgText(1214070)
end

function FormationUIApi:GetSkillGroupIndexText(index)
	if index == 1 then
		return "Ⅰ"
	elseif index == 2 then
		return "Ⅱ"
	elseif index == 3 then
		return "Ⅲ"
	end

	return "?"
end

function FormationUIApi:GetSoulCellSkillGroupLabel()
	return self:GetCfgText(1214071)
end

function FormationUIApi:GetSoulCellEquipLabel()
	return self:GetCfgText(1214069)
end

function FormationUIApi:GetSoulInfoLevelText(level)
	return "LV." .. level
end

function FormationUIApi:GetSoulInfoPowerLabel()
	return self:GetCfgText(1214073)
end

function FormationUIApi:GetSoulInfoAttrValue(value, addValue, attrId)
	if value == nil then
		return "--"
	end

	if addValue == 0 then
		return value
	elseif addValue > 0 then
		return self.TextColor[207] .. value .. self.TextColor[0]
	elseif addValue < 0 then
		return self.TextColor[203] .. value .. self.TextColor[0]
	end

	return "???"
end

function FormationUIApi:GetSoulInfoEmptyLabel()
	return self:GetCfgText(1214072)
end

function FormationUIApi:GetFormationIndexText(index)
	if index < 10 then
		return "0" .. index
	else
		return index
	end
end

function FormationUIApi:GetSmallEquipCellQualityIconPath(quality)
	if quality == 0 then
		return self:GetResUrl(1300001)
	elseif quality == 1 then
		return self:GetResUrl(1300001)
	elseif quality == 2 then
		return self:GetResUrl(1300002)
	elseif quality == 3 then
		return self:GetResUrl(1300003)
	elseif quality == 4 then
		return self:GetResUrl(1300004)
	elseif quality == 5 then
		return self:GetResUrl(1300005)
	end
end

function FormationUIApi:GetSmallEquipCellLevelText(level)
	if level == 0 then
		return ""
	else
		return level
	end
end

function FormationUIApi:GetSwitchSkillLabel()
	return self:GetCfgText(1214074)
end

function FormationUIApi:GetSoulInfoInfoBtnText()
	return self:GetCfgText(1214077)
end

function FormationUIApi:GetSoulCellPowerLabel()
	return self:GetCfgText(1214078)
end

function FormationUIApi:GetPowerLabel()
	return self:GetCfgText(1214079)
end

function FormationUIApi:GetPasteBtnText()
	return self:GetCfgText(1214055)
end

function FormationUIApi:GetCopyToggleTexts()
	return {
		self:GetCfgText(1214056),
		self:GetCfgText(1214057)
	}
end

function FormationUIApi:GetSwitchPageBtnText(page, totalPage)
	return page .. "/" .. totalPage
end

FormationUIApi:Init()
