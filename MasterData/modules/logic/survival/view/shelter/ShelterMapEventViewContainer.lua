-- chunkname: @modules/logic/survival/view/shelter/ShelterMapEventViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterMapEventViewContainer", package.seeall)

local ShelterMapEventViewContainer = class("ShelterMapEventViewContainer", BaseViewContainer)

function ShelterMapEventViewContainer:buildViews()
	return {
		ShelterMapEventView.New()
	}
end

return ShelterMapEventViewContainer
