-- chunkname: @modules/logic/season/view1_5/Season1_5RetailLevelInfoViewContainer.lua

module("modules.logic.season.view1_5.Season1_5RetailLevelInfoViewContainer", package.seeall)

local Season1_5RetailLevelInfoViewContainer = class("Season1_5RetailLevelInfoViewContainer", BaseViewContainer)

function Season1_5RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5RetailLevelInfoView.New())

	return views
end

function Season1_5RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_5RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_5RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_5RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season1_5RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season1_5RetailLevelInfoViewContainer
