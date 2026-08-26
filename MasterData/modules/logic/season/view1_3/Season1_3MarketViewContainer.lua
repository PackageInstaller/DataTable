-- chunkname: @modules/logic/season/view1_3/Season1_3MarketViewContainer.lua

module("modules.logic.season.view1_3.Season1_3MarketViewContainer", package.seeall)

local Season1_3MarketViewContainer = class("Season1_3MarketViewContainer", BaseViewContainer)

function Season1_3MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_3MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season1_3MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_3MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_3MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_3MarketViewContainer
