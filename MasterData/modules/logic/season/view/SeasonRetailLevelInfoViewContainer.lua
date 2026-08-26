-- chunkname: @modules/logic/season/view/SeasonRetailLevelInfoViewContainer.lua

module("modules.logic.season.view.SeasonRetailLevelInfoViewContainer", package.seeall)

local SeasonRetailLevelInfoViewContainer = class("SeasonRetailLevelInfoViewContainer", BaseViewContainer)

function SeasonRetailLevelInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonRetailLevelInfoView.New())

	return views
end

function SeasonRetailLevelInfoViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function SeasonRetailLevelInfoViewContainer:_closeCallback()
	self:closeThis()
end

function SeasonRetailLevelInfoViewContainer:_homeCallback()
	self:closeThis()
end

function SeasonRetailLevelInfoViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.duration = 0

	SeasonRetailLevelInfoViewContainer.super.playOpenTransition(self, paramTable)
end

return SeasonRetailLevelInfoViewContainer
