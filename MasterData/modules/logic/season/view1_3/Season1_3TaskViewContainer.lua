-- chunkname: @modules/logic/season/view1_3/Season1_3TaskViewContainer.lua

module("modules.logic.season.view1_3.Season1_3TaskViewContainer", package.seeall)

local Season1_3TaskViewContainer = class("Season1_3TaskViewContainer", BaseViewContainer)

function Season1_3TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_3TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_3TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season1_3TaskViewContainer
