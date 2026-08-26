-- chunkname: @modules/logic/season/view1_6/Season1_6SpecialMarketViewContainer.lua

module("modules.logic.season.view1_6.Season1_6SpecialMarketViewContainer", package.seeall)

local Season1_6SpecialMarketViewContainer = class("Season1_6SpecialMarketViewContainer", BaseViewContainer)

function Season1_6SpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_6SpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_6SpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_6SpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_6SpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_6SpecialMarketViewContainer
