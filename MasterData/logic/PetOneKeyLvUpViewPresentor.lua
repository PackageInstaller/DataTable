-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetOneKeyLvUpViewPresentor.lua

module("logic.extensions.bag.view.PetOneKeyLvUpViewPresentor", package.seeall)

local PetOneKeyLvUpViewPresentor = class("PetOneKeyLvUpViewPresentor", ViewWithGuidePresentor)

function PetOneKeyLvUpViewPresentor:ctor()
	PetOneKeyLvUpViewPresentor.super.ctor(self)
end

function PetOneKeyLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetOneKeyLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petonekeylvupview.prefab"
	}
end

function PetOneKeyLvUpViewPresentor:buildViews()
	return {
		PetOneKeyLvUpView.New()
	}
end

function PetOneKeyLvUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetOneKeyLvUpViewPresentor
