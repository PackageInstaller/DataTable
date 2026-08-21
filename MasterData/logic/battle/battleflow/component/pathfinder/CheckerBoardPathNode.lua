-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/pathfinder/CheckerBoardPathNode.lua

module("logic.battle.battleflow.component.pathfinder.CheckerBoardPathNode", package.seeall)

local CheckerBoardPathNode = class("CheckerBoardPathNode")

function CheckerBoardPathNode:ctor(cellMO)
	self._cellMO = cellMO
	self._neighbors = {}
	self._nodeCanAttackSelf = {}

	self:resetAllState()
end

function CheckerBoardPathNode:resetAllState()
	self.isEnable = false
	self.isClosed = false
	self.fromNode = false
	self.prettyFromNode = false
	self.consume = false
	self.remain = 0
	self.distance = 0
	self.fromDistance = 0
	self.priority = 0
	self.isWalkable = false
	self.isAttackable = false
	self.isStopable = false
	self.isTransportable = false
	self.isTransportableArea = false
	self.isSkillArea = false
	self.isCanAttackTarget = false
	self.isBestCanAttackTarget = false
	self.isStopableEdge = false
	self.isSelectable = false

	BattleTableUtil.clearTable(self._nodeCanAttackSelf)
end

function CheckerBoardPathNode:resetForSignTransportable()
	local cellMO = self:getCellMO()

	self.isEnable = cellMO:isEnable()
	self.isTransportable = false
	self.isTransportableArea = false
	self.isClosed = false
	self.consume = 1
	self.remain = 0
	self.fromNode = false
end

function CheckerBoardPathNode:resetForSignAttackable()
	local cellMO = self:getCellMO()

	self.isEnable = cellMO:isEnable()
	self.isAttackable = false
	self.isClosed = false
	self.consume = 1
	self.remain = 0
	self.fromNode = false
end

function CheckerBoardPathNode:resetForPrettyPath()
	self.isEnable = self.isWalkable
	self.isClosed = false
	self.prettyFromNode = false
	self.distance = 0
	self.fromDistance = 0
	self.priority = 0
end

function CheckerBoardPathNode:resetForSignSkillRange()
	self.isEnable = true
	self.isClosed = false
	self.isSkillArea = false
	self.fromNode = false
	self.consume = 1
	self.remain = 0
	self.distance = 0
	self.fromDistance = 0
end

function CheckerBoardPathNode:resetForSignSelectable()
	self.isSelectable = false
end

function CheckerBoardPathNode:resetForCanAttackTarget()
	local cellMO = self:getCellMO()

	self.isEnable = cellMO:isEnable()
	self.isClosed = false
	self.consume = 1
	self.remain = 0
	self.fromNode = false
	self.isCanAttackTarget = false
	self.isBestCanAttackTarget = false
end

function CheckerBoardPathNode:resetForFindNearestAttackUnionIndex()
	self.isEnable = self.isWalkable
	self.isClosed = false
	self.fromNode = false
	self.distance = 0
	self.fromDistance = 0
end

function CheckerBoardPathNode:resetForFindPath()
	self.isEnable = self.isWalkable
	self.isClosed = false
	self.fromNode = false
	self.distance = 0
	self.fromDistance = 0
end

function CheckerBoardPathNode:calculateDistance(toX, toZ)
	local x, z = self:getCoordinates()
	local wx = math.abs(toX - x)
	local wz = math.abs(toZ - z)

	if wx ~= 0 then
		wx = wx + 0.5
	end

	if wz ~= 0 then
		wz = wz + 0.5
	end

	self.distance = wx + wz
end

function CheckerBoardPathNode:calculateManhattanDistance(toX, toZ)
	local x, z = self:getCoordinates()

	self.distance = math.abs(x - toX) + math.abs(z - toZ)
end

function CheckerBoardPathNode:calculateDistanceToFrom(fromX, fromZ)
	local x, z = self:getCoordinates()

	self.fromDistance = math.abs(x - fromX) + math.abs(z - fromZ)
end

function CheckerBoardPathNode:getNeighbors()
	return self._neighbors
end

function CheckerBoardPathNode:getCoordinates()
	return self._cellMO:getCoordinates()
end

function CheckerBoardPathNode:getUnionIndex()
	return BoardIndexConverter.coordinatesToUnionIndex(self:getCoordinates())
end

function CheckerBoardPathNode:getCellMO()
	return self._cellMO
end

function CheckerBoardPathNode:addNeighbor(neighborNode)
	table.insert(self._neighbors, neighborNode)
end

return CheckerBoardPathNode
