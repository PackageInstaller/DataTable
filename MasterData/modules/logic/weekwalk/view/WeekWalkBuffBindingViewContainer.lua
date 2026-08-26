-- chunkname: @modules/logic/weekwalk/view/WeekWalkBuffBindingViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkBuffBindingViewContainer", package.seeall)

local WeekWalkBuffBindingViewContainer = class("WeekWalkBuffBindingViewContainer", BaseViewContainer)

function WeekWalkBuffBindingViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalkBuffBindingHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 211
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 30

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.06
	end

	return {
		LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, scrollParam, animationDelayTimes),
		WeekWalkBuffBindingView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function WeekWalkBuffBindingViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigationView
	}
end

function WeekWalkBuffBindingViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

return WeekWalkBuffBindingViewContainer
