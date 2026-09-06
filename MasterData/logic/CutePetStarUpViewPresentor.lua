-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetStarUpViewPresentor", package.seeall)

local CutePetStarUpViewPresentor = class("CutePetStarUpViewPresentor", ViewPresentor)

function CutePetStarUpViewPresentor:ctor()
	CutePetStarUpViewPresentor.super.ctor(self)
end

function CutePetStarUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetStarUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetstarupview.prefab"
	}
end

function CutePetStarUpViewPresentor:buildViews()
	return {
		CutePetStarUpView.New()
	}
end

function CutePetStarUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetStarUpViewPresentor
