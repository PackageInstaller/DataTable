-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEmptyStep.lua

module("modules.logic.guide.controller.action.impl.GuideActionEmptyStep", package.seeall)

local GuideActionEmptyStep = class("GuideActionEmptyStep", BaseGuideAction)

function GuideActionEmptyStep:onStart(context)
	GuideActionEmptyStep.super.onStart(self, context)
	self:onDone(true)
end

return GuideActionEmptyStep
