-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzleMazeDrawController.lua

module("modules.logic.dungeon.controller.DungeonPuzzleMazeDrawController", package.seeall)

local DungeonPuzzleMazeDrawController = class("DungeonPuzzleMazeDrawController", BaseController)

function DungeonPuzzleMazeDrawController:onInitFinish()
	return
end

function DungeonPuzzleMazeDrawController:addConstEvents()
	return
end

function DungeonPuzzleMazeDrawController:reInit()
	self._curPosX = nil
	self._curPosY = nil
	self._passedPosX = nil
	self._passedPosY = nil
	self._passedCheckPoint = nil
	self._alertMoMap = nil
	self._nextDir = nil
	self._nextForwardX = nil
	self._nextForwardY = nil
	self._nextProgressX = nil
	self._nextProgressY = nil
	self._lineDirty = nil
end

local LEFT = DungeonPuzzleEnum.dir.left
local RIGHT = DungeonPuzzleEnum.dir.right
local DOWN = DungeonPuzzleEnum.dir.down
local UP = DungeonPuzzleEnum.dir.up

function DungeonPuzzleMazeDrawController:release()
	self._curPosX = nil
	self._curPosY = nil
	self._passedPosX = nil
	self._passedPosY = nil
	self._passedCheckPoint = nil
	self._alertMoMap = nil
	self._nextDir = nil
	self._nextForwardX = nil
	self._nextForwardY = nil
	self._nextProgressX = nil
	self._nextProgressY = nil
	self._lineDirty = nil
end

function DungeonPuzzleMazeDrawController:openGame(elementCo)
	DungeonPuzzleMazeDrawModel.instance:initByElementCo(elementCo)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleMazeDrawView)
end

function DungeonPuzzleMazeDrawController:goStartPoint()
	local startX, startY = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

	self._curPosX = startX
	self._curPosY = startY

	table.insert(self._passedPosX, startX)
	table.insert(self._passedPosY, startY)
end

function DungeonPuzzleMazeDrawController:startGame()
	self._passedPosX = {}
	self._passedPosY = {}
	self._passedCheckPoint = {}
	self._alertMoMap = {}

	self:goStartPoint()
end

function DungeonPuzzleMazeDrawController:isGameClear()
	local endX, endY = DungeonPuzzleMazeDrawModel.instance:getEndPoint()

	if not self:hasAlertObj() and self._curPosX == endX and self._curPosY == endY then
		local objList = DungeonPuzzleMazeDrawModel.instance:getList()

		for _, mo in pairs(objList) do
			if mo.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint and not self._passedCheckPoint[mo] then
				return false
			end
		end

		return true
	end

	return false
end

function DungeonPuzzleMazeDrawController:goPassLine(x1, y1, x2, y2, progressX, progressY)
	local fromDir, passPosList

	self._nextDir = nil
	self._nextForwardX = self._curPosX ~= x1 and x1 or x2
	self._nextForwardY = self._curPosY ~= y1 and y1 or y2

	if self._curPosX ~= x1 or self._curPosX ~= x2 then
		fromDir = x2 > self._curPosX and LEFT or RIGHT
		passPosList = passPosList or {}

		if fromDir == LEFT then
			for i = self._curPosX + 1, x1 do
				table.insert(passPosList, {
					RIGHT,
					i,
					y1
				})
			end

			self._nextForwardX = x2
		else
			for i = self._curPosX - 1, x2, -1 do
				table.insert(passPosList, {
					LEFT,
					i,
					y1
				})
			end

			self._nextForwardX = x1
		end

		progressY = nil
	end

	if self._curPosY ~= y1 or self._curPosY ~= y2 then
		if fromDir ~= nil then
			self._nextForwardX = nil
			self._nextForwardY = nil

			return false
		end

		fromDir = y2 > self._curPosY and DOWN or UP
		passPosList = passPosList or {}

		if fromDir == DOWN then
			for i = self._curPosY + 1, y1 do
				table.insert(passPosList, {
					UP,
					x1,
					i
				})
			end

			self._nextForwardY = y2
		else
			for i = self._curPosY - 1, y2, -1 do
				table.insert(passPosList, {
					DOWN,
					x1,
					i
				})
			end

			self._nextForwardY = y1
		end

		progressX = nil
	end

	self._nextDir = fromDir
	self._nextProgressX = progressX
	self._nextProgressY = progressY

	if passPosList and #passPosList > 0 then
		return self:processPath(passPosList, progressX, progressY)
	end

	return false
end

function DungeonPuzzleMazeDrawController:goPassPos(x, y)
	local fromDir, passPosList

	if self._curPosX ~= x then
		fromDir = x > self._curPosX and LEFT or RIGHT
		passPosList = passPosList or {}

		if fromDir == LEFT then
			for i = self._curPosX + 1, x do
				table.insert(passPosList, {
					RIGHT,
					i,
					y
				})
			end
		else
			for i = self._curPosX - 1, x, -1 do
				table.insert(passPosList, {
					LEFT,
					i,
					y
				})
			end
		end
	end

	if self._curPosY ~= y then
		if fromDir ~= nil then
			self._nextDir = nil
			self._nextForwardX = nil
			self._nextForwardY = nil

			return false
		end

		fromDir = y > self._curPosY and DOWN or UP
		passPosList = passPosList or {}

		if fromDir == DOWN then
			for i = self._curPosY + 1, y do
				table.insert(passPosList, {
					UP,
					x,
					i
				})
			end
		else
			for i = self._curPosY - 1, y, -1 do
				table.insert(passPosList, {
					DOWN,
					x,
					i
				})
			end
		end
	end

	self._nextProgressX = nil
	self._nextProgressY = nil

	if passPosList and #passPosList > 0 then
		local rs = self:processPath(passPosList)
	end

	return false
end

function DungeonPuzzleMazeDrawController:processPath(passPosList, progressX, progressY)
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

		local mo = DungeonPuzzleMazeDrawModel.instance:getObjAtLine(DungeonPuzzleMazeDrawController.formatPos(self._curPosX, self._curPosY, nextX, nextY))

		if mo ~= nil and mo.objType == DungeonPuzzleEnum.MazeObjType.Block then
			self._alertMoMap[mo] = valueMo
		end

		if isBack then
			local curKey = DungeonPuzzleMazeDrawModel.getPosKey(self._curPosX, self._curPosY)

			self._alertMoMap[curKey] = nil
			mo = DungeonPuzzleMazeDrawModel.instance:getObjAtPos(self._curPosX, self._curPosY)

			if mo ~= nil and mo.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint and not self:alreadyPassed(self._curPosX, self._curPosY, true) then
				self._passedCheckPoint[mo] = valueMo
			end
		else
			mo = DungeonPuzzleMazeDrawModel.instance:getObjAtPos(nextX, nextY)

			if mo ~= nil and mo.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint then
				self._passedCheckPoint[mo] = valueMo
			end

			if self:alreadyPassed(nextX, nextY) then
				local key = DungeonPuzzleMazeDrawModel.getPosKey(nextX, nextY)

				self._alertMoMap[key] = valueMo
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

function DungeonPuzzleMazeDrawController:goBackPos()
	local len = #self._passedPosX

	if len >= 2 then
		self:goPassPos(self._passedPosX[len - 1], self._passedPosY[len - 1])
	end
end

function DungeonPuzzleMazeDrawController:isBackward(nextX, nextY)
	return #self._passedPosX > 1 and self._passedPosX[#self._passedPosX - 1] == nextX and self._passedPosY[#self._passedPosY - 1] == nextY
end

function DungeonPuzzleMazeDrawController:alreadyPassed(x, y, withoutTop)
	if withoutTop then
		if not (#self._passedPosX - 1) then
			local len = #self._passedPosX

			for i = 1, len do
				local tmpX, tmpY = self._passedPosX[i], self._passedPosY[i]

				if tmpX == x and tmpY == y then
					return true
				end
			end

			return false
		end
	end
end

function DungeonPuzzleMazeDrawController:alreadyCheckPoint(mo)
	return self._passedCheckPoint and self._passedCheckPoint[mo] ~= nil
end

function DungeonPuzzleMazeDrawController:getLastPos()
	return self._curPosX, self._curPosY
end

function DungeonPuzzleMazeDrawController:getPassedPoints()
	return self._passedPosX, self._passedPosY
end

function DungeonPuzzleMazeDrawController:getProgressLine()
	return self._nextForwardX, self._nextForwardY, self._nextProgressX, self._nextProgressY
end

function DungeonPuzzleMazeDrawController:getAlertMap()
	return self._alertMoMap
end

function DungeonPuzzleMazeDrawController:hasAlertObj()
	for alertObj, _ in pairs(self._alertMoMap) do
		return true
	end

	return false
end

function DungeonPuzzleMazeDrawController:isLineDirty()
	return self._lineDirty
end

function DungeonPuzzleMazeDrawController:resetLineDirty()
	self._lineDirty = false
end

function DungeonPuzzleMazeDrawController.formatPos(x1, y1, x2, y2)
	if x2 < x1 then
		x2 = x1
		x1 = x2
	end

	if y2 < y1 then
		y2 = y1
		y1 = y2
	end

	return x1, y1, x2, y2
end

function DungeonPuzzleMazeDrawController.getFromToDir(fromX, fromY, toX, toY)
	if fromX ~= toX then
		if fromY ~= toY then
			return nil
		end

		return (fromX < toX or nil) and (RIGHT or LEFT)
	else
		return (fromY < toY or nil) and (UP or DOWN)
	end
end

DungeonPuzzleMazeDrawController.instance = DungeonPuzzleMazeDrawController.New()

return DungeonPuzzleMazeDrawController
