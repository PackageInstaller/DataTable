-- chunkname: @modules/logic/summon/view/SummonMainViewContainer.lua

module("modules.logic.summon.view.SummonMainViewContainer", package.seeall)

local SummonMainViewContainer = class("SummonMainViewContainer", BaseViewContainer)

function SummonMainViewContainer:buildViews()
	local views = {}

	self.centerTabContent = SummonMainPreloadView.New(3, "#go_ui/contentView")

	self.centerTabContent:preloadTab(self:getPreloadTabs())
	table.insert(views, self.centerTabContent)
	table.insert(views, TabViewGroup.New(1, "#go_ui/#go_lefttop"))
	table.insert(views, TabViewGroup.New(2, "#go_ui/#go_righttop"))

	self._mainView = SummonMainView.New()

	table.insert(views, self._mainView)
	table.insert(views, SummonMainTabView.New())
	SummonMainCategoryListModel.instance:saveEnterTime()

	SummonMainViewContainer.BlockCloseKey = "SummonCloseAnim"

	return views
end

function SummonMainViewContainer:getPreloadTabs()
	local tabIdSet = {}
	local result = {}
	local validPools = SummonMainModel.getValidPools()
	local curId = SummonMainModel.instance:getCurId()
	local curPoolIdIndex = 1

	for _, poolCfg in ipairs(validPools) do
		local tabIndex = SummonMainModel.instance:getADPageTabIndexForUI(poolCfg)

		if poolCfg.id ~= curId then
			tabIdSet[tabIndex] = true
		else
			table.insert(result, tabIndex)

			curPoolIdIndex = tabIndex
		end
	end

	for k, _ in pairs(tabIdSet) do
		if k ~= curPoolIdIndex then
			table.insert(result, k)
		end
	end

	return result
end

function SummonMainViewContainer:preloadUIRes()
	if not self._uiLoader then
		local resList = SummonMainController.instance:pickAllUIPreloadRes()

		self._uiLoader = MultiAbLoader.New()

		self._uiLoader:setPathList(resList)
		self._uiLoader:startLoad(self.disposeUILoader, self)
	end
end

function SummonMainViewContainer:disposeUILoader()
	if self._uiLoader ~= nil then
		logNormal("disposeUILoader")
		self._uiLoader:dispose()

		self._uiLoader = nil
	end
end

function SummonMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setCloseCheck(self._closeCheckFunc, self)
		self._navigateButtonView:setHomeCheck(self._closeCheckFunc, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return self:_buildCurrency()
	elseif tabContainerId == 3 then
		self._tabInsts = SummonMainModel.instance:createUIClassTab()

		return self._tabInsts
	elseif tabContainerId == 4 then
		return {}
	end
end

function SummonMainViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(0)

	if self.centerTabContent then
		self.centerTabContent:checkPreload()
	end

	self:preloadUIRes()
end

function SummonMainViewContainer:hideHomeButton()
	if self._navigateButtonView then
		self._navigateButtonView:setParam({
			true,
			false,
			false
		})
	end
end

function SummonMainViewContainer:refreshHelp()
	if self._navigateButtonView then
		self._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end
end

function SummonMainViewContainer:_buildCurrency()
	self._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		{
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = SummonMainModel.jumpToSummonCostShop
		}
	}, nil, nil, nil, true)

	return {
		self._currencyView
	}
end

function SummonMainViewContainer:refreshCurrencyType()
	if self._currencyView then
		local pool = SummonMainModel.instance:getCurPool()

		if pool then
			self._currencyView:setCurrencyType(SummonMainModel.getCostCurrencyParam(pool))
		end
	end
end

function SummonMainViewContainer:_closeCheckFunc()
	logNormal("_closeCheckFunc")

	local delayTime = self._mainView:startExitSummonFadeOut()

	TaskDispatcher.runDelay(self._onAnimExit, self, delayTime)
	self:_onBlackLoadingShow()

	return false
end

function SummonMainViewContainer:getCurTabInst()
	local tabIndex = SummonMainModel.instance:getCurADPageIndex()

	if tabIndex then
		return self._tabInsts[tabIndex]
	end

	return nil
end

function SummonMainViewContainer:_onBlackLoadingShow()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onMainUILoaded, self)
		MainController.instance:enterMainScene(true)
	else
		self._isSceneExitFinish = true
	end

	VirtualSummonScene.instance:close(true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(SummonMainViewContainer.BlockCloseKey)
end

function SummonMainViewContainer:_onMainUILoaded(viewName)
	if viewName == ViewName.MainView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onMainUILoaded, self)

		self._isSceneExitFinish = true

		logNormal("_onMainSceneLoaded ViewName : " .. tostring(viewName))
		self:_checkAllStepFinish()
	end
end

function SummonMainViewContainer:_onAnimExit()
	self._isAnimExitFinish = true

	self:_checkAllStepFinish()
end

function SummonMainViewContainer:_checkAllStepFinish()
	if self._isSceneExitFinish and self._isAnimExitFinish then
		self:reallyClose()
	end
end

function SummonMainViewContainer:reallyClose()
	UIBlockMgr.instance:endBlock(SummonMainViewContainer.BlockCloseKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:closeThis()
end

function SummonMainViewContainer:onContainerClose()
	self:disposeUILoader()
end

return SummonMainViewContainer
