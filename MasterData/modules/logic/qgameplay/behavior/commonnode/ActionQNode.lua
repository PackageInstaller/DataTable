-- chunkname: @modules/logic/qgameplay/behavior/commonnode/ActionQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.ActionQNode", package.seeall)

local ActionQNode = class("ActionQNode", BehaviorQNode)

function ActionQNode:onSetData(context, func, param, behaviorTimeS)
	self.context = context
	self.func = func
	self.param = param
	self.behaviorTimeS = behaviorTimeS
end

function ActionQNode:onExecute()
	self:onExecuteAction()
end

function ActionQNode:onExecuteAction()
	local success

	self:done((self.func or nil) and self.func(self.context, self.param))
end

return ActionQNode
