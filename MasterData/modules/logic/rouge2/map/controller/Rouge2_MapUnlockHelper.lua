-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapUnlockHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapUnlockHelper", package.seeall)

local Rouge2_MapUnlockHelper = class("Rouge2_MapUnlockHelper")

Rouge2_MapUnlockHelper.UnlockType = {
	FinishEntrust = 11,
	LessThanAttr = 18,
	PossessRelicsNum = 13,
	PossessCoin = 8,
	NotActiveTalent = 35,
	SelectChoiceNum = 34,
	NotPossessItemAnd = 15,
	PossessItemAnd = 1,
	PossessItemOr = 2,
	PossessRevival = 9,
	CurEntrustNum = 12,
	LevelUpRelicsNum = 33,
	SelectPieceChoice = 10001,
	PossessAttr = 5,
	ActiveOutGenius = 7,
	FinishEvent = 4,
	UnselectChoice = 17,
	PassLayer = 6,
	None = 0
}

function Rouge2_MapUnlockHelper.checkIsUnlock(unlock)
	Rouge2_MapUnlockHelper._initHandle()

	local unlockInfoList = Rouge2_MapUnlockHelper.getUnlockTypeAndParam(unlock)

	if unlockInfoList and #unlockInfoList > 0 then
		for _, unlockInfo in ipairs(unlockInfoList) do
			local unlockType = unlockInfo.type
			local unlockParam = unlockInfo.param
			local isUnlock = Rouge2_MapUnlockHelper.checkIsOneConditionUnlock(unlockType, unlockParam)

			if not isUnlock then
				return
			end
		end
	end

	return true
end

function Rouge2_MapUnlockHelper.checkIsOneConditionUnlock(unlockType, unlockParam)
	local handle = Rouge2_MapUnlockHelper.unlockHandleDict[unlockType]

	if handle then
		return handle and handle(unlockParam)
	end

	return true
end

function Rouge2_MapUnlockHelper.getUnlockTypeAndParam(unlock)
	if string.nilorempty(unlock) then
		return
	end

	local unlockInfoList = string.split(unlock, "|") or {}
	local unlockParamList = {}

	for _, unlockInfo in ipairs(unlockInfoList) do
		local subInfoList = string.split(unlockInfo, ":")
		local subUnlockType = tonumber(subInfoList[1])
		local subUnlockParam = subInfoList[2]

		table.insert(unlockParamList, {
			type = subUnlockType,
			param = subUnlockParam
		})
	end

	return unlockParamList
end

function Rouge2_MapUnlockHelper.getLockTips(unlock)
	Rouge2_MapUnlockHelper._initGetTipHandle()

	local unlockInfoList = Rouge2_MapUnlockHelper.getUnlockTypeAndParam(unlock)
	local lockTips = ""

	if unlockInfoList and #unlockInfoList > 0 then
		local resultDescList = {}

		for _, unlockInfo in ipairs(unlockInfoList) do
			local unlockType = unlockInfo.type
			local unlockParam = unlockInfo.param
			local isUnlock = Rouge2_MapUnlockHelper.checkIsOneConditionUnlock(unlockType, unlockParam)

			if not isUnlock then
				local descCo = lua_rouge2_unlock_desc.configDict[unlockType]
				local handle = Rouge2_MapUnlockHelper.getTipHandleDict[unlockType]

				if descCo and handle then
					local desc = handle(descCo.desc, unlockParam)

					table.insert(resultDescList, desc)
				end
			end
		end

		lockTips = table.concat(resultDescList, "\n")
	end

	return lockTips
end

function Rouge2_MapUnlockHelper._initHandle()
	if Rouge2_MapUnlockHelper.unlockHandleDict then
		return
	end

	Rouge2_MapUnlockHelper.unlockHandleDict = {
		[Rouge2_MapUnlockHelper.UnlockType.None] = Rouge2_MapUnlockHelper._defaultCheck,
		[Rouge2_MapUnlockHelper.UnlockType.PossessItemAnd] = Rouge2_MapUnlockHelper._checkPossessItemAnd,
		[Rouge2_MapUnlockHelper.UnlockType.PossessItemOr] = Rouge2_MapUnlockHelper._checkPossessItemOr,
		[Rouge2_MapUnlockHelper.UnlockType.FinishEvent] = Rouge2_MapUnlockHelper._checkFinishEvent,
		[Rouge2_MapUnlockHelper.UnlockType.PossessAttr] = Rouge2_MapUnlockHelper._checkPossessAttr,
		[Rouge2_MapUnlockHelper.UnlockType.PassLayer] = Rouge2_MapUnlockHelper._checkPassLayer,
		[Rouge2_MapUnlockHelper.UnlockType.ActiveOutGenius] = Rouge2_MapUnlockHelper._checkActiveOutGenius,
		[Rouge2_MapUnlockHelper.UnlockType.PossessCoin] = Rouge2_MapUnlockHelper._checkPossessCoin,
		[Rouge2_MapUnlockHelper.UnlockType.PossessRevival] = Rouge2_MapUnlockHelper._checkPossessRevival,
		[Rouge2_MapUnlockHelper.UnlockType.FinishEntrust] = Rouge2_MapUnlockHelper._checkFinishEntrust,
		[Rouge2_MapUnlockHelper.UnlockType.CurEntrustNum] = Rouge2_MapUnlockHelper._checkCurEntrustNum,
		[Rouge2_MapUnlockHelper.UnlockType.PossessRelicsNum] = Rouge2_MapUnlockHelper._checkPossessRelicsNum,
		[Rouge2_MapUnlockHelper.UnlockType.NotPossessItemAnd] = Rouge2_MapUnlockHelper._checkNotPossessItemAnd,
		[Rouge2_MapUnlockHelper.UnlockType.UnselectChoice] = Rouge2_MapUnlockHelper._checkUnselectChoice,
		[Rouge2_MapUnlockHelper.UnlockType.LessThanAttr] = Rouge2_MapUnlockHelper._checkLessThanAttr,
		[Rouge2_MapUnlockHelper.UnlockType.LevelUpRelicsNum] = Rouge2_MapUnlockHelper._checkLevelUpRelicsNum,
		[Rouge2_MapUnlockHelper.UnlockType.SelectChoiceNum] = Rouge2_MapUnlockHelper._checkSelectChoiceNum,
		[Rouge2_MapUnlockHelper.UnlockType.SelectPieceChoice] = Rouge2_MapUnlockHelper._checkSelectPieceChoice,
		[Rouge2_MapUnlockHelper.UnlockType.NotActiveTalent] = Rouge2_MapUnlockHelper._checkNotActiveTalent
	}
end

function Rouge2_MapUnlockHelper._initGetTipHandle()
	if Rouge2_MapUnlockHelper.getTipHandleDict then
		return
	end

	Rouge2_MapUnlockHelper.getTipHandleDict = {
		[Rouge2_MapUnlockHelper.UnlockType.PossessItemAnd] = Rouge2_MapUnlockHelper._getPossessItemTip,
		[Rouge2_MapUnlockHelper.UnlockType.PossessItemOr] = Rouge2_MapUnlockHelper._getPossessItemTip,
		[Rouge2_MapUnlockHelper.UnlockType.FinishEvent] = Rouge2_MapUnlockHelper._getFinishEventTip,
		[Rouge2_MapUnlockHelper.UnlockType.PossessAttr] = Rouge2_MapUnlockHelper._getPossessAttrTip,
		[Rouge2_MapUnlockHelper.UnlockType.PassLayer] = Rouge2_MapUnlockHelper._getPassLayerTip,
		[Rouge2_MapUnlockHelper.UnlockType.ActiveOutGenius] = Rouge2_MapUnlockHelper._getActiveOutGeniusTip,
		[Rouge2_MapUnlockHelper.UnlockType.PossessCoin] = Rouge2_MapUnlockHelper._getDefaultTips,
		[Rouge2_MapUnlockHelper.UnlockType.PossessRevival] = Rouge2_MapUnlockHelper._getDefaultTips,
		[Rouge2_MapUnlockHelper.UnlockType.FinishEntrust] = Rouge2_MapUnlockHelper._getFinishEntrustTip,
		[Rouge2_MapUnlockHelper.UnlockType.CurEntrustNum] = Rouge2_MapUnlockHelper._noParamTips,
		[Rouge2_MapUnlockHelper.UnlockType.PossessRelicsNum] = Rouge2_MapUnlockHelper._getPossessRelicsNumTip,
		[Rouge2_MapUnlockHelper.UnlockType.NotPossessItemAnd] = Rouge2_MapUnlockHelper._getPossessItemTip,
		[Rouge2_MapUnlockHelper.UnlockType.UnselectChoice] = Rouge2_MapUnlockHelper._getUnselectChoiceTips,
		[Rouge2_MapUnlockHelper.UnlockType.LessThanAttr] = Rouge2_MapUnlockHelper._getPossessAttrTip,
		[Rouge2_MapUnlockHelper.UnlockType.LevelUpRelicsNum] = Rouge2_MapUnlockHelper._getDefaultTips,
		[Rouge2_MapUnlockHelper.UnlockType.SelectChoiceNum] = Rouge2_MapUnlockHelper._noParamTips,
		[Rouge2_MapUnlockHelper.UnlockType.SelectPieceChoice] = Rouge2_MapUnlockHelper._noParamTips,
		[Rouge2_MapUnlockHelper.UnlockType.NotActiveTalent] = Rouge2_MapUnlockHelper._getNotActiveTalentTip
	}
end

function Rouge2_MapUnlockHelper._defaultCheck()
	return true
end

function Rouge2_MapUnlockHelper._checkPossessItemAnd(unlockParam)
	local itemIdList = string.splitToNumber(unlockParam, "#")

	for _, itemId in ipairs(itemIdList or {}) do
		local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(itemId)

		if not itemList or #itemList <= 0 then
			return
		end
	end

	return true
end

function Rouge2_MapUnlockHelper._checkPossessItemOr(unlockParam)
	local itemIdList = string.splitToNumber(unlockParam, "#")

	for _, itemId in ipairs(itemIdList or {}) do
		local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(itemId)

		if itemList and #itemList > 0 then
			return true
		end
	end
end

function Rouge2_MapUnlockHelper._checkFinishEvent(unlockParam)
	local eventIdList = string.splitToNumber(unlockParam, "#")
	local recordInfo = Rouge2_MapModel.instance:getGameRecordInfo()

	for _, eventId in ipairs(eventIdList or {}) do
		if not recordInfo:isFinishEvent(eventId) then
			return
		end
	end

	return true
end

function Rouge2_MapUnlockHelper._checkPossessAttr(unlockParam)
	local attrInfo = string.splitToNumber(unlockParam, "#")
	local attrId = attrInfo[1]
	local attrVal = attrInfo[2]
	local curAttrVal = Rouge2_Model.instance:getAttrValue(attrId)

	return attrVal < curAttrVal
end

function Rouge2_MapUnlockHelper._checkPassLayer(unlockParam)
	local layerId = Rouge2_MapModel.instance:getLayerId()

	return layerId > tonumber(unlockParam)
end

function Rouge2_MapUnlockHelper._checkActiveOutGenius(unlockParam)
	return Rouge2_TalentModel.instance:isTalentActive(tonumber(unlockParam))
end

function Rouge2_MapUnlockHelper._checkPossessCoin(unlockParam)
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()

	return rougeInfo and rougeInfo.coin >= tonumber(unlockParam)
end

function Rouge2_MapUnlockHelper._checkPossessRevival(unlockParam)
	return Rouge2_Model.instance:getRevivalCoin() >= tonumber(unlockParam)
end

function Rouge2_MapUnlockHelper._checkFinishEntrust(unlockParam)
	local recordInfo = Rouge2_MapModel.instance:getGameRecordInfo()

	return recordInfo and recordInfo:isFinishEntrust(tonumber(unlockParam))
end

function Rouge2_MapUnlockHelper._checkCurEntrustNum(unlockParam)
	local doingEntrustNum = Rouge2_MapModel.instance:getDoingEntrustNum()

	return doingEntrustNum <= tonumber(unlockParam)
end

function Rouge2_MapUnlockHelper._checkPossessRelicsNum(unlockParam)
	local unlockParamList = string.splitToNumber(unlockParam, "#")
	local itemType = unlockParamList[1]
	local itemNum = unlockParamList[2]
	local isRemove = unlockParamList[3] == 1
	local filterParamMap = {
		[Rouge2_Enum.ItemFilterType.Remove] = {
			isRemove
		}
	}
	local itemList

	if itemType == 1 then
		itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Buff, filterParamMap)
	elseif itemType == 2 then
		itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Relics, filterParamMap)
	else
		logError(string.format("未定义解锁类型 unlockParam = ", unlockParam))
	end

	if itemList then
		if not #itemList then
			local curItemNum = 0

			return itemNum <= curItemNum
		end
	end
end

function Rouge2_MapUnlockHelper._checkNotPossessItemAnd(unlockParam)
	return not Rouge2_MapUnlockHelper._checkPossessItemAnd(unlockParam)
end

function Rouge2_MapUnlockHelper._checkUnselectChoice(choiceId)
	local recordInfo = Rouge2_MapModel.instance:getGameRecordInfo()
	local isSelect = recordInfo and recordInfo:isChoiceSelect(tonumber(choiceId))

	return not isSelect
end

function Rouge2_MapUnlockHelper._checkLessThanAttr(unlockParam)
	local attrInfo = string.splitToNumber(unlockParam, "#")
	local attrId = attrInfo[1]
	local attrVal = attrInfo[2]
	local curAttrVal = Rouge2_Model.instance:getAttrValue(attrId)

	return curAttrVal < attrVal
end

function Rouge2_MapUnlockHelper._checkLevelUpRelicsNum(unlockParam)
	local canUpdateRelicsNum = 0
	local itemList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.Relics)

	if itemList then
		for _, itemMo in ipairs(itemList) do
			local itemCo = itemMo:getConfig()
			local updateId = itemCo and itemCo.updateId

			if updateId and updateId ~= 0 then
				canUpdateRelicsNum = canUpdateRelicsNum + 1
			end
		end
	end

	return canUpdateRelicsNum >= tonumber(unlockParam)
end

function Rouge2_MapUnlockHelper._checkSelectChoiceNum(unlockParam)
	local unlockParamList = string.splitToNumber(unlockParam, "#")
	local choiceId = unlockParamList and unlockParamList[1]

	if unlockParamList then
		if not unlockParamList[2] then
			local selectNum = 0
			local curNode = Rouge2_MapModel.instance:getCurNode()
			local curEventCo = curNode and curNode:getEventCo()
			local curEventType = curEventCo and curEventCo.type
			local isChoiceEvent = Rouge2_MapHelper.isChoiceEvent(curEventType)

			if isChoiceEvent then
				local hasSelectNum = curNode.eventMo:getChoiceSelectNum(choiceId)

				return hasSelectNum < selectNum
			end
		end
	end
end

function Rouge2_MapUnlockHelper._checkSelectPieceChoice(unlockParam)
	local isMiddle = Rouge2_MapModel.instance:isMiddle()

	if not isMiddle then
		return
	end

	local pieceList = Rouge2_MapModel.instance:getPieceList()

	if not pieceList or #pieceList <= 0 then
		return
	end

	local selectIdMap = {}

	for _, pieceMo in ipairs(pieceList) do
		local selectIdList = pieceMo:getSelectIdList()

		if selectIdList then
			for _, selectId in ipairs(selectIdList) do
				selectIdMap[selectId] = true
			end
		end
	end

	local choiceIdList = string.splitToNumber(unlockParam, "#")

	if choiceIdList then
		for _, choiceId in ipairs(choiceIdList) do
			local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

			if choiceCo then
				if selectIdMap[choiceId] then
					return true
				end
			else
				logError(string.format("间隙层棋子选项解锁条件配置错误, 选项配置不存在 unlockParam = %s, choiceId = %s", unlockParam, choiceId))
			end
		end
	end
end

function Rouge2_MapUnlockHelper._checkNotActiveTalent(unlockParam)
	local talentIdList = unlockParam and string.splitToNumber(unlockParam, "#")

	if talentIdList then
		for _, talentId in ipairs(talentIdList) do
			local isActive = Rouge2_BackpackModel.instance:isTalentActive(talentId)

			if isActive then
				return
			end
		end
	end

	return true
end

function Rouge2_MapUnlockHelper._noParamTips(desc, unlockParam)
	return desc
end

function Rouge2_MapUnlockHelper._getDefaultTips(desc, unlockParam)
	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, unlockParam)
end

function Rouge2_MapUnlockHelper._getPossessItemTip(desc, unlockParam)
	local itemList = string.splitToNumber(unlockParam, "#")
	local itemNameList = {}

	for _, itemId in ipairs(itemList) do
		local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)

		if itemCo then
			if not itemCo.name then
				local itemName = ""

				table.insert(itemNameList, itemName)
			end
		end
	end

	local fullItemNameStr = table.concat(itemNameList, "/")

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, fullItemNameStr)
end

function Rouge2_MapUnlockHelper._getPossessChoiceTip(desc, unlockParam)
	local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(tonumber(unlockParam))

	if choiceCo then
		if not choiceCo.title then
			local choiceTitle = ""

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, choiceTitle)
		end
	end
end

function Rouge2_MapUnlockHelper._getFinishEventTip(desc, unlockParam)
	local eventCo = Rouge2_MapConfig.instance:getRougeEvent(tonumber(unlockParam))

	if eventCo then
		if not eventCo.name then
			local eventName = ""

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, eventName)
		end
	end
end

function Rouge2_MapUnlockHelper._getFinishEntrustTip(desc, unlockParam)
	local entrustCo = lua_rouge2_entrust.configDict[tonumber(unlockParam)]

	if entrustCo then
		if not entrustCo.desc then
			local entrustDesc = ""

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, entrustDesc)
		end
	end
end

function Rouge2_MapUnlockHelper._getPossessRelicsNumTip(desc, unlockParam)
	local unlockParamList = string.splitToNumber(unlockParam, "#")
	local itemType = unlockParamList and unlockParamList[1]
	local itemNum = unlockParamList and unlockParamList[2]

	itemNum = itemNum or 0

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, itemNum, itemType == 1 and luaLang("rouge2_unlockhelper_buff") or luaLang("rouge2_unlockhelper_relics"))
end

function Rouge2_MapUnlockHelper._getUnselectChoiceTips(desc, unlockParam)
	local unlockParamList = string.splitToNumber(unlockParam, "#")
	local choiceId = unlockParamList and unlockParamList[1]
	local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(choiceId)

	if choiceCo then
		if not choiceCo.title then
			local choiceName = ""

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, choiceName)
		end
	end
end

function Rouge2_MapUnlockHelper._getPossessAttrTip(desc, unlockParam)
	local attrInfo = string.splitToNumber(unlockParam, "#")
	local attrId = attrInfo and attrInfo[1]

	if attrInfo then
		if not attrInfo[2] then
			local attrVal = 0
			local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

			if attrCo then
				if not attrCo.name then
					local attrName = ""

					return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, attrName, attrVal)
				end
			end
		end
	end
end

function Rouge2_MapUnlockHelper._getPassLayerTip(desc, unlockParam)
	local layerCo = lua_rouge2_layer.configDict[tonumber(unlockParam)]

	if layerCo then
		if not layerCo.name then
			local layerName = ""

			return GameUtil.getSubPlaceholderLuaLangOneParam(desc, layerName)
		end
	end
end

function Rouge2_MapUnlockHelper._getActiveOutGeniusTip(desc, unlockParam)
	local geniusId = tonumber(unlockParam)
	local co = Rouge2_OutSideConfig.instance:getTalentConfigById(geniusId)

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, co.name)
end

function Rouge2_MapUnlockHelper._getNotActiveTalentTip(desc, unlockParam)
	local talentIdList = string.splitToNumber(unlockParam, "#")
	local fullTalentNameStr = ""

	if talentIdList then
		local talentNameList = {}

		for _, talentId in ipairs(talentIdList) do
			local talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)

			if talentCo then
				if not talentCo.name then
					local talentName = ""

					table.insert(talentNameList, talentName)
				end
			end
		end

		fullTalentNameStr = table.concat(talentNameList, "/")
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, fullTalentNameStr)
end

return Rouge2_MapUnlockHelper
