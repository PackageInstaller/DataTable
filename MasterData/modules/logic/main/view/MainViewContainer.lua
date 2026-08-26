-- chunkname: @modules/logic/main/view/MainViewContainer.lua

module("modules.logic.main.view.MainViewContainer", package.seeall)

local MainViewContainer = class("MainViewContainer", BaseViewContainer)

function MainViewContainer:buildViews()
	self._mainHeroNoInteractive = MainHeroNoInteractive.New()
	self._mainHeroView = MainHeroView.New()
	self._mainActivityEnterView = MainActivityEnterView.New()

	return {
		MainView.New(),
		self._mainHeroNoInteractive,
		self._mainHeroView,
		MainHeroMipView.New(),
		self._mainActivityEnterView,
		MainActExtraDisplay.New(),
		TabViewGroup.New(1, "#go_righttop"),
		MainViewCamera.New(),
		MainActivityCenterView.New(),
		MainNoticeRequestView.New(),
		MainUIPartView.New(),
		MainEagleAnimView.New(),
		MainBirdAnimView.New()
	}
end

function MainViewContainer:getNoInteractiveComp()
	return self._mainHeroNoInteractive
end

function MainViewContainer:getMainHeroView()
	return self._mainHeroView
end

function MainViewContainer:getMainActivityEnterView()
	return self._mainActivityEnterView
end

function MainViewContainer:buildTabViews(tabContainerId)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.Diamond,
		currencyType.FreeDiamondCoupon,
		currencyType.Gold
	}

	return {
		CurrencyView.New(currencyParam)
	}
end

function MainViewContainer:onContainerOpenFinish()
	self:forceRefreshMainSceneYearAnimation()
end

function MainViewContainer:forceRefreshMainSceneYearAnimation()
	local currentSceneType = GameSceneMgr.instance:getCurSceneType()

	if currentSceneType == SceneType.Main then
		GameSceneMgr.instance:getCurScene().yearAnimation:forcePlayAni()
	end
end

function MainViewContainer:_checkSceneVisible(viewName)
	if ViewMgr.instance:isOpen(ViewName.SummonView) then
		TaskDispatcher.cancelTask(self._checkSceneVisible, self)

		return
	end

	local curScene = GameSceneMgr.instance:getCurScene()
	local curSceneRootGO = curScene and curScene:getSceneContainerGO()

	if curSceneRootGO and not curSceneRootGO.activeSelf then
		TaskDispatcher.cancelTask(self._checkSceneVisible, self)

		local names

		if self._isVisible then
			local fullViewState = GameGlobalMgr.instance:getFullViewState()

			fullViewState:forceSceneCameraActive(true)
			logError(string.format("MainViewContainer _checkSceneVisible isVisible:%s,viewName:%s,names:%s", self._isVisible, viewName, (fullViewState:getOpenFullViewNames())))
		end
	end
end

function MainViewContainer:_onCloseFullView(viewName)
	if self._isVisible then
		TaskDispatcher.cancelTask(self._checkSceneVisible, self)
		TaskDispatcher.runRepeat(self._checkSceneVisible, self, 0, 3)
		self:_checkSceneVisible(viewName)
	end
end

function MainViewContainer:onContainerOpen()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
end

function MainViewContainer:onContainerClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	TaskDispatcher.cancelTask(self._checkSceneVisible, self)
end

return MainViewContainer
