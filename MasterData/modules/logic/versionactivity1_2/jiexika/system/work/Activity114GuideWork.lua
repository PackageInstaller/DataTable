-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114GuideWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114GuideWork", package.seeall)

local Activity114GuideWork = class("Activity114GuideWork", Activity114BaseWork)

function Activity114GuideWork:ctor(guideId)
	self._guideId = guideId

	Activity114GuideWork.super.ctor(self)
end

function Activity114GuideWork:onStart()
	local guideMO = GuideModel.instance:getById(self._guideId)

	if guideMO and guideMO.isFinish or not guideMO then
		if not guideMO then
			logError("指引没有自动接？？？")
		end

		self:onDone(false)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(self._guideId))
end

function Activity114GuideWork:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)

	if Activity114Model.instance:isEnd() then
		self:onDone(false)

		return
	end

	self:onDone(true)
end

function Activity114GuideWork:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	Activity114GuideWork.super.clearWork(self)
end

return Activity114GuideWork
