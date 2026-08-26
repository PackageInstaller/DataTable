-- chunkname: @modules/logic/seasonver/act123/view/Season123HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123HeroGroupFightViewContainer", package.seeall)

local Season123HeroGroupFightViewContainer = class("Season123HeroGroupFightViewContainer", BaseViewContainer)

function Season123HeroGroupFightViewContainer:buildViews()
	return {
		Season123HeroGroupFightView.New(),
		Season123HeroGroupListView.New(),
		Season123HeroGroupFightViewRule.New(),
		Season123HeroGroupMainCardView.New(),
		Season123HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.SeasonHerogroup, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_7HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123HeroGroupFightViewContainer
