-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoActionNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoActionNode", package.seeall)

local TravelGoActionNode = class("TravelGoActionNode", TravelGoBehaviorNode)

function TravelGoActionNode:onSetData(data)
	self.func = data.func
	self.context = data.context
	self.param = data.param
end

function TravelGoActionNode:onEnable()
	if self.func then
		self.func(self.context, self.param)
	end

	self:done()
end

return TravelGoActionNode
