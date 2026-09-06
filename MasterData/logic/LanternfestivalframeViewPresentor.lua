-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/lanternfestival/LanternfestivalframeViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.lanternfestival.LanternfestivalframeViewPresentor", package.seeall)

local LanternfestivalframeViewPresentor = class("LanternfestivalframeViewPresentor", ViewPresentor)

function LanternfestivalframeViewPresentor:ctor()
	LanternfestivalframeViewPresentor.super.ctor(self)
end

function LanternfestivalframeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternfestivalframeViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/lanternfestival/lanternfestivalframeview.prefab"
	}
end

function LanternfestivalframeViewPresentor:buildViews()
	return {
		LanternfestivalframeView.New()
	}
end

return LanternfestivalframeViewPresentor
