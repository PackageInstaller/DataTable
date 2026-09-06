-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/controller/LinkGameController.lua

module("logic.extensions.linkgame.controller.LinkGameController", package.seeall)

local LinkGameController = class("LinkGameController", BaseController)

LinkGameController.RandomExchangeTime = 3
LinkGameController.RetestTime = 100

function LinkGameController:ctor()
	return
end

function LinkGameController:onInit()
	GlobalDispatcher:addListener(LinkGameAgent.handlePM_LinkGameInfoRes, self._handlePM_LinkGameInfoRes, self)
	GlobalDispatcher:addListener(LinkGameAgent.handlePM_LinkGameStartGameRes, self._handlePM_LinkGameStartGameRes, self)
	GlobalDispatcher:addListener(LinkGameAgent.handlePM_LinkGameEndGameRes, self._handlePM_LinkGameEndGameRes, self)
	GlobalDispatcher:addListener(LinkGameAgent.handlePM_LinkGameRankRes, self._handlePM_LinkGameRankRes, self)
	self:onReset()
end

function LinkGameController:onReset()
	self:checkRedPoint()
end

function LinkGameController:calcCellIsLink(cellInfoA, cellInfoB)
	local path
	local isFindPath = false

	isFindPath, path = self:_getRowExtendLink(cellInfoA, cellInfoB)

	if isFindPath == true then
		return path
	end

	local var_4_0, var_4_1 = self:_getColExtendLink(cellInfoA, cellInfoB)

	path = var_4_1

	if var_4_0 == true then
		return path
	end

	return {}
end

function LinkGameController:_getRowExtendLink(cellInfoA, cellInfoB)
	local path = {}
	local mapData = LinkGameModel.instance:getMapData()
	local isFindPath = false
	local maxA, minA = cellInfoA.col, cellInfoA.col
	local maxB, minB = cellInfoB.col, cellInfoB.col

	for col = cellInfoA.col + 1, LinkGameModel.instance:getMapCol() do
		if mapData[cellInfoA.row][col] and mapData[cellInfoA.row][col].stateIdx == LinkGameModel.EmptyState then
			maxA = col
		else
			break
		end
	end

	for col = cellInfoA.col - 1, 1, -1 do
		if mapData[cellInfoA.row][col] and mapData[cellInfoA.row][col].stateIdx == LinkGameModel.EmptyState then
			minA = col
		else
			break
		end
	end

	for col = cellInfoB.col + 1, LinkGameModel.instance:getMapCol() do
		if mapData[cellInfoB.row][col] and mapData[cellInfoB.row][col].stateIdx == LinkGameModel.EmptyState then
			maxB = col
		else
			break
		end
	end

	for col = cellInfoB.col - 1, 1, -1 do
		if mapData[cellInfoB.row][col] and mapData[cellInfoB.row][col].stateIdx == LinkGameModel.EmptyState then
			minB = col
		else
			break
		end
	end

	local checkCol = {}

	if maxA >= minB and maxB >= minA then
		for i = math.max(minB, minA), math.min(maxA, maxB) do
			if i == cellInfoB.col or i == cellInfoA.col then
				table.insert(checkCol, 1, i)
			else
				table.insert(checkCol, i)
			end
		end

		table.sort(checkCol, function(a, b)
			local disA = Mathf.Abs(a - cellInfoB.col) + Mathf.Abs(a - cellInfoA.col)
			local disB = Mathf.Abs(b - cellInfoB.col) + Mathf.Abs(b - cellInfoA.col)

			if disA ~= disB then
				return disA < disB
			else
				return a < b
			end
		end)
	end

	local minPath = {}

	for i, col in ipairs(checkCol) do
		minPath = {}

		local isEmpty = true

		for row = cellInfoA.row, cellInfoB.row, (cellInfoA.row > cellInfoB.row or nil) and -1 do
			if mapData[row][col] and (mapData[row][col].stateIdx == LinkGameModel.EmptyState or row == cellInfoA.row or row == cellInfoB.row) then
				table.insert(minPath, mapData[row][col])
			else
				isEmpty = false

				break
			end
		end

		if isEmpty == true then
			isFindPath = true

			break
		end
	end

	if isFindPath == true then
		local linkCol = minPath[1].col
		local step = 1

		if linkCol < cellInfoA.col then
			step = -1
		end

		for col = cellInfoA.col, linkCol - step, step do
			table.insert(path, mapData[cellInfoA.row][col])
		end

		for i, v in ipairs(minPath) do
			table.insert(path, v)
		end

		step = 1

		if linkCol > cellInfoB.col then
			step = -1
		end

		for col = linkCol + step, cellInfoB.col, step do
			table.insert(path, mapData[cellInfoB.row][col])
		end
	end

	return isFindPath, path
end

function LinkGameController:_getColExtendLink(cellInfoA, cellInfoB)
	local path = {}
	local mapData = LinkGameModel.instance:getMapData()
	local isFindPath = false
	local maxA, minA = cellInfoA.row, cellInfoA.row
	local maxB, minB = cellInfoB.row, cellInfoB.row

	for row = cellInfoA.row + 1, LinkGameModel.instance:getMapRow() do
		if mapData[row][cellInfoA.col] and mapData[row][cellInfoA.col].stateIdx == LinkGameModel.EmptyState then
			maxA = row
		else
			break
		end
	end

	for row = cellInfoA.row - 1, 1, -1 do
		if mapData[row][cellInfoA.col] and mapData[row][cellInfoA.col].stateIdx == LinkGameModel.EmptyState then
			minA = row
		else
			break
		end
	end

	for row = cellInfoB.row + 1, LinkGameModel.instance:getMapRow() do
		if mapData[row][cellInfoB.col] and mapData[row][cellInfoB.col].stateIdx == LinkGameModel.EmptyState then
			maxB = row
		else
			break
		end
	end

	for row = cellInfoB.row - 1, 1, -1 do
		if mapData[row][cellInfoB.col] and mapData[row][cellInfoB.col].stateIdx == LinkGameModel.EmptyState then
			minB = row
		else
			break
		end
	end

	local checkRow = {}

	if maxA >= minB and maxB >= minA then
		for i = math.max(minB, minA), math.min(maxA, maxB) do
			if i == cellInfoB.row or i == cellInfoA.row then
				table.insert(checkRow, 1, i)
			else
				table.insert(checkRow, i)
			end
		end

		table.sort(checkRow, function(a, b)
			local disA = Mathf.Abs(a - cellInfoB.row) + Mathf.Abs(a - cellInfoA.row)
			local disB = Mathf.Abs(b - cellInfoB.row) + Mathf.Abs(b - cellInfoA.row)

			if disA ~= disB then
				return disA < disB
			else
				return a < b
			end
		end)
	end

	local minPath = {}

	for i, row in ipairs(checkRow) do
		minPath = {}

		local isEmpty = true

		for col = cellInfoA.col, cellInfoB.col, (cellInfoA.col > cellInfoB.col or nil) and -1 do
			if mapData[row][col] and (mapData[row][col].stateIdx == LinkGameModel.EmptyState or col == cellInfoA.col or col == cellInfoB.col) then
				table.insert(minPath, mapData[row][col])
			else
				isEmpty = false

				break
			end
		end

		if isEmpty == true then
			isFindPath = true

			break
		end
	end

	if isFindPath == true then
		local linkRow = minPath[1].row
		local step = 1

		if linkRow < cellInfoA.row then
			step = -1
		end

		for row = cellInfoA.row, linkRow - step, step do
			table.insert(path, mapData[row][cellInfoA.col])
		end

		for i, v in ipairs(minPath) do
			table.insert(path, v)
		end

		step = 1

		if linkRow > cellInfoB.row then
			step = -1
		end

		for row = linkRow + step, cellInfoB.row, step do
			table.insert(path, mapData[row][cellInfoB.col])
		end
	end

	return isFindPath, path
end

function LinkGameController:randomCurMap(fixType)
	local newMapData = {}
	local mapCol = LinkGameModel.instance:getMapCol()
	local mapRow = LinkGameModel.instance:getMapRow()

	for col = 1, mapCol do
		for row = 1, mapRow do
			local cellInfo = LinkGameCellMo.New()

			cellInfo:setInfo(LinkGameModel.ExCellIndex, row, col, LinkGameModel.EmptyState)

			newMapData[row] = newMapData[row] or {}
			newMapData[row][col] = cellInfo
		end
	end

	local totalCellCount = 0
	local stateMap = LinkGameModel.instance:getStateMap()
	local typeList = {}
	local stateCountMap = LinkGameModel.instance:getStateCountMap()

	for i, v in pairs(stateCountMap) do
		totalCellCount = totalCellCount + v

		if v > 0 then
			table.insert(typeList, i)
		end
	end

	for i = 1, totalCellCount do
		local randomNum = math.random(1, #typeList - 1)
		local randomTypeA = typeList[randomNum]
		local randomTypeB = typeList[math.random(randomNum + 1, #typeList)]

		if checknumber(fixType) > 0 then
			while randomTypeA == fixType or randomTypeB == fixType do
				randomNum = math.random(1, #typeList - 1)
				randomTypeA = typeList[randomNum]
				randomTypeB = typeList[math.random(randomNum + 1, #typeList)]
			end
		end

		local count = 0
		local randomCount = math.random(1, math.max(stateCountMap[randomTypeA], stateCountMap[randomTypeB]))
		local cellInfoA, cellInfoB

		for i, v in pairs(stateMap[randomTypeA]) do
			if count == randomCount % stateCountMap[randomTypeA] then
				cellInfoA = v

				break
			end

			count = count + 1
		end

		count = 0

		for i, v in pairs(stateMap[randomTypeB]) do
			if count == randomCount % stateCountMap[randomTypeB] then
				cellInfoB = v

				break
			end

			count = count + 1
		end

		LinkGameModel.instance:swapCell(cellInfoA.index, cellInfoB.index)
	end

	local testTime = 0
	local recordCount = totalCellCount

	while totalCellCount > 0 and testTime < LinkGameController.RetestTime do
		local isLink = false

		repeat
			isLink = false
			stateMap = LinkGameModel.instance:getStateMap()

			for i, typeMap in pairs(stateMap) do
				local list = table.values(typeMap)
				local isFind = false

				for j, v in ipairs(list) do
					for k = j + 1, #list do
						if #self:calcCellIsLink(v, list[k]) > 0 then
							isLink = true

							newMapData[v.row][v.col]:setInfo(v.index, v.row, v.col, v.stateIdx)
							newMapData[list[k].row][list[k].col]:setInfo(list[k].index, list[k].row, list[k].col, list[k].stateIdx)
							LinkGameModel.instance:removeCell(v.index)
							LinkGameModel.instance:removeCell(list[k].index)

							isFind = true

							break
						end
					end

					if isFind == true then
						break
					end
				end
			end
		until isLink == false

		totalCellCount = 0
		typeList = {}
		stateCountMap = LinkGameModel.instance:getStateCountMap()
		stateMap = LinkGameModel.instance:getStateMap()

		for i, v in pairs(stateCountMap) do
			totalCellCount = totalCellCount + v

			if v > 0 then
				table.insert(typeList, i)
			end
		end

		if totalCellCount == recordCount then
			testTime = testTime + 1
		else
			testTime = 0
			recordCount = totalCellCount
		end

		if totalCellCount > 0 then
			for i = 1, totalCellCount + LinkGameController.RandomExchangeTime do
				local randomNum = math.random(1, #typeList - 1)
				local randomTypeA = typeList[randomNum]
				local randomTypeB = typeList[math.random(randomNum + 1, #typeList)]

				if checknumber(fixType) > 0 then
					while randomTypeA == fixType or randomTypeB == fixType do
						randomNum = math.random(1, #typeList - 1)
						randomTypeA = typeList[randomNum]
						randomTypeB = typeList[math.random(randomNum + 1, #typeList)]
					end
				end

				local count = 0
				local randomCount = math.random(1, math.max(stateCountMap[randomTypeA], stateCountMap[randomTypeB]))
				local cellInfoA, cellInfoB

				for i, v in pairs(stateMap[randomTypeA]) do
					if count == randomCount % stateCountMap[randomTypeA] then
						cellInfoA = v

						break
					end

					count = count + 1
				end

				count = 0

				for i, v in pairs(stateMap[randomTypeB]) do
					if count == randomCount % stateCountMap[randomTypeB] then
						cellInfoB = v

						break
					end

					count = count + 1
				end

				LinkGameModel.instance:swapCell(cellInfoA.index, cellInfoB.index)
			end
		end
	end

	LinkGameModel.instance:setMapDataByMapData(newMapData, mapCol, mapRow)
end

function LinkGameController:_handlePM_LinkGameInfoRes(msg)
	LinkGameModel.instance:setStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LinkGameInfoRes)
end

function LinkGameController:sendPM_LinkGameStartGameReq(activityId, stageId)
	local clientKey = math.random(1, 100000)

	LinkGameModel.instance:setClientKey(clientKey)
	LinkGameAgent.instance:sendPM_LinkGameStartGameReq(activityId, stageId, clientKey)
end

function LinkGameController:_handlePM_LinkGameStartGameRes(msg)
	LinkGameModel.instance:setServerKey(msg.serverKey)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LinkGameStartGameRes)
end

function LinkGameController:sendPM_LinkGameEndGameReq(activityId, stageId, isPass, stepNum)
	local encryptedKey = 0
	local clientKey = LinkGameModel.instance:getClientKey()
	local serverKey = bit.bxor(LinkGameModel.instance:getServerKey(), clientKey)
	local passIndex = 0

	passIndex = isPass and isPass == true and 1 or 0
	encryptedKey = passIndex % 2 == 0 and encryptedKey + (passIndex + serverKey) * 5381 or encryptedKey + (passIndex + clientKey) * 31
	encryptedKey = stepNum % 2 == 0 and encryptedKey + (stepNum + serverKey) * 5381 or encryptedKey + (stepNum + clientKey) * 31

	LinkGameAgent.instance:sendPM_LinkGameEndGameReq(activityId, stageId, isPass, stepNum, encryptedKey)
end

function LinkGameController:_handlePM_LinkGameEndGameRes(msg)
	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.handlePM_LinkGameEndGameRes, msg.changeSetId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.handlePM_LinkGameEndGameRes)
	end
end

function LinkGameController:_handlePM_LinkGameRankRes(msg)
	LinkGameModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LinkGameRankRes)
end

function LinkGameController:checkRedPoint()
	local actId = LinkGameModel.instance:getCurActId()
	local haveNewLevel = false

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LINK_GAME_NEW_LEVEL, haveNewLevel)

	if not actId then
		return
	end

	local stageCfgs = LinkGameConfig.instance:getStageCfgs(actId)

	for i, v in ipairs(stageCfgs) do
		local time = GameUtil.string2time(v.openDateTime)

		if time >= ServerTime.now() then
			GameUtil.getUserData(LinkGameModel.ReadFlag .. "#newLevel#" .. v.activityId .. "#" .. v.stageId, function(result)
				if not result then
					RedPointController.instance:setRedPointInfo(RedPointModel.ID_LINK_GAME_NEW_LEVEL, true)
				end
			end)
		end
	end
end

LinkGameController.instance = LinkGameController.New()

return LinkGameController
