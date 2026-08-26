-- chunkname: @modules/logic/season/view3_0/Season3_0MarketViewContainer.lua

module("modules.logic.season.view3_0.Season3_0MarketViewContainer", package.seeall)

local Season3_0MarketViewContainer = class("Season3_0MarketViewContainer", BaseViewContainer)

function Season3_0MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season3_0MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season3_0MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season3_0MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season3_0MarketViewContainer
