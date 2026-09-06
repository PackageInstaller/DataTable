-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpTipViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetStarUpTipViewPresentor", package.seeall)

local CutePetStarUpTipViewPresentor = class("CutePetStarUpTipViewPresentor", ViewPresentor)

function CutePetStarUpTipViewPresentor:ctor()
	CutePetStarUpTipViewPresentor.super.ctor(self)
end

function CutePetStarUpTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetStarUpTipViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetstaruptipview.prefab"
	}
end

function CutePetStarUpTipViewPresentor:buildViews()
	return {
		CutePetStarUpTipView.New()
	}
end

function CutePetStarUpTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetStarUpTipViewPresentor
