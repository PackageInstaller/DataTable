-- chunkname: @modules/logic/season/view1_4/Season1_4MarketViewContainer.lua

module("modules.logic.season.view1_4.Season1_4MarketViewContainer", package.seeall)

local Season1_4MarketViewContainer = class("Season1_4MarketViewContainer", BaseViewContainer)

function Season1_4MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season1_4MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_4MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_4MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_4MarketViewContainer
