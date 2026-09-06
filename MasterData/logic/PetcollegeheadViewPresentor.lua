-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegeheadViewPresentor.lua

module("logic.extensions.petcollege.view.PetcollegeheadViewPresentor", package.seeall)

local PetcollegeheadViewPresentor = class("PetcollegeheadViewPresentor", ViewPresentor)

function PetcollegeheadViewPresentor:ctor()
	PetcollegeheadViewPresentor.super.ctor(self)
end

function PetcollegeheadViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetcollegeheadViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guideheadview.prefab"
	}
end

function PetcollegeheadViewPresentor:buildViews()
	return {
		PetcollegeheadView.New()
	}
end

return PetcollegeheadViewPresentor
