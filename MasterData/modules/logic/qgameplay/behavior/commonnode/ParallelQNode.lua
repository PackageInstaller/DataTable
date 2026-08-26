-- chunkname: @modules/logic/qgameplay/behavior/commonnode/ParallelQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.ParallelQNode", package.seeall)

local ParallelQNode = class("ParallelQNode", ContainerQNode)

function ParallelQNode:onExecute()
	if #self.nodes > 0 then
		for i, v in ipairs(self.nodes) do
			v:execute()
		end
	else
		self:done()
	end
end

function ParallelQNode:onNodeExecuteEnd(success, node)
	ParallelQNode.super.onNodeExecuteEnd(self, success, node)

	if #self.completedNodes == #self.nodes then
		self:done()
	end
end

return ParallelQNode
