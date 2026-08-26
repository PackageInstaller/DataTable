-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5HeroGroupFightViewContainer", package.seeall)

local Season123_3_5HeroGroupFightViewContainer = class("Season123_3_5HeroGroupFightViewContainer", BaseViewContainer)

function Season123_3_5HeroGroupFightViewContainer:buildViews()
	return {
		Season123_3_5HeroGroupFightView.New(),
		Season123_3_5HeroGroupListView.New(),
		Season123_3_5HeroGroupFightViewRule.New(),
		Season123_3_5HeroGroupMainCardView.New(),
		Season123_3_5HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123_3_5HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123_3_5HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season3_5HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season3_5HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123_3_5HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123_3_5HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123_3_5HeroGroupFightViewContainer
