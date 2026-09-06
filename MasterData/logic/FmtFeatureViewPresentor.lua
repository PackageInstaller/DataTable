-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/FmtFeatureViewPresentor.lua

module("logic.extensions.mission.view.FmtFeatureViewPresentor", package.seeall)

local FmtFeatureViewPresentor = class("FmtFeatureViewPresentor", ViewWithGuidePresentor)

function FmtFeatureViewPresentor:ctor()
	FmtFeatureViewPresentor.super.ctor(self)
end

function FmtFeatureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FmtFeatureViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/fmtfeatureview.prefab"
	}
end

function FmtFeatureViewPresentor:buildViews()
	return {
		FmtFeatureView.New()
	}
end

return FmtFeatureViewPresentor
