-- chunkname: @modules/logic/room/model/map/path/RoomMapVehicleMO.lua

module("modules.logic.room.model.map.path.RoomMapVehicleMO", package.seeall)

local RoomMapVehicleMO = pureTable("RoomMapVehicleMO")

function RoomMapVehicleMO:init(id, pathPlanMO, vehicleId, areaNodeList)
	self.id = id
	self.vehicleId = vehicleId
	self.resourceId = pathPlanMO.resourceId
	self.resId = pathPlanMO.resourceId
	self.pathPlanMO = pathPlanMO
	self.config = RoomConfig.instance:getVehicleConfig(vehicleId)
	self._areaNodeList = {}
	self._initAreaNodeList = {}

	tabletool.addValues(self._initAreaNodeList, areaNodeList)

	self.startMO = self._initAreaNodeList[1] or self:_findMaxNodeNum(pathPlanMO:getNodeList())
	self.curPathNodeMO = self.startMO
	self.enterDirection = 4
	self.moveOffsetDirs = {
		3,
		4,
		2,
		5,
		1,
		0
	}
	self.mapHexPointDic = self:_getHexPiontDic(pathPlanMO:getNodeList())
	self._areaNodeNum = math.max(1, #self._initAreaNodeList)
	self._recentHistoryNum = 10
	self._recentHistory = {}
	self.vehicleType = 0
	self.ownerType = 0
	self.owerId = 0
	self._replaceType = RoomVehicleEnum.ReplaceType.None

	if not self.config then
		logError(string.format("找不到交通工具配置,id:%s ", self.vehicleId))
	end

	if #self._initAreaNodeList > 1 then
		for i = #self._initAreaNodeList, 1, -1 do
			self:moveToNode(self._initAreaNodeList[i], self.enterDirection)
		end
	else
		self:moveToNode(self.startMO, self.enterDirection)
	end
end

function RoomMapVehicleMO:setReplaceType(replaceType)
	self._replaceType = self.ownerType == RoomVehicleEnum.OwnerType.TransportSite and replaceType or RoomVehicleEnum.ReplaceType.None
end

function RoomMapVehicleMO:getReplaceDefideCfg()
	if self.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		self:_initReplaceDefideCfg()

		return self._replacConfigMap[self._replaceType] or self.config
	end

	return self.config
end

function RoomMapVehicleMO:_initReplaceDefideCfg()
	if self._replacConfigMap and self._lasetDefideId == self.vehicleId then
		return
	end

	self._replacConfigMap = {}

	if not self.config or string.nilorempty(self.config.replaceConditionStr) then
		return
	end

	local replaceList = GameUtil.splitString2(self.config.replaceConditionStr, true)

	for i, param in ipairs(replaceList) do
		if param and #param > 1 then
			local vehicleCfg = RoomConfig.instance:getVehicleConfig(param[2])

			if vehicleCfg then
				self._replacConfigMap[param[1]] = vehicleCfg
			end
		end
	end
end

function RoomMapVehicleMO:_findSideNode(nodeMOList)
	for i, nodeMO in ipairs(nodeMOList) do
		if nodeMO:isSideNode() then
			return nodeMO
		end
	end

	return nodeMOList[1]
end

function RoomMapVehicleMO:_findMaxNodeNum(nodeMOList)
	local findNode, maxNumNode

	for i, nodeMO in ipairs(nodeMOList) do
		if not nodeMO.hasBuilding and (findNode == nil or findNode.connectNodeNum < nodeMO.connectNodeNum) then
			findNode = nodeMO
		end

		if nodeMO:isSideNode() and (maxNumNode == nil or maxNumNode.connectNodeNum < nodeMO.connectNodeNum) then
			maxNumNode = nodeMO
		end
	end

	return findNode or maxNumNode or nodeMOList[1]
end

function RoomMapVehicleMO:_getHexPiontDic(nodeMOList)
	local mapdic = {}

	for i, nodeMO in ipairs(nodeMOList) do
		local xList = mapdic[nodeMO.hexPoint.x]

		if xList == nil then
			xList = {}
			mapdic[nodeMO.hexPoint.x] = xList
		end

		xList[nodeMO.hexPoint.y] = 0
	end

	return mapdic
end

function RoomMapVehicleMO:resetHistory()
	local mapdic = self.mapHexPointDic

	for x, xList in pairs(mapdic) do
		for y, value in pairs(xList) do
			xList[y] = 0
		end
	end
end

function RoomMapVehicleMO:getHistoryCount(x, y)
	return (self.mapHexPointDic[x] or nil) and (self.mapHexPointDic[x][y] or 0)
end

function RoomMapVehicleMO:setHistoryCount(x, y, count)
	self.mapHexPointDic[x] = self.mapHexPointDic[x] or {}
	self.mapHexPointDic[x][y] = count
end

function RoomMapVehicleMO:_isNextStar()
	local curNode = self.curPathNodeMO

	if curNode.hexPoint == self.startMO.hexPoint and self:getHistoryCount(curNode.hexPoint.x, curNode.hexPoint.y) >= 5 then
		return true
	end

	local flag = false

	for direction = 1, 6 do
		local node = curNode:getConnctNode(direction)

		if node and self:getHistoryCount(node.hexPoint.x, node.hexPoint.y) >= 5 then
			flag = true
		end
	end

	return flag
end

function RoomMapVehicleMO:getCurNode()
	return self.curPathNodeMO
end

function RoomMapVehicleMO:findNextWeightNode()
	local curNodel = self.curPathNodeMO

	if not self.enterDirection then
		local curDire = 4
		local nextNode
		local nextWeight = 0
		local nextEnterDire = curDire
		local curExitDire = curDire
		local connectCount = 0

		for i = 1, #self.moveOffsetDirs do
			local direction = (curDire + self.moveOffsetDirs[i] - 1) % 6 + 1
			local node = curNodel:getConnctNode(direction)

			if node then
				connectCount = connectCount + 1

				local weight = self:_getWeight(node, i)

				if nextWeight < weight or nextNode == nil then
					nextNode = node
					nextWeight = weight
					curExitDire = direction
					nextEnterDire = curNodel:getConnectDirection(direction)
				end
			end
		end

		return nextNode or curNodel, nextEnterDire, curExitDire
	end
end

function RoomMapVehicleMO:moveToNode(nextNode, enterDire, isFail)
	if nextNode then
		local historyCount = self:getHistoryCount(nextNode.hexPoint.x, nextNode.hexPoint.y) + 1

		if nextNode:isEndNode() then
			historyCount = historyCount + 1
		end

		self:setHistoryCount(nextNode.hexPoint.x, nextNode.hexPoint.y, historyCount)

		if isFail ~= true then
			self.enterDirection = enterDire
			self.curPathNodeMO = nextNode

			self:_addAreaNode(nextNode)
		end

		self:_addRecentHistory(nextNode.id)
	end

	return self.curPathNodeMO
end

function RoomMapVehicleMO:_getWeight(nextNode, index)
	local weight = (7 - index) * 30
	local count = self:getHistoryCount(nextNode.hexPoint.x, nextNode.hexPoint.y)

	weight = weight - count * 200

	if nextNode:isSideNode() then
		weight = weight + 1000
	end

	local index = self:_getRecentHistoryIndexOf(nextNode.id)

	if index then
		weight = weight - index * 1000
	end

	return weight
end

function RoomMapVehicleMO:_addRecentHistory(nodeId)
	table.insert(self._recentHistory, nodeId)

	if #self._recentHistory > self._recentHistoryNum then
		table.remove(self._recentHistory, 1)
	end
end

function RoomMapVehicleMO:_getRecentHistoryIndexOf(nodeId)
	for i = #self._recentHistory, 1, -1 do
		if self._recentHistory[i] == nodeId then
			return i
		end
	end
end

function RoomMapVehicleMO:findEndDir(node, enterDire)
	if not node then
		return enterDire
	end

	for i = 1, #self.moveOffsetDirs do
		local direction = (enterDire + self.moveOffsetDirs[i] - 1) % 6 + 1

		if tabletool.indexOf(node.directionList, direction) then
			return direction
		end
	end

	return enterDire
end

function RoomMapVehicleMO:_addAreaNode(nodeMO)
	table.insert(self._areaNodeList, 1, nodeMO)

	while #self._areaNodeList > self._areaNodeNum do
		table.remove(self._areaNodeList, #self._areaNodeList)
	end
end

function RoomMapVehicleMO:getAreaNode()
	return self._areaNodeList
end

function RoomMapVehicleMO:getInitAreaNode()
	return self._initAreaNodeList
end

return RoomMapVehicleMO
