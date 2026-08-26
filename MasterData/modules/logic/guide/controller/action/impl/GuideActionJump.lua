-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionJump.lua

module("modules.logic.guide.controller.action.impl.GuideActionJump", package.seeall)

local GuideActionJump = class("GuideActionJump", BaseGuideAction)

function GuideActionJump:onStart(context)
	GuideActionJump.super.onStart(self, context)

	local jumpParam = self.actionParam

	JumpController.instance:jumpByParam(jumpParam)
	self:onDone(true)
end

return GuideActionJump
