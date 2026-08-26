-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianGameHelper.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameHelper", package.seeall)

local YaXianGameHelper = class("YaXianGameHelper")

function YaXianGameHelper.getRowStartPosInScene(row)
	return row * YaXianGameEnum.TileSetting.halfWidth, -row * YaXianGameEnum.TileSetting.halfHeight
end

function YaXianGameHelper.getPosZ(posY)
	local rate = (posY - YaXianGameEnum.ScenePosYRange.Min) / YaXianGameEnum.ScenePosYRangeArea

	return Mathf.Lerp(YaXianGameEnum.LevelScenePosZRange.Min, YaXianGameEnum.LevelScenePosZRange.Max, rate)
end

function YaXianGameHelper.calcTilePosInScene(tileX, tileY)
	local x, y = YaXianGameHelper.getRowStartPosInScene(tileX)

	x = x + tileY * YaXianGameEnum.TileSetting.halfWidth
	y = y + tileY * YaXianGameEnum.TileSetting.halfHeight
	x = x + YaXianGameModel.instance.mapOffsetX
	y = y + YaXianGameModel.instance.mapOffsetY

	return x, y, YaXianGameHelper.getPosZ(y)
end

function YaXianGameHelper.calBafflePosInScene(tileX, tileY, direction)
	local x, y, z = YaXianGameHelper.calcTilePosInScene(tileX, tileY)

	if direction == YaXianGameEnum.BaffleDirection.Left then
		x = x - YaXianGameEnum.TileSetting.baffleOffsetX
		y = y + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif direction == YaXianGameEnum.BaffleDirection.Top then
		x = x + YaXianGameEnum.TileSetting.baffleOffsetX
		y = y + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif direction == YaXianGameEnum.BaffleDirection.Right then
		x = x + YaXianGameEnum.TileSetting.baffleOffsetX
		y = y - YaXianGameEnum.TileSetting.baffleOffsetY
	elseif direction == YaXianGameEnum.BaffleDirection.Bottom then
		x = x - YaXianGameEnum.TileSetting.baffleOffsetX
		y = y - YaXianGameEnum.TileSetting.baffleOffsetY
	else
		logError("un support direction, please check ... " .. direction)
	end

	return x, y, YaXianGameHelper.getPosZ(y)
end

function YaXianGameHelper.hasBaffle(tileData, directionPosPos)
	return bit.band(tileData, bit.lshift(1, directionPosPos)) ~= 0
end

function YaXianGameHelper.getBaffleType(tileData, directionPosPos)
	return bit.band(tileData, bit.lshift(1, directionPosPos - 1)) == 0 and 0 or 1
end

function YaXianGameHelper.canBlock(interactConfig)
	if interactConfig then
		return interactConfig.interactType == YaXianGameEnum.InteractType.Obstacle or interactConfig.interactType == YaXianGameEnum.InteractType.TriggerFail or interactConfig.interactType == YaXianGameEnum.InteractType.Player
	end

	return false
end

function YaXianGameHelper.canSelect(interactConfig)
	return interactConfig and interactConfig.interactType == YaXianGameEnum.InteractType.Player
end

function YaXianGameHelper.getDirection(startX, startY, targetX, targetY)
	if startX ~= targetX then
		if startX < targetX then
			return YaXianGameEnum.MoveDirection.Right
		else
			return YaXianGameEnum.MoveDirection.Left
		end
	end

	if startY ~= targetY then
		if startY < targetY then
			return YaXianGameEnum.MoveDirection.Top
		else
			return YaXianGameEnum.MoveDirection.Bottom
		end
	end

	logError(string.format("get direction fail ... startX : %s, startY : %s, targetX : %s, targetY : %s", startX, startY, targetX, targetY))
end

function YaXianGameHelper.getNextPos(startX, startY, direction)
	if direction == YaXianGameEnum.MoveDirection.Bottom then
		startY = startY - 1
	elseif direction == YaXianGameEnum.MoveDirection.Left then
		startX = startX - 1
	elseif direction == YaXianGameEnum.MoveDirection.Right then
		startX = startX + 1
	elseif direction == YaXianGameEnum.MoveDirection.Top then
		startY = startY + 1
	else
		logError(string.format("un support direction, x : %s, y : %s, direction : %s", startX, startY, direction))
	end

	return startX, startY
end

function YaXianGameHelper.getPassPosGenerator(startX, startY, targetX, targetY)
	local moveDir = YaXianGameHelper.getDirection(startX, startY, targetX, targetY)
	local isArrived = false

	return function()
		if isArrived then
			return nil
		end

		local nextPosX, nextPosY = YaXianGameHelper.getNextPos(startX, startY, moveDir)

		if nextPosX == targetX and nextPosY == targetY then
			isArrived = true
		end

		startX, startY = nextPosX, nextPosY

		return nextPosX, nextPosY
	end
end

function YaXianGameHelper.getPosHashKey(posX, posY)
	return posX .. "." .. posY
end

return YaXianGameHelper
