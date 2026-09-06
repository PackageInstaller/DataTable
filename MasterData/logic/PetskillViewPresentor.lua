-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetskillViewPresentor.lua

module("logic.extensions.bag.view.PetskillViewPresentor", package.seeall)

local PetskillViewPresentor = class("PetskillViewPresentor", ViewPresentor)

function PetskillViewPresentor:ctor()
	PetskillViewPresentor.super.ctor(self)
end

function PetskillViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskillViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskillview.prefab"
	}
end

function PetskillViewPresentor:buildViews()
	return {
		PetSkillView.New()
	}
end

function PetskillViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetskillViewPresentor
