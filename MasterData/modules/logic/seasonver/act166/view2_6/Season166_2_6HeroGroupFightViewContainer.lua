-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6HeroGroupFightViewContainer", package.seeall)

local Season166_2_6HeroGroupFightViewContainer = class("Season166_2_6HeroGroupFightViewContainer", BaseViewContainer)

function Season166_2_6HeroGroupFightViewContainer:buildViews()
	return {
		Season166HeroGroupFightLayoutView.New(),
		Season166_2_6HeroGroupFightView.New(),
		Season166HeroGroupListView.New(),
		Season166HeroGroupFightViewRule.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season166_2_6HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season166_2_6HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season166_2_6HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season166_2_6HeroGroupFightViewContainer
