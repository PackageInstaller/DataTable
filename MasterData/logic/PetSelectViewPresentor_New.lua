-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petselect/view/PetSelectViewPresentor_New.lua

module("logic.extensions.petselect.view.PetSelectViewPresentor_New", package.seeall)

local PetSelectViewPresentor_New = class("PetSelectViewPresentor_New", ViewWithGuidePresentor)

function PetSelectViewPresentor_New:ctor()
	PetSelectViewPresentor_New.super.ctor(self)
end

function PetSelectViewPresentor_New:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetSelectViewPresentor_New:dependWhatResources()
	return {
		"ui/views/petselect/petselectview.prefab",
		ItemPetSelect.ResPath
	}
end

function PetSelectViewPresentor_New:buildViews()
	return {
		PetSelectView_New.New()
	}
end

return PetSelectViewPresentor_New
