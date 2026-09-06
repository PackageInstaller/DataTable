-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcompose/view/PetComposeViewPresentor.lua

module("logic.extensions.petcompose.view.PetComposeViewPresentor", package.seeall)

local PetComposeViewPresentor = class("PetComposeViewPresentor", ViewPresentor)

function PetComposeViewPresentor:ctor()
	PetComposeViewPresentor.super.ctor(self)
end

function PetComposeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetComposeViewPresentor:dependWhatResources()
	return {
		"ui/views/petcompose/petcomposeview.prefab"
	}
end

function PetComposeViewPresentor:buildViews()
	return {
		PetComposeView.New()
	}
end

return PetComposeViewPresentor
