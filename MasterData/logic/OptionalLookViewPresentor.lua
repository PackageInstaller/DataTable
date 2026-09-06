-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/OptionalLookViewPresentor.lua

module("logic.extensions.equipment.view.OptionalLookViewPresentor", package.seeall)

local OptionalLookViewPresentor = class("OptionalLookViewPresentor", ViewWithGuidePresentor)

function OptionalLookViewPresentor:ctor()
	OptionalLookViewPresentor.super.ctor(self)
end

function OptionalLookViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OptionalLookViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/optionallookview.prefab"
	}
end

function OptionalLookViewPresentor:buildViews()
	return {
		OptionalLookView.New()
	}
end

return OptionalLookViewPresentor
