-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetShowInfoViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetShowInfoViewPresentor", package.seeall)

local CutePetShowInfoViewPresentor = class("CutePetShowInfoViewPresentor", ViewPresentor)

function CutePetShowInfoViewPresentor:ctor()
	CutePetShowInfoViewPresentor.super.ctor(self)
end

function CutePetShowInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetShowInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetshowinfoview.prefab"
	}
end

function CutePetShowInfoViewPresentor:buildViews()
	return {
		CutePetShowInfoView.New()
	}
end

function CutePetShowInfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetShowInfoViewPresentor
