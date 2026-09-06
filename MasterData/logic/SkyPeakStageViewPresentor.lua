-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakStageViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakStageViewPresentor", package.seeall)

local SkyPeakStageViewPresentor = class("SkyPeakStageViewPresentor", ViewPresentor)

function SkyPeakStageViewPresentor:ctor()
	SkyPeakStageViewPresentor.super.ctor(self)
end

function SkyPeakStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakStageViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakstageview.prefab"
	}
end

function SkyPeakStageViewPresentor:buildViews()
	return {
		SkyPeakStageView.New()
	}
end

return SkyPeakStageViewPresentor
