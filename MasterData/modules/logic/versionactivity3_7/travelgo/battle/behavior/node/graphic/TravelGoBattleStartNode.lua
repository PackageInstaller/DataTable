-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoBattleStartNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoBattleStartNode", package.seeall)

local TravelGoBattleStartNode = class("TravelGoBattleStartNode", TravelGoBehaviorNode)

function TravelGoBattleStartNode:ctor()
	TravelGoBattleStartNode.super.ctor(self)
end

function TravelGoBattleStartNode:onEnable()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnBattleStart)

	self.parallelNode = TravelGoParallelNode.New()

	self.parallelNode:complete(self.onComplete, self)
	self.parallelNode:add(TravelGoTimeNode.New({
		_time = TravelGoConst.BattleStartWaiteTime
	}))
	self.parallelNode:add(TravelGoBattleResLoadNode.New())
	self.parallelNode:enable()
end

function TravelGoBattleStartNode:onDisable()
	if self.parallelNode then
		self.parallelNode:dispose()
	end
end

function TravelGoBattleStartNode:onComplete()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnBattleStartComplete)
	self:done()
end

return TravelGoBattleStartNode
