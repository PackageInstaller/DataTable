-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/holylight/HolyLightTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.holylight.HolyLightTaskFrameViewPresentor", package.seeall)

local HolyLightTaskFrameViewPresentor = class("HolyLightTaskFrameViewPresentor", ViewPresentor)

function HolyLightTaskFrameViewPresentor:ctor()
	HolyLightTaskFrameViewPresentor.super.ctor(self)
end

function HolyLightTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/holylight/holylighttaskframeview.prefab"
	}
end

function HolyLightTaskFrameViewPresentor:buildViews()
	return {
		HolyLightTaskFrameView.New()
	}
end

return HolyLightTaskFrameViewPresentor
