-- chunkname: @modules/logic/survival/view/shelter/ShelterBuildingManagerViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterBuildingManagerViewContainer", package.seeall)

local ShelterBuildingManagerViewContainer = class("ShelterBuildingManagerViewContainer", BaseViewContainer)

function ShelterBuildingManagerViewContainer:buildViews()
	local views = {}

	table.insert(views, ShelterBuildingManagerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ShelterBuildingManagerViewContainer:buildTabViews(tabContainerId)
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

return ShelterBuildingManagerViewContainer
