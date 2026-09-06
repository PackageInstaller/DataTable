-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleFmtFeatureViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleFmtFeatureViewPresentor", package.seeall)

local FreeScuffleFmtFeatureViewPresentor = class("FreeScuffleFmtFeatureViewPresentor", ViewPresentor)

function FreeScuffleFmtFeatureViewPresentor:ctor()
	FreeScuffleFmtFeatureViewPresentor.super.ctor(self)
end

function FreeScuffleFmtFeatureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleFmtFeatureViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/fmtfeatureview.prefab"
	}
end

function FreeScuffleFmtFeatureViewPresentor:buildViews()
	return {
		FreeScuffleFmtFeatureView.New()
	}
end

return FreeScuffleFmtFeatureViewPresentor
