-- chunkname: @modules/logic/season/view1_4/Season1_4RetailLevelInfoViewContainer.lua

module("modules.logic.season.view1_4.Season1_4RetailLevelInfoViewContainer", package.seeall)

local Season1_4RetailLevelInfoViewContainer = class("Season1_4RetailLevelInfoViewContainer", BaseViewContainer)

function Season1_4RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4RetailLevelInfoView.New())

	return views
end

function Season1_4RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_4RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_4RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_4RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season1_4RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season1_4RetailLevelInfoViewContainer
