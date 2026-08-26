-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ItemDescBaseHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ItemDescBaseHelper", package.seeall)

local Rouge2_ItemDescBaseHelper = class("Rouge2_ItemDescBaseHelper")

function Rouge2_ItemDescBaseHelper:_type2GetDescFunc(descType)
	if not self._getDescFuncMap then
		self._getDescFuncMap = {}

		self:_initGetDescFuncMap(self._getDescFuncMap)
	end

	local func = self._getDescFuncMap[descType]

	if not func then
		logError(string.format("肉鸽不存在获取指定造物描述的方法, descType = %s", descType))
	end

	return func
end

function Rouge2_ItemDescBaseHelper:_initGetDescFuncMap(funcMap)
	funcMap[Rouge2_Enum.RelicsDescType.Desc] = self._getDesc_Desc
	funcMap[Rouge2_Enum.RelicsDescType.NarrativeDesc] = self._getDesc_NarrativeDesc
	funcMap[Rouge2_Enum.RelicsDescType.NarrativeDescOutside] = self._getDesc_NarrativeDescOutside
end

function Rouge2_ItemDescBaseHelper:_getDesc_Desc(model, config, descType, descMode, resultDescList)
	local isSimply = descMode == Rouge2_Enum.ItemDescMode.Simply

	if isSimply then
		if not config.descSimply then
			local descStr = config.desc

			if string.nilorempty(descStr) then
				return
			end

			local descList = string.split(descStr, "|")

			if descList then
				if not #descList then
					local descNum = 0

					for i = 1, descNum do
						local desc = descList[i]
						local descResult = Rouge2_ItemExpressionHelper.getDescResult(model, config, desc)
						local isTrigger = model == nil and true or model:isTriggerEffect(i)
						local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, descResult, Rouge2_Enum.RelicsDescParam.isTrigger, isTrigger)

						Rouge2_ItemDescHelper._addDescMo(resultDescList, descMo)
					end
				end
			end
		end
	end
end

function Rouge2_ItemDescBaseHelper:_getDesc_NarrativeDesc(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.narrativeDesc)

	table.insert(resultDescList, descMo)
end

function Rouge2_ItemDescBaseHelper:_getDesc_NarrativeDescOutside(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.narrativeDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, string.format("<color=#C2AA99><i>%s<i></color>", config.narrativeDesc))

	table.insert(resultDescList, descMo)
end

function Rouge2_ItemDescBaseHelper:getDefaultIncludeTypeList()
	if not self._defaultIncludeTypeList then
		self._defaultIncludeTypeList = {}

		self:_initDefaultIncludeTypeList(self._defaultIncludeTypeList)
	end

	return self._defaultIncludeTypeList
end

function Rouge2_ItemDescBaseHelper:_initDefaultIncludeTypeList(includeTypeList)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.Desc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.NarrativeDesc)
end

function Rouge2_ItemDescBaseHelper:setItemDesc(dataType, dataId, goParent, descMode, includeTypeList)
	local descMoList = self:getItemDescList(dataType, dataId, descMode, includeTypeList)

	if not descMoList then
		return
	end

	local unUseItemMap = self:_buildUnuseItemMap(goParent)

	for _, descMo in ipairs(descMoList) do
		self:setOneDesc(descMo, goParent, unUseItemMap)
	end
end

function Rouge2_ItemDescBaseHelper:setOneDesc(descMo, goRoot, unUseItemMap)
	if not descMo then
		return
	end

	local descType = descMo:getDescType()
	local unUseItemList = unUseItemMap and unUseItemMap[descType]
	local goItem = unUseItemList and unUseItemList[1]

	if goItem then
		goItem = table.remove(unUseItemList, 1)
	else
		local goTemplate = gohelper.findChild(goRoot, string.format("go_Type%s", descType))

		goItem = gohelper.cloneInPlace(goTemplate, descType)
	end

	gohelper.setActive(goItem, true)
	gohelper.setAsLastSibling(goItem)

	local setFunc = self:_type2SetDescFunc(descType)

	if setFunc and goItem then
		setFunc(self, descMo, goItem)
	end
end

function Rouge2_ItemDescBaseHelper:_buildUnuseItemMap(goParent)
	if gohelper.isNil(goParent) then
		logError("肉鸽构筑物描述根节点不存在")

		return
	end

	local unUseItemMap = {}
	local tranParent = goParent.transform
	local childNum = tranParent.childCount

	for i = 1, childNum do
		local goChild = tranParent:GetChild(i - 1).gameObject
		local goChildName = goChild.name
		local childType = string.splitToNumber(goChildName, "_")[1]

		if childType then
			unUseItemMap[childType] = unUseItemMap[childType] or {}

			table.insert(unUseItemMap[childType], goChild)
		end

		gohelper.setActive(goChild, false)
	end

	return unUseItemMap
end

function Rouge2_ItemDescBaseHelper:getItemDescList(dataType, dataId, descMode, includeTypeList)
	includeTypeList = includeTypeList or self:getDefaultIncludeTypeList()

	local resultDescList = {}
	local itemCo, itemMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)

	for _, descType in ipairs(includeTypeList) do
		local func = self:_type2GetDescFunc(descType)

		if func then
			func(self, itemMo, itemCo, descType, descMode, resultDescList)
		end
	end

	return resultDescList
end

function Rouge2_ItemDescBaseHelper:getItemDescStr(dataType, dataId, descMode, includeTypeList)
	local contentList = {}
	local itemDescList = self:getItemDescList(dataType, dataId, descMode, includeTypeList)

	for _, itemDescMo in ipairs(itemDescList) do
		local content = itemDescMo:getContent()

		if content then
			table.insert(contentList, content)
		end
	end

	return table.concat(contentList, "\n")
end

function Rouge2_ItemDescBaseHelper:_type2SetDescFunc(descType)
	if not self._setDescFuncMap then
		self._setDescFuncMap = {}

		self:_buildSetDescFuncMap(self._setDescFuncMap)
	end

	local func = self._setDescFuncMap[descType]

	if not func then
		logError(string.format("肉鸽不存在获取指定造物描述的方法, descType = %s", descType))
	end

	return func
end

function Rouge2_ItemDescBaseHelper:_buildSetDescFuncMap(funcMap)
	funcMap[Rouge2_Enum.RelicsDescType.Desc] = self._setDesc_DescType
	funcMap[Rouge2_Enum.RelicsDescType.UnlockDesc] = self._setDesc_UnlockDesc
	funcMap[Rouge2_Enum.RelicsDescType.NarrativeDesc] = self._setDesc_NarrativeDesc
	funcMap[Rouge2_Enum.RelicsDescType.NarrativeDescOutside] = self._setDesc_NarrativeDesc
	funcMap[Rouge2_Enum.RelicsDescType.LevelUp] = self._setDesc_LevelUp
end

function Rouge2_ItemDescBaseHelper:_setDesc_DescType(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)
	local isTrigger = descMo:getValue(Rouge2_Enum.RelicsDescParam.isTrigger)

	self:_setPointImage(imagePoint, isTrigger)
	self:_updateTxtComp(txtDesc, desc, isTrigger)
end

function Rouge2_ItemDescBaseHelper:_setDesc_UnlockDesc(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local txtCondition = gohelper.findChildText(goItem, "txt_desc2")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")

	SkillHelper.addHyperLinkClick(txtDesc)
	SkillHelper.addHyperLinkClick(txtCondition)

	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)
	local condition = descMo:getValue(Rouge2_Enum.RelicsDescParam.Condition)
	local isTrigger = descMo:getValue(Rouge2_Enum.RelicsDescParam.isTrigger)

	self:_setPointImage(imagePoint, isTrigger)
	self:_updateTxtComp(txtDesc, desc, isTrigger)
	self:_updateTxtComp(txtCondition, condition, isTrigger)
	gohelper.setActive(txtCondition.gameObject, not isTrigger)
end

function Rouge2_ItemDescBaseHelper:_setDesc_NarrativeDesc(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.Desc)

	Rouge2_ItemDescHelper.buildAndSetDesc(txtDesc, desc)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtDesc)
end

function Rouge2_ItemDescBaseHelper:_setDesc_LevelUp(descMo, goItem)
	local txtDesc = gohelper.findChildText(goItem, "extra/txt_desc")
	local desc = descMo:getValue(Rouge2_Enum.RelicsDescParam.LevelUp)

	Rouge2_ItemDescHelper.buildAndSetDesc(txtDesc, desc)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtDesc)
end

function Rouge2_ItemDescBaseHelper:_setPointImage(imagePoint, isTrigger)
	local pointImageName = isTrigger and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(imagePoint, pointImageName)
end

function Rouge2_ItemDescBaseHelper:_updateTxtComp(txtComp, content, isTrigger)
	if string.nilorempty(content) then
		txtComp.text = ""

		return
	end

	Rouge2_ItemDescHelper.buildAndSetDesc(txtComp, content)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtComp)
	self:_setTxtColor(txtComp, isTrigger)
end

function Rouge2_ItemDescBaseHelper:_setTxtColor(txtComp, isTrigger)
	local color = self:_getEffectColor(isTrigger)

	SLFramework.UGUI.GuiHelper.SetColor(txtComp, color)
end

Rouge2_ItemDescBaseHelper.ActiveEffectColor = "#201F1E"
Rouge2_ItemDescBaseHelper.DisactiveEffectColor = "#7E7E7E"

function Rouge2_ItemDescBaseHelper:_getEffectColor(isTrigger)
	return (isTrigger or nil) and (Rouge2_ItemDescBaseHelper.ActiveEffectColor or Rouge2_ItemDescBaseHelper.DisactiveEffectColor)
end

return Rouge2_ItemDescBaseHelper
