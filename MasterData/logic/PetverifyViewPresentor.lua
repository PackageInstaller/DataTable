-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifyViewPresentor.lua

module("logic.extensions.petverify.view.PetverifyViewPresentor", package.seeall)

local PetverifyViewPresentor = class("PetverifyViewPresentor", ViewWithGuidePresentor)

function PetverifyViewPresentor:ctor()
	PetverifyViewPresentor.super.ctor(self)
end

function PetverifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifyViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifyview.prefab"
	}
end

function PetverifyViewPresentor:buildViews()
	return {
		PetverifyView.New()
	}
end

function PetverifyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetverifyViewPresentor
