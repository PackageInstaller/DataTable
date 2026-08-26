-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapPieceTriggerHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapPieceTriggerHelper", package.seeall)

local Rouge2_MapPieceTriggerHelper = class("Rouge2_MapPieceTriggerHelper")

function Rouge2_MapPieceTriggerHelper.triggerHandle(pieceMo, choiceId)
	Rouge2_MapPieceTriggerHelper._initHandle()

	local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

	if not choiceCo then
		logError("not found rouge_piece_select config .. " .. tostring(choiceId))

		return
	end

	local triggerType = choiceCo.triggerType
	local handle = Rouge2_MapPieceTriggerHelper.handleDict[triggerType]

	if not handle then
		logError("not found handle .. " .. tostring(triggerType))

		return
	end

	handle(pieceMo, choiceCo)
end

function Rouge2_MapPieceTriggerHelper.getTip(pieceMo, choiceId, status)
	if choiceId == 0 then
		return ""
	end

	Rouge2_MapPieceTriggerHelper._initGetTipHandle()

	local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

	if not choiceCo then
		logError("not found rouge_piece_select config .. " .. tostring(choiceId))

		return
	end

	local triggerType = choiceCo.triggerType
	local handle = Rouge2_MapPieceTriggerHelper.getTipHandleDict[triggerType]

	handle = handle or Rouge2_MapPieceTriggerHelper.defaultGetPieceTip

	return handle(pieceMo, choiceCo, status)
end

function Rouge2_MapPieceTriggerHelper.getChoiceStatus(pieceMo, choiceId)
	Rouge2_MapPieceTriggerHelper._initGetStatusHandle()

	local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

	if not choiceCo then
		return Rouge2_MapEnum.ChoiceStatus.Normal
	end

	local triggerType = choiceCo.triggerType
	local handle = Rouge2_MapPieceTriggerHelper.getStatusHandleDict[triggerType]

	handle = handle or Rouge2_MapPieceTriggerHelper.defaultGetStatus

	return handle(pieceMo, choiceCo)
end

function Rouge2_MapPieceTriggerHelper._initHandle()
	if Rouge2_MapPieceTriggerHelper.handleDict then
		return
	end

	Rouge2_MapPieceTriggerHelper.handleDict = {
		[Rouge2_MapEnum.PieceTriggerType.Empty] = Rouge2_MapPieceTriggerHelper.handleEmpty,
		[Rouge2_MapEnum.PieceTriggerType.Reward] = Rouge2_MapPieceTriggerHelper.handleReward,
		[Rouge2_MapEnum.PieceTriggerType.EndFight] = Rouge2_MapPieceTriggerHelper.handleEndFight
	}
end

function Rouge2_MapPieceTriggerHelper.handleEmpty()
	logNormal("empty 类型")
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onExitPieceChoiceEvent)
end

function Rouge2_MapPieceTriggerHelper.handleReward(pieceMo, choiceCo)
	logNormal("奖励")
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onExitPieceChoiceEvent)
end

function Rouge2_MapPieceTriggerHelper.handleEndFight(pieceMo, choiceCo)
	logNormal("结局战斗")

	local chapterId = Rouge2_MapEnum.ChapterId
	local paramArray = string.splitToNumber(choiceCo.triggerParam, "#")
	local episodeId = paramArray[1]

	Rouge2_MapModel.instance:setEndId(paramArray[2])
	DungeonFightController.instance:enterFight(chapterId, episodeId)
end

function Rouge2_MapPieceTriggerHelper._initGetTipHandle()
	if Rouge2_MapPieceTriggerHelper.getTipHandleDict then
		return
	end

	Rouge2_MapPieceTriggerHelper.getTipHandleDict = {}
end

function Rouge2_MapPieceTriggerHelper.defaultGetPieceTip(pieceMo, choiceCo, status)
	if status ~= Rouge2_MapEnum.ChoiceStatus.Lock then
		return ""
	end

	return Rouge2_MapUnlockHelper.getLockTips(choiceCo.unlock)
end

function Rouge2_MapPieceTriggerHelper._initGetStatusHandle()
	if Rouge2_MapPieceTriggerHelper.getStatusHandleDict then
		return
	end

	Rouge2_MapPieceTriggerHelper.getStatusHandleDict = {}
end

function Rouge2_MapPieceTriggerHelper.defaultGetStatus(pieceMo, choiceCo)
	if Rouge2_MapUnlockHelper.checkIsUnlock(choiceCo.unlock) then
		return Rouge2_MapEnum.ChoiceStatus.Normal
	end

	return Rouge2_MapEnum.ChoiceStatus.Lock
end

return Rouge2_MapPieceTriggerHelper
