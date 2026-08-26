-- chunkname: @modules/logic/qgameplay/behavior/commonnode/SequenceQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.SequenceQNode", package.seeall)

local SequenceQNode = class("SequenceQNode", ContainerQNode)

function SequenceQNode:onExecute()
	if #self.nodes > 0 then
		self.nodes[1]:execute()
	else
		self:done()
	end
end

function SequenceQNode:addNode(node)
	node.isManageGoToNext = true

	local preNode = self.nodes[#self.nodes]

	if preNode then
		preNode:next(node)
	end

	SequenceQNode.super.addNode(self, node)

	node.index = #self.nodes
end

function SequenceQNode:onNodeExecuteEnd(success, node)
	SequenceQNode.super.onNodeExecuteEnd(self, success, node)

	if not success then
		self:done(false)

		return
	end

	if node.index == #self.nodes then
		self:done()
	else
		node:goToNext()
	end
end

return SequenceQNode
