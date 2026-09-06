-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifybtnUIPresentor.lua

module("logic.extensions.petverify.view.PetverifybtnUIPresentor", package.seeall)

local PetverifybtnUIPresentor = class("PetverifybtnUIPresentor", ViewPresentor)

function PetverifybtnUIPresentor:ctor()
	PetverifybtnUIPresentor.super.ctor(self)
end

function PetverifybtnUIPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetverifybtnUIPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifybtn.prefab"
	}
end

function PetverifybtnUIPresentor:buildViews()
	return {
		PetverifybtnUI.New()
	}
end

function PetverifybtnUIPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetverifybtnUIPresentor
