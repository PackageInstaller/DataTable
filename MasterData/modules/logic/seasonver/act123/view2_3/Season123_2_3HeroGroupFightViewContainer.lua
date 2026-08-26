-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3HeroGroupFightViewContainer", package.seeall)

local Season123_2_3HeroGroupFightViewContainer = class("Season123_2_3HeroGroupFightViewContainer", BaseViewContainer)

function Season123_2_3HeroGroupFightViewContainer:buildViews()
	return {
		Season123_2_3HeroGroupFightView.New(),
		Season123_2_3HeroGroupListView.New(),
		Season123_2_3HeroGroupFightViewRule.New(),
		Season123_2_3HeroGroupMainCardView.New(),
		Season123_2_3HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123_2_3HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123_2_3HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season2_3HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season2_3HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123_2_3HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123_2_3HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123_2_3HeroGroupFightViewContainer
