-- chunkname: @modules/logic/dungeonmazev3a7/model/DungeonMazeV3a7Model.lua

module("modules.logic.dungeonmazev3a7.model.DungeonMazeV3a7Model", package.seeall)

local DungeonMazeV3a7Model = class("DungeonMazeV3a7Model", BaseModel)

DungeonMazeV3a7Model.defaultMapId = 1002

local chaosAddValueConstId = 1

function DungeonMazeV3a7Model:reInit()
	return
end

function DungeonMazeV3a7Model:release()
	return
end

function DungeonMazeV3a7Model:initData(mapId)
	self._cellDatas = {}
	self._cellDataDict = {}
	self._playerChaosValue = 0
	self._skillState = DungeonMazeV3a7Enum.skillState.usable
	self._skillCooling = 0
	self._destinationCell = nil
	self._roleOrder = DungeonMazeV3a7Enum.RoleOrder.Player14
	self._defaultChaosAddValue = tonumber(DungeonMazeV3a7Config.instance:getMazeGameConst(chaosAddValueConstId).size)
	self._chaosAddValue = self._defaultChaosAddValue
	self._mapId = mapId and mapId or DungeonMazeV3a7Model.defaultMapId

	local mapCfg = DungeonMazeV3a7Config.instance:getMazeMap(self._mapId)
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local cellIdx = (x - 1) * w + y
			local cellCfg = mapCfg[cellIdx]

			self._cellDatas[x] = self._cellDatas[x] or {}

			local cellData = DungeonMazeV3a7CellData.New()

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
						[DungeonMazeV3a7Enum.dir.left] = leftCell,
						[DungeonMazeV3a7Enum.dir.right] = rightCell,
						[DungeonMazeV3a7Enum.dir.up] = upCell,
						[DungeonMazeV3a7Enum.dir.down] = downCell
					}
				end
			end
		end
	end
end

function DungeonMazeV3a7Model:getGameSize()
	if not self._mazeSize then
		self._mazeSize = {}

		local mapSizeCfg = DungeonMazeV3a7Config.instance:getMazeGameConst(self._mapId).size

		if mapSizeCfg then
			local mapSizeArray = string.splitToNumber(mapSizeCfg, "#")

			self._mazeSize.width = mapSizeArray[1]
			self._mazeSize.height = mapSizeArray[2]
		else
			logError("DungeonMazeV3a7Model:getGameSize mapId = " .. self._mapId .. " mapSizeCfg is nil")
		end
	end

	return self._mazeSize.width, self._mazeSize.height
end

function DungeonMazeV3a7Model:setCurCellData(targetCell)
	self._curCell = targetCell
end

function DungeonMazeV3a7Model:getCurCellData()
	return self._curCell
end

function DungeonMazeV3a7Model:getCellData(x, y)
	return self._cellDatas[x][y]
end

function DungeonMazeV3a7Model:getNearestCellToDestination(curCell, lastCell, curStepNum)
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

	for _, dir in pairs(DungeonMazeV3a7Enum.dir) do
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

function DungeonMazeV3a7Model:addChaosValue(value)
	if value then
		self._playerChaosValue = self._playerChaosValue + value
		self._chaosAddValue = value
	else
		self._playerChaosValue = self._playerChaosValue + self._defaultChaosAddValue
	end
end

function DungeonMazeV3a7Model:getAddChaosValue()
	return self._chaosAddValue
end

function DungeonMazeV3a7Model:getChaosValue()
	return self._playerChaosValue
end

function DungeonMazeV3a7Model:UnpateSkillState(move)
	if move then
		if self._skillState == DungeonMazeV3a7Enum.skillState.using then
			self._skillState = DungeonMazeV3a7Enum.skillState.cooling
		end

		if self._skillCooling > 0 then
			self._skillCooling = self._skillCooling - 1
		end

		if self._skillCooling == 0 then
			self._skillState = DungeonMazeV3a7Enum.skillState.usable
		end
	else
		if self._skillCooling > 0 then
			return false
		end

		self._skillCooling = 2
		self._skillState = DungeonMazeV3a7Enum.skillState.using
	end
end

function DungeonMazeV3a7Model:GetSkillState()
	return self._skillState, self._skillCooling
end

function DungeonMazeV3a7Model:getRoleOrder()
	return self._roleOrder
end

function DungeonMazeV3a7Model:switchRoleOrder()
	if self._roleOrder == DungeonMazeV3a7Enum.RoleOrder.Player14 then
		self._roleOrder = DungeonMazeV3a7Enum.RoleOrder.PlayerVertin or DungeonMazeV3a7Enum.RoleOrder.Player14
	end
end

function DungeonMazeV3a7Model:SaveCurProgress()
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

	local progressStr = string.format("%d,%d,%d,%d,%d,%s,%d", x, y, chaosValue, skillState, skillCooling, toggledCellIdStr, self._roleOrder)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeV3a7Key), progressStr)
end

function DungeonMazeV3a7Model:HasLocalProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeV3a7Key), "")

	return progressStr and not string.nilorempty(progressStr)
end

function DungeonMazeV3a7Model:ClearProgress()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeV3a7Key), "")
end

function DungeonMazeV3a7Model:LoadProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeV3a7Key), "")

	if string.nilorempty(progressStr) then
		return false
	end

	local arr = string.split(progressStr, ",")

	if not DungeonMazeV3a7Enum.GM_X then
		local x = tonumber(arr[1])

		if not DungeonMazeV3a7Enum.GM_Y then
			local y = tonumber(arr[2])
			local chaosValue = tonumber(arr[3])
			local skillState = tonumber(arr[4])
			local skillCooling = tonumber(arr[5])
			local toggledCellIdStr = arr[6]
			local roleOrder = tonumber(arr[7])

			if DungeonMazeV3a7Enum.GM_X and y and chaosValue and skillState and skillCooling then
				self._curCell = self._cellDatas[DungeonMazeV3a7Enum.GM_X][y]
				self._playerChaosValue = chaosValue
				self._skillState = skillState
				self._skillCooling = skillCooling

				if roleOrder then
					self._roleOrder = roleOrder

					if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(DungeonMazeV3a7Enum.FirstGuideId) then
						self._roleOrder = DungeonMazeV3a7Enum.RoleOrder.Player14
					end
				end
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
	end
end

DungeonMazeV3a7Model.instance = DungeonMazeV3a7Model.New()

return DungeonMazeV3a7Model
