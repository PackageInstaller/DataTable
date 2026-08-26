-- chunkname: @modules/logic/qgameplay/behavior/commonnode/ContainerQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.ContainerQNode", package.seeall)

local ContainerQNode = class("ContainerQNode", BehaviorQNode)

function ContainerQNode:onAwake()
	self.nodes = {}
end

function ContainerQNode:onEnable()
	ContainerQNode.super.onEnable(self)

	self.runningNodes = {}
	self.completedNodes = {}
end

function ContainerQNode:addNode(node)
	self:addComponentByObject(node)
	table.insert(self.nodes, node)
	node:addListenExecute(self.onNodeExecute, self)
	node:addListenExecuteEnd(self.onNodeExecuteEnd, self)
end

function ContainerQNode:execute()
	tabletool.clear(self.runningNodes)
	tabletool.clear(self.completedNodes)
	ContainerQNode.super.execute(self)
end

function ContainerQNode:endExecute()
	ContainerQNode.super.endExecute(self)

	for i, v in ipairs(self.runningNodes) do
		v:endExecute()
	end
end

function ContainerQNode:onNodeExecute(node)
	table.insert(self.runningNodes, node)
end

function ContainerQNode:onNodeExecuteEnd(success, node)
	for i, v in ipairs(self.runningNodes) do
		if v == node then
			table.remove(self.runningNodes, i)

			break
		end
	end

	table.insert(self.completedNodes, node)
end

function ContainerQNode:onDispose()
	tabletool.clear(self.nodes)
end

return ContainerQNode
