-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionOpenMaskHole.lua

module("modules.logic.guide.controller.action.impl.GuideActionOpenMaskHole", package.seeall)

local GuideActionOpenMaskHole = class("GuideActionOpenMaskHole", BaseGuideAction)

function GuideActionOpenMaskHole:onStart(context)
	GuideActionOpenMaskHole.super.onStart(self, context)
	GuideViewMgr.instance:open(self.guideId, self.stepId)
	self:onDone(true)
end

function GuideActionOpenMaskHole:onDestroy()
	GuideActionOpenMaskHole.super.onDestroy(self)
	GuideViewMgr.instance:close()
end

return GuideActionOpenMaskHole
