-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakRankViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakRankViewPresentor", package.seeall)

local SkyPeakRankViewPresentor = class("SkyPeakRankViewPresentor", ViewPresentor)

function SkyPeakRankViewPresentor:ctor()
	SkyPeakRankViewPresentor.super.ctor(self)
end

function SkyPeakRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakRankViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakrankview.prefab"
	}
end

function SkyPeakRankViewPresentor:buildViews()
	return {
		SkyPeakRankView.New()
	}
end

return SkyPeakRankViewPresentor
