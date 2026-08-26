-- chunkname: @modules/logic/chessgame/controller/ChessGameHelper.lua

module("modules.logic.chessgame.controller.ChessGameHelper", package.seeall)

local ChessGameHelper = class("ChessGameHelper")

function ChessGameHelper.isNodeWalkable(x, y, isCanDestory)
	local node = ChessGameNodeModel.instance:getNode(x, y)

	if not node then
		return false
	end

	return node:isCanWalk(isCanDestory)
end

function ChessGameHelper.nodePosToWorldPos(nodePos)
	local v3 = Vector3.New()

	v3.x = (nodePos.x + nodePos.y) * ChessGameEnum.NodeXOffset
	v3.y = (nodePos.y - nodePos.x) * ChessGameEnum.NodeYOffset
	v3.z = (nodePos.y - nodePos.x) * ChessGameEnum.NodeZOffset

	return v3
end

function ChessGameHelper.worldPosToNodePos(pos)
	local v3 = Vector3.New()
	local x = pos.x / ChessGameEnum.NodeXOffset
	local y = pos.y / ChessGameEnum.NodeYOffset

	v3.x = Mathf.Round((x - y) / 2)
	v3.y = Mathf.Round((x + y) / 2)

	return v3
end

function ChessGameHelper.getMap()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.ChessGame then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	return scene.map
end

local colTileNum = 8

function ChessGameHelper.ToDirection(sourceX, sourceY, targetX, targetY)
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

function ChessGameHelper.CalNextCellPos(sourceX, sourceY, dir)
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

function ChessGameHelper.CalOppositeDir(dir)
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

function ChessGameHelper.IsEdgeTile(x, y)
	return y == colTileNum - 1
end

function ChessGameHelper.getClearConditionDesc(params, actId)
	local conditionType = params[1]
	local func = ChessGameHelper.conditionDescFuncMap[conditionType]

	return func and func(params, actId) or ""
end

function ChessGameHelper.isClearConditionFinish(params, actId)
	local conditionType = params[1]
	local func = ChessGameHelper.conditionCheckMap[conditionType]

	if func then
		return func(params, actId)
	end

	return false
end

function ChessGameHelper.calPosIndex(x, y)
	return x + y * colTileNum
end

function ChessGameHelper.calPosXY(index)
	return index % colTileNum, math.floor(index / colTileNum)
end

function ChessGameHelper.getConditionDescRoundLimit(params, actId)
	return string.format(luaLang("chessgame_clear_round_limit"), params[2])
end

function ChessGameHelper.getConditionDescInteractFinish(params, actId)
	local interactCo = ChessGameConfig.instance:getInteractObjectCo(actId, params[2])

	return interactCo and string.format(luaLang("chessgame_clear_interact_finish"), interactCo.name) or string.format(luaLang("chessgame_clear_interact_finish"), params[2])
end

function ChessGameHelper.checkRoundLimit(params, actId)
	local result = ChessGameModel.instance:getResult()

	if not result then
		return false
	else
		local round = ChessGameModel.instance:getRound()

		return round <= params[2]
	end
end

function ChessGameHelper.checkInteractFinish(params, actId)
	for i = 2, #params do
		if not ChessGameInteractModel.instance:checkInteractFinish(params[i]) then
			return false
		end
	end

	return #params > 1
end

function ChessGameHelper.checkHpLimit(params, actId)
	local result = ChessGameModel.instance:getHp()

	return result >= params[2]
end

function ChessGameHelper.checkAllInteractFinish(params, actId)
	local result = ChessGameModel.instance:getResult()

	if result == false then
		return false
	end

	local unFinishedCount = 0

	for i = 2, #params do
		if not ChessGameModel.instance:isInteractFinish(params[i]) then
			unFinishedCount = unFinishedCount + 1
		end
	end

	if unFinishedCount > 0 then
		return false, unFinishedCount
	else
		return true
	end
end

function ChessGameHelper.calBulletFlyTime(speed, startX, startY, endX, endY)
	local result = ChessGameEnum.DEFAULT_BULLET_FLY_TIME

	speed = speed or ChessGameEnum.DEFAULT_BULLET_SPEED

	if startX and startY and endX and endY then
		local xSquare = math.pow(endX - startX, 2)
		local ySquare = math.pow(endY - startY, 2)
		local dis = math.sqrt(xSquare + ySquare)

		result = dis / speed
	end

	return result
end

ChessGameHelper.conditionCheckMap = {
	[ChessGameEnum.ChessClearCondition.InteractFinish] = ChessGameHelper.checkInteractFinish,
	[ChessGameEnum.ChessClearCondition.InteractAllFinish] = ChessGameHelper.checkAllInteractFinish
}

return ChessGameHelper
