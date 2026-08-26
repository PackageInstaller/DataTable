-- chunkname: @modules/logic/season/view/SeasonTaskViewContainer.lua

module("modules.logic.season.view.SeasonTaskViewContainer", package.seeall)

local SeasonTaskViewContainer = class("SeasonTaskViewContainer", BaseViewContainer)

function SeasonTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function SeasonTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return SeasonTaskViewContainer
