-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetInteractViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetInteractViewPresentor", package.seeall)

local CutePetInteractViewPresentor = class("CutePetInteractViewPresentor", ViewPresentor)

function CutePetInteractViewPresentor:ctor()
	CutePetInteractViewPresentor.super.ctor(self)
end

function CutePetInteractViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetInteractViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetinteractview.prefab"
	}
end

function CutePetInteractViewPresentor:buildViews()
	return {
		CutePetInteractView.New()
	}
end

function CutePetInteractViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetInteractViewPresentor
