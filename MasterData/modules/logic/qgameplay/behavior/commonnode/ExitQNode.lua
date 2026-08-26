-- chunkname: @modules/logic/qgameplay/behavior/commonnode/ExitQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.ExitQNode", package.seeall)

local ExitQNode = class("ExitQNode", BehaviorQNode)

function ExitQNode:onExecute()
	self:done()
end

return ExitQNode
