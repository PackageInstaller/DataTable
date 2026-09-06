-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegeViewPresentor.lua

module("logic.extensions.petcollege.view.PetcollegeViewPresentor", package.seeall)

local PetcollegeViewPresentor = class("PetcollegeViewPresentor", ViewPresentor)

function PetcollegeViewPresentor:ctor()
	PetcollegeViewPresentor.super.ctor(self)
end

function PetcollegeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetcollegeViewPresentor:dependWhatResources()
	return {
		"ui/views/petcollege/petcollegeview.prefab"
	}
end

function PetcollegeViewPresentor:buildViews()
	return {
		PetcollegeView.New()
	}
end

return PetcollegeViewPresentor
