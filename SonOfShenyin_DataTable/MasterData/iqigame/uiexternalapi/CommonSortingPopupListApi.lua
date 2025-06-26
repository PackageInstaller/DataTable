-- chunkname: @IQIGame\\UIExternalApi\\CommonSortingPopupListApi.lua

CommonSortingPopupListApi = BaseLangApi:Extend()

function CommonSortingPopupListApi:Init()
	return
end

function CommonSortingPopupListApi:GetEquipSortingData()
	return {
		self:GetCfgText(6000043),
		self:GetCfgText(1000001),
		self:GetCfgText(6000044),
		self:GetCfgText(6000045)
	}
end

function CommonSortingPopupListApi:GetSkillSortingData()
	return {
		self:GetCfgText(1000002),
		self:GetCfgText(1000001),
		self:GetCfgText(130203)
	}
end

function CommonSortingPopupListApi:GetItemSortingData()
	return {
		self:GetCfgText(1000003),
		self:GetCfgText(1000012),
		self:GetCfgText(1000001)
	}
end

function CommonSortingPopupListApi:GetRoleSortingData()
	return {
		self:GetCfgText(1000002),
		self:GetCfgText(1000001)
	}
end

function CommonSortingPopupListApi:GetSkillScreenTypeTitle(subScreenType)
	if subScreenType == Constant.SkillScreenType.OpType then
		return self:GetCfgText(250001)
	elseif subScreenType == Constant.SkillScreenType.Quality then
		return self:GetCfgText(250002)
	elseif subScreenType == Constant.SkillScreenType.ElementProperty then
		return self:GetCfgText(250003)
	elseif subScreenType == Constant.SkillScreenType.PurifyLevel then
		return self:GetCfgText(250004)
	end

	return "Error_" .. tostring(subScreenType)
end

function CommonSortingPopupListApi:GetSkillScreenAllShowData(subScreenType)
	local result = {}

	if subScreenType == Constant.SkillScreenType.OpType then
		result.Icon = ""
		result.Content = self:GetCfgText(250005)
	elseif subScreenType == Constant.SkillScreenType.Quality then
		result.Icon = ""
		result.Content = self:GetCfgText(250006)
	elseif subScreenType == Constant.SkillScreenType.ElementProperty then
		result.Icon = ""
		result.Content = self:GetCfgText(250007)
	elseif subScreenType == Constant.SkillScreenType.PurifyLevel then
		result.Icon = ""
		result.Content = self:GetCfgText(250008)
	else
		result.Icon = ""
		result.Content = "Error_" .. tostring(subScreenType)
	end

	return result
end

function CommonSortingPopupListApi:GetEquipScreenTypeTitle(subScreenType)
	if subScreenType == Constant.EquipScreenType.Suit then
		return self:GetCfgText(260001)
	elseif subScreenType == Constant.EquipScreenType.Quality then
		return self:GetCfgText(260002)
	elseif subScreenType == Constant.EquipScreenType.MainProperty then
		return self:GetCfgText(260003)
	elseif subScreenType == Constant.EquipScreenType.SubProperty then
		return self:GetCfgText(260004)
	elseif subScreenType == Constant.EquipScreenType.Part then
		return self:GetCfgText(260005)
	end

	return "Error_" .. tostring(subScreenType)
end

function CommonSortingPopupListApi:GetEquipScreenAllItemShowData(subScreenType)
	local result = {}

	if subScreenType == Constant.EquipScreenType.Suit then
		result.Icon = ""
		result.Content = self:GetCfgText(260006)
	elseif subScreenType == Constant.EquipScreenType.Quality then
		result.Icon = ""
		result.Content = self:GetCfgText(260007)
	elseif subScreenType == Constant.EquipScreenType.MainProperty then
		result.Icon = ""
		result.Content = self:GetCfgText(260008)
	elseif subScreenType == Constant.EquipScreenType.SubProperty then
		result.Icon = ""
		result.Content = self:GetCfgText(260009)
	elseif subScreenType == Constant.EquipScreenType.Part then
		result.Icon = ""
		result.Content = self:GetCfgText(260010)
	else
		result.Icon = ""
		result.Content = "Error_" .. tostring(subScreenType)
	end

	return result
end

CommonSortingPopupListApi:Init()
