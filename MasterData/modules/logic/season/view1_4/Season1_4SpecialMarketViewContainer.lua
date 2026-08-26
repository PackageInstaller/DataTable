-- chunkname: @modules/logic/season/view1_4/Season1_4SpecialMarketViewContainer.lua

module("modules.logic.season.view1_4.Season1_4SpecialMarketViewContainer", package.seeall)

local Season1_4SpecialMarketViewContainer = class("Season1_4SpecialMarketViewContainer", BaseViewContainer)

function Season1_4SpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4SpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_4SpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_4SpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_4SpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_4SpecialMarketViewContainer
