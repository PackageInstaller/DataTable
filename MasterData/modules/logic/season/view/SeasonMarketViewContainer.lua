-- chunkname: @modules/logic/season/view/SeasonMarketViewContainer.lua

module("modules.logic.season.view.SeasonMarketViewContainer", package.seeall)

local SeasonMarketViewContainer = class("SeasonMarketViewContainer", BaseViewContainer)

function SeasonMarketViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonMarketView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function SeasonMarketViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function SeasonMarketViewContainer:_closeCallback()
	self:closeThis()
end

function SeasonMarketViewContainer:_homeCallback()
	self:closeThis()
end

return SeasonMarketViewContainer
