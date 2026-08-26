-- chunkname: @modules/logic/season/view1_2/Season1_2SpecialMarketViewContainer.lua

module("modules.logic.season.view1_2.Season1_2SpecialMarketViewContainer", package.seeall)

local Season1_2SpecialMarketViewContainer = class("Season1_2SpecialMarketViewContainer", BaseViewContainer)

function Season1_2SpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_2SpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_2SpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_2SpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_2SpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_2SpecialMarketViewContainer
