-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionOpenSpecifyView.lua

module("logic.extensions.guide.controller.action.GuideActionOpenSpecifyView", package.seeall)

local GuideActionOpenSpecifyView = class("GuideActionOpenSpecifyView", BaseGuideAction)

function GuideActionOpenSpecifyView:ctor(guideId, stepId, guideStepCO)
	GuideActionOpenSpecifyView.super.ctor(self, guideId, stepId, guideStepCO)

	self._viewId = tonumber(guideStepCO.guideControlParam)
	self._curOpenViewName = false
end

function GuideActionOpenSpecifyView:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onViewOpen, self)
	GuideActionOpenSpecifyView.super.onEnter(self, context)
	self:_doOpenView(self._viewId)
end

function GuideActionOpenSpecifyView:onExit()
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onViewOpen, self)
	GuideActionOpenSpecifyView.super.onExit(self)
end

function GuideActionOpenSpecifyView:_onViewOpen(evt, viewName, opType, isBackOpen)
	if self._curOpenViewName == viewName then
		self._curOpenViewName = false

		self:onDone(WorkResult.Succeed)
	end
end

function GuideActionOpenSpecifyView:_doOpenView(jumpId)
	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

	if not jumpInfo then
		if enableErrorLog then
			printError("引导步骤异常跳过，跳过原因:参数配置错误。请检查 引导ID 步骤ID 跳转ID:", self.guideId, self.stepId, jumpId)
		end

		self:onDone(WorkResult.Succeed)

		return
	end

	self._curOpenViewName = jumpInfo.viewName

	if not ViewMgr.instance:isOpen(jumpInfo.viewName) then
		ViewMgr.instance:open(self._curOpenViewName)
	end
end

return GuideActionOpenSpecifyView
