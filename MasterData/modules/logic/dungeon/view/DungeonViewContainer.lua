-- chunkname: @modules/logic/dungeon/view/DungeonViewContainer.lua

module("modules.logic.dungeon.view.DungeonViewContainer", package.seeall)

local DungeonViewContainer = class("DungeonViewContainer", BaseViewContainer)

function DungeonViewContainer:buildViews()
	local views = {}
	local dynamicGroup = TabViewGroupDynamic.New(2)

	dynamicGroup:stopOpenDefaultTab(true)
	dynamicGroup:setDynamicNodeContainers({
		[DungeonEnum.DungeonViewTabEnum.WeekWalk] = "#go_weekwalk",
		[DungeonEnum.DungeonViewTabEnum.Explore] = "#go_explore",
		[DungeonEnum.DungeonViewTabEnum.Permanent] = "#go_permanent",
		[DungeonEnum.DungeonViewTabEnum.WeekWalk_2] = "#go_weekwalk",
		[DungeonEnum.DungeonViewTabEnum.AdvPlay] = "#go_advplay",
		[DungeonEnum.DungeonViewTabEnum.Rouge] = "#go_rouge"
	})
	dynamicGroup:setDynamicNodeResHandlers({
		[DungeonEnum.DungeonViewTabEnum.Explore] = DungeonViewContainer._getExploreRes
	})
	table.insert(views, dynamicGroup)

	self._dynamicGroup = dynamicGroup
	self._dungeonViewAudio = DungeonViewAudio.New()

	table.insert(views, self._dungeonViewAudio)
	table.insert(views, DungeonView.New())

	self._mainStory = DungeonViewMainStory.New()

	table.insert(views, self._mainStory)

	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_story/chapterlist/#scroll_chapter"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = DungeonChapterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.startSpace = 147.5
	scrollParam.endSpace = 0
	self._scrollParam = scrollParam

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, DungeonResourceView.New())
	table.insert(views, DungeonViewEffect.New())
	table.insert(views, DungeonViewPointReward.New())

	return views
end

function DungeonViewContainer._getExploreRes()
	local chapterIndex, _, chapterId = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())

	if ExploreSimpleModel.instance:isChapterFinish(chapterId) then
		if not ("level/levelbg" .. chapterIndex .. "_1") then
			local bg = "level/levelbg" .. chapterIndex

			return {
				ResUrl.getExploreBg(bg)
			}
		end
	end
end

function DungeonViewContainer:_dynamicGetItem(mo)
	if mo and DungeonModel.instance:isSpecialMainPlot(mo.id) then
		return "mini_item", DungeonChapterMiniItem, self._viewSetting.otherRes.mini_item
	end
end

function DungeonViewContainer:onContainerOpen()
	self._dungeonViewAudio:addScrollChangeCallback(self._mainStory.onScrollChange, self._mainStory)
end

function DungeonViewContainer:getScrollView()
	return self._scrollView
end

function DungeonViewContainer:getScrollParam()
	return self._scrollParam
end

function DungeonViewContainer:getItemSpace()
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local screenWidth = recthelper.getWidth(popUpTopGO.transform)
	local screenHeight = recthelper.getHeight(popUpTopGO.transform)
	local rate = screenWidth / screenHeight

	if rate >= 2.2 then
		return 16
	elseif rate >= 2 then
		return 8
	else
		return 0
	end
end

function DungeonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		self._exploreView = DungeonExploreView.New()

		return {
			[DungeonEnum.DungeonViewTabEnum.WeekWalk] = DungeonWeekWalkView.New(),
			[DungeonEnum.DungeonViewTabEnum.Explore] = self._exploreView,
			[DungeonEnum.DungeonViewTabEnum.Permanent] = PermanentMainView.New(),
			[DungeonEnum.DungeonViewTabEnum.WeekWalk_2] = DungeonWeekWalk_2View.New(),
			[DungeonEnum.DungeonViewTabEnum.AdvPlay] = DungeonAdvPlayView.New(),
			[DungeonEnum.DungeonViewTabEnum.Rouge] = DungeonRougeView.New()
		}
	end
end

function DungeonViewContainer:getExploreView()
	return self._exploreView
end

function DungeonViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function DungeonViewContainer:destoryTab(tabId)
	self._dynamicGroup:destoryTab(tabId)
end

function DungeonViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio()
end

function DungeonViewContainer:setOverrideClose(overrideCloseFunc, overrideCloseObj)
	self._navigateButtonView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

function DungeonViewContainer:_closeCallback()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		if ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	elseif not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function DungeonViewContainer:setNavigateButtonViewLight(useLightBtn)
	if self._navigateButtonView then
		self._navigateButtonView:setLight(useLightBtn)
	end
end

function DungeonViewContainer:setNavigateButtonViewHelpId()
	if self._navigateButtonView then
		self._navigateButtonView:setHelpId(HelpEnum.HelpId.WeekWalk)
	end
end

function DungeonViewContainer:resetNavigateButtonViewHelpId()
	if self._navigateButtonView then
		self._navigateButtonView:hideHelpIcon()
	end
end

return DungeonViewContainer
