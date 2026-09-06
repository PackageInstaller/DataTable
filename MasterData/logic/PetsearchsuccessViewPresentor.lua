-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchsuccessViewPresentor.lua

module("logic.extensions.petsearch.view.PetsearchsuccessViewPresentor", package.seeall)

local PetsearchsuccessViewPresentor = class("PetsearchsuccessViewPresentor", ViewPresentor)

function PetsearchsuccessViewPresentor:ctor()
	PetsearchsuccessViewPresentor.super.ctor(self)
end

function PetsearchsuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsearchsuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/petsearch/petsearchsuccessview.prefab"
	}
end

function PetsearchsuccessViewPresentor:buildViews()
	return {
		PetsearchsuccessView.New()
	}
end

return PetsearchsuccessViewPresentor
