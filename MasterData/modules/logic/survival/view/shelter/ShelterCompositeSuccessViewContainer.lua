-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeSuccessViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterCompositeSuccessViewContainer", package.seeall)

local ShelterCompositeSuccessViewContainer = class("ShelterCompositeSuccessViewContainer", BaseViewContainer)

function ShelterCompositeSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, ShelterCompositeSuccessView.New())

	return views
end

return ShelterCompositeSuccessViewContainer
