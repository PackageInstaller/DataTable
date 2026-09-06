-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/FmtFeatureTipViewPresentor.lua

module("logic.extensions.mission.view.FmtFeatureTipViewPresentor", package.seeall)

local FmtFeatureTipViewPresentor = class("FmtFeatureTipViewPresentor", ViewPresentor)

function FmtFeatureTipViewPresentor:ctor()
	FmtFeatureTipViewPresentor.super.ctor(self)
end

function FmtFeatureTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FmtFeatureTipViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/fmtfeaturetipview.prefab"
	}
end

function FmtFeatureTipViewPresentor:buildViews()
	return {
		FmtFeatureTipView.New()
	}
end

return FmtFeatureTipViewPresentor
