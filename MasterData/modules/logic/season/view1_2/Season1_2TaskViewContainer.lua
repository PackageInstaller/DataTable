-- chunkname: @modules/logic/season/view1_2/Season1_2TaskViewContainer.lua

module("modules.logic.season.view1_2.Season1_2TaskViewContainer", package.seeall)

local Season1_2TaskViewContainer = class("Season1_2TaskViewContainer", BaseViewContainer)

function Season1_2TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_2TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_2TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season1_2TaskViewContainer
