-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifysuccessViewPresentor.lua

module("logic.extensions.petverify.view.PetverifysuccessViewPresentor", package.seeall)

local PetverifysuccessViewPresentor = class("PetverifysuccessViewPresentor", ViewWithGuidePresentor)

function PetverifysuccessViewPresentor:ctor()
	PetverifysuccessViewPresentor.super.ctor(self)
end

function PetverifysuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifysuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifysuccessview.prefab"
	}
end

function PetverifysuccessViewPresentor:buildViews()
	return {
		PetverifysuccessView.New()
	}
end

return PetverifysuccessViewPresentor
