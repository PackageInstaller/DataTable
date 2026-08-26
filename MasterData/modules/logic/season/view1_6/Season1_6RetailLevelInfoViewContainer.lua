-- chunkname: @modules/logic/season/view1_6/Season1_6RetailLevelInfoViewContainer.lua

module("modules.logic.season.view1_6.Season1_6RetailLevelInfoViewContainer", package.seeall)

local Season1_6RetailLevelInfoViewContainer = class("Season1_6RetailLevelInfoViewContainer", BaseViewContainer)

function Season1_6RetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_6RetailLevelInfoView.New())

	return views
end

function Season1_6RetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_6RetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_6RetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_6RetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	Season1_6RetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return Season1_6RetailLevelInfoViewContainer
