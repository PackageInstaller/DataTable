-- chunkname: @modules/logic/rouge/controller/RougeCollectionDescHelper.lua

module("modules.logic.rouge.controller.RougeCollectionDescHelper", package.seeall)

local RougeCollectionDescHelper = _M

function RougeCollectionDescHelper.setCollectionDescInfos(collectionId, goItemParent, goItemInstMap, descTypes, extraParams)
	descTypes = descTypes or RougeCollectionDescHelper.getDefaultShowDescTypes()
	extraParams = extraParams or RougeCollectionDescHelper.getDefaultExtraParams_HasInst()

	local descInfoMap = RougeCollectionDescHelper.buildCollectionInfos(descTypes, collectionId, nil, nil, extraParams)

	RougeCollectionDescHelper._showCollectionDescs(goItemParent, goItemInstMap, descTypes, descInfoMap, extraParams)
end

function RougeCollectionDescHelper.setCollectionDescInfos2(collectionCfgId, enchantCfgIds, goItemParent, goItemInstMap, descTypes, extraParams)
	descTypes = descTypes or RougeCollectionDescHelper.getDefaultShowDescTypes()
	extraParams = extraParams or RougeCollectionDescHelper.getDefaultExtraParams_NoneInst()

	local descInfoMap = RougeCollectionDescHelper.buildCollectionInfos(descTypes, nil, collectionCfgId, enchantCfgIds, extraParams)

	RougeCollectionDescHelper._showCollectionDescs(goItemParent, goItemInstMap, descTypes, descInfoMap, extraParams)
end

function RougeCollectionDescHelper.setCollectionDescInfos3(collectionCfgId, enchantCfgIds, txtComp, descTypes, extraParams)
	descTypes = descTypes or RougeCollectionDescHelper.getDefaultShowDescTypes()
	extraParams = extraParams or RougeCollectionDescHelper.getDefaultExtraParams_NoneInst()

	local descInfoMap = RougeCollectionDescHelper.buildCollectionInfos(descTypes, nil, collectionCfgId, enchantCfgIds, extraParams)

	RougeCollectionDescHelper._showCollectionDesc2(descTypes, descInfoMap, txtComp, extraParams)
end

function RougeCollectionDescHelper.setCollectionDescInfos4(collectionId, txtComp, descTypes, extraParams)
	descTypes = descTypes or RougeCollectionDescHelper.getDefaultShowDescTypes()
	extraParams = extraParams or RougeCollectionDescHelper.getDefaultExtraParams_HasInst()

	local descInfoMap = RougeCollectionDescHelper.buildCollectionInfos(descTypes, collectionId, extraParams)

	RougeCollectionDescHelper._showCollectionDesc2(descTypes, descInfoMap, txtComp, extraParams)
end

function RougeCollectionDescHelper._showCollectionDescs(goItemParent, goItemInstMap, descTypes, descInfoMap, extraParams)
	if not descTypes or not descInfoMap then
		return
	end

	local useIndexMap = {}

	for _, descType in ipairs(descTypes) do
		local contentInfo = descInfoMap[descType]

		if contentInfo then
			for _, info in ipairs(contentInfo) do
				local itemInst = RougeCollectionDescHelper._getOrCreateDescItem(descType, useIndexMap, goItemParent, goItemInstMap)

				RougeCollectionDescHelper._showCollectionSingleContent(descType, info, itemInst, extraParams)
			end
		end
	end

	for descType, itemInsts in pairs(goItemInstMap) do
		if not useIndexMap[descType] then
			local useIndex = 0
			local itemInstCount = #itemInsts

			for i = useIndex + 1, itemInstCount do
				gohelper.setActive(itemInsts[i], false)
			end
		end
	end
end

function RougeCollectionDescHelper._showCollectionDesc2(descTypes, descInfoMap, txtComp, extraParams)
	if not descTypes or not descInfoMap or not txtComp then
		return
	end

	local overrideShowFunc = extraParams and extraParams.showDescToListFunc
	local defaultShowFunc = RougeCollectionDescHelper._defaultShowDescToListFunc
	local showFunc = overrideShowFunc or defaultShowFunc

	showFunc(descTypes, descInfoMap, txtComp, extraParams)
end

function RougeCollectionDescHelper._defaultShowDescToListFunc(descTypes, descInfoMap, txtComp, extraParams)
	local descList = {}
	local isAllActive = extraParams and extraParams.isAllActive

	for _, descType in ipairs(descTypes) do
		local contentInfo = descInfoMap[descType]

		if contentInfo then
			for _, info in ipairs(contentInfo) do
				local isActive = isAllActive or info.isActive
				local desc = RougeCollectionDescHelper._decorateCollectionEffectStr(info.content, isActive)

				table.insert(descList, desc)

				if info.isConditionVisible and not string.nilorempty(info.condition) then
					local condition = RougeCollectionDescHelper._decorateCollectionEffectStr(info.condition, isActive)

					table.insert(descList, condition)
				end
			end
		end
	end

	txtComp.text = table.concat(descList, "\n")

	SkillHelper.addHyperLinkClick(txtComp)
end

function RougeCollectionDescHelper._getOrCreateDescItem(descType, useIndexMap, goItemParent, goItemInstMap)
	local goItemPrefab = gohelper.findChild(goItemParent, "go_descitem" .. descType)

	if not goItemPrefab then
		logError("找不到描述类型对应的预制体 descType = " .. tostring(descType))

		return
	end

	local goItemInstList = goItemInstMap and goItemInstMap[descType]

	if goItemInstList then
		if not #goItemInstList then
			local goItemInstCount = 0

			if useIndexMap then
				if not useIndexMap[descType] then
					local useIndex = 0
					local canGetFromInstList = useIndex < goItemInstCount

					useIndex = useIndex + 1

					if not canGetFromInstList then
						local newInstName = string.format("%s_%s", descType, useIndex)
						local newInstItem = gohelper.cloneInPlace(goItemPrefab, newInstName)

						goItemInstMap[descType] = goItemInstMap[descType] or {}

						table.insert(goItemInstMap[descType], newInstItem)
					end

					useIndexMap[descType] = useIndex

					return goItemInstMap[descType][useIndex]
				end
			end
		end
	end
end

function RougeCollectionDescHelper._showCollectionSingleContent(descType, contentInfo, obj, extraParams)
	local overrideShowFuncMap = extraParams and extraParams.showDescFuncMap
	local overrideShowFunc = overrideShowFuncMap and overrideShowFuncMap[descType]
	local defaultShowFunc = RougeCollectionDescHelper.getDefaultDescTypeShowFunc(descType)
	local contentShowFunc = overrideShowFunc or defaultShowFunc

	if not contentShowFunc then
		logError("缺少造物描述显示方法 描述类型 : " .. tostring(descType))

		return
	end

	gohelper.setActive(obj, true)
	gohelper.setAsLastSibling(obj)
	contentShowFunc(obj, contentInfo)
end

function RougeCollectionDescHelper._showCollectionBaseEffect(goItem, contentInfo)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")
	local pointImageName = contentInfo.isActive and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(imagePoint, pointImageName)

	txtDesc.text = RougeCollectionDescHelper._decorateCollectionEffectStr(contentInfo.content, contentInfo.isActive)

	SkillHelper.addHyperLinkClick(txtDesc)
	RougeCollectionDescHelper.addFixTmpBreakLine(txtDesc)
end

function RougeCollectionDescHelper._showCollectionExtraEffect(goItem, contentInfo)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")

	txtDesc.text = RougeCollectionDescHelper._decorateCollectionEffectStr(contentInfo.content, contentInfo.isActive)

	SkillHelper.addHyperLinkClick(txtDesc)
	RougeCollectionDescHelper.addFixTmpBreakLine(txtDesc)
end

function RougeCollectionDescHelper._showCollectionText(goItem, contentInfo)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")

	txtDesc.text = contentInfo.content
end

function RougeCollectionDescHelper.addFixTmpBreakLine(txtComp)
	if not txtComp then
		return
	end

	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtComp.gameObject, FixTmpBreakLine)

	fixTmpBreakLine:refreshTmpContent(txtComp)

	return fixTmpBreakLine
end

function RougeCollectionDescHelper.buildCollectionInfos(descTypes, collectionId, collectionCfgId, enchantCfgIds, extraParams)
	if not descTypes then
		return
	end

	local isValid, collectionId, collectionCfgId, enchantCfgIds = RougeCollectionDescHelper._checkExtraParamsValid(collectionId, collectionCfgId, enchantCfgIds)

	if not isValid then
		return
	end

	local overrideBuildDescFuncMap = extraParams and extraParams.buildDescFuncMap
	local resultAttrMap = RougeCollectionExpressionHelper.getCollectionAttrMap(collectionId, collectionCfgId, enchantCfgIds)
	local infoMap = {}

	for _, descType in ipairs(descTypes) do
		local overrideBuildDescFunc = overrideBuildDescFuncMap and overrideBuildDescFuncMap[descType]
		local defaultBuildDescFunc = RougeCollectionDescHelper.getDefaultDescTypeExecuteFunc(descType)
		local buildFunc = overrideBuildDescFunc or defaultBuildDescFunc

		if not buildFunc then
			logError("缺少造物描述数据构建方法 描述类型 : " .. tostring(descType))
		else
			local typeInfo = buildFunc(collectionId, collectionCfgId, enchantCfgIds, resultAttrMap, extraParams)

			if typeInfo and #typeInfo > 0 then
				infoMap[descType] = typeInfo
			end
		end
	end

	return infoMap
end

function RougeCollectionDescHelper._checkExtraParamsValid(collectionId, collectionCfgId, enchantCfgIds)
	if collectionId then
		local collectionMo = RougeCollectionModel.instance:getCollectionByUid(collectionId)

		if not collectionMo then
			return
		end

		collectionCfgId = collectionMo:getCollectionCfgId()
		enchantCfgIds = collectionMo:getAllEnchantCfgId()
	else
		local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

		if not collectionCo then
			return
		end
	end

	return true, collectionId, collectionCfgId, enchantCfgIds
end

function RougeCollectionDescHelper.getCollectionBaseEffectInfo(collectionId, collectionCfgId, enchantCfgIds, resultAttrMap, params)
	local isAllActive = params and params.isAllActive
	local activeEffectMap = params and params.activeEffectMap
	local isUseDefaultEffectMap = not isAllActive and not activeEffectMap and collectionId ~= nil

	if isUseDefaultEffectMap then
		activeEffectMap = RougeCollectionModel.instance:getCollectionActiveEffectMap(collectionId)
	end

	local infoTypeParam = params and params.infoType
	local defaultInfoType = RougeCollectionModel.instance:getCurCollectionInfoType()
	local infoType = infoTypeParam or defaultInfoType
	local isComplextType = infoType == RougeEnum.CollectionInfoType.Complex
	local effectInfosParam = params and params.effectInfos
	local defaultEffectInfo = RougeCollectionConfig.instance:getCollectionDescsCfg(collectionCfgId)
	local effectInfos = effectInfosParam or defaultEffectInfo
	local infoList = {}

	for _, effectInfo in ipairs(effectInfos) do
		if isComplextType then
			if not effectInfo.desc then
				local desc = effectInfo.descSimply

				if not string.nilorempty(desc) then
					local descResult = RougeCollectionExpressionHelper.getDescExpressionResult(desc, resultAttrMap)
					local isActive = isAllActive or activeEffectMap and activeEffectMap[effectInfo.effectId] == true
					local baseInfo = RougeCollectionDescHelper._createCollectionDescMo(descResult)

					baseInfo.isActive = isActive

					table.insert(infoList, baseInfo)
				end
			end
		end
	end

	return infoList
end

function RougeCollectionDescHelper.getCollectionExtraEffectInfo(collectionId, collectionCfgId, enchantCfgIds, resultAttrMap, params)
	local isAllActive = params and params.isAllActive
	local activeEffectMap = params and params.activeEffectMap
	local isUseDefaultEffectMap = not isAllActive and not activeEffectMap and collectionId ~= nil

	if isUseDefaultEffectMap then
		activeEffectMap = RougeCollectionModel.instance:getCollectionActiveEffectMap(collectionId)
	end

	local effectInfosParam = params and params.effectInfos
	local defaultEffectInfo = RougeCollectionConfig.instance:getCollectionDescsCfg(collectionCfgId)
	local effectInfos = effectInfosParam or defaultEffectInfo
	local infoTypeParam = params and params.infoType
	local defaultInfoType = RougeCollectionModel.instance:getCurCollectionInfoType()
	local infoType = infoTypeParam or defaultInfoType
	local isComplextType = infoType == RougeEnum.CollectionInfoType.Complex
	local infoList = {}

	for _, effectInfo in ipairs(effectInfos) do
		if isComplextType then
			if not effectInfo.descExtra then
				local extraDesc = effectInfo.descExtraSimply

				if not string.nilorempty(extraDesc) then
					local extraDescResult = RougeCollectionExpressionHelper.getDescExpressionResult(extraDesc, resultAttrMap)
					local isActive = isAllActive or activeEffectMap and activeEffectMap[effectInfo.effectId] == true
					local extraInfo = RougeCollectionDescHelper._createCollectionDescMo(extraDescResult)

					extraInfo.isActive = isActive

					table.insert(infoList, extraInfo)
				end
			end
		end
	end

	return infoList
end

function RougeCollectionDescHelper.getCollectionTextInfo(collectionId, collectionCfgId, enchantCfgIds, params)
	local officialDesc = RougeCollectionConfig.instance:getCollectionOfficialDesc(collectionCfgId)

	if not string.nilorempty(officialDesc) then
		local descMo = RougeCollectionDescHelper._createCollectionDescMo(officialDesc)

		return {
			descMo
		}
	end
end

function RougeCollectionDescHelper._createCollectionDescMo(descStr)
	return {
		content = descStr
	}
end

RougeCollectionDescHelper.ActiveEffectColor = "#B7B7B7"
RougeCollectionDescHelper.DisactiveEffectColor = "#7E7E7E"

function RougeCollectionDescHelper._decorateCollectionEffectStr(desc, isActive, activeColor, disactiveColor)
	if string.nilorempty(desc) then
		return
	end

	local resultDisactiveColor = disactiveColor or RougeCollectionDescHelper.DisactiveEffectColor
	local resultActiveColor = activeColor or RougeCollectionDescHelper.ActiveEffectColor
	local resultColor = isActive and resultActiveColor or resultDisactiveColor
	local buildDesc = SkillHelper.buildDesc(desc)

	return (string.format("<%s>%s</color>", resultColor, buildDesc))
end

function RougeCollectionDescHelper.getDefaultDescTypeShowFunc(descType)
	RougeCollectionDescHelper.DefaultDescTypeShowFuncMap = RougeCollectionDescHelper.DefaultDescTypeShowFuncMap or {
		[RougeEnum.CollectionDescType.BaseEffect] = RougeCollectionDescHelper._showCollectionBaseEffect,
		[RougeEnum.CollectionDescType.ExtraEffect] = RougeCollectionDescHelper._showCollectionExtraEffect,
		[RougeEnum.CollectionDescType.Text] = RougeCollectionDescHelper._showCollectionText,
		[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102._showSpCollectionHeader,
		[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102._showSpCollectionDescInfo
	}

	return RougeCollectionDescHelper.DefaultDescTypeShowFuncMap[descType]
end

function RougeCollectionDescHelper.getDefaultDescTypeExecuteFunc(descType)
	RougeCollectionDescHelper.DefaultDescTypeExecuteFuncMap = RougeCollectionDescHelper.DefaultDescTypeExecuteFuncMap or {
		[RougeEnum.CollectionDescType.BaseEffect] = RougeCollectionDescHelper.getCollectionBaseEffectInfo,
		[RougeEnum.CollectionDescType.ExtraEffect] = RougeCollectionDescHelper.getCollectionExtraEffectInfo,
		[RougeEnum.CollectionDescType.Text] = RougeCollectionDescHelper.getCollectionTextInfo,
		[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102.getSpCollectionHeaderInfo,
		[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102.getSpCollectionDescInfo
	}

	return RougeCollectionDescHelper.DefaultDescTypeExecuteFuncMap[descType]
end

function RougeCollectionDescHelper.getDefaultShowDescTypes()
	if not RougeCollectionDescHelper.DefaultShowDescTypes then
		RougeCollectionDescHelper.DefaultShowDescTypes = {}

		for _, descType in pairs(RougeEnum.CollectionDescType) do
			table.insert(RougeCollectionDescHelper.DefaultShowDescTypes, descType)
		end

		table.sort(RougeCollectionDescHelper.DefaultShowDescTypes, RougeCollectionDescHelper._showDescTypeSortFunc)
	end

	return RougeCollectionDescHelper.DefaultShowDescTypes
end

function RougeCollectionDescHelper._showDescTypeSortFunc(sortTypeA, sortTypeB)
	if not RougeEnum.CollectionDescTypeSort[sortTypeA] then
		local priorityA = 10000

		if not RougeEnum.CollectionDescTypeSort[sortTypeB] then
			local priorityB = 10000

			if priorityA ~= priorityB then
				return priorityA < priorityB
			end

			return sortTypeA < sortTypeB
		end
	end
end

function RougeCollectionDescHelper.getShowDescTypesWithoutText()
	if not RougeCollectionDescHelper.ShowDescTypesWithoutText then
		RougeCollectionDescHelper.ShowDescTypesWithoutText = {}

		for _, descType in pairs(RougeEnum.CollectionDescType) do
			if descType ~= RougeEnum.CollectionDescType.Text then
				table.insert(RougeCollectionDescHelper.ShowDescTypesWithoutText, descType)
			end
		end

		table.sort(RougeCollectionDescHelper.ShowDescTypesWithoutText, RougeCollectionDescHelper._showDescTypeSortFunc)
	end

	return RougeCollectionDescHelper.ShowDescTypesWithoutText
end

function RougeCollectionDescHelper.getDefaultExtraParams_NoneInst()
	RougeCollectionDescHelper.NoneInstExtraParams = RougeCollectionDescHelper.NoneInstExtraParams or {
		isKeepConditionVisible = true,
		isAllActive = true
	}

	return RougeCollectionDescHelper.NoneInstExtraParams
end

function RougeCollectionDescHelper.getDefaultExtraParams_HasInst()
	RougeCollectionDescHelper.HasInstExtraParams = RougeCollectionDescHelper.HasInstExtraParams or {}

	return RougeCollectionDescHelper.HasInstExtraParams
end

function RougeCollectionDescHelper.getExtraParams_KeepAllActive()
	RougeCollectionDescHelper.ExtraParams_KeepAllActive = RougeCollectionDescHelper.ExtraParams_KeepAllActive or {
		isAllActive = true
	}

	return RougeCollectionDescHelper.ExtraParams_KeepAllActive
end

return RougeCollectionDescHelper
