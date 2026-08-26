-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerOpenView.lua

module("modules.logic.guide.controller.trigger.GuideTriggerOpenView", package.seeall)

local GuideTriggerOpenView = class("GuideTriggerOpenView", BaseGuideTrigger)

function GuideTriggerOpenView:ctor(triggerKey)
	GuideTriggerOpenView.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function GuideTriggerOpenView:assertGuideSatisfy(param, configParam)
	return param == configParam
end

function GuideTriggerOpenView:_onOpenView(viewName, viewParam)
	self:checkStartGuide(viewName)
end

return GuideTriggerOpenView
