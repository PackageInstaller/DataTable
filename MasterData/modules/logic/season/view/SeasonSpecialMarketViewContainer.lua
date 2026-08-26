-- chunkname: @modules/logic/season/view/SeasonSpecialMarketViewContainer.lua

module("modules.logic.season.view.SeasonSpecialMarketViewContainer", package.seeall)

local SeasonSpecialMarketViewContainer = class("SeasonSpecialMarketViewContainer", BaseViewContainer)

function SeasonSpecialMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonSpecialMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function SeasonSpecialMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function SeasonSpecialMarketViewContainer:_closeCallback()
	self:closeThis()
end

function SeasonSpecialMarketViewContainer:_homeCallback()
	self:closeThis()
end

return SeasonSpecialMarketViewContainer
