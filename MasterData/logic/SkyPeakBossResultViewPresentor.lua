-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakBossResultViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakBossResultViewPresentor", package.seeall)

local SkyPeakBossResultViewPresentor = class("SkyPeakBossResultViewPresentor", ViewPresentor)

function SkyPeakBossResultViewPresentor:ctor()
	SkyPeakBossResultViewPresentor.super.ctor(self)
end

function SkyPeakBossResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakBossResultViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakbossresultview.prefab"
	}
end

function SkyPeakBossResultViewPresentor:buildViews()
	return {
		SkyPeakBossResultView.New()
	}
end

return SkyPeakBossResultViewPresentor
