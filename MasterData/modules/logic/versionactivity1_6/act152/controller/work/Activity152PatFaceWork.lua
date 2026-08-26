-- chunkname: @modules/logic/versionactivity1_6/act152/controller/work/Activity152PatFaceWork.lua

module("modules.logic.versionactivity1_6.act152.controller.work.Activity152PatFaceWork", package.seeall)

local Activity152PatFaceWork = class("Activity152PatFaceWork", PatFaceWorkBase)

function Activity152PatFaceWork:onStart(context)
	if self:_needWaitShow() then
		self:_startCheckShow()

		return
	end

	self:_startPatFaceWork()
end

function Activity152PatFaceWork:_needWaitShow()
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	local isInMainView = MainController.instance:isInMainView()

	return not isInMainView
end

function Activity152PatFaceWork:_startCheckShow()
	TaskDispatcher.runRepeat(self._startPatFaceWork, self, 0.5)
end

function Activity152PatFaceWork:_startPatFaceWork()
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		self:onDone(true)

		return
	end

	if self:_needWaitShow() then
		return
	end

	TaskDispatcher.cancelTask(self._startPatFaceWork, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkRewardGet, self)

	local unacceptPresents = Activity152Model.instance:getPresentUnaccepted()

	if #unacceptPresents > 0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onGetGift, self)
		Activity152Controller.instance:openNewYearGiftView(unacceptPresents[1])
	else
		self:onDone(true)
	end
end

function Activity152PatFaceWork:_onGetGift(viewName)
	if viewName ~= ViewName.NewYearEveGiftView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onGetGift, self)

	local activityId = ActivityEnum.Activity.NewYearEve
	local unacceptPresents = Activity152Model.instance:getPresentUnaccepted()

	Activity152Rpc.instance:sendAct152AcceptPresentRequest(activityId, unacceptPresents[1], self._enterNext, self)
end

function Activity152PatFaceWork:_enterNext(cmd, resultcode, msg)
	if resultcode ~= 0 then
		self:onDone(true)

		return
	end

	Activity152Model.instance:setActivity152PresentGet(msg.present.presentId)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkRewardGet, self)
end

function Activity152PatFaceWork:_checkRewardGet(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkRewardGet, self)
	self:_startCheckShow()
end

function Activity152PatFaceWork:clearWork()
	TaskDispatcher.cancelTask(self._startPatFaceWork, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkRewardGet, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onGetGift, self)
end

return Activity152PatFaceWork
