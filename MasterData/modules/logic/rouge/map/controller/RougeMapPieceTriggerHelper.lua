-- chunkname: @modules/logic/rouge/map/controller/RougeMapPieceTriggerHelper.lua

module("modules.logic.rouge.map.controller.RougeMapPieceTriggerHelper", package.seeall)

local RougeMapPieceTriggerHelper = class("RougeMapPieceTriggerHelper")

function RougeMapPieceTriggerHelper.triggerHandle(pieceMo, choiceId)
	RougeMapPieceTriggerHelper._initHandle()

	local choiceCo = lua_rouge_piece_select.configDict[choiceId]

	if not choiceCo then
		logError("not found rouge_piece_select config .. " .. tostring(choiceId))

		return
	end

	local triggerType = choiceCo.triggerType
	local handle = RougeMapPieceTriggerHelper.handleDict[triggerType]

	if not handle then
		logError("not found handle .. " .. tostring(triggerType))

		return
	end

	handle(pieceMo, choiceCo)
end

function RougeMapPieceTriggerHelper.getTip(pieceMo, choiceId, status)
	if choiceId == 0 then
		return ""
	end

	RougeMapPieceTriggerHelper._initGetTipHandle()

	local choiceCo = lua_rouge_piece_select.configDict[choiceId]

	if not choiceCo then
		logError("not found rouge_piece_select config .. " .. tostring(choiceId))

		return
	end

	local triggerType = choiceCo.triggerType
	local handle = RougeMapPieceTriggerHelper.getTipHandleDict[triggerType]

	handle = handle or RougeMapPieceTriggerHelper.defaultGetPieceTip

	return handle(pieceMo, choiceCo, status)
end

function RougeMapPieceTriggerHelper.getChoiceStatus(pieceMo, choiceId)
	RougeMapPieceTriggerHelper._initGetStatusHandle()

	local choiceCo = lua_rouge_piece_select.configDict[choiceId]

	if not choiceCo then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	local triggerType = choiceCo.triggerType
	local handle = RougeMapPieceTriggerHelper.getStatusHandleDict[triggerType]

	handle = handle or RougeMapPieceTriggerHelper.defaultGetStatus

	return handle(pieceMo, choiceCo)
end

function RougeMapPieceTriggerHelper._initHandle()
	if RougeMapPieceTriggerHelper.handleDict then
		return
	end

	RougeMapPieceTriggerHelper.handleDict = {
		[RougeMapEnum.PieceTriggerType.Empty] = RougeMapPieceTriggerHelper.handleEmpty,
		[RougeMapEnum.PieceTriggerType.AcceptEntrust] = RougeMapPieceTriggerHelper.handleAcceptEntrust,
		[RougeMapEnum.PieceTriggerType.Reward] = RougeMapPieceTriggerHelper.handleReward,
		[RougeMapEnum.PieceTriggerType.Compound] = RougeMapPieceTriggerHelper.handleCompound,
		[RougeMapEnum.PieceTriggerType.Shop] = RougeMapPieceTriggerHelper.handleShop,
		[RougeMapEnum.PieceTriggerType.Exchange] = RougeMapPieceTriggerHelper.handleExchange,
		[RougeMapEnum.PieceTriggerType.EndFight] = RougeMapPieceTriggerHelper.handleEndFight,
		[RougeMapEnum.PieceTriggerType.LevelUpSp] = RougeMapPieceTriggerHelper.handleLevelUpSp
	}
end

function RougeMapPieceTriggerHelper.handleEmpty()
	logNormal("empty 类型")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function RougeMapPieceTriggerHelper.handleAcceptEntrust(pieceMo, choiceCo)
	logNormal("接受委托")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function RougeMapPieceTriggerHelper.handleReward(pieceMo, choiceCo)
	logNormal("奖励")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function RougeMapPieceTriggerHelper.handleCompound(pieceMo, choiceCo)
	logNormal("合成")
	ViewMgr.instance:openView(ViewName.RougeCollectionCompositeView)
end

function RougeMapPieceTriggerHelper.handleShop(pieceMo, choiceCo)
	logNormal("休整购物")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Store)
end

function RougeMapPieceTriggerHelper.handleExchange(pieceMo, choiceCo)
	logNormal("交换")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionExchangeView)
end

function RougeMapPieceTriggerHelper.handleEndFight(pieceMo, choiceCo)
	logNormal("结局战斗")

	local chapterId = RougeMapEnum.ChapterId
	local paramArray = string.splitToNumber(choiceCo.triggerParam, "#")
	local episodeId = paramArray[1]

	RougeMapModel.instance:setEndId(paramArray[2])
	DungeonFightController.instance:enterFight(chapterId, episodeId)
end

function RougeMapPieceTriggerHelper.handleLevelUpSp(pieceMo, choiceCo)
	logNormal("专武升级")

	if pieceMo.triggerStr then
		if not pieceMo.triggerStr.collectionLevelUpNum then
			local maxLevelUpNum = 0
			local viewParams = {
				closeBtnVisible = true,
				maxLevelUpNum = maxLevelUpNum
			}

			RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, viewParams)
		end
	end
end

function RougeMapPieceTriggerHelper._initGetTipHandle()
	if RougeMapPieceTriggerHelper.getTipHandleDict then
		return
	end

	RougeMapPieceTriggerHelper.getTipHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = RougeMapPieceTriggerHelper.getExchangeTip
	}
end

function RougeMapPieceTriggerHelper.defaultGetPieceTip(pieceMo, choiceCo, status)
	if status ~= RougeMapEnum.ChoiceStatus.Lock then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(choiceCo.unlockType, choiceCo.unlockParam)
end

function RougeMapPieceTriggerHelper.getExchangeTip(pieceMo, choiceCo, status)
	if status == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(choiceCo.unlockType, choiceCo.unlockParam)
	end

	local maxExchangeCount = RougeMapModel.instance:getExchangeMaxDisplaceNum()

	if pieceMo.triggerStr then
		if not pieceMo.triggerStr.displaceNum then
			local curExchangedCount = 0
			local remainCount = maxExchangeCount - curExchangedCount

			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_remain_exchange_time"), remainCount)
		end
	end
end

function RougeMapPieceTriggerHelper._initGetStatusHandle()
	if RougeMapPieceTriggerHelper.getStatusHandleDict then
		return
	end

	RougeMapPieceTriggerHelper.getStatusHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = RougeMapPieceTriggerHelper.getExchangeStatus
	}
end

function RougeMapPieceTriggerHelper.defaultGetStatus(pieceMo, choiceCo)
	if RougeMapUnlockHelper.checkIsUnlock(choiceCo.unlockType, choiceCo.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	return RougeMapEnum.ChoiceStatus.Lock
end

function RougeMapPieceTriggerHelper.getExchangeStatus(pieceMo, choiceCo)
	if not RougeMapUnlockHelper.checkIsUnlock(choiceCo.unlockType, choiceCo.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Lock
	end

	local maxExchangeCount = RougeMapModel.instance:getExchangeMaxDisplaceNum()

	if pieceMo.triggerStr then
		if not pieceMo.triggerStr.displaceNum then
			local curExchangedCount = 0
			local remainCount = maxExchangeCount - curExchangedCount

			if remainCount < 1 then
				return RougeMapEnum.ChoiceStatus.Bought
			end

			return RougeMapEnum.ChoiceStatus.Normal
		end
	end
end

return RougeMapPieceTriggerHelper
