-- chunkname: @modules/logic/main/controller/work/MainGuideWork.lua

module("modules.logic.main.controller.work.MainGuideWork", package.seeall)

local MainGuideWork = class("MainGuideWork", BaseWork)

function MainGuideWork:onStart(context)
	GuideModel.instance:onOpenMainView()

	local forbidGuides = GuideController.instance:isForbidGuides()

	if forbidGuides then
		if isDebugBuild then
			local guideId = self:_getDoingGuideId()

			if guideId then
				logError("登录主界面，屏蔽了强指引：" .. guideId)
			end
		end

		self:onDone(true)

		return
	end

	if self:_getDoingGuideId() then
		self:_checkInvalid()
	elseif GuideTriggerController.instance:hasSatisfyGuide() then
		GuideController.instance:registerCallback(GuideEvent.StartGuide, self._checkInvalid, self)
	else
		self:_checkInvalid()
	end

	GuideTriggerController.instance:startTrigger()
end

function MainGuideWork:_checkInvalid()
	if GuideInvalidController.instance:hasInvalidGuide() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._checkDoGuide, self)
		GuideController.instance:registerCallback(GuideEvent.FinishGuideFail, self._exceptionDone, self)
		GuideInvalidController.instance:checkInvalid()
	else
		self:_checkDoGuide()
	end
end

function MainGuideWork:_exceptionDone()
	logNormal("完成指引出异常，跳过")
	self:onDone(true)
end

function MainGuideWork:_checkDoGuide()
	local doingGuideIds = GuideModel.instance:getDoingGuideIdList()

	if doingGuideIds then
		for i = #doingGuideIds, 1, -1 do
			local guideCO = GuideConfig.instance:getGuideCO(doingGuideIds[i])

			if guideCO.parallel == 1 then
				GuideController.instance:execNextStep(doingGuideIds[i])
				table.remove(doingGuideIds, i)
			end
		end

		local highestGuideId = GuideConfig.instance:getHighestPriorityGuideId(doingGuideIds)

		if highestGuideId then
			GuideController.instance:execNextStep(highestGuideId)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			BGMSwitchController.instance:startAllOnLogin()
			self:onDone(false)

			return
		end
	end

	self:onDone(true)
end

function MainGuideWork:_getDoingGuideId()
	local doingGuideIds = GuideModel.instance:getDoingGuideIdList()

	if doingGuideIds then
		for i = #doingGuideIds, 1, -1 do
			local guideCO = GuideConfig.instance:getGuideCO(doingGuideIds[i])

			if guideCO.parallel == 1 then
				table.remove(doingGuideIds, i)
			end
		end

		return (GuideConfig.instance:getHighestPriorityGuideId(doingGuideIds))
	end
end

function MainGuideWork:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, self._checkInvalid, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._checkDoGuide, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, self._exceptionDone, self)
end

return MainGuideWork
