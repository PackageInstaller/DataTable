-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/model/PuzzleMazeDrawModel.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawModel", package.seeall)

local PuzzleMazeDrawModel = class("PuzzleMazeDrawModel", PuzzleMazeDrawBaseModel)

function PuzzleMazeDrawModel:release()
	PuzzleMazeDrawModel.super.release(self)

	self._interactPosX = nil
	self._interactPosY = nil
	self._effectDoneMap = nil
	self._canFlyPlane = true
	self._planePosX = nil
	self._planePosY = nil
end

function PuzzleMazeDrawModel:startGame(elementCo)
	PuzzleMazeDrawModel.super.startGame(self, elementCo)
	self:setCanFlyPane(true)
end

function PuzzleMazeDrawModel:switchLine(lineState, interactPosX, interactPosY)
	local interactLines = self:getInteractLines(interactPosX, interactPosY)

	if not interactLines then
		return
	end

	for _, interactLine in pairs(interactLines) do
		local startPosX = interactLine.x1
		local startPosY = interactLine.y1
		local endPosX = interactLine.x2
		local endPosY = interactLine.y2
		local key = PuzzleMazeHelper.getLineKey(startPosX, startPosY, endPosX, endPosY)

		self._lineMap[key] = lineState

		PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.SwitchLineState, startPosX, startPosY, endPosX, endPosY)
	end

	if lineState == PuzzleEnum.LineState.Connect then
		self._interactPosX = interactPosX
		self._interactPosY = interactPosY
	else
		self._interactPosX = nil
		self._interactPosY = nil
	end
end

function PuzzleMazeDrawModel:getInteractLines(interactPosX, interactPosY)
	local interactObj = self:getObjAtPos(interactPosX, interactPosY)

	if interactObj then
		return interactObj.interactLines
	end
end

function PuzzleMazeDrawModel:getInteractPos()
	return self._interactPosX, self._interactPosY
end

function PuzzleMazeDrawModel:isCanFlyPlane()
	return self._canFlyPlane
end

function PuzzleMazeDrawModel:setCanFlyPane(isEnabled)
	self._canFlyPlane = isEnabled
end

function PuzzleMazeDrawModel:setPlanePlacePos(posX, posY)
	self._planePosX = posX
	self._planePosY = posY
end

function PuzzleMazeDrawModel:getCurPlanePos()
	local canFly = self:isCanFlyPlane()

	if canFly then
		return PuzzleMazeDrawController.instance:getLastPos()
	else
		return self._planePosX, self._planePosY
	end
end

function PuzzleMazeDrawModel:setTriggerEffectDone(posX, posY)
	self._effectDoneMap = self._effectDoneMap or {}

	local key = PuzzleMazeHelper.getPosKey(posX, posY)

	self._effectDoneMap[key] = true
end

function PuzzleMazeDrawModel:hasTriggerEffect(posX, posY)
	local key = PuzzleMazeHelper.getPosKey(posX, posY)

	return self._effectDoneMap and self._effectDoneMap[key]
end

function PuzzleMazeDrawModel:canTriggerEffect(posX, posY)
	local hasTrigger = self:hasTriggerEffect(posX, posY)

	if hasTrigger then
		return false
	end

	local mo = self:getObjAtPos(posX, posY)

	if not mo then
		return false
	end

	local hasTriggerPriority = self._effectDoneMap and tabletool.len(self._effectDoneMap) or 0
	local priority = mo.priority

	return hasTriggerPriority + 1 == priority
end

function PuzzleMazeDrawModel:getTriggerEffectDoneMap()
	return self._effectDoneMap
end

function PuzzleMazeDrawModel:setTriggerEffectDoneMap(effectDoneMap)
	self._effectDoneMap = effectDoneMap
end

PuzzleMazeDrawModel.instance = PuzzleMazeDrawModel.New()

return PuzzleMazeDrawModel
