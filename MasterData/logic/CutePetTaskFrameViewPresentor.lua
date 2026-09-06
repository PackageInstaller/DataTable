-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/cutepet/CutePetTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.cutepet.CutePetTaskFrameViewPresentor", package.seeall)

local CutePetTaskFrameViewPresentor = class("CutePetTaskFrameViewPresentor", ViewPresentor)

function CutePetTaskFrameViewPresentor:ctor()
	CutePetTaskFrameViewPresentor.super.ctor(self)
end

function CutePetTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/cutepet/cutepettaskframeview.prefab"
	}
end

function CutePetTaskFrameViewPresentor:buildViews()
	return {
		CutePetTaskFrameView.New()
	}
end

return CutePetTaskFrameViewPresentor
