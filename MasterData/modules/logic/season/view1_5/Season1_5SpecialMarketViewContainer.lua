-- chunkname: @modules/logic/season/view1_5/Season1_5SpecialMarketViewContainer.lua

module("modules.logic.season.view1_5.Season1_5SpecialMarketViewContainer", package.seeall)

local Season1_5SpecialMarketViewContainer = class("Season1_5SpecialMarketViewContainer", BaseViewContainer)

function Season1_5SpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5SpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_5SpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_5SpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_5SpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_5SpecialMarketViewContainer
