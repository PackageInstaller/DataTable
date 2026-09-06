-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/fuyao/FuYaoTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.fuyao.FuYaoTaskFrameViewPresentor", package.seeall)

local FuYaoTaskFrameViewPresentor = class("FuYaoTaskFrameViewPresentor", ViewPresentor)

function FuYaoTaskFrameViewPresentor:ctor()
	FuYaoTaskFrameViewPresentor.super.ctor(self)
end

function FuYaoTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FuYaoTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/fuyao/fuyaotaskframeview.prefab"
	}
end

function FuYaoTaskFrameViewPresentor:buildViews()
	return {
		FuYaoTaskFrameView.New()
	}
end

return FuYaoTaskFrameViewPresentor
