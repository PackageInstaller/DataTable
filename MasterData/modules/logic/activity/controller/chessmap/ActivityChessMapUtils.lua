-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessMapUtils.lua

module("modules.logic.activity.controller.chessmap.ActivityChessMapUtils", package.seeall)

local ActivityChessMapUtils = class("ActivityChessMapUtils")

function ActivityChessMapUtils.ToDirection(sourceX, sourceY, targetX, targetY)
	if targetX < sourceX then
		if targetY < sourceY then
			return 1
		elseif sourceY < targetY then
			return 7
		else
			return 4
		end
	elseif sourceX < targetX then
		if targetY < sourceY then
			return 3
		elseif sourceY < targetY then
			return 9
		else
			return 6
		end
	elseif targetY < sourceY then
		return 2
	elseif sourceY < targetY then
		return 8
	else
		return 5
	end
end

function ActivityChessMapUtils.getClearConditionDesc(params, actId)
	local conditionType = params[1]
	local func = ActivityChessMapUtils.conditionDescFuncMap[conditionType]

	return func and func(params, actId) or ""
end

function ActivityChessMapUtils.isClearConditionFinish(params, actId)
	local conditionType = params[1]
	local func = ActivityChessMapUtils.conditionCheckMap[conditionType]

	if func then
		return func(params, actId)
	end

	return false
end

function ActivityChessMapUtils.getConditionDescRoundLimit(params, actId)
	return string.format(luaLang("chessgame_clear_round_limit"), params[2])
end

function ActivityChessMapUtils.getConditionDescInteractFinish(params, actId)
	local interactCo = Activity109Config.instance:getInteractObjectCo(actId, params[2])

	return interactCo and string.format(luaLang("chessgame_clear_interact_finish"), interactCo.name) or string.format(luaLang("chessgame_clear_interact_finish"), params[2])
end

ActivityChessMapUtils.conditionDescFuncMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = ActivityChessMapUtils.getConditionDescRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = ActivityChessMapUtils.getConditionDescInteractFinish
}

function ActivityChessMapUtils.checkRoundLimit(params, actId)
	local result = ActivityChessGameModel.instance:getResult()

	if not result then
		return false
	else
		local round = ActivityChessGameModel.instance:getRound()

		return round <= params[2]
	end
end

function ActivityChessMapUtils.checkInteractFinish(params, actId)
	local result = ActivityChessGameModel.instance:getResult()

	if result == false then
		return false
	end

	return ActivityChessGameModel.instance:isInteractFinish(params[2])
end

ActivityChessMapUtils.conditionCheckMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = ActivityChessMapUtils.checkRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = ActivityChessMapUtils.checkInteractFinish
}

return ActivityChessMapUtils
