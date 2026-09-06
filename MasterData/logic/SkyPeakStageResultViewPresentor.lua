-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakStageResultViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakStageResultViewPresentor", package.seeall)

local SkyPeakStageResultViewPresentor = class("SkyPeakStageResultViewPresentor", ViewPresentor)

function SkyPeakStageResultViewPresentor:ctor()
	SkyPeakStageResultViewPresentor.super.ctor(self)
end

function SkyPeakStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakstageresultview.prefab"
	}
end

function SkyPeakStageResultViewPresentor:buildViews()
	return {
		SkyPeakStageResultView.New()
	}
end

return SkyPeakStageResultViewPresentor
