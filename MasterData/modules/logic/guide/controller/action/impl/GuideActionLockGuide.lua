-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionLockGuide.lua

module("modules.logic.guide.controller.action.impl.GuideActionLockGuide", package.seeall)

local GuideActionLockGuide = class("GuideActionLockGuide", BaseGuideAction)

function GuideActionLockGuide:onStart(context)
	GuideActionLockGuide.super.onStart(self, context)

	local param = string.splitToNumber(self.actionParam, "#")
	local cancel = param[1] == 0
	local force = param[2] == 1

	if not cancel then
		GuideModel.instance:setLockGuide(self.guideId, force)
	else
		GuideModel.instance:setLockGuide(nil, force)
	end

	self:onDone(true)
end

return GuideActionLockGuide
