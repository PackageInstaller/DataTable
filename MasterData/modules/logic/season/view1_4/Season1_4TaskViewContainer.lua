-- chunkname: @modules/logic/season/view1_4/Season1_4TaskViewContainer.lua

module("modules.logic.season.view1_4.Season1_4TaskViewContainer", package.seeall)

local Season1_4TaskViewContainer = class("Season1_4TaskViewContainer", BaseViewContainer)

function Season1_4TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_4TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season1_4TaskViewContainer
