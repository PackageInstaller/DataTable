-- chunkname: @modules/logic/survival/view/shelter/ShelterMapBagViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterMapBagViewContainer", package.seeall)

local ShelterMapBagViewContainer = class("ShelterMapBagViewContainer", BaseViewContainer)

function ShelterMapBagViewContainer:buildViews()
	return {
		ShelterMapBagView.New(),
		ToggleListView.New(1, "root/toggleGroup")
	}
end

return ShelterMapBagViewContainer
