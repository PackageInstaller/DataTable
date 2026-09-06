-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetMainViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetMainViewPresentor", package.seeall)

local CutePetMainViewPresentor = class("CutePetMainViewPresentor", ViewWithGuidePresentor)

function CutePetMainViewPresentor:ctor()
	CutePetMainViewPresentor.super.ctor(self)
end

function CutePetMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetmainview.prefab"
	}
end

function CutePetMainViewPresentor:buildViews()
	return {
		CutePetMainView.New()
	}
end

function CutePetMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetMainViewPresentor
