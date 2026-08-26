-- chunkname: @modules/logic/season/view3_0/Season3_0SpecialMarketViewContainer.lua

module("modules.logic.season.view3_0.Season3_0SpecialMarketViewContainer", package.seeall)

local Season3_0SpecialMarketViewContainer = class("Season3_0SpecialMarketViewContainer", BaseViewContainer)

function Season3_0SpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0SpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season3_0SpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season3_0SpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function Season3_0SpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return Season3_0SpecialMarketViewContainer
