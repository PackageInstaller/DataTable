-- chunkname: @modules/logic/season/view1_5/Season1_5MarketViewContainer.lua

module("modules.logic.season.view1_5.Season1_5MarketViewContainer", package.seeall)

local Season1_5MarketViewContainer = class("Season1_5MarketViewContainer", BaseViewContainer)

function Season1_5MarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5MarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season1_5MarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_5MarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_5MarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_5MarketViewContainer
