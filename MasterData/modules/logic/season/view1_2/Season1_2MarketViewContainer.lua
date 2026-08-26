-- chunkname: @modules/logic/season/view1_2/Season1_2MarketViewContainer.lua

module("modules.logic.season.view1_2.Season1_2MarketViewContainer", package.seeall)

local Season1_2MarketViewContainer = class("Season1_2MarketViewContainer", BaseViewContainer)

function Season1_2MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_2MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season1_2MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_2MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_2MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_2MarketViewContainer
