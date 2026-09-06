-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakRewardViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakRewardViewPresentor", package.seeall)

local SkyPeakRewardViewPresentor = class("SkyPeakRewardViewPresentor", ViewPresentor)

function SkyPeakRewardViewPresentor:ctor()
	SkyPeakRewardViewPresentor.super.ctor(self)
end

function SkyPeakRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakrewardview.prefab"
	}
end

function SkyPeakRewardViewPresentor:buildViews()
	return {
		SkyPeakRewardView.New()
	}
end

return SkyPeakRewardViewPresentor
