-- chunkname: @modules/logic/room/model/map/path/RoomMapPathNodeMO.lua

module("modules.logic.room.model.map.path.RoomMapPathNodeMO", package.seeall)

local RoomMapPathNodeMO = pureTable("RoomMapPathNodeMO")

function RoomMapPathNodeMO:init(id, hexPoint, resId)
	self.id = id
	self.hexPoint = hexPoint
	self.resourceId = resId
	self.resId = resId
	self.directionDic = {}
	self.connectNode = {}
	self.directionList = {}
	self.neighborNum = 0
	self.connectNodeNum = 0
	self.searchIndex = 0
	self.hasBuilding = false
end

function RoomMapPathNodeMO:addDirection(direction)
	self.directionDic[direction] = true

	if direction >= 1 and direction <= 6 and not tabletool.indexOf(self.directionList) then
		table.insert(self.directionList, direction)
	end
end

function RoomMapPathNodeMO:getConnectDirection(direction)
	return (direction + 3 - 1) % 6 + 1
end

function RoomMapPathNodeMO:isHasDirection(direction)
	return self.directionDic[direction] ~= nil
end

function RoomMapPathNodeMO:setConnctNode(direction, node)
	if self.directionDic[direction] ~= nil then
		self.connectNode[direction] = node
	end
end

function RoomMapPathNodeMO:getConnctNode(direction)
	return self.connectNode[direction]
end

function RoomMapPathNodeMO:getDirectionNum()
	return #self.directionList
end

function RoomMapPathNodeMO:isEndNode()
	return self.connectNodeNum <= 1
end

function RoomMapPathNodeMO:isNotConnctDirection()
	return #self.directionList > self.connectNodeNum
end

function RoomMapPathNodeMO:isSideNode()
	return self.neighborNum <= 6
end

return RoomMapPathNodeMO
