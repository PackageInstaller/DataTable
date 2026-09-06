-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/LevelJumpFloorGame.lua

module("logic.extensions.jumpfloor.view.game.LevelJumpFloorGame", package.seeall)

local LevelJumpFloorGame = class("LevelJumpFloorGame", BaseJumpFloorGame)

function LevelJumpFloorGame:init(jsonData, countdown)
	self:reset()

	self._jsonData = jsonData
	self._totalCountdown = countdown
	self._curCountdown = countdown
	self._curPassFloors = 1

	self:setCellDatas()
end

function LevelJumpFloorGame:setCellDatas()
	table.clear(self._cellDataList)
	table.clear(self._cellDataDic)

	local jsonCells = GameUtil.jsonToTable(self._jsonData)
	local jsonCellList = jsonCells.t
	local lastCol = 1

	for i, v in ipairs(jsonCellList) do
		local cell = JumpFloorCellData.New(v.t[1], v.t[2], v.t[3], v.t[4], v.t[5])

		table.insert(self._cellDataList, cell)

		if not self._cellDataDic[cell.col] then
			self._cellDataDic[cell.col] = {}
			lastCol = cell.col
		end

		self._cellDataDic[cell.col][cell.row] = cell

		if i == 1 then
			self._curCellData = cell
		end
	end

	local lastCells = self._cellDataDic[lastCol]

	for k, v in pairs(lastCells) do
		v:setIsDestination(true)
	end

	self._destinationFloorNum = lastCol
end

return LevelJumpFloorGame
