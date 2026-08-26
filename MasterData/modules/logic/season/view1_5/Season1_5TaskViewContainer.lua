-- chunkname: @modules/logic/season/view1_5/Season1_5TaskViewContainer.lua

module("modules.logic.season.view1_5.Season1_5TaskViewContainer", package.seeall)

local Season1_5TaskViewContainer = class("Season1_5TaskViewContainer", BaseViewContainer)

function Season1_5TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_5TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season1_5TaskViewContainer
