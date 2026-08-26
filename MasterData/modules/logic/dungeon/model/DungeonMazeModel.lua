-- chunkname: @modules/logic/dungeon/model/DungeonMazeModel.lua

module("modules.logic.dungeon.model.DungeonMazeModel", package.seeall)

local DungeonMazeModel = class("DungeonMazeModel", BaseModel)

DungeonMazeModel.constWidth = 5
DungeonMazeModel.constHeight = 5
DungeonMazeModel.defaultMapId = 1001

local chaosAddValueConstId = 1

function DungeonMazeModel:reInit()
	return
end

function DungeonMazeModel:release()
	return
end

function DungeonMazeModel:initData(mapId)
	self._cellDatas = {}
	self._cellDataDict = {}
	self._playerChaosValue = 0
	self._skillState = DungeonMazeEnum.skillState.usable
	self._skillCooling = 0
	self._destinationCell = nil
	self._defaultChaosAddValue = tonumber(DungeonGameConfig.instance:getMazeGameConst(chaosAddValueConstId).size)
	self._chaosAddValue = self._defaultChaosAddValue
	self._mapId = mapId and mapId or DungeonMazeModel.defaultMapId

	local mapCfg = DungeonGameConfig.instance:getMazeMap(self._mapId)
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local cellIdx = (x - 1) * w + y
			local cellCfg = mapCfg[cellIdx]

			self._cellDatas[x] = self._cellDatas[x] or {}

			local cellData = DungeonMazeCellData.New()

			cellData:init(x, y)

			cellData.value = cellCfg.celltype
			cellData.obstacleDialog = cellCfg.dialogid
			cellData.eventId = cellCfg.evenid
			cellData.cellId = cellCfg.cellId
			cellData.pass = cellCfg.celltype == 1 or cellCfg.celltype == 2 or cellCfg.celltype == 3
			self._cellDatas[x][y] = cellData
			self._cellDataDict[cellData.cellId] = cellData

			if cellData.value == 2 then
				self._destinationCell = cellData
			elseif cellData.value == 3 then
				self._curCell = cellData
			end
		end
	end

	for x = 1, w do
		for y = 1, h do
			local cellData = self._cellDatas[x][y]
			local leftCell = self._cellDatas[x][y - 1]
			local rightCell = self._cellDatas[x][y + 1]

			if self._cellDatas[x - 1] then
				local upCell = self._cellDatas[x - 1][y]

				if self._cellDatas[x + 1] then
					local downCell = self._cellDatas[x + 1][y]

					cellData.connectSet = {
						[DungeonMazeEnum.dir.left] = leftCell,
						[DungeonMazeEnum.dir.right] = rightCell,
						[DungeonMazeEnum.dir.up] = upCell,
						[DungeonMazeEnum.dir.down] = downCell
					}
				end
			end
		end
	end
end

function DungeonMazeModel:getGameSize()
	if not self._mazeSize then
		self._mazeSize = {}

		local mapSizeCfg = DungeonGameConfig.instance:getMazeGameConst(self._mapId).size

		if mapSizeCfg then
			local mapSizeArray = string.splitToNumber(mapSizeCfg, "#")

			self._mazeSize.width = mapSizeArray[1]
			self._mazeSize.height = mapSizeArray[2]
		else
			self._mazeSize.width = DungeonMazeModel.constWidth
			self._mazeSize.height = DungeonMazeModel.constHeight
		end
	end

	return self._mazeSize.width, self._mazeSize.height
end

function DungeonMazeModel:setCurCellData(targetCell)
	self._curCell = targetCell
end

function DungeonMazeModel:getCurCellData()
	return self._curCell
end

function DungeonMazeModel:getCellData(x, y)
	return self._cellDatas[x][y]
end

function DungeonMazeModel:getNearestCellToDestination(curCell, lastCell, curStepNum)
	local isStart = false

	if curCell == nil then
		isStart = true
		self._cellRecord = {}
	end

	curStepNum = curStepNum or 0
	curCell = curCell or self._curCell

	local x, y = curCell.x, curCell.y

	if curCell.value == 2 then
		self._cellRecord[curCell.cellId] = false

		return curCell, curStepNum
	end

	local minStepNum = 99
	local minDirCell

	for _, dir in pairs(DungeonMazeEnum.dir) do
		local targetCell = curCell.connectSet[dir]

		if targetCell and targetCell.pass and targetCell ~= lastCell and not self._cellRecord[targetCell.cellId] then
			self._cellRecord[targetCell.cellId] = true

			local cell, stepNum = self:getNearestCellToDestination(targetCell, curCell, curStepNum + 1)

			if cell ~= nil and stepNum <= minStepNum then
				minStepNum = stepNum
				minDirCell = curCell

				if isStart then
					minDirCell = cell
				end
			end
		end
	end

	if isStart then
		return minDirCell
	end

	self._cellRecord[curCell.cellId] = false

	return minDirCell, minStepNum
end

function DungeonMazeModel:addChaosValue(value)
	if value then
		self._playerChaosValue = self._playerChaosValue + value
		self._chaosAddValue = value
	else
		self._playerChaosValue = self._playerChaosValue + self._defaultChaosAddValue
	end
end

function DungeonMazeModel:getAddChaosValue()
	return self._chaosAddValue
end

function DungeonMazeModel:getChaosValue()
	return self._playerChaosValue
end

function DungeonMazeModel:UnpateSkillState(move)
	if move then
		if self._skillState == DungeonMazeEnum.skillState.using then
			self._skillState = DungeonMazeEnum.skillState.cooling
		end

		if self._skillCooling > 0 then
			self._skillCooling = self._skillCooling - 1
		end

		if self._skillCooling == 0 then
			self._skillState = DungeonMazeEnum.skillState.usable
		end
	else
		if self._skillCooling > 0 then
			return false
		end

		self._skillCooling = 2
		self._skillState = DungeonMazeEnum.skillState.using
	end
end

function DungeonMazeModel:GetSkillState()
	return self._skillState, self._skillCooling
end

function DungeonMazeModel:SaveCurProgress()
	local x = self._curCell.x
	local y = self._curCell.y
	local chaosValue = self._playerChaosValue
	local skillState = self._skillState
	local skillCooling = self._skillCooling
	local toggledCellIdStr = ""

	for cellId, cell in ipairs(self._cellDataDict) do
		if cell.toggled then
			toggledCellIdStr = toggledCellIdStr == "" and cellId or toggledCellIdStr .. "#" .. cellId
		end
	end

	local progressStr = string.format("%d,%d,%d,%d,%d,%s", x, y, chaosValue, skillState, skillCooling, toggledCellIdStr)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), progressStr)
end

function DungeonMazeModel:HasLocalProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")

	return progressStr and not string.nilorempty(progressStr)
end

function DungeonMazeModel:ClearProgress()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")
end

function DungeonMazeModel:LoadProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")

	if string.nilorempty(progressStr) then
		return false
	end

	local arr = string.split(progressStr, ",")
	local x = tonumber(arr[1])
	local y = tonumber(arr[2])
	local chaosValue = tonumber(arr[3])
	local skillState = tonumber(arr[4])
	local skillCooling = tonumber(arr[5])
	local toggledCellIdStr = arr[6]

	if x and y and chaosValue and skillState and skillCooling then
		self._curCell = self._cellDatas[x][y]
		self._playerChaosValue = chaosValue
		self._skillState = skillState
		self._skillCooling = skillCooling
	end

	if toggledCellIdStr and not string.nilorempty(toggledCellIdStr) then
		local toggledCellIds = string.splitToNumber(toggledCellIdStr, "#")

		for _, cellId in ipairs(toggledCellIds) do
			local cell = self._cellDataDict[cellId]

			if cell then
				cell.toggled = true
			end
		end
	end
end

DungeonMazeModel.instance = DungeonMazeModel.New()

return DungeonMazeModel
