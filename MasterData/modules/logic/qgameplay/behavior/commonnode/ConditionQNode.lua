-- chunkname: @modules/logic/qgameplay/behavior/commonnode/ConditionQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.ConditionQNode", package.seeall)

local ConditionQNode = class("ConditionQNode", BehaviorQNode)

function ConditionQNode:onSetData()
	return
end

function ConditionQNode:onExecute()
	local success = self:isSatisfy()

	self:done(success)
end

function ConditionQNode:isSatisfy()
	return
end

return ConditionQNode
