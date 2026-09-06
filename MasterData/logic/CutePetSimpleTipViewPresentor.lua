-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSimpleTipViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSimpleTipViewPresentor", package.seeall)

local CutePetSimpleTipViewPresentor = class("CutePetSimpleTipViewPresentor", ViewPresentor)

function CutePetSimpleTipViewPresentor:ctor()
	CutePetSimpleTipViewPresentor.super.ctor(self)
end

function CutePetSimpleTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CutePetSimpleTipViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetsimpletipview.prefab"
	}
end

function CutePetSimpleTipViewPresentor:buildViews()
	return {
		CutePetSimpleTipView.New()
	}
end

return CutePetSimpleTipViewPresentor
