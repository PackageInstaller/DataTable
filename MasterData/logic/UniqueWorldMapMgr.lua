-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldMapMgr.lua

module("logic.extensions.uniqueworld.view.UniqueWorldMapMgr", package.seeall)

local UniqueWorldMapMgr = class("UniqueWorldMapMgr", ViewComponent)

function UniqueWorldMapMgr:ctor()
	self._itemMap = {}
	self._complateInstanceMap = {}
	self._cellList = {}
end

function UniqueWorldMapMgr:initParam(activityId, gameId, levelId, bgGo, eventGo, contentGo)
	self._bgRoot = bgGo
	self._eventRoot = eventGo
	self._contentGo = contentGo
	self._activityId = activityId
	self._gameId = gameId
	self._levelId = levelId
	self._levelPlanCfg = UniqueWorldConfig.instance:getLevelPlanCfgsById(activityId, gameId, levelId)
	self._cellWidth = self._levelPlanCfg.cellWidth
	self._cellHeight = self._levelPlanCfg.cellHeight
	self._mapLength = self._levelPlanCfg.length
	self._mapWidth = self._levelPlanCfg.width
	self._gridRowNum = self._mapWidth
	self._gridColNum = self._mapLength
	self._mapId = self._levelPlanCfg.mapId
	self._mapCfg = UniqueWorldConfig.instance:getMapCfgs(self._mapId)
	self._canShowBoss = UniqueWorldController.instance:canShowBoss(self._activityId, self._levelId)
	self._halfWidth = self._cellWidth * 0.5
	self._halfHeight = self._cellHeight * 0.5
	self._totalHeight = self._mapLength * self._cellHeight + 50
	self._totalWidth = self._mapWidth * self._cellWidth + 50
	self._offsetPosY = self._totalHeight / 2 - 50
	self._startPosList = {}
	self._eventItemList = {}
	self._internalFinder = LuaAStarPathfinder.New()

	GlobalDispatcher:addListener(GlobalNotify.UniqueWorldClickGrid, self._onClickGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_UniqueWorldDoEventRes, self._onDoEventRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_UniqueWorldMoveRes, self._onMoveRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_UniqueWorldMapChangeRes, self._onMapChangeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UniqueWorldPlayerSiblingIdxChange, self._onPlayerSiblingIdxChange, self)
end

function UniqueWorldMapMgr:createPlayerWalkPath(curItem, endItem)
	local endX, endY = endItem:getXYCoord()
	local endNode = self._internalFinder:getNode(endX - 1, endY - 1)
	local oldX, oldY = curItem:getXYCoord()
	local startNode = self._internalFinder:getNode(oldX - 1, oldY - 1)

	if startNode and endNode then
		local pathList = self._internalFinder:search(startNode, endNode, true)

		if pathList then
			local length = #pathList
			local pathNodePath = {}

			for j = 1, length, 2 do
				local row = pathList[j] + 1
				local col = pathList[j + 1] + 1
				local gridId = (col - 1) * self._mapLength + row
				local posX, posY = self:getMapPos(col, row)

				table.insert(pathNodePath, {
					x = posX,
					y = posY,
					gridId = gridId,
					row = row,
					col = col
				})
			end

			return pathNodePath
		end
	end

	return {}
end

function UniqueWorldMapMgr:setComplateInstance(cellGoTag, cellInstance)
	if not cellInstance then
		printError("无对象实例，请检查是否有正确设置模板实例。 cellGoTag: ", cellGoTag)
	else
		GameUtil.SetActive(cellInstance, true)

		self._complateInstanceMap[cellGoTag] = cellInstance

		GameUtil.SetActive(cellInstance, false)
	end
end

function UniqueWorldMapMgr:getWidthNHeight()
	return self._mapWidth * self._cellWidth * 1.5, self._mapLength * self._cellHeight * 1.5
end

function UniqueWorldMapMgr:getOffsetPosY()
	return self._offsetPosY
end

function UniqueWorldMapMgr:getMapLength()
	return self._mapLength
end

function UniqueWorldMapMgr:getMapPos(xIndex, yIndex)
	local posX = (xIndex - yIndex) * self._halfWidth
	local posY = -(xIndex + yIndex) * self._halfHeight

	return posX, posY + self._offsetPosY
end

function UniqueWorldMapMgr:getEventItemList()
	return self._eventItemList
end

function UniqueWorldMapMgr:createMap()
	local bgComplateInstance = self._complateInstanceMap[UniqueWorldEnum.MapGoType.Bg]
	local cellComplateInstance = self._complateInstanceMap[UniqueWorldEnum.MapGoType.Cell]
	local finishMap = UniqueWorldModel.instance:getFinishGridMap(self._activityId)
	local curFloorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)
	local extGridInfoMap = UniqueWorldModel.instance:getExtGridInfoMap(self._activityId)

	for x = 1, self._mapWidth do
		for y = 1, self._mapLength do
			local gridId = (y - 1) * self._mapLength + x
			local cellGo
			local mapCfg = UniqueWorldConfig.instance:getMapCfg(self._mapId, gridId)
			local extGridInfo = extGridInfoMap[gridId]
			local eventType = mapCfg.eventType
			local eventId

			if extGridInfo then
				eventType = extGridInfo.eventType
				eventId = extGridInfo.eventId
			end

			local xCoord, yCoord = self:getXYCoord(gridId)
			local bgGo = goutil.cloneAndSetParent(bgComplateInstance, self._bgRoot.transform, "bg_" .. gridId)
			local posX, posY = self:getMapPos(xCoord, yCoord)

			GameUtil.setLocalPos(bgGo, posX, posY, 0)

			if eventType ~= UniqueWorldEnum.GridType.Empty then
				cellGo = goutil.cloneAndSetParent(cellComplateInstance, self._eventRoot.transform, "cell_" .. gridId)

				GameUtil.setLocalPos(cellGo, posX, posY, 0)
			end

			local item = UniqueWorldCell.New(self._activityId, self._mapId, self._levelId, eventType, eventId, gridId, xCoord, yCoord, bgGo, cellGo)

			item:init()

			self._itemMap[gridId] = item

			GameUtil.SetActive(bgGo, true)

			if cellGo then
				GameUtil.SetActive(cellGo, true)
				table.insert(self._eventItemList, item)
			end
		end
	end

	local blockType, array, index
	local data = {}

	for i = 1, self._gridRowNum do
		array = {}
		data[i - 1] = array

		for j = 1, self._gridColNum do
			index = (j - 1) * self._gridColNum + i

			local item = self._itemMap[(j - 1) * self._gridColNum + i]

			if item then
				local hasFinish = finishMap[index]
				local isBoss = item:getType() == UniqueWorldEnum.GridType.BossChallenge
				local canWalk = false

				if isBoss then
					canWalk = curFloorPercent >= 1 or not self._canShowBoss
					self._bossGridId = index
				else
					canWalk = item:isWalkable() or hasFinish
				end

				blockType = canWalk and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall
			else
				blockType = LuaPathfinder_Const.BlockType_Wall
			end

			array[j - 1] = {
				weight = 20,
				x = i - 1,
				y = j - 1,
				blockType = blockType
			}
		end
	end

	self._internalFinder:reload(data, self._gridRowNum, self._gridColNum, LuaPathfinder_Const.CostFlag_Dir_4, LuaPathfinder_Const.HeuristicFlag_Manhattan)
end

function UniqueWorldMapMgr:_onDoEventRes(targetGridId)
	local targetItem = self._itemMap[targetGridId]
	local type = targetItem:getType()
	local bossItem = self._itemMap[self._bossGridId]

	if type == UniqueWorldEnum.GridType.Shop then
		return
	end

	targetItem:updateUI()
	bossItem:updateUI()

	local curFloorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)
	local hasFinish = UniqueWorldModel.instance:gridHasFinish(self._activityId, targetGridId)
	local canWalk = false
	local doorCanWalk = false
	local gridId = targetGridId

	if type ~= UniqueWorldEnum.GridType.DigMine then
		self._isWalking = false
	end

	if type == UniqueWorldEnum.GridType.BossChallenge then
		canWalk = bossItem:canShowBoss() and hasFinish and curFloorPercent >= 1
		doorCanWalk = canWalk
		gridId = self._bossGridId
	else
		canWalk = hasFinish
		doorCanWalk = curFloorPercent >= 1
	end

	self:setGridWalkableState(gridId, canWalk)
	self:setGridWalkableState(self._bossGridId, doorCanWalk)
end

function UniqueWorldMapMgr:clear()
	GlobalDispatcher:removeListener(GlobalNotify.UniqueWorldClickGrid, self._onClickGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_UniqueWorldMoveRes, self._onMoveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_UniqueWorldDoEventRes, self._onDoEventRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.UniqueWorldPlayerSiblingIdxChange, self._onPlayerSiblingIdxChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_UniqueWorldMapChangeRes, self._onMapChangeRes, self)

	self._isWalking = false
	self._complateInstanceMap = {}

	for k, v in pairs(self._itemMap) do
		v:destroy()

		self._itemMap[k] = nil
	end
end

function UniqueWorldMapMgr:reCreateMap()
	for k, v in pairs(self._itemMap) do
		v:destroy()

		self._itemMap[k] = nil
	end

	self:createMap()
end

function UniqueWorldMapMgr:_onClickGrid(gridId)
	if self._isWalking then
		return
	end

	local curPlayerGridId = UniqueWorldPlayerMgr.instance:getPlayerCurGridId()

	if checknumber(curPlayerGridId) <= 0 then
		curPlayerGridId = 1
	end

	local curItem = self._itemMap[curPlayerGridId]
	local targetItem = self._itemMap[gridId]
	local walkList = self:createPlayerWalkPath(curItem, targetItem)

	if not walkList or #walkList == 0 then
		if self:canTrigCell(gridId) then
			self._isWalking = true

			targetItem:afterTrig()
			self:_tryTipFinishCurFloor(gridId)
		end

		return
	end

	self._isWalking = true

	local gridList = {}

	for i, gridData in ipairs(walkList) do
		table.insert(gridList, gridData.gridId)
	end

	local finalGridId = gridList[#gridList]

	self._finalGridId = gridId

	local info = UniqueWorldModel.instance:getInfo(self._activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.leftCoin then
			local preLeftCoin = 0

			UniqueWorldController.instance:savePreCoinNum(preLeftCoin)

			local function finishCallBack()
				UniqueWorldPlayerMgr.instance:setPlayerCurGridId(finalGridId)
				UniqueWorldController.instance:sendPM_UniqueWorldMoveReq(self._activityId, finalGridId)
				UniqueWorldPlayerMgr.instance:checkNeedUpdateSiblingIdx(finalGridId)
			end

			UniqueWorldPlayerMgr.instance:move(gridList, finishCallBack)
		end
	end
end

function UniqueWorldMapMgr:_onMoveRes()
	local isMine = false

	if self._finalGridId and self:canTrigCell(self._finalGridId) then
		local item = self._itemMap[self._finalGridId]

		item:afterTrig()
		self:_tryTipFinishCurFloor(self._finalGridId)

		self._finalGridId = nil
		isMine = item:getType() == UniqueWorldEnum.GridType.DigMine
	end

	if not isMine then
		self:endWalking()
	end
end

function UniqueWorldMapMgr:_onMapChangeRes()
	local extGridInfoMap = UniqueWorldModel.instance:getExtGridInfoMap(self._activityId)

	if extGridInfoMap then
		for gridId, gridInfo in pairs(extGridInfoMap) do
			local item = self._itemMap[gridId]

			if item then
				local cellGo
				local cellComplateInstance = self._complateInstanceMap[UniqueWorldEnum.MapGoType.Cell]
				local xIndex, yIndex = item:getXYCoord()

				if not item:hasCellGo() then
					local siblingIdx = self:getSiblingIdx(gridId)

					cellGo = goutil.cloneAndSetParent(cellComplateInstance, self._eventRoot.transform, "cell_" .. gridId)

					cellGo.transform:SetSiblingIndex(siblingIdx)
					table.insert(self._eventItemList, siblingIdx, item)

					local posX, posY = self:getMapPos(xIndex, yIndex)

					GameUtil.setLocalPos(cellGo, posX, posY, 0)
					GameUtil.SetActive(cellGo, true)
					item:updateUIByExtInfo(gridId, gridInfo.eventType, gridInfo.eventId, cellGo)
				end

				local hasFinish = UniqueWorldModel.instance:gridHasFinish(self._activityId, gridId)

				if not hasFinish then
					self:setGridWalkableState(gridId, false)
				end
			end
		end
	end
end

function UniqueWorldMapMgr:_tryTipFinishCurFloor(gridId)
	local finishMap = UniqueWorldModel.instance:getFinishGridMap(self._activityId)
	local item = self._itemMap[gridId]

	if item and item:getType() == UniqueWorldEnum.GridType.BossChallenge then
		local curPlayerGridId = UniqueWorldPlayerMgr.instance:getPlayerCurGridId()
		local curFloorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)

		if curFloorPercent < 1 and finishMap[gridId] then
			FloatWordMgr.instance:show("请先完成本层事件再进入下一层")
		end
	end

	if item and item:getType() ~= UniqueWorldEnum.GridType.DigMine then
		self:endWalking()
	end
end

function UniqueWorldMapMgr:setGridWalkableState(gridId, canWalk)
	local item = self._itemMap[gridId]

	if item then
		local xIndex, yIndex = item:getXYCoord()
		local node = self._internalFinder:getNode(xIndex - 1, yIndex - 1)

		if node then
			node.blockType = canWalk and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall
		end
	end
end

function UniqueWorldMapMgr:canTrigCell(gridId)
	if checknumber(gridId) == 0 then
		return false
	end

	local playerX, playerY = UniqueWorldPlayerMgr.instance:getPlayerCoord()
	local cellItem = self._itemMap[gridId]
	local targetX, targetY = cellItem:getXYCoord()

	if math.abs(playerX - targetX) == 1 and playerY == targetY or math.abs(playerY - targetY) == 1 and playerX == targetX then
		return true
	end

	return false
end

function UniqueWorldMapMgr:getXYCoord(gridId)
	local xIndex = (gridId - 1) % self._mapLength + 1
	local yIndex = math.floor((gridId - 1) / self._mapLength) + 1

	return xIndex, yIndex
end

function UniqueWorldMapMgr:_onPlayerSiblingIdxChange(siblingIdx)
	local playerGo = UniqueWorldPlayerMgr.instance:getPlayerGo()

	if not playerGo then
		return
	end

	playerGo.transform:SetSiblingIndex(siblingIdx)
end

function UniqueWorldMapMgr:getSiblingIdx(extInfoGridId)
	local curSilblingIdx = 0
	local extItem = self._itemMap[extInfoGridId]
	local extItemX, extItemY = extItem:getXYCoord()

	for idx, item in ipairs(self._eventItemList) do
		local gridX, gridY = item:getXYCoord()

		if gridX < extItemX or extItemX == gridX and gridY < extItemY then
			curSilblingIdx = idx + 1
		end
	end

	return curSilblingIdx
end

function UniqueWorldMapMgr:endWalking()
	self._isWalking = false
end

function UniqueWorldMapMgr:cancelPendingEvent()
	self._finalGridId = nil
end

function UniqueWorldMapMgr:addEventToGrid(gridId, eventType, eventId)
	local item = self._itemMap[gridId]

	item:updateUI(eventType, eventId)
end

UniqueWorldMapMgr.instance = UniqueWorldMapMgr.New()

return UniqueWorldMapMgr
