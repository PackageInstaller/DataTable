-- chunkname: @modules/logic/room/view/manufacture/RoomCritterBuildingViewContainer.lua

module("modules.logic.room.view.manufacture.RoomCritterBuildingViewContainer", package.seeall)

local RoomCritterBuildingViewContainer = class("RoomCritterBuildingViewContainer", BaseViewContainer)
local TabGroup = {
	Navigate = 1,
	SubView = 2,
	Currency = 3
}

RoomCritterBuildingViewContainer.SubViewTabId = {
	Summon = 3,
	Rest = 1,
	Training = 2,
	Incubate = 4
}
RoomCritterBuildingViewContainer.TabSettingList = {
	{
		isPlayAnim = true,
		name = "room_critter_building_rest",
		icon = "critter_summon_icon_1",
		currency = {}
	},
	{
		isPlayAnim = true,
		name = "room_critter_building_training",
		icon = "critter_summon_icon_3",
		currency = {}
	},
	{
		icon = "critter_summon_icon_2",
		name = "room_critter_building_incubate",
		isPlayAnim = true,
		currency = CritterSummonModel.instance:getCostCurrency(),
		needHideCurrencyBtn = CritterSummonModel.instance:getCostCurrency(),
		helpBtnCallBack = function()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Summon)
		end
	},
	{
		icon = "critter_summon_icon_4",
		name = "room_critter_building_breed",
		isPlayAnim = true,
		currency = CritterIncubateModel.instance:getCostCurrency(),
		needHideCurrencyBtn = CritterIncubateModel.instance:getCostCurrency(),
		helpBtnCallBack = function()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Incubate)
		end,
		openBtnCallBack = function()
			return ManufactureModel.instance:getTradeLevel() >= RoomTradeTaskModel.instance:getOpenCritterIncubateLevel()
		end
	}
}

function RoomCritterBuildingViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterBuildingView.New())
	table.insert(views, TabViewGroup.New(TabGroup.Navigate, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(TabGroup.SubView, "#go_subView"))
	table.insert(views, TabViewGroup.New(TabGroup.Currency, "righttop"))

	return views
end

function RoomCritterBuildingViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabGroup.Navigate then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == TabGroup.SubView then
		self.subViewList = {
			self:getRestMultiView(),
			self:getTrainMultiView(),
			self:getSummonMultiView(),
			self:getIncubateMultiView()
		}

		return self.subViewList
	elseif tabContainerId == 3 then
		local defaultTabId = self:getDefaultSelectedTab()
		local currency = RoomCritterBuildingViewContainer.TabSettingList[defaultTabId].currency

		self._currencyView = CurrencyView.New(currency)

		return {
			self._currencyView
		}
	end
end

function RoomCritterBuildingViewContainer:getRestMultiView()
	local foodScrollParam = ListScrollParam.New()

	foodScrollParam.scrollGOPath = "content/feed/#scroll_feed"
	foodScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	foodScrollParam.prefabUrl = "content/feed/#scroll_feed/viewport/content/go_feeditem"
	foodScrollParam.cellClass = RoomCritterRestViewFoodItem
	foodScrollParam.scrollDir = ScrollEnum.ScrollDirV
	foodScrollParam.cellWidth = 150
	foodScrollParam.cellHeight = 122
	foodScrollParam.cellSpaceV = 0

	local foodScrollView = LuaListScrollView.New(RoomCritterFoodListModel.instance, foodScrollParam)

	return MultiView.New({
		RoomCritterRestView.New(),
		foodScrollView,
		RoomCritterRestViewMapUI.New()
	})
end

function RoomCritterBuildingViewContainer:getSummonMultiView()
	local poolScrollParam = ListScrollParam.New()

	poolScrollParam.scrollGOPath = "root/right/#go_critterSub/#scroll_critter"
	poolScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	poolScrollParam.prefabUrl = "root/right/#go_critterSub/#go_critteritem"
	poolScrollParam.cellClass = RoomCritterSummonPoolItem
	poolScrollParam.scrollDir = ScrollEnum.ScrollDirV
	poolScrollParam.lineCount = 2
	poolScrollParam.cellWidth = 166
	poolScrollParam.cellHeight = 166
	poolScrollParam.cellSpaceV = 0

	local poolScrollView = LuaListScrollView.New(RoomSummonPoolCritterListModel.instance, poolScrollParam)

	return MultiView.New({
		RoomCritterSummonView.New(),
		poolScrollView
	})
end

function RoomCritterBuildingViewContainer:getTrainMultiView()
	return MultiView.New(RoomCritterTrainViewContainer.createViewList())
end

function RoomCritterBuildingViewContainer:getIncubateMultiView()
	local incubateScrollParam = ListScrollParam.New()

	incubateScrollParam.scrollGOPath = "root/right/#go_critter/#scroll_critter"
	incubateScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	incubateScrollParam.prefabUrl = "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	incubateScrollParam.cellClass = RoomCritterIncubateItem
	incubateScrollParam.scrollDir = ScrollEnum.ScrollDirV
	incubateScrollParam.lineCount = 1
	incubateScrollParam.cellWidth = 540
	incubateScrollParam.cellHeight = 184
	incubateScrollParam.cellSpaceV = 8.6
	incubateScrollParam.startSpace = 14

	local incubateScrollView = LuaListScrollView.New(CritterIncubateListModel.instance, incubateScrollParam)

	return MultiView.New({
		RoomCritterIncubateView.New(),
		incubateScrollView
	})
end

function RoomCritterBuildingViewContainer:_overrideCloseFunc()
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterPlaceView)
		CritterController.instance:clearSelectedCritterSeatSlot()

		return
	end

	if self:getContainerCurSelectTab() == RoomCritterBuildingViewContainer.SubViewTabId.Training then
		local trainOp = self:getSubViewTabState(RoomCritterBuildingViewContainer.SubViewTabId.Training)

		if trainOp and trainOp ~= CritterEnum.TrainOPState.Normal then
			self:dispatchEvent(CritterEvent.UITrainViewGoBack)

			return
		end
	end

	ManufactureController.instance:closeCritterBuildingView(false)
	ManufactureController.instance:resetCameraOnCloseView()
end

function RoomCritterBuildingViewContainer:getDefaultSelectedTab()
	if self.viewParam then
		local paramTabId = self.viewParam.defaultTab
		local checkResult = self:checkTabId(paramTabId)

		return (checkResult or nil) and paramTabId
	end
end

function RoomCritterBuildingViewContainer:checkTabId(argsTabId)
	local result = false

	if argsTabId then
		for _, tabId in pairs(RoomCritterBuildingViewContainer.SubViewTabId) do
			if tabId == argsTabId then
				result = true

				break
			end
		end
	end

	return result
end

function RoomCritterBuildingViewContainer:onContainerInit()
	local defaultBuildingUid

	if self.viewParam then
		local defaultTabId = self:getDefaultSelectedTab()

		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[TabGroup.SubView] = defaultTabId
		self._curSelectTab = defaultTabId
		defaultBuildingUid = self.viewParam.buildingUid
	end

	if not defaultBuildingUid then
		local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

		if buildingList then
			defaultBuildingUid = buildingList[1].buildingUid
		else
			logError("RoomCritterBuildingViewContainer:onContainerInit,error,can't find critterBuilding")
		end
	end

	self:setContainerViewBuildingUid(defaultBuildingUid)
end

function RoomCritterBuildingViewContainer:switchTab(tabId)
	if not tabId then
		return
	end

	local tag = RoomCritterBuildingViewContainer.TabSettingList[tabId]
	local currency = tag.currency

	self._currencyView:setCurrencyType(currency)

	self._currencyView.foreHideBtn = tag.needHideCurrencyBtn ~= nil

	if tag.needHideCurrencyBtn then
		for _, type in pairs(tag.needHideCurrencyBtn) do
			self._currencyView:_hideAddBtn(type)
		end
	end

	self.playViewOpenCloseAnim(self, tabId, function()
		self:dispatchEvent(ViewEvent.ToSwitchTab, TabGroup.SubView, tabId)
	end, self)

	self._curSelectTab = tabId
end

function RoomCritterBuildingViewContainer:playViewOpenCloseAnim(tabId, callback, callbackObj)
	self._curSelectTab = self._curSelectTab or self:getDefaultSelectedTab()

	local isLastPlayAnim = RoomCritterBuildingViewContainer.TabSettingList[self._curSelectTab].isPlayAnim
	local isCurPlayAnim = RoomCritterBuildingViewContainer.TabSettingList[tabId].isPlayAnim

	if isLastPlayAnim then
		if self.subViewList[self._curSelectTab] then
			local view = self.subViewList[self._curSelectTab]._views[1]

			if view and view.viewGO then
				local animator = SLFramework.AnimatorPlayer.Get(view.viewGO)

				if animator then
					animator:Play(UIAnimationName.Close, callback, callbackObj)
				else
					isLastPlayAnim = false
				end
			else
				isLastPlayAnim = false
			end
		else
			isLastPlayAnim = false
		end
	end

	if isCurPlayAnim then
		if self.subViewList[tabId] then
			local view = self.subViewList[tabId]._views[1]

			if view and view.viewGO then
				local animator = SLFramework.AnimatorPlayer.Get(view.viewGO)

				if animator then
					if isLastPlayAnim then
						animator:Play(UIAnimationName.Open, nil, self)
					else
						animator:Play(UIAnimationName.Open, callback, callbackObj)
					end
				else
					isCurPlayAnim = false
				end
			else
				isCurPlayAnim = false
			end
		else
			isCurPlayAnim = false
		end
	end

	if not isLastPlayAnim and not isCurPlayAnim then
		callback(callbackObj)
	end
end

function RoomCritterBuildingViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
end

function RoomCritterBuildingViewContainer:setContainerViewBuildingUid(buildingUid)
	self._viewBuildingUid = buildingUid
end

function RoomCritterBuildingViewContainer:getContainerViewBuildingUid()
	return self._viewBuildingUid
end

function RoomCritterBuildingViewContainer:getContainerCurSelectTab()
	return self._curSelectTab
end

function RoomCritterBuildingViewContainer:setContainerTabState(subViewTag, opState)
	self._subViewTagOpDict = self._subViewTagOpDict or {}
	self._subViewTagOpDict[subViewTag] = opState
end

function RoomCritterBuildingViewContainer:getSubViewTabState(subViewTag)
	return self._subViewTagOpDict and self._subViewTagOpDict[subViewTag]
end

function RoomCritterBuildingViewContainer:getContainerViewBuilding(nilError)
	local viewBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._viewBuildingUid)

	if not viewBuildingMO and nilError then
		logError(string.format("RoomCritterBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", self._viewBuildingUid))
	end

	return self._viewBuildingUid, viewBuildingMO
end

return RoomCritterBuildingViewContainer
