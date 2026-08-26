-- chunkname: @modules/logic/rouge/dlc/102/controller/RougeDLCHelper102.lua

module("modules.logic.rouge.dlc.102.controller.RougeDLCHelper102", package.seeall)

local RougeDLCHelper102 = class("RougeDLCHelper102")

function RougeDLCHelper102.getSpCollectionHeaderInfo(collectionId, collectionCfgId, enchantCfgIds, resultAttrMap, params)
	local isUsing_102 = RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102)

	if not isUsing_102 then
		return
	end

	local ownerCo = RougeDLCConfig102.instance:getCollectionOwnerCo(collectionCfgId)

	if ownerCo then
		return {
			ownerCo
		}
	end
end

function RougeDLCHelper102.getSpCollectionDescInfo(collectionId, collectionCfgId, enchantCfgIds, resultAttrMap, params)
	local isUsing_102 = RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102)

	if not isUsing_102 then
		return
	end

	local descCos = RougeDLCConfig102.instance:getSpCollectionDescCos(collectionCfgId)

	if not descCos then
		return
	end

	local infoTypeParam = params and params.infoType
	local defaultInfoType = RougeCollectionModel.instance:getCurCollectionInfoType()
	local infoType = infoTypeParam or defaultInfoType
	local isComplextType = infoType == RougeEnum.CollectionInfoType.Complex
	local isAllActive = params and params.isAllActive
	local isKeepConditionVisible = params and params.isKeepConditionVisible
	local activeEffectMap = params and params.activeEffectMap
	local isUseDefaultEffectMap = not isAllActive and not activeEffectMap and collectionId ~= nil

	if isUseDefaultEffectMap then
		activeEffectMap = RougeCollectionModel.instance:getCollectionActiveEffectMap(collectionId)
	end

	local infoList = {}
	local spDescExpressionFunc = params and params.spDescExpressionFunc
	local spConditionExpressionFunc = params and params.spConditionExpressionFunc

	for index, descCo in ipairs(descCos) do
		if isComplextType then
			if not descCo.desc then
				local desc = descCo.descSimply

				if isComplextType then
					if not descCo.condition then
						local condition = descCo.conditionSimply

						if not string.nilorempty(desc) then
							local descResult = RougeCollectionExpressionHelper.getDescExpressionResult(desc, resultAttrMap, spDescExpressionFunc)
							local conditionResult = RougeCollectionExpressionHelper.getDescExpressionResult(condition, resultAttrMap, spConditionExpressionFunc)
							local isActive = isAllActive or activeEffectMap and activeEffectMap[descCo.effectId] == true
							local isConditionVisible = isKeepConditionVisible or RougeDLCHelper102.checkpCollectionConditionVisible(collectionId, index)
							local spInfo = {
								isActive = isActive,
								content = descResult,
								isConditionVisible = isConditionVisible,
								condition = conditionResult
							}

							table.insert(infoList, spInfo)
						end
					end
				end
			end
		end
	end

	return infoList
end

local SpCollectionLevelUpAttrMap = {
	3001,
	3002,
	4001
}

function RougeDLCHelper102.checkpCollectionConditionVisible(collectionId, descIndex)
	local visible = true

	if collectionId and collectionId ~= 0 then
		local collectionMo = RougeCollectionModel.instance:getCollectionByUid(collectionId)

		if collectionMo and SpCollectionLevelUpAttrMap[descIndex] then
			visible = not collectionMo:isAttrExist(SpCollectionLevelUpAttrMap[descIndex])
		end
	end

	return visible
end

function RougeDLCHelper102._defaultSpDescExpressionFunc()
	return
end

function RougeDLCHelper102._defaultSpConditionExpressionFunc()
	return
end

function RougeDLCHelper102._showSpCollectionHeader(goItem, contentInfo)
	local characterName = contentInfo.name
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")

	txtDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_spcollection_header"), characterName)
end

local ActiveSpDescColor = "#B7B7B7"
local DisactiveSpDescColor = "#7E7E7E"
local ActiveSpDescAlpha = 1
local DisactiveSpDescAlpha = 1
local SpConditionColor = "#A08156"

function RougeDLCHelper102._showSpCollectionDescInfo(goItem, contentInfo)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local txtDesc2 = gohelper.findChildText(goItem, "txt_desc2")
	local imagePoint = gohelper.findChildImage(goItem, "txt_desc/image_point")
	local isActive = contentInfo.isActive

	txtDesc.text = SkillHelper.buildDesc(contentInfo.content)

	SLFramework.UGUI.GuiHelper:SetColor((isActive or nil) and (ActiveSpDescColor or DisactiveSpDescColor))
	ZProj.UGUIHelper:SetColorAlpha((isActive or nil) and (ActiveSpDescAlpha or DisactiveSpDescAlpha))

	local pointImageName = isActive and "rouge_collection_point1" or "rouge_collection_point2"

	UISpriteSetMgr.instance:setRougeSprite(imagePoint, pointImageName)
	SkillHelper.addHyperLinkClick(txtDesc)
	RougeCollectionDescHelper.addFixTmpBreakLine(txtDesc)
	LuaUtil.updateTMPRectHeight_LayoutElement(txtDesc)

	local isConditionVisible = contentInfo.isConditionVisible

	gohelper.setActive(txtDesc2, isConditionVisible)

	if isConditionVisible then
		local conditionTxt = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_spcollection_unlock"), {
			contentInfo.condition
		})

		txtDesc2.text = SkillHelper.buildDesc(conditionTxt)

		SLFramework.UGUI.GuiHelper.SetColor(txtDesc2, SpConditionColor)
	end
end

return RougeDLCHelper102
