-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessMapUtils.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessMapUtils", package.seeall)

local Va3ChessMapUtils = class("Va3ChessMapUtils")
local colTileNum = 8

function Va3ChessMapUtils.ToDirection(sourceX, sourceY, targetX, targetY)
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

function Va3ChessMapUtils.CalNextCellPos(sourceX, sourceY, dir)
	if dir == 2 then
		return sourceX, sourceY - 1
	elseif dir == 8 then
		return sourceX, sourceY + 1
	elseif dir == 6 then
		return sourceX + 1, sourceY
	elseif dir == 4 then
		return sourceX - 1, sourceY
	end
end

function Va3ChessMapUtils.CalOppositeDir(dir)
	if dir == 2 then
		return 8
	elseif dir == 8 then
		return 2
	elseif dir == 6 then
		return 4
	elseif dir == 4 then
		return 6
	end
end

function Va3ChessMapUtils.IsEdgeTile(x, y)
	return y == colTileNum - 1
end

function Va3ChessMapUtils.getClearConditionDesc(params, actId)
	local conditionType = params[1]
	local func = Va3ChessMapUtils.conditionDescFuncMap[conditionType]

	return func and func(params, actId) or ""
end

function Va3ChessMapUtils.isClearConditionFinish(params, actId)
	local conditionType = params[1]
	local func = Va3ChessMapUtils.conditionCheckMap[conditionType]

	if func then
		return func(params, actId)
	end

	return false
end

function Va3ChessMapUtils.calPosIndex(x, y)
	return x + y * colTileNum
end

function Va3ChessMapUtils.calPosXY(index)
	return index % colTileNum, math.floor(index / colTileNum)
end

function Va3ChessMapUtils.getConditionDescRoundLimit(params, actId)
	return string.format(luaLang("chessgame_clear_round_limit"), params[2])
end

function Va3ChessMapUtils.getConditionDescInteractFinish(params, actId)
	local interactCo = Va3ChessConfig.instance:getInteractObjectCo(actId, params[2])

	return interactCo and string.format(luaLang("chessgame_clear_interact_finish"), interactCo.name) or string.format(luaLang("chessgame_clear_interact_finish"), params[2])
end

Va3ChessMapUtils.conditionDescFuncMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = Va3ChessMapUtils.getConditionDescRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = Va3ChessMapUtils.getConditionDescInteractFinish
}

function Va3ChessMapUtils.checkRoundLimit(params, actId)
	local result = Va3ChessGameModel.instance:getResult()

	if not result then
		return false
	else
		local round = Va3ChessGameModel.instance:getRound()

		return round <= params[2]
	end
end

function Va3ChessMapUtils.checkInteractFinish(params, actId)
	if actId == VersionActivity1_3Enum.ActivityId.Act304 then
		return Va3ChessGameModel.instance:isInteractFinish(params[2], true)
	end

	for i = 2, #params do
		if not Va3ChessGameModel.instance:isInteractFinish(params[i]) then
			return false
		end
	end

	return #params > 1
end

function Va3ChessMapUtils.checkHpLimit(params, actId)
	local result = Va3ChessGameModel.instance:getHp()

	return result >= params[2]
end

function Va3ChessMapUtils.checkAllInteractFinish(params, actId)
	local result = Va3ChessGameModel.instance:getResult()

	if result == false then
		return false
	end

	local unFinishedCount = 0

	for i = 2, #params do
		if not Va3ChessGameModel.instance:isInteractFinish(params[i]) then
			unFinishedCount = unFinishedCount + 1
		end
	end

	if unFinishedCount > 0 then
		return false, unFinishedCount
	else
		return true
	end
end

function Va3ChessMapUtils.calBulletFlyTime(speed, startX, startY, endX, endY)
	local result = Va3ChessEnum.DEFAULT_BULLET_FLY_TIME

	speed = speed or Va3ChessEnum.DEFAULT_BULLET_SPEED

	if startX and startY and endX and endY then
		local xSquare = math.pow(endX - startX, 2)
		local ySquare = math.pow(endY - startY, 2)
		local dis = math.sqrt(xSquare + ySquare)

		result = dis / speed
	end

	return result
end

Va3ChessMapUtils.conditionCheckMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = Va3ChessMapUtils.checkRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = Va3ChessMapUtils.checkInteractFinish,
	[Va3ChessEnum.ChessClearCondition.HpLimit] = Va3ChessMapUtils.checkHpLimit,
	[Va3ChessEnum.ChessClearCondition.InteractAllFinish] = Va3ChessMapUtils.checkAllInteractFinish
}

return Va3ChessMapUtils
