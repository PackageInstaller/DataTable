-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetInitPropViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetInitPropViewPresentor", package.seeall)

local CutePetInitPropViewPresentor = class("CutePetInitPropViewPresentor", ViewPresentor)

function CutePetInitPropViewPresentor:ctor()
	CutePetInitPropViewPresentor.super.ctor(self)
end

function CutePetInitPropViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetInitPropViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetinitpropview.prefab"
	}
end

function CutePetInitPropViewPresentor:buildViews()
	return {
		CutePetInitPropView.New()
	}
end

function CutePetInitPropViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetInitPropViewPresentor
