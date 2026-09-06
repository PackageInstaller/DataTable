-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/EndlessJumpFloorGame.lua

module("logic.extensions.jumpfloor.view.game.EndlessJumpFloorGame", package.seeall)

local EndlessJumpFloorGame = class("EndlessJumpFloorGame", BaseJumpFloorGame)
local limitMinFloor = 10

function EndlessJumpFloorGame:init(jsonDataList, countdown)
	self:reset()

	self._jsonDataList = jsonDataList
	self._totalCountdown = countdown
	self._curCountdown = countdown
	self._curPassFloors = 1
	self._totalStageCount = #self._jsonDataList

	self:setCellDatas()
end

function EndlessJumpFloorGame:jumpLeft()
	EndlessJumpFloorGame.super.jumpLeft(self)

	if self:getLeftFloors() < limitMinFloor then
		self:_addNewCellDatas()
	end
end

function EndlessJumpFloorGame:jumpRight()
	EndlessJumpFloorGame.super.jumpRight(self)

	if self:getLeftFloors() < limitMinFloor then
		self:_addNewCellDatas()
	end
end

function EndlessJumpFloorGame:skipCell()
	EndlessJumpFloorGame.super.skipCell(self)

	if self:getLeftFloors() < limitMinFloor then
		self:_addNewCellDatas()
	end
end

function EndlessJumpFloorGame:setCellDatas()
	table.clear(self._cellDataList)
	table.clear(self._cellDataDic)
	self:_addNewCellDatas()
end

function EndlessJumpFloorGame:_addNewCellDatas()
	local index = Mathf.Random(1, self._totalStageCount)
	local jsonCells = GameUtil.jsonToTable(self._jsonDataList[index])
	local jsonCellList = jsonCells.t
	local lastCol = 0
	local lastRow = 0
	local newDestCol = 0
	local destCells = self:getCellDatasByCol(self._destinationFloorNum)

	if destCells then
		lastCol = destCells[1]:getCol()
		lastRow = destCells[1]:getRow()

		for i, v in ipairs(destCells) do
			v:setIsDestination(false)
		end
	end

	for i, v in ipairs(jsonCellList) do
		local cell = JumpFloorCellData.New(lastCol + v.t[1], lastRow + v.t[2], 0, v.t[4], v.t[5])

		table.insert(self._cellDataList, cell)

		if not self._cellDataDic[cell.col] then
			self._cellDataDic[cell.col] = {}
			newDestCol = cell.col
		end

		self._cellDataDic[cell.col][cell.row] = cell

		if destCells == nil and i == 1 then
			self._curCellData = cell
		end
	end

	local lastCells = self._cellDataDic[newDestCol]

	for k, v in pairs(lastCells) do
		v:setIsDestination(true)
	end

	self._destinationFloorNum = newDestCol

	printInfo("test 无尽模式，添加的索引是 = ", index, "当前最高层是 = ", self._destinationFloorNum)
end

return EndlessJumpFloorGame
