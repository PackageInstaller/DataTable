-- chunkname: @modules/logic/survival/view/map/SurvivalInitHeroSelectViewContainer.lua

module("modules.logic.survival.view.map.SurvivalInitHeroSelectViewContainer", package.seeall)

local SurvivalInitHeroSelectViewContainer = class("SurvivalInitHeroSelectViewContainer", BaseViewContainer)

function SurvivalInitHeroSelectViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SurvivalInitHeroSelectEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		SurvivalInitHeroSelectView.New(),
		LuaListScrollViewWithAnimator.New(SurvivalMapModel.instance:getInitGroup(), scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function SurvivalInitHeroSelectViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = SurvivalInitHeroSelectQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(SurvivalMapModel.instance:getInitGroup(), scrollParam, animationDelayTimes)
end

function SurvivalInitHeroSelectViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function SurvivalInitHeroSelectViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

function SurvivalInitHeroSelectViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return SurvivalInitHeroSelectViewContainer
