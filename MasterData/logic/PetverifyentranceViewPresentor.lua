-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifyentranceViewPresentor.lua

module("logic.extensions.petverify.view.PetverifyentranceViewPresentor", package.seeall)

local PetverifyentranceViewPresentor = class("PetverifyentranceViewPresentor", ViewWithGuidePresentor)

function PetverifyentranceViewPresentor:ctor()
	PetverifyentranceViewPresentor.super.ctor(self)
end

function PetverifyentranceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifyentranceViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifyentranceview.prefab"
	}
end

function PetverifyentranceViewPresentor:buildViews()
	return {
		PetverifyentranceView.New()
	}
end

return PetverifyentranceViewPresentor
