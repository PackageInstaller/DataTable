-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1HeroGroupFightViewContainer", package.seeall)

local Season123_2_1HeroGroupFightViewContainer = class("Season123_2_1HeroGroupFightViewContainer", BaseViewContainer)

function Season123_2_1HeroGroupFightViewContainer:buildViews()
	return {
		Season123_2_1HeroGroupFightView.New(),
		Season123_2_1HeroGroupListView.New(),
		Season123_2_1HeroGroupFightViewRule.New(),
		Season123_2_1HeroGroupMainCardView.New(),
		Season123_2_1HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123_2_1HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123_2_1HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season2_1HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season2_1HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123_2_1HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123_2_1HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123_2_1HeroGroupFightViewContainer
