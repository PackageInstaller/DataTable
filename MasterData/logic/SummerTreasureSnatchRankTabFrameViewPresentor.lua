-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchRankTabFrameViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchRankTabFrameViewPresentor", package.seeall)

local SummerTreasureSnatchRankTabFrameViewPresentor = class("SummerTreasureSnatchRankTabFrameViewPresentor", ViewPresentor)

function SummerTreasureSnatchRankTabFrameViewPresentor:ctor()
	SummerTreasureSnatchRankTabFrameViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchranktabframeview.prefab"
	}
end

function SummerTreasureSnatchRankTabFrameViewPresentor:buildViews()
	return {
		SummerTreasureSnatchRankTabFrameView.New()
	}
end

return SummerTreasureSnatchRankTabFrameViewPresentor
