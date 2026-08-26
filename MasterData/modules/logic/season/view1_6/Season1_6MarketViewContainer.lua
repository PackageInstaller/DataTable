-- chunkname: @modules/logic/season/view1_6/Season1_6MarketViewContainer.lua

module("modules.logic.season.view1_6.Season1_6MarketViewContainer", package.seeall)

local Season1_6MarketViewContainer = class("Season1_6MarketViewContainer", BaseViewContainer)

function Season1_6MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_6MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season1_6MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_6MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_6MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_6MarketViewContainer
