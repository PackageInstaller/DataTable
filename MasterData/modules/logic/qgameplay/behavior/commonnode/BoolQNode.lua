-- chunkname: @modules/logic/qgameplay/behavior/commonnode/BoolQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.BoolQNode", package.seeall)

local BoolQNode = class("BoolQNode", BehaviorQNode)

function BoolQNode:onSetData(true_nodes, false_nodes)
	self.true_nodes = true_nodes
	self.false_nodes = false_nodes
end

function BoolQNode:onExecute()
	self.nextNodes = self:isTrue() and self.true_nodes or self.false_nodes

	self:done()
end

function BoolQNode:isTrue()
	return
end

return BoolQNode
