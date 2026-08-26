-- chunkname: @modules/logic/season/view3_0/Season3_0RetailLevelInfoViewContainer.lua

module("modules.logic.season.view3_0.Season3_0RetailLevelInfoViewContainer", package.seeall)

local Season3_0RetailLevelInfoViewContainer = class("Season3_0RetailLevelInfoViewContainer", BaseViewContainer)

function Season3_0RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0RetailLevelInfoView.New())

	return views
end

function Season3_0RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season3_0RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season3_0RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season3_0RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season3_0RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season3_0RetailLevelInfoViewContainer
