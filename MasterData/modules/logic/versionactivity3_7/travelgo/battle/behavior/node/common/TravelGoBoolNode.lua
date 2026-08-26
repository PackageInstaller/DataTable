-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoBoolNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoBoolNode", package.seeall)

local TravelGoBoolNode = class("TravelGoBoolNode", TravelGoBehaviorNode)

function TravelGoBoolNode:setBranch(true_nodes, false_nodes)
	self.true_nodes = true_nodes
	self.false_nodes = false_nodes
end

function TravelGoBoolNode:setBranchTrue(nodes)
	self.true_nodes = nodes
end

function TravelGoBoolNode:setBranchFalse(nodes)
	self.false_nodes = nodes
end

function TravelGoBoolNode:onDone()
	self.nextNodes = self:isTrue() and self.true_nodes or self.false_nodes

	TravelGoBoolNode.super.onDone(self)
end

function TravelGoBoolNode:isTrue()
	return
end

return TravelGoBoolNode
