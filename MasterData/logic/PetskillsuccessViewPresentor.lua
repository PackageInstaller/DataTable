-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetskillsuccessViewPresentor.lua

module("logic.extensions.bag.view.PetskillsuccessViewPresentor", package.seeall)

local PetskillsuccessViewPresentor = class("PetskillsuccessViewPresentor", ViewPresentor)

function PetskillsuccessViewPresentor:ctor()
	PetskillsuccessViewPresentor.super.ctor(self)
end

function PetskillsuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskillsuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskillsuccess.prefab"
	}
end

function PetskillsuccessViewPresentor:buildViews()
	return {
		PetskillsuccessView.New()
	}
end

return PetskillsuccessViewPresentor
