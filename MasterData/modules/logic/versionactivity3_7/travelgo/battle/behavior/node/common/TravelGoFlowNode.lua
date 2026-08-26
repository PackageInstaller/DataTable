-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoFlowNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoFlowNode", package.seeall)

local TravelGoFlowNode = class("TravelGoFlowNode", TravelGoBehaviorNode)

function TravelGoFlowNode:ctor(data)
	TravelGoFlowNode.super.ctor(self, data)

	self.nodes = {}
end

function TravelGoFlowNode:onEnable()
	if #self.nodes > 0 then
		self.nodes[#self.nodes]:complete(self.onFinish, self)
		self.nodes[1]:enable()
	else
		self:done()
	end
end

function TravelGoFlowNode:onDisable()
	for i, v in ipairs(self.nodes) do
		v:disable()
	end
end

function TravelGoFlowNode:onFinish()
	self:done()
end

function TravelGoFlowNode:setInterruptFunc(func, context)
	self.interruptFunc = func
	self.interruptFuncContext = context
end

function TravelGoFlowNode:add(node)
	local beforeNode = self.nodes[#self.nodes]

	if beforeNode then
		beforeNode:next(node)
		beforeNode:setInterruptFunc(self.interruptFunc, self.interruptFuncContext)
	end

	table.insert(self.nodes, node)
end

function TravelGoFlowNode:onDispose()
	for i, v in ipairs(self.nodes) do
		v:dispose()
	end

	tabletool.clear(self.nodes)
end

return TravelGoFlowNode
