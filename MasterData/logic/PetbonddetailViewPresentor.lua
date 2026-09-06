-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetbonddetailViewPresentor.lua

module("logic.extensions.bag.view.PetbonddetailViewPresentor", package.seeall)

local PetbonddetailViewPresentor = class("PetbonddetailViewPresentor", ViewPresentor)

function PetbonddetailViewPresentor:ctor()
	PetbonddetailViewPresentor.super.ctor(self)
end

function PetbonddetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetbonddetailViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petbonddetailview.prefab"
	}
end

function PetbonddetailViewPresentor:buildViews()
	return {
		PetBondDetailView.New()
	}
end

return PetbonddetailViewPresentor
