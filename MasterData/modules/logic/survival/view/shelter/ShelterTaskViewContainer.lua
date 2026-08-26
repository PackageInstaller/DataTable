-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterTaskViewContainer", package.seeall)

local ShelterTaskViewContainer = class("ShelterTaskViewContainer", BaseViewContainer)

function ShelterTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, ShelterTaskView.New())
	table.insert(views, ShelterTaskMainTaskView.New())
	table.insert(views, ShelterTaskStoryTaskView.New())
	table.insert(views, ShelterTaskDecreeTaskView.New())
	table.insert(views, ShelterTaskNormalTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ShelterTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return ShelterTaskViewContainer
