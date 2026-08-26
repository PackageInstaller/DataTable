-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupEditViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupEditViewContainer", package.seeall)

local Season166HeroGroupEditViewContainer = class("Season166HeroGroupEditViewContainer", BaseViewContainer)

function Season166HeroGroupEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season166HeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 472
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 35

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		Season166HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(Season166HeroGroupEditModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season166HeroGroupEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = Season166HeroGroupQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 472
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 35

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(Season166HeroGroupQuickEditModel.instance, scrollParam, animationDelayTimes)
end

function Season166HeroGroupEditViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)

	return {
		self._navigateButtonView
	}
end

function Season166HeroGroupEditViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

function Season166HeroGroupEditViewContainer:_overrideClose()
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.Season166HeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.Season166HeroGroupEditView, nil, true)
	end
end

function Season166HeroGroupEditViewContainer:_setHomeBtnVisible(isVisible)
	self._navigateButtonView:setParam({
		true,
		isVisible,
		false
	})
end

function Season166HeroGroupEditViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return Season166HeroGroupEditViewContainer
