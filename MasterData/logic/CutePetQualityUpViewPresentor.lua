-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetQualityUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetQualityUpViewPresentor", package.seeall)

local CutePetQualityUpViewPresentor = class("CutePetQualityUpViewPresentor", ViewPresentor)

function CutePetQualityUpViewPresentor:ctor()
	CutePetQualityUpViewPresentor.super.ctor(self)
end

function CutePetQualityUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetQualityUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetqualityupview.prefab"
	}
end

function CutePetQualityUpViewPresentor:buildViews()
	return {
		CutePetQualityUpView.New()
	}
end

function CutePetQualityUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetQualityUpViewPresentor
