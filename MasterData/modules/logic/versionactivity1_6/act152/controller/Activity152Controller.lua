-- chunkname: @modules/logic/versionactivity1_6/act152/controller/Activity152Controller.lua

module("modules.logic.versionactivity1_6.act152.controller.Activity152Controller", package.seeall)

local Activity152Controller = class("Activity152Controller", BaseController)

function Activity152Controller:onInit()
	return
end

function Activity152Controller:reInit()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	TaskDispatcher.cancelTask(self._checkGiftUnlock, self)
end

function Activity152Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._startCheckGiftUnlock, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
end

function Activity152Controller:_checkActivityInfo()
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		Activity152Rpc.instance:sendGet152InfoRequest(ActivityEnum.Activity.NewYearEve)
	end
end

function Activity152Controller:_onApplicationPause(isFront)
	if isFront then
		self:_startCheckGiftUnlock()
	end
end

function Activity152Controller:_startCheckGiftUnlock()
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		return
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	local unacceptPresents = Activity152Model.instance:getPresentUnaccepted()

	TaskDispatcher.cancelTask(self._checkGiftUnlock, self)

	local delay = Activity152Model.instance:getNextUnlockLimitTime() + 0.5
	local delay

	if #unacceptPresents > 0 then
		delay = 0.5
	end

	if delay > 0 then
		TaskDispatcher.runDelay(self._checkGiftUnlock, self, delay)
	end
end

function Activity152Controller:_checkGiftUnlock()
	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(Activity152PatFaceWork.New())
	self._popupFlow:registerDoneListener(self._stopShowSequence, self)
	self._popupFlow:start()
end

function Activity152Controller:_stopShowSequence()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self:_startCheckGiftUnlock()
end

function Activity152Controller:openNewYearGiftView(giftId)
	ViewMgr.instance:openView(ViewName.NewYearEveGiftView, giftId)
end

Activity152Controller.instance = Activity152Controller.New()

return Activity152Controller
