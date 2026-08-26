-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroEditViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditViewContainer", package.seeall)

local Act191HeroEditViewContainer = class("Act191HeroEditViewContainer", BaseViewContainer)

function Act191HeroEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/layout/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Act191HeroEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		Act191HeroEditView.New(),
		LuaListScrollViewWithAnimator.New(Act191HeroEditListModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Act191HeroEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/layout/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Act191HeroQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(Act191HeroQuickEditListModel.instance, scrollParam, animationDelayTimes)
end

function Act191HeroEditViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function Act191HeroEditViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

return Act191HeroEditViewContainer
