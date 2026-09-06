-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/model/LinkGameModel.lua

module("logic.extensions.linkgame.model.LinkGameModel", package.seeall)

local LinkGameModel = class("LinkGameModel", BaseModel)

LinkGameModel.NotSelectIndex = -1
LinkGameModel.ExCellIndex = 0
LinkGameModel.EmptyState = 0
LinkGameModel.ReadFlag = "LinkGameModel.ReadFlag"

function LinkGameModel:ctor()
	return
end

function LinkGameModel:onInit()
	self:onReset()
end

function LinkGameModel:onReset()
	self._stageInfo = {}
	self._selectCellIndex = -1
	self._curMapCol = -1
	self._curMapRow = -1
end

function LinkGameModel:getCurActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.LinkGame)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.LinkGame)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LinkGame, v.activityId) then
			local cfg = LinkGameConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v.activityId)

			break
		end
	end

	return actId
end

function LinkGameModel:setMapData(jsonData, isFull)
	self:resetGame()

	self._curMapCol = -1
	self._curMapRow = -1

	for i, v in ipairs(jsonData.list) do
		if v.row + 1 > self._curMapRow then
			self._curMapRow = v.row + 1
		end

		if v.column + 1 > self._curMapCol then
			self._curMapCol = v.column + 1
		end

		local cellInfo = LinkGameCellMo.New()

		if not isFull then
			cellInfo:setInfo(v.index + 1, v.row + 1, v.column + 1, v.stateIdx)
		else
			cellInfo:setInfo(v.index + 1, v.row + 1 + 1, v.column + 1 + 1, v.stateIdx)
		end

		self:_addCell(cellInfo)
	end

	if isFull == true then
		for i = 1, self._curMapCol + 2 do
			local cellInfoA = LinkGameCellMo.New()

			cellInfoA:setInfo(LinkGameModel.ExCellIndex, 1, i, LinkGameModel.EmptyState)
			self:_addCell(cellInfoA)

			local cellInfoB = LinkGameCellMo.New()

			cellInfoB:setInfo(LinkGameModel.ExCellIndex, self._curMapRow + 2, i, LinkGameModel.EmptyState)
			self:_addCell(cellInfoB)
		end

		for i = 1, self._curMapRow + 2 do
			local cellInfoA = LinkGameCellMo.New()

			cellInfoA:setInfo(LinkGameModel.ExCellIndex, i, 1, LinkGameModel.EmptyState)
			self:_addCell(cellInfoA)

			local cellInfoB = LinkGameCellMo.New()

			cellInfoB:setInfo(LinkGameModel.ExCellIndex, i, self._curMapCol + 2, LinkGameModel.EmptyState)
			self:_addCell(cellInfoB)
		end

		self._curMapCol = self._curMapCol + 2
		self._curMapRow = self._curMapRow + 2
	end
end

function LinkGameModel:setMapDataByCellList(cellList, col, row)
	self:resetGame()

	self._curMapCol = col
	self._curMapRow = row

	for col = 1, self._curMapCol do
		for row = 1, self._curMapRow do
			local cellInfo = LinkGameCellMo.New()

			cellInfo:setInfo(LinkGameModel.ExCellIndex, row, col, LinkGameModel.EmptyState)

			self._curMapData[row] = self._curMapData[row] or {}
			self._curMapData[row][col] = cellInfo
		end
	end

	for index, cellInfo in ipairs(cellList) do
		if self._curMapData[cellInfo.row] and self._curMapData[cellInfo.row][cellInfo.col] then
			self._curMapData[cellInfo.row][cellInfo.col]:setInfo(index, cellInfo.row, cellInfo.col, cellInfo.stateIdx)

			if cellInfo.stateIdx ~= LinkGameModel.EmptyState then
				self._curCellMap[cellInfo.index] = cellInfo
				self._curStateMap[cellInfo.stateIdx] = self._curStateMap[cellInfo.stateIdx] or {}
				self._curStateMap[cellInfo.stateIdx][cellInfo.index] = cellInfo
				self._curStateCountMap[cellInfo.stateIdx] = checknumber(self._curStateCountMap[cellInfo.stateIdx]) + 1
			end
		end
	end
end

function LinkGameModel:setMapDataByMapData(mapData, col, row)
	self._curCellMap = {}
	self._curStateMap = {}
	self._curStateCountMap = {}
	self._selectCellIndex = -1
	self._curMapCol = col
	self._curMapRow = row
	self._curMapData = mapData

	for col = 1, self._curMapCol do
		for row = 1, self._curMapRow do
			if self._curMapData[row] and self._curMapData[row][col] then
				local cellInfo = self._curMapData[row][col]

				if cellInfo.stateIdx ~= LinkGameModel.EmptyState then
					self._curCellMap[cellInfo.index] = cellInfo
					self._curStateMap[cellInfo.stateIdx] = self._curStateMap[cellInfo.stateIdx] or {}
					self._curStateMap[cellInfo.stateIdx][cellInfo.index] = cellInfo
					self._curStateCountMap[cellInfo.stateIdx] = checknumber(self._curStateCountMap[cellInfo.stateIdx]) + 1
				end
			end
		end
	end
end

function LinkGameModel:resetGame()
	self._curMapData = {}
	self._curCellMap = {}
	self._curStateMap = {}
	self._curStateCountMap = {}
	self._removeStack = {}
	self._removeCount = 0
	self._selectCellIndex = -1
end

function LinkGameModel:_addCell(cellInfo)
	self._curMapData[cellInfo.row] = self._curMapData[cellInfo.row] or {}
	self._curMapData[cellInfo.row][cellInfo.col] = cellInfo

	if cellInfo.stateIdx ~= LinkGameModel.EmptyState then
		self._curCellMap[cellInfo.index] = cellInfo
		self._curStateMap[cellInfo.stateIdx] = self._curStateMap[cellInfo.stateIdx] or {}
		self._curStateMap[cellInfo.stateIdx][cellInfo.index] = cellInfo
		self._curStateCountMap[cellInfo.stateIdx] = checknumber(self._curStateCountMap[cellInfo.stateIdx]) + 1
	end
end

function LinkGameModel:removeCell(index, isRecord)
	local info = self._curCellMap[index]

	if isRecord == true then
		table.insert(self._removeStack, info)

		self._removeCount = self._removeCount + 1
	end

	self._curCellMap[index] = nil

	if self._curStateMap[info.stateIdx] then
		if self._curStateMap[info.stateIdx][info.index] then
			self._curStateMap[info.stateIdx][info.index] = nil
			self._curStateCountMap[info.stateIdx] = checknumber(self._curStateCountMap[info.stateIdx]) - 1
		end

		if checknumber(self._curStateCountMap[info.stateIdx]) <= 0 then
			self._curStateMap[info.stateIdx] = nil
		end
	end

	if self._curMapData[info.row][info.col] then
		self._curMapData[info.row][info.col].stateIdx = 0
	end
end

function LinkGameModel:swapCell(indexA, indexB)
	local infoA = self._curCellMap[indexA]
	local infoB = self._curCellMap[indexB]
	local colA = infoA.col
	local rowA = infoA.row
	local colB = infoB.col
	local rowB = infoB.row

	infoA:setInfo(infoA.index, rowB, colB, infoA.stateIdx)
	infoB:setInfo(infoB.index, rowA, colA, infoB.stateIdx)

	self._curMapData[infoA.row][infoA.col] = infoA
	self._curMapData[infoB.row][infoB.col] = infoB
end

function LinkGameModel:getMapCol()
	return self._curMapCol
end

function LinkGameModel:getMapRow()
	return self._curMapRow
end

function LinkGameModel:getMapData()
	return self._curMapData
end

function LinkGameModel:getCellMap()
	return self._curCellMap
end

function LinkGameModel:getStateMap()
	return self._curStateMap
end

function LinkGameModel:getStateCountMap()
	return self._curStateCountMap
end

function LinkGameModel:setSelectCell(index)
	self._selectCellIndex = index
end

function LinkGameModel:resetSelectCell()
	self._selectCellIndex = LinkGameModel.NotSelectIndex
end

function LinkGameModel:getSelectCell()
	return self._selectCellIndex
end

function LinkGameModel:getCellInfo(index)
	return self._curCellMap[index]
end

function LinkGameModel:getRemoveStackTop(topIndex)
	local index = topIndex or 1

	return self._removeStack[#self._removeStack - index + 1]
end

function LinkGameModel:getRemovePairs()
	return math.floor(self._removeCount / 2)
end

function LinkGameModel:getIsReadRule(actId)
	return GameUtil.getUserData(LinkGameModel.ReadFlag .. "#ReadRule#" .. checknumber(actId))
end

function LinkGameModel:setIsReadRule(actId)
	GameUtil.saveUserData(LinkGameModel.ReadFlag .. "#ReadRule#" .. checknumber(actId), true)
end

function LinkGameModel:setStageInfo(msg)
	local isPass = true

	self._curStage = 0
	self._myTotalStep = 0
	self._stageInfo = {}

	for i, v in ipairs(msg.stageList or {}) do
		if v.stageMinStepNum > 0 and self._curStage < v.stageId then
			self._curStage = v.stageId
		else
			isPass = false
		end

		self._stageInfo[v.stageId] = v.stageMinStepNum
		self._myTotalStep = self._myTotalStep + v.stageMinStepNum
	end

	if isPass == false then
		self._myTotalStep = 0
	end
end

function LinkGameModel:getStageInfo(stageId)
	return self._stageInfo[stageId]
end

function LinkGameModel:getCurStage()
	return checknumber(self._curStage)
end

function LinkGameModel:setRankInfo(msg)
	self._rankList = msg.rankInfos

	table.sort(self._rankList, function(a, b)
		return a.rank < b.rank
	end)

	self._myRank = msg.myRank
end

function LinkGameModel:getRankInfo()
	return self._rankList or {}
end

function LinkGameModel:getMyRank()
	return self._myRank or 0
end

function LinkGameModel:setClientKey(clientKey)
	self._clientKey = clientKey
end

function LinkGameModel:getClientKey()
	return self._clientKey
end

function LinkGameModel:setServerKey(key)
	self._severKey = key
end

function LinkGameModel:getServerKey()
	return self._severKey
end

function LinkGameModel:getMyTotalStep()
	return self._myTotalStep
end

function LinkGameModel:getNewLevel(activityId, stageId)
	return GameUtil.getUserData(LinkGameModel.ReadFlag .. "#newLevel#" .. activityId .. "#" .. stageId)
end

function LinkGameModel:setNewLevel(activityId, stageId)
	GameUtil.saveUserData(LinkGameModel.ReadFlag .. "#newLevel#" .. activityId .. "#" .. stageId, true)
end

LinkGameModel.instance = LinkGameModel.New()

return LinkGameModel
