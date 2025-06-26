-- chunkname: @IQIGame\\Module\\Common\\Screen\\CommonScreenModule.lua

local CommonScreenData = require("IQIGame/Module/Common/Screen/CommonScreenData")

CommonScreenModule = {
	__equipScreenCfgData = {},
	__roleScreenCfgData = {},
	__skillScreenCfgData = {}
}

function CommonScreenModule.Initialize()
	CommonScreenModule.__InitEquipScreenData()
	CommonScreenModule.__InitSkillScreenData()
	CommonScreenModule.__InitRoleScreenData()
end

function CommonScreenModule.CreateCommonScreenItemLimitData(maxChoiceCount, excludeAll)
	local limitData = {}

	limitData.maxChoiceCount = maxChoiceCount
	limitData.excludeAll = excludeAll
	limitData.hideInScreenView = false
	limitData.exParams = {}

	return limitData
end

function CommonScreenModule.CreateCommonScreenData(screenType, limitTable)
	if screenType == Constant.CommonScreenType.Equip then
		return CommonScreenModule.__CreateCommonScreenData(screenType, limitTable, CommonScreenModule.__equipScreenCfgData)
	elseif screenType == Constant.CommonScreenType.Role then
		return CommonScreenModule.__CreateCommonScreenData(screenType, limitTable, CommonScreenModule.__roleScreenCfgData)
	elseif screenType == Constant.CommonScreenType.Skill then
		return CommonScreenModule.__CreateCommonScreenData(screenType, limitTable, CommonScreenModule.__skillScreenCfgData)
	else
		return {}
	end
end

function CommonScreenModule.__CreateCommonScreenData(screenType, limitTable, cfgTable)
	local screenData = CommonScreenData.New()

	screenData.screenType = screenType

	ForPairs(limitTable, function(_screenType, limitData)
		local cfgData = cfgTable[_screenType]

		if cfgData == nil then
			logError("筛选数据错误, 配置表找不到类型 {0} 的筛选配置", _screenType)

			return
		end

		screenData:AddScreenItem(_screenType, limitData)
	end)

	return screenData
end

function CommonScreenModule.GetSubScreenCfgIDList(screenType, subScreenType)
	if screenType == Constant.CommonScreenType.Equip then
		return CommonScreenModule.__equipScreenCfgData[subScreenType]
	elseif screenType == Constant.CommonScreenType.Role then
		return CommonScreenModule.__roleScreenCfgData[subScreenType]
	elseif screenType == Constant.CommonScreenType.Skill then
		return CommonScreenModule.__skillScreenCfgData[subScreenType]
	else
		return {}
	end
end

function CommonScreenModule.GetSubScreenCfgIDByValue(screenType, subScreenType, value)
	local idList = CommonScreenModule.GetSubScreenCfgIDList(screenType, subScreenType)
	local resultId = 0

	ForPairs(idList, function(_, _cfgId)
		local cfg = CommonScreenModule.GetScreenCfgByID(screenType, _cfgId)

		if cfg.Value == value then
			resultId = cfg.Id

			return true
		end
	end)

	return resultId
end

function CommonScreenModule.GetScreenCfgByID(screenType, screenID)
	if screenType == Constant.CommonScreenType.Equip then
		return CfgEquipScreenTable[screenID]
	elseif screenType == Constant.CommonScreenType.Role then
		return {}
	elseif screenType == Constant.CommonScreenType.Skill then
		return CfgSkillScreenTable[screenID]
	else
		return {}
	end
end

function CommonScreenModule.FormatScreenIconPath(path)
	if LuaUtility.StrIsNullOrEmpty(path) then
		return ""
	end

	return "Assets/" .. path
end

function CommonScreenModule.GetScreenItemTitle(screenType, subScreenType)
	if screenType == Constant.CommonScreenType.Equip then
		return CommonSortingPopupListApi:GetEquipScreenTypeTitle(subScreenType)
	elseif screenType == Constant.CommonScreenType.Skill then
		return CommonSortingPopupListApi:GetSkillScreenTypeTitle(subScreenType)
	elseif screenType == Constant.CommonScreenType.Role then
		-- block empty
	end

	return ""
end

function CommonScreenModule.GetScreenItemShowData(screenType, subScreenType, screenID)
	if screenID == Constant.CommonScreenAllValueID then
		return CommonScreenModule.__GetScreenAllItemShowData(screenType, subScreenType)
	end

	local result = {}
	local cfg = CommonScreenModule.GetScreenCfgByID(screenType, screenID)

	result.Icon = cfg.Icon
	result.Content = cfg.Content

	local emptyIcon = LuaUtility.StrIsNullOrEmpty(result.Icon)

	if result.Icon == "none" then
		result.Icon = ""
	end

	local emptyContent = LuaUtility.StrIsNullOrEmpty(result.Content)

	if emptyIcon or emptyContent then
		local icon, content = CommonScreenModule.__GetScreenShowDataByConfig(screenType, cfg)

		if emptyIcon then
			result.Icon = icon
		end

		if emptyContent then
			result.Content = content
		end
	end

	return result
end

function CommonScreenModule.__GetScreenAllItemShowData(screenType, subScreenType)
	if screenType == Constant.CommonScreenType.Equip then
		return CommonSortingPopupListApi:GetEquipScreenAllItemShowData(subScreenType)
	elseif screenType == Constant.CommonScreenType.Skill then
		return CommonSortingPopupListApi:GetSkillScreenAllShowData(subScreenType)
	elseif screenType == Constant.CommonScreenType.Role then
		-- block empty
	end

	logError("未实现 Constant.CommonScreenType {0} 选中全部选项显示数据逻辑....", screenType)
end

function CommonScreenModule.__GetScreenShowDataByConfig(screenType, config)
	if screenType == Constant.CommonScreenType.Equip then
		return CommonScreenModule.__GetEquipScreenItemShowDataByConfig(config)
	elseif screenType == Constant.CommonScreenType.Skill then
		return CommonScreenModule.__GetSkillScreenItemShowDataByConfig(config)
	elseif screenType == Constant.CommonScreenType.Role then
		-- block empty
	end

	logError("未实现 Constant.CommonScreenType {0} 类型从配置表获取选项显示数据逻辑....", screenType)
end

function CommonScreenModule.ScreenCheck(target, commonScreenData)
	if commonScreenData.screenType == Constant.CommonScreenType.Equip then
		return CommonScreenModule.__CheckEquip(target, commonScreenData)
	elseif commonScreenData.screenType == Constant.CommonScreenType.Skill then
		return CommonScreenModule.__CheckSkill(target, commonScreenData)
	elseif commonScreenData.screenType == Constant.CommonScreenType.Role then
		-- block empty
	end

	logError("未实现 Constant.CommonScreenType {0} 类型验证数据逻辑....", commonScreenData.screenType)

	return true
end

function CommonScreenModule.__InitEquipScreenData()
	CommonScreenModule.__equipScreenCfgData = {}

	ForPairs(CfgEquipScreenTable, function(_cid, _data)
		if CommonScreenModule.__equipScreenCfgData[_data.Type] == nil then
			CommonScreenModule.__equipScreenCfgData[_data.Type] = {}
		end

		table.insert(CommonScreenModule.__equipScreenCfgData[_data.Type], _cid)
	end)
end

function CommonScreenModule.__GetEquipScreenItemShowDataByConfig(cfg)
	if cfg.Type == Constant.EquipScreenType.Suit then
		local valueCfg = EquipModule.GetSuitNeedCount(cfg.Value, 1)[1]

		return valueCfg.Icon, valueCfg.Name
	elseif cfg.Type == Constant.EquipScreenType.Quality then
		return "", ""
	elseif cfg.Type == Constant.EquipScreenType.MainProperty then
		local cfgAttribute = CfgAttributeTable[cfg.Value]

		return cfgAttribute.ImageUrl, cfgAttribute.Name
	elseif cfg.Type == Constant.EquipScreenType.SubProperty then
		local cfgAttribute = CfgAttributeTable[cfg.Value]

		return cfgAttribute.ImageUrl, cfgAttribute.Name
	elseif cfg.Type == Constant.EquipScreenType.Part then
		return "", ""
	end

	return "Error", "Error"
end

function CommonScreenModule.__CheckEquip(equipData, commonScreenData)
	local isLegal = true

	ForPairs(commonScreenData.valueTable, function(_subScreenType, _valueArray)
		if _subScreenType == Constant.EquipScreenType.Suit then
			isLegal = CommonScreenModule.__CheckArrayValueInArray(_valueArray, equipData:GetEquipCfg().SuitId)
		elseif _subScreenType == Constant.EquipScreenType.Quality then
			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, equipData:GetCfg().Quality)
		elseif _subScreenType == Constant.EquipScreenType.Part then
			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, equipData:GetCfg().Part)
		elseif _subScreenType == Constant.EquipScreenType.MainProperty then
			isLegal = CommonScreenModule.__CheckEquipAttribute(_valueArray, equipData.baseAttribute.Main)
		elseif _subScreenType == Constant.EquipScreenType.SubProperty then
			isLegal = CommonScreenModule.__CheckEquipAttribute(_valueArray, equipData.baseAttribute.Other)
		end

		if not isLegal then
			return true
		end
	end)

	return isLegal
end

function CommonScreenModule.__CheckEquipAttribute(tab, attributeTable)
	local result = true

	ForArray(tab, function(_, _attrId)
		result = false

		ForPairs(attributeTable, function(_, _attrData)
			if _attrId ~= _attrData.id then
				return
			end

			result = true

			return true
		end)

		if result == true then
			return true
		end
	end)

	return result
end

function CommonScreenModule.GetCommonEquipScreenData(hidePartScreen)
	if CommonScreenModule.CommonEquipScreenData == nil then
		local limitTab = {}

		limitTab[Constant.EquipScreenType.Part] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		limitTab[Constant.EquipScreenType.Suit] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		limitTab[Constant.EquipScreenType.Quality] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		limitTab[Constant.EquipScreenType.MainProperty] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		limitTab[Constant.EquipScreenType.SubProperty] = CommonScreenModule.CreateCommonScreenItemLimitData(4, false)
		CommonScreenModule.CommonEquipScreenData = CommonScreenModule.CreateCommonScreenData(Constant.CommonScreenType.Equip, limitTab)

		CommonScreenModule.CommonEquipScreenData:UpdateValueTable()
	end

	local result = Clone(CommonScreenModule.CommonEquipScreenData)

	result:GetScreenLimitData(Constant.EquipScreenType.Part).hideInScreenView = hidePartScreen

	return result
end

function CommonScreenModule.__InitSkillScreenData()
	CommonScreenModule.__skillScreenCfgData = {}

	ForPairs(CfgSkillScreenTable, function(_cid, _cfg)
		if CommonScreenModule.__skillScreenCfgData[_cfg.Type] == nil then
			CommonScreenModule.__skillScreenCfgData[_cfg.Type] = {}
		end

		table.insert(CommonScreenModule.__skillScreenCfgData[_cfg.Type], _cid)
	end)
end

function CommonScreenModule.__GetSkillScreenItemShowDataByConfig(cfg)
	logError("配置表 SkillScreen ID：{0} 未正确配置显示数据", cfg.Id)

	return "", ""
end

function CommonScreenModule.__CheckSkill(skillData, commonScreenData)
	local isLegal = true

	ForPairs(commonScreenData.valueTable, function(_subScreenType, _valueArray)
		if _subScreenType == Constant.SkillScreenType.OpType then
			local releaseType = skillData:GetCfg().ReleaseType

			if releaseType == nil then
				releaseType = 0
			end

			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, releaseType)
		elseif _subScreenType == Constant.SkillScreenType.Quality then
			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, skillData:GetCfg().Quality)
		elseif _subScreenType == Constant.SkillScreenType.ElementProperty then
			local skillDetailCfg = CfgSkillDetailTable[skillData:GetCfg().SkillDetail]
			local elementID = skillDetailCfg.Element

			if elementID == nil then
				elementID = 0
			end

			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, elementID)
		elseif _subScreenType == Constant.SkillScreenType.PurifyLevel then
			isLegal = CommonScreenModule.__CheckValueInArray(_valueArray, skillData.purifyLv)
		end

		if not isLegal then
			return true
		end
	end)

	return isLegal
end

function CommonScreenModule.GetCommonSkillScreenData()
	if CommonScreenModule.CommonSkillScreenData == nil then
		local limitTable = {}

		limitTable[Constant.SkillScreenType.ElementProperty] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		limitTable[Constant.SkillScreenType.OpType] = CommonScreenModule.CreateCommonScreenItemLimitData(1, false)
		CommonScreenModule.CommonSkillScreenData = CommonScreenModule.CreateCommonScreenData(Constant.CommonScreenType.Skill, limitTable)

		CommonScreenModule.CommonSkillScreenData:UpdateValueTable()
	end

	return Clone(CommonScreenModule.CommonSkillScreenData)
end

function CommonScreenModule.GetCommonPlayerScreenData()
	return Clone(CommonScreenModule.CommonRoleScreenData)
end

function CommonScreenModule.__InitRoleScreenData()
	CommonScreenModule.__roleScreenCfgData = {}
end

function CommonScreenModule.__CheckValueInArray(tab, value)
	local result = true

	ForArray(tab, function(_, v)
		result = v == value

		if result then
			return true
		end
	end)

	return result
end

function CommonScreenModule.__CheckArrayValueInArray(targetValues, sourceValues)
	local result = true

	ForArray(targetValues, function(_, _targetValue)
		result = false

		ForArray(sourceValues, function(_, _sourceValue)
			if _targetValue ~= _sourceValue then
				return
			end

			result = true

			return true
		end)

		if result == true then
			return true
		end
	end)

	return result
end
