-- chunkname: @modules/logic/room/model/transport/quicklink/RoomTransportQuickLinkMO.lua

module("modules.logic.room.model.transport.quicklink.RoomTransportQuickLinkMO", package.seeall)

local RoomTransportQuickLinkMO = pureTable("RoomTransportQuickLinkMO")

function RoomTransportQuickLinkMO:init()
	self._nodeMap = {}
	self._nodeList = {}
	self._nodePoolList = {}
	self._maxSearchIndex = 200

	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	for _, blockMO in ipairs(blockMOList) do
		if RoomTransportHelper.canPathByBlockMO(blockMO, true) then
			local node = self:_popNode()
			local hexPoint = blockMO.hexPoint

			node:init(hexPoint)
			RoomHelper.add2KeyValue(self._nodeMap, hexPoint.x, hexPoint.y, node)
			table.insert(self._nodeList, node)
		end
	end

	self._maxSearchIndex = #self._nodeList
end

function RoomTransportQuickLinkMO:findPath(fromType, toType, isRmoveBuilding)
	self:_resetNodeParam(isRmoveBuilding)

	local pathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for _, pathMO in ipairs(pathMOList) do
		if pathMO:isLinkFinish() then
			local hexPointList = pathMO:getHexPointList()

			for __, hexPoint in ipairs(hexPointList) do
				local node = RoomHelper.get2KeyValue(self._nodeMap, hexPoint.x, hexPoint.y)

				if node then
					node.isBlock = true
				end
			end
		end
	end

	local siteTypeList = {
		fromType,
		toType
	}

	for _, siteType in ipairs(siteTypeList) do
		local hexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(siteType)

		if hexPoint then
			local node = RoomHelper.get2KeyValue(self._nodeMap, hexPoint.x, hexPoint.y)

			if node then
				node.isBlock = false
			end
		end
	end

	self._fromNodeList = {}
	self._toNodeList = {}

	self:_addNodeList(self._fromNodeList, fromType)
	self:_addNodeList(self._toNodeList, toType)
	self:_searchNode(self._toNodeList, 0)
	table.sort(self._fromNodeList, RoomTransportQuickLinkMO._sortFunction)
	self:_clearSelectPathFlag()

	return (self:_findNodePathList(self._fromNodeList[1]))
end

function RoomTransportQuickLinkMO._sortFunction(a, b)
	local aLink = RoomTransportQuickLinkMO._getLinkIdx(a)
	local bLink = RoomTransportQuickLinkMO._getLinkIdx(b)

	if aLink ~= bLink then
		return aLink < bLink
	end

	if a.searchIndex ~= b.searchIndex then
		return a.searchIndex < b.searchIndex
	end
end

function RoomTransportQuickLinkMO._getLinkIdx(a)
	if a.isBlock or a.searchIndex == -1 then
		return 10000
	end

	if a.linkNum > 1 then
		if a.searchIndex == 0 then
			return 2
		end

		return 1
	end

	if a.searchIndex == 0 then
		return 100
	end

	return 10
end

function RoomTransportQuickLinkMO:_addNodeList(nodeList, siteType)
	local hexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(siteType)

	if hexPoint then
		local node = RoomHelper.get2KeyValue(self._nodeMap, hexPoint.x, hexPoint.y)

		if node then
			table.insert(nodeList, node)

			return
		end
	end

	local areaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBType(siteType)

	if areaMO then
		local hexPointList = areaMO:getRangesHexPointList()

		for _, hexPoint in ipairs(hexPointList) do
			local node = RoomHelper.get2KeyValue(self._nodeMap, hexPoint.x, hexPoint.y)

			if node then
				table.insert(nodeList, node)
			end
		end
	end
end

function RoomTransportQuickLinkMO:_updateNodeListLinkNum(nodeList)
	for _, node in ipairs(nodeList) do
		node.linkNum = 0

		for i = 1, 6 do
			local dirHexPoint = HexPoint.directions[i]
			local nextNode = RoomHelper.get2KeyValue(self._nodeMap, dirHexPoint.x + node.hexPoint.x, dirHexPoint.y + node.hexPoint.y)

			if nextNode and not nextNode.isBlock and nextNode.searchIndex ~= -1 then
				node.linkNum = node.linkNum + 1
			end
		end
	end
end

function RoomTransportQuickLinkMO:_resetNodeParam(isRmoveBuilding)
	local tRoomMapBuildingModel = RoomMapBuildingModel.instance

	for i = 1, #self._nodeList do
		local node = self._nodeList[i]

		node:resetParam()

		node.isBuilding = tRoomMapBuildingModel:isHasBuilding(node.hexPoint.x, node.hexPoint.y)

		if isRmoveBuilding then
			node.isBlock = false
		else
			node.isBlock = node.isBuilding
		end
	end
end

function RoomTransportQuickLinkMO:_findNodePathList(startNode, pathList)
	if not startNode or startNode.isBlock or startNode.searchIndex == -1 then
		return nil
	end

	if startNode.searchIndex == 0 and pathList and #pathList > 1 then
		return pathList
	end

	local nextStartNode
	local nextIndex = startNode.searchIndex - 1

	if nextIndex < 0 then
		nextIndex = 0
	end

	for i = 1, 6 do
		local dirHexPoint = HexPoint.directions[i]
		local nextNode = RoomHelper.get2KeyValue(self._nodeMap, dirHexPoint.x + startNode.hexPoint.x, dirHexPoint.y + startNode.hexPoint.y)

		if nextNode and nextNode.searchIndex == nextIndex and nextNode.isSelectPath ~= true then
			nextNode.isSelectPath = true

			if not pathList then
				startNode.isSelectPath = true
				pathList = {
					startNode
				}
			end

			nextStartNode = nextNode

			table.insert(pathList, nextNode)

			break
		end
	end

	return self:_findNodePathList(nextStartNode, pathList)
end

function RoomTransportQuickLinkMO:_clearSelectPathFlag()
	for _, node in ipairs(self._nodeList) do
		node.isSelectPath = false
	end
end

function RoomTransportQuickLinkMO:_searchNode(nodeList, searchIndex)
	if not nodeList or #nodeList < 1 or searchIndex > self._maxSearchIndex then
		return
	end

	for _, node in ipairs(nodeList) do
		if not node.isBlock and (node.searchIndex == -1 or searchIndex < node.searchIndex) then
			node.searchIndex = searchIndex
		end
	end

	local nextList
	local nextIndex = searchIndex + 1

	for _, node in ipairs(nodeList) do
		if not node.isBlock and node.searchIndex == searchIndex then
			for i = 1, 6 do
				local dirHexPoint = HexPoint.directions[i]
				local nextNode = RoomHelper.get2KeyValue(self._nodeMap, dirHexPoint.x + node.hexPoint.x, dirHexPoint.y + node.hexPoint.y)

				if nextNode and not nextNode.isBlock and (nextNode.searchIndex == -1 or nextIndex < nextNode.searchIndex) then
					nextNode.searchIndex = nextIndex
					nextList = nextList or {}

					table.insert(nextList, nextNode)
				end
			end
		end
	end

	self:_searchNode(nextList, nextIndex)
end

function RoomTransportQuickLinkMO:_popNode()
	local node
	local count = #self._nodePoolList

	if count > 0 then
		node = self._nodePoolList[count]

		table.remove(self._nodePoolList, count)
	else
		node = RoomTransportNodeMO.New()
	end

	return node
end

function RoomTransportQuickLinkMO:_pushNode(node)
	if node then
		table.insert(self._nodePoolList, node)
	end
end

function RoomTransportQuickLinkMO:getNodeList()
	return self._nodeList
end

return RoomTransportQuickLinkMO
