-- chunkname: @modules/logic/qgameplay/behavior/commonnode/TimeQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.TimeQNode", package.seeall)

local TimeQNode = class("TimeQNode", BehaviorQNode)

function TimeQNode:onSetData(time)
	self.behaviorTimeS = time
end

function TimeQNode:onExecute()
	self:done()
end

return TimeQNode
