-- chunkname: @modules/logic/season/view1_6/Season1_6TaskViewContainer.lua

module("modules.logic.season.view1_6.Season1_6TaskViewContainer", package.seeall)

local Season1_6TaskViewContainer = class("Season1_6TaskViewContainer", BaseViewContainer)

function Season1_6TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_6TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_6TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season1_6TaskViewContainer
