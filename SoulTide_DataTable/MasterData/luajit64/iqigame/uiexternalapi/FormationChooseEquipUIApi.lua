-- chunkname: @IQIGame\\UIExternalApi\\FormationChooseEquipUIApi.lua

FormationChooseEquipUIApi = BaseLangApi:Extend()

function FormationChooseEquipUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipSelectedEquipBtnText", self.GetTipSelectedEquipBtnText)
	self:RegisterApi("TipWearingEquipText", self.GetTipWearingEquipText)
	self:RegisterApi("TipInfoBtnText", self.GetTipInfoBtnText)
	self:RegisterApi("TipEnhanceBtnText", self.GetTipEnhanceBtnText)
	self:RegisterApi("EquipPrefabBtnText", self.GetEquipPrefabBtnText)
	self:RegisterApi("EquipPrefabNameText", self.GetEquipPrefabNameText)
	self:RegisterApi("UsePrefabBtnText", self.GetUsePrefabBtnText)
	self:RegisterApi("CoverBtnPrefabBtnText", self.GetCoverBtnPrefabBtnText)
	self:RegisterApi("SortBtnText", self.GetSortBtnText)
	self:RegisterApi("FilterBtnText", self.GetFilterBtnText)
	self:RegisterApi("ClearFilterBtnText", self.GetClearFilterBtnText)
	self:RegisterApi("SoulPortraitPath", self.GetSoulPortraitPath)
	self:RegisterApi("SuitTipText", self.GetSuitTipText)
	self:RegisterApi("UnloadAllBtnText", self.GetUnloadAllBtnText)
	self:RegisterApi("PrefabItemUnloadAllBtnText", self.GetPrefabItemUnloadAllBtnText)
	self:RegisterApi("InputPrefabNameNoticeText", self.GetInputPrefabNameNoticeText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("GoSoulBtnText", self.GetGoSoulBtnText)
	self:RegisterApi("GoEquipText", self.GetGoEquipText)
	self:RegisterApi("CloseBtn2Text", self.GetCloseBtn2Text)
	self:RegisterApi("QuickModeToggleText", self.GetQuickModeToggleText)
	self:RegisterApi("EquipPrefabOrderText", self.GetEquipPrefabOrderText)
	self:RegisterApi("EquipEmptyViewText", self.GetEquipEmptyViewText)
end

function FormationChooseEquipUIApi:GetTitleText()
	return self:GetCfgText(1214201)
end

function FormationChooseEquipUIApi:GetTipSelectedEquipBtnText(isSelected)
	if isSelected then
		return self:GetCfgText(1314052)
	else
		return self:GetCfgText(1211042)
	end
end

function FormationChooseEquipUIApi:GetTipWearingEquipText()
	return self:GetCfgText(1001028)
end

function FormationChooseEquipUIApi:GetEquipPrefabBtnText()
	return self:GetCfgText(1214202)
end

function FormationChooseEquipUIApi:GetEquipPrefabNameText(index)
	return "<size=20>No.</size><size=30>" .. index .. "</size>"
end

function FormationChooseEquipUIApi:GetUsePrefabBtnText(index)
	return self:GetCfgText(22)
end

function FormationChooseEquipUIApi:GetCoverBtnPrefabBtnText(index)
	return self:GetCfgText(1214203)
end

function FormationChooseEquipUIApi:GetSortBtnText()
	return self:GetCfgText(1314311)
end

function FormationChooseEquipUIApi:GetFilterBtnText()
	return self:GetCfgText(1314310)
end

function FormationChooseEquipUIApi:GetClearFilterBtnText()
	return self:GetCfgText(1214204)
end

function FormationChooseEquipUIApi:GetSoulPortraitPath(soulCid, soulResCid)
	return UIGlobalApi.GetSoulPortraitPath(soulCid, soulResCid)
end

function FormationChooseEquipUIApi:GetSuitTipText(isSuitActive, quality)
	if isSuitActive then
		local color = UIGlobalApi.GetColorStrByQuality(quality)

		if quality == 1 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 2 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 3 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 4 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 5 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		end

		return "品质错误：" .. quality
	else
		return "<color=#B2B2B2>" .. self:GetCfgText(1214206) .. "</color>"
	end
end

function FormationChooseEquipUIApi:GetUnloadAllBtnText()
	return self:GetCfgText(1214207)
end

function FormationChooseEquipUIApi:GetPrefabItemUnloadAllBtnText()
	return self:GetCfgText(1214208)
end

function FormationChooseEquipUIApi:GetInputPrefabNameNoticeText()
	return self:GetCfgText(1214305)
end

function FormationChooseEquipUIApi:GetConfirmBtnText()
	return self:GetCfgText(1214306)
end

function FormationChooseEquipUIApi:GetGoSoulBtnText()
	return self:GetCfgText(1214068)
end

function FormationChooseEquipUIApi:GetGoEquipText()
	return self:GetCfgText(1214069)
end

function FormationChooseEquipUIApi:GetCloseBtn2Text()
	return self:GetCfgText(1214307)
end

function FormationChooseEquipUIApi:GetQuickModeToggleText()
	return self:GetCfgText(1214308)
end

function FormationChooseEquipUIApi:GetEquipPrefabOrderText(order)
	if order < 10 then
		return "0" .. order
	end

	return tostring(order)
end

function FormationChooseEquipUIApi:GetTipInfoBtnText()
	return self:GetCfgText(1314413)
end

function FormationChooseEquipUIApi:GetTipEnhanceBtnText()
	return self:GetCfgText(1314409)
end

function FormationChooseEquipUIApi:GetEquipEmptyViewText()
	return self:GetCfgText(1214209)
end

FormationChooseEquipUIApi:Init()
