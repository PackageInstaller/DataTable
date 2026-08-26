-- chunkname: @modules/logic/main/controller/MainController.lua

module("modules.logic.main.controller.MainController", package.seeall)

local MainController = class("MainController", BaseController)

function MainController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, self._onLoginEnterMainScene, self)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onActivityUpdate, self)
	MainController.instance:registerCallback(MainEvent.ManuallyOpenMainView, self._onManuallyOpenMainView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function MainController:onInit()
	self.firstEnterMainScene = true
	self._inPopupFlow = false
	self._needOpenMainView = false
end

function MainController:reInit()
	self:_destroyPopupFlow()

	self.firstEnterMainScene = true
	self._inPopupFlow = false
	self._needOpenMainView = false
end

function MainController:_startPopupFlow()
	self:_destroyPopupFlow()

	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(MainGuideWork.New())
	self._popupFlow:addWork(MainLimitedRoleEffect.New())
	self._popupFlow:addWork(FunctionWork.New(function()
		BGMSwitchController.instance:startAllOnLogin()
	end))
	self._popupFlow:addWork(MainAchievementToast.New())
	self._popupFlow:addWork(MainThumbnailWork.New())
	self._popupFlow:addWork(MainMailWork.New())
	self._popupFlow:addWork(MainUseExpireItemWork.New())
	self._popupFlow:addWork(MainSignInWork.New())
	self._popupFlow:addWork(MainFightReconnectWork.New())
	self._popupFlow:addWork(MainPatFaceWork.New())
	self._popupFlow:addWork(MainParallelGuideWork.New())
	self._popupFlow:addWork(AutoOpenNoticeWork.New())
	self._popupFlow:registerDoneListener(self._onPopupFlowDone, self)
	self._popupFlow:start({})

	self._inPopupFlow = true
end

function MainController:_destroyPopupFlow()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
		self._inPopupFlow = false
	end
end

function MainController:_onLoginEnterMainScene()
	MainController.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	EyeProtectionModeMgr.instance:active()
	self:_startPopupFlow()
end

function MainController:_onDailyRefresh()
	self:_onCheckAutoPop(true)
end

function MainController:_onActivityUpdate()
	self:_onCheckAutoPop(false)
end

function MainController:_onCheckAutoPop(isDailyRefresh)
	self._isDailyRefresh = isDailyRefresh

	if self._inPopupFlow then
		self.registerCallback(self, MainEvent.OnMainPopupFlowFinish, self._onCheckFlowDone, self)

		return
	end

	self:_setDailyRefreshPopUp()
end

function MainController:_onCheckFlowDone()
	self.unregisterCallback(self, MainEvent.OnMainPopupFlowFinish, self._onCheckFlowDone, self)
	self:_setDailyRefreshPopUp()
end

function MainController:_setDailyRefreshPopUp()
	self:_destroyPopupFlow()

	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(MainSignInWork.New())

	if self._isDailyRefresh then
		self._popupFlow:addWork(MainPatFaceWork.New())
	else
		self._popupFlow:addWork(Activity152PatFaceWork.New())
	end

	self._popupFlow:registerDoneListener(self._onPopupFlowDailyDone, self)

	self._inPopupFlow = true

	self._popupFlow:start({
		dailyRefresh = self._isDailyRefresh
	})
end

function MainController:_onPopupFlowDailyDone()
	self._inPopupFlow = false

	MainController.instance:dispatchEvent(MainEvent.OnDailyPopupFlowFinish)
end

function MainController:_onPopupFlowDone(isSuccess)
	self._inPopupFlow = false

	MainController.instance:dispatchEvent(MainEvent.OnMainPopupFlowFinish)
end

function MainController:enterMainScene(forceStarting, forceSceneType)
	GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Main, 101, forceStarting, forceSceneType)
end

function MainController:openMainThumbnailView(param, isImmediate)
	MainController.instance:dispatchEvent(MainEvent.OnClickSwitchRole)
	ViewMgr.instance:openView(ViewName.MainThumbnailView, param, isImmediate)
end

function MainController:setRequestNoticeTime()
	self.requestTime = Time.realtimeSinceStartup
end

function MainController:getLastRequestNoticeTime()
	return self.requestTime
end

function MainController:isInMainView()
	local openViews = ViewMgr.instance:getOpenViewNameList()
	local openFullView = {}

	for _, v in ipairs(openViews) do
		local setting = ViewMgr.instance:getSetting(v)

		if setting.layer ~= UILayerName.Message and setting.layer ~= UILayerName.IDCanvasPopUp then
			table.insert(openFullView, v)
		end
	end

	return (#openFullView > 1 or openFullView[1] ~= ViewName.MainView or nil) and false
end

function MainController:isInPopupFlow()
	return self._inPopupFlow
end

function MainController:clearOpenMainViewFlag()
	self._needOpenMainView = false
end

function MainController:_onManuallyOpenMainView()
	self._needOpenMainView = true

	self:_checkOpenMainView()
end

function MainController:_checkOpenMainView()
	if not self._needOpenMainView or ViewMgr.instance:hasOpenFullView() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoreView) then
		return
	end

	self._needOpenMainView = false

	if ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	ViewMgr.instance:openView(ViewName.MainView)
end

function MainController:_onCloseView()
	self:_checkOpenMainView()
end

function MainController:_onCloseViewFinish()
	self:_checkOpenMainView()
end

MainController.instance = MainController.New()

return MainController
