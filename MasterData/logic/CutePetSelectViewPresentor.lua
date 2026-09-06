-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSelectViewPresentor", package.seeall)

local CutePetSelectViewPresentor = class("CutePetSelectViewPresentor", ViewPresentor)

function CutePetSelectViewPresentor:ctor()
	CutePetSelectViewPresentor.super.ctor(self)
end

function CutePetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetselectview.prefab"
	}
end

function CutePetSelectViewPresentor:buildViews()
	return {
		CutePetSelectView.New()
	}
end

return CutePetSelectViewPresentor
