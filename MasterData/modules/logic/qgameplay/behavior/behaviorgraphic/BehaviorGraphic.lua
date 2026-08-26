-- chunkname: @modules/logic/qgameplay/behavior/behaviorgraphic/BehaviorGraphic.lua

module("modules.logic.qgameplay.behavior.behaviorgraphic.BehaviorGraphic", package.seeall)

local BehaviorGraphic = class("BehaviorGraphic", ContainerQNode)

function BehaviorGraphic:onSetData()
	self.startNodes = {}

	self:onCreateNode()
end

function BehaviorGraphic:onCreateNode()
	return
end

function BehaviorGraphic:onExecute()
	for i, v in ipairs(self.startNodes) do
		v:execute()
	end
end

function BehaviorGraphic:addNode(node, isStartNode)
	BehaviorGraphic.super.addNode(self, node)

	if isStartNode then
		table.insert(self.startNodes, node)
	end
end

function BehaviorGraphic:onNodeExecuteEnd(success, node)
	BehaviorGraphic.super.onNodeExecuteEnd(self, success, node)

	if isTypeOf(node, ExitQNode) then
		self:done()
	end
end

return BehaviorGraphic
