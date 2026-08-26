-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoParallelNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoParallelNode", package.seeall)

local TravelGoParallelNode = class("TravelGoParallelNode", TravelGoBehaviorNode)

function TravelGoParallelNode:ctor(data)
	TravelGoParallelNode.super.ctor(self, data)

	self.nodes = {}
	self.completeNum = 0
end

function TravelGoParallelNode:onEnable()
	if #self.nodes > 0 then
		for i, v in ipairs(self.nodes) do
			v:enable()
		end
	else
		self:done()
	end
end

function TravelGoParallelNode:onDisable()
	for i, v in ipairs(self.nodes) do
		v:disable()
	end
end

function TravelGoParallelNode:add(node)
	table.insert(self.nodes, node)
	node:complete(self.onNodeCompete, self)
end

function TravelGoParallelNode:onNodeCompete()
	self.completeNum = self.completeNum + 1

	if self.completeNum == #self.nodes then
		self:done()
	end
end

function TravelGoParallelNode:onDispose()
	for i, v in ipairs(self.nodes) do
		v:dispose()
	end

	tabletool.clear(self.nodes)

	self.completeNum = 0
end

return TravelGoParallelNode
