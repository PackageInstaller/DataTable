-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoTimeNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoTimeNode", package.seeall)

local TravelGoTimeNode = class("TravelGoTimeNode", TravelGoBehaviorNode)

function TravelGoTimeNode:onEnable()
	self:done()
end

return TravelGoTimeNode
