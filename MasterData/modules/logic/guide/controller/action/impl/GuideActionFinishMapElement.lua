-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionFinishMapElement.lua

module("modules.logic.guide.controller.action.impl.GuideActionFinishMapElement", package.seeall)

local GuideActionFinishMapElement = class("GuideActionFinishMapElement", BaseGuideAction)

function GuideActionFinishMapElement:onStart(context)
	DungeonRpc.instance:sendMapElementRequest(tonumber(self.actionParam))
	self:onDone(true)
end

return GuideActionFinishMapElement
