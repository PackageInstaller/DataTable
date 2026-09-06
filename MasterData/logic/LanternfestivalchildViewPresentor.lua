-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/lanternfestival/LanternfestivalchildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.lanternfestival.LanternfestivalchildViewPresentor", package.seeall)

local LanternfestivalchildViewPresentor = class("LanternfestivalchildViewPresentor", ViewPresentor)

function LanternfestivalchildViewPresentor:ctor()
	LanternfestivalchildViewPresentor.super.ctor(self)
end

function LanternfestivalchildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternfestivalchildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/lanternfestival/lanternfestivalchildview.prefab"
	}
end

function LanternfestivalchildViewPresentor:buildViews()
	return {
		LanternfestivalchildView.New()
	}
end

function LanternfestivalchildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LanternfestivalchildViewPresentor
