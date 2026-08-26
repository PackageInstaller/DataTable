-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/controller/PuzzleMazeDrawController.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.PuzzleMazeDrawController", package.seeall)

local PuzzleMazeDrawController = class("PuzzleMazeDrawController", PuzzleMazeDrawBaseController)

function PuzzleMazeDrawController:openGame(elementCo)
	self:setModelInst(PuzzleMazeDrawModel.instance)
	PuzzleMazeDrawController.super.openGame(self, elementCo)
	ViewMgr.instance:openView(ViewName.PuzzleMazeDrawView)
end

function PuzzleMazeDrawController:interactSwitchObj(interactPosX, interactPosY)
	PuzzleMazeDrawModel.instance:setCanFlyPane(false)
	PuzzleMazeDrawModel.instance:setPlanePlacePos(interactPosX, interactPosY)
	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_On, interactPosX, interactPosY)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.SimulatePlane, interactPosX, interactPosY)
end

function PuzzleMazeDrawController:recyclePlane()
	local planePosX, planePosY = PuzzleMazeDrawModel.instance:getCurPlanePos()

	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_Off, planePosX, planePosY)
	PuzzleMazeDrawModel.instance:setCanFlyPane(true)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.RecyclePlane)
end

function PuzzleMazeDrawController:processPath(passPosList, progressX, progressY)
	for _, pos in ipairs(passPosList) do
		local goDir, nextX, nextY = pos[1], pos[2], pos[3]
		local isBack = self:isBackward(nextX, nextY)
		local valueMo

		if not isBack then
			for k, v in pairs(self._alertMoMap) do
				return false
			end

			valueMo = 1
		end

		local key = PuzzleMazeHelper.getLineKey(self._curPosX, self._curPosY, nextX, nextY)
		local mo = PuzzleMazeDrawModel.instance:getObjAtLine(self._curPosX, self._curPosY, nextX, nextY)

		if mo ~= nil and mo.objType == PuzzleEnum.MazeObjType.Block then
			self._alertMoMap[key] = PuzzleEnum.MazeAlertType.VisitBlock
		end

		if isBack then
			local curKey = PuzzleMazeHelper.getPosKey(self._curPosX, self._curPosY)

			self._alertMoMap[curKey] = nil
			curKey = PuzzleMazeHelper.getLineKey(self._curPosX, self._curPosY, nextX, nextY)
			self._alertMoMap[curKey] = nil
			mo = PuzzleMazeDrawModel.instance:getObjAtPos(self._curPosX, self._curPosY)

			if mo ~= nil and mo.objType == PuzzleEnum.MazeObjType.CheckPoint and not self:alreadyPassed(self._curPosX, self._curPosY, true) then
				self._passedCheckPoint[mo] = valueMo
			end
		else
			if not self:canPassLine(nextX, nextY) then
				self._alertMoMap[key] = PuzzleEnum.MazeAlertType.DisconnectLine
			elseif self:alreadyPassed(nextX, nextY) then
				local key = PuzzleMazeHelper.getPosKey(nextX, nextY)

				self._alertMoMap[key] = PuzzleEnum.MazeAlertType.VisitRepeat
			end

			mo = PuzzleMazeDrawModel.instance:getObjAtPos(nextX, nextY)

			if mo ~= nil and mo.objType == PuzzleEnum.MazeObjType.CheckPoint then
				self._passedCheckPoint[mo] = valueMo
			end
		end

		if isBack then
			self._passedPosX[#self._passedPosX] = nil
			self._passedPosY[#self._passedPosY] = nil
		else
			table.insert(self._passedPosX, nextX)
			table.insert(self._passedPosY, nextY)
		end

		self._curPosX = nextX
		self._curPosY = nextY
		self._nextDir = goDir
		self._lineDirty = true
	end

	return true
end

function PuzzleMazeDrawController:canPassLine(nextPosX, nextPosY)
	local lineState = PuzzleMazeDrawModel.instance:getMapLineState(self._curPosX, self._curPosY, nextPosX, nextPosY)

	return lineState ~= PuzzleEnum.LineState.Disconnect and lineState ~= PuzzleEnum.LineState.Switch_Off
end

function PuzzleMazeDrawController:savePuzzleProgress()
	local elementCo = PuzzleMazeDrawModel.instance:getElementCo()

	if not elementCo then
		return
	end

	local hasAlertObj = self:hasAlertObj()

	if hasAlertObj then
		return
	end

	local passX, passY = self:getPassedPoints()
	local interactPosX, interactPosY = PuzzleMazeDrawModel.instance:getInteractPos()
	local map = {
		passX = passX,
		passY = passY
	}

	if interactPosX and interactPosY then
		map.interactPosX = interactPosX
		map.interactPosY = interactPosY
	end

	local progressStr = cjson.encode(map)

	DungeonRpc.instance:sendSavePuzzleProgressRequest(elementCo.id, progressStr)
end

function PuzzleMazeDrawController:getPuzzleDrawProgress()
	local elementCo = PuzzleMazeDrawModel.instance:getElementCo()

	if not elementCo then
		return
	end

	DungeonRpc.instance:sendGetPuzzleProgressRequest(elementCo.id)
end

function PuzzleMazeDrawController:onGetPuzzleDrawProgress(elementId, progressStr)
	if string.nilorempty(progressStr) then
		return
	end

	local progress = cjson.decode(progressStr)

	if progress.interactPosX and progress.interactPosY then
		self:interactSwitchObj(progress.interactPosX, progress.interactPosY)
	end

	if progress.passX then
		if not #progress.passX then
			local passXCount = 0

			for i = 1, passXCount do
				local passX = progress.passX[i]
				local passY = progress.passY[i]
				local prePassX = progress.passX[i - 1]
				local prePassY = progress.passY[i - 1]
				local dirty = false

				if prePassX ~= nil then
					local lineState = self._modelInst:getMapLineState(prePassX, prePassY, passX, passY)

					if lineState == PuzzleEnum.LineState.Switch_Off then
						self._modelInst:setMapLineState(prePassX, prePassY, passX, passY, PuzzleEnum.LineState.Switch_On)

						dirty = true
					end
				end

				self:goPassPos(passX, passY)

				if dirty then
					self._modelInst:setMapLineState(prePassX, prePassY, passX, passY, PuzzleEnum.LineState.Switch_Off)
				end
			end
		end
	end
end

function PuzzleMazeDrawController:hasAlertObj()
	for alertObj, _ in pairs(self._alertMoMap) do
		return true
	end

	if self._passedPosX then
		if not #self._passedPosX then
			local len = 0

			if len >= 2 then
				if self._passedPosX then
					local lastPosX = self._passedPosX[len]

					if self._passedPosY then
						local lastPosY = self._passedPosY[len]
						local objMo = self._modelInst:getObjAtPos(lastPosX, lastPosY)

						if not objMo then
							return true
						end
					end
				end
			end

			return false
		end
	end
end

function PuzzleMazeDrawController:goBackPos()
	local len = #self._passedPosX

	if len >= 2 then
		self:goPassPos(self._passedPosX[len - 1], self._passedPosY[len - 1])

		for i = len - 1, 2, -1 do
			local posX = self._passedPosX[i]
			local posY = self._passedPosY[i]
			local objMo = self._modelInst:getObjAtPos(posX, posY)

			if objMo then
				break
			end

			self:goPassPos(self._passedPosX[i - 1], self._passedPosY[i - 1])
		end
	end
end

function PuzzleMazeDrawController:restartGame()
	local effectDoneMap = self._modelInst:getTriggerEffectDoneMap()

	PuzzleMazeDrawController.super.restartGame(self)
	self._modelInst:setTriggerEffectDoneMap(effectDoneMap)
end

PuzzleMazeDrawController.instance = PuzzleMazeDrawController.New()

LuaEventSystem.addEventMechanism(PuzzleMazeDrawController.instance)

return PuzzleMazeDrawController
