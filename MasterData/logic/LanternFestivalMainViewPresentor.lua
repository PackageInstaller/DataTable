-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalMainViewPresentor.lua

module("logic.extensions.lanternfestival.view.LanternFestivalMainViewPresentor", package.seeall)

local LanternFestivalMainViewPresentor = class("LanternFestivalMainViewPresentor", ViewPresentor)

function LanternFestivalMainViewPresentor:ctor()
	LanternFestivalMainViewPresentor.super.ctor(self)
end

function LanternFestivalMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternFestivalMainViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternfestival/lanternfestivalmainview.prefab"
	}
end

function LanternFestivalMainViewPresentor:buildViews()
	return {
		LanternFestivalMainView.New()
	}
end

return LanternFestivalMainViewPresentor
