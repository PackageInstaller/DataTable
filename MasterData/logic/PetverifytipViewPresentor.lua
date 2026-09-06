-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifytipViewPresentor.lua

module("logic.extensions.petverify.view.PetverifytipViewPresentor", package.seeall)

local PetverifytipViewPresentor = class("PetverifytipViewPresentor", ViewWithGuidePresentor)

function PetverifytipViewPresentor:ctor()
	PetverifytipViewPresentor.super.ctor(self)
end

function PetverifytipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifytipViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifytipview.prefab"
	}
end

function PetverifytipViewPresentor:buildViews()
	return {
		PetverifytipView.New()
	}
end

return PetverifytipViewPresentor
