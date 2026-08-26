-- chunkname: @modules/logic/season/view1_2/Season1_2RetailLevelInfoViewContainer.lua

module("modules.logic.season.view1_2.Season1_2RetailLevelInfoViewContainer", package.seeall)

local Season1_2RetailLevelInfoViewContainer = class("Season1_2RetailLevelInfoViewContainer", BaseViewContainer)

function Season1_2RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_2RetailLevelInfoView.New())

	return views
end

function Season1_2RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_2RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_2RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_2RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season1_2RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season1_2RetailLevelInfoViewContainer
