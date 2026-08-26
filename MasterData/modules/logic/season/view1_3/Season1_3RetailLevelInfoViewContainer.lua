-- chunkname: @modules/logic/season/view1_3/Season1_3RetailLevelInfoViewContainer.lua

module("modules.logic.season.view1_3.Season1_3RetailLevelInfoViewContainer", package.seeall)

local Season1_3RetailLevelInfoViewContainer = class("Season1_3RetailLevelInfoViewContainer", BaseViewContainer)

function Season1_3RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_3RetailLevelInfoView.New())

	return views
end

function Season1_3RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_3RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_3RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_3RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season1_3RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season1_3RetailLevelInfoViewContainer
