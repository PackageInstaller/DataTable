-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifybtnViewPresentor.lua

module("logic.extensions.petverify.view.PetverifybtnViewPresentor", package.seeall)

local PetverifybtnViewPresentor = class("PetverifybtnViewPresentor", ViewPresentor)

function PetverifybtnViewPresentor:ctor()
	PetverifybtnViewPresentor.super.ctor(self)
end

function PetverifybtnViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifybtnViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifybtn.prefab"
	}
end

function PetverifybtnViewPresentor:buildViews()
	return {
		PetverifybtnView.New()
	}
end

function PetverifybtnViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetverifybtnViewPresentor
