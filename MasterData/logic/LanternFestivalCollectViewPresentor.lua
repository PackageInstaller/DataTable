-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalCollectViewPresentor.lua

module("logic.extensions.lanternfestival.view.LanternFestivalCollectViewPresentor", package.seeall)

local LanternFestivalCollectViewPresentor = class("LanternFestivalCollectViewPresentor", ViewPresentor)

function LanternFestivalCollectViewPresentor:ctor()
	LanternFestivalCollectViewPresentor.super.ctor(self)
end

function LanternFestivalCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternFestivalCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternfestival/lanternfestivalcollectview.prefab"
	}
end

function LanternFestivalCollectViewPresentor:buildViews()
	return {
		LanternFestivalCollectView.New()
	}
end

return LanternFestivalCollectViewPresentor
