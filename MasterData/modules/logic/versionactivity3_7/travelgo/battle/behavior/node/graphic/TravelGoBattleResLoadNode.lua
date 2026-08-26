-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoBattleResLoadNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoBattleResLoadNode", package.seeall)

local TravelGoBattleResLoadNode = class("TravelGoBattleResLoadNode", TravelGoBehaviorNode)

function TravelGoBattleResLoadNode:ctor()
	TravelGoBattleResLoadNode.super.ctor(self)
end

function TravelGoBattleResLoadNode:onEnable()
	local resLoader = TravelGoController.instance.travelGoBattleMgr:loadRes()

	if resLoader then
		resLoader:startLoad(self.onComplete, self)
	else
		self:done()
	end
end

function TravelGoBattleResLoadNode:onDisable()
	return
end

function TravelGoBattleResLoadNode:onComplete()
	self:done()
end

return TravelGoBattleResLoadNode
