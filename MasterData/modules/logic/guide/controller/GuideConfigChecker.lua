-- chunkname: @modules/logic/guide/controller/GuideConfigChecker.lua

module("modules.logic.guide.controller.GuideConfigChecker", package.seeall)

local GuideConfigChecker = class("GuideConfigChecker")

function GuideConfigChecker:addConstEvents()
	if isDebugBuild then
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, self._onCheckForceGuideStep, self)
		GuideController.instance:registerCallback(GuideEvent.FinishStep, self._onFinishStep, self)
	end
end

function GuideConfigChecker:onInit()
	self._checkForceGuideId = nil
end

function GuideConfigChecker:reInit()
	if isDebugBuild then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouch, self)
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, self._onCheckForceGuideStep, self)
	end

	self._checkForceGuideId = nil
end

function GuideConfigChecker:_onCheckForceGuideStep(guideId, stepId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if guideId >= 600 and guideCO.parallel == 0 then
		self._checkForceGuideId = guideId

		GuideController.instance:unregisterCallback(GuideEvent.StartGuideStep, self._onCheckForceGuideStep, self)
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
		GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	end
end

function GuideConfigChecker:_onTouch()
	self._filterViews = self._filterViews or {
		ViewName.GuideView,
		ViewName.FightGuideView,
		ViewName.StoryView
	}

	for _, viewName in ipairs(self._filterViews) do
		if ViewMgr.instance:isOpen(viewName) then
			self._touchCount = 0

			break
		end
	end

	if self._touchCount then
		self._touchCount = self._touchCount + 1 or 1
	end

	if self._touchCount > 10 then
		if self._checkForceGuideId then
			local guideCO = GuideConfig.instance:getGuideCO(self._checkForceGuideId)

			logError("是否可以改成弱指引：" .. self._checkForceGuideId .. " " .. guideCO.desc)
		end

		self._checkForceGuideId = nil

		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	end
end

function GuideConfigChecker:_onFinishGuide(guideId)
	if self._checkForceGuideId == guideId then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
	end
end

function GuideConfigChecker:_onFinishStep(guideId, clientStepId)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonView) then
		return
	end

	local list = DungeonMainStoryModel.instance:getConflictGuides()

	if guideId ~= DungeonMainStoryEnum.Guide.PreviouslyOn and guideId ~= DungeonMainStoryEnum.Guide.EarlyAccess and not tabletool.indexOf(list, guideId) then
		logError(string.format("严重log,必须处理!!!请往DungeonMainStoryModel.instance:getConflictGuides()添加该指引:%s,否则会跟28005指引冲突", guideId))
	end
end

GuideConfigChecker.instance = GuideConfigChecker.New()

return GuideConfigChecker
