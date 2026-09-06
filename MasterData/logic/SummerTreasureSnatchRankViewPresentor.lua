-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchRankViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchRankViewPresentor", package.seeall)

local SummerTreasureSnatchRankViewPresentor = class("SummerTreasureSnatchRankViewPresentor", ViewPresentor)

function SummerTreasureSnatchRankViewPresentor:ctor()
	SummerTreasureSnatchRankViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchRankViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchrankview.prefab"
	}
end

function SummerTreasureSnatchRankViewPresentor:buildViews()
	return {
		SummerTreasureSnatchRankView.New()
	}
end

return SummerTreasureSnatchRankViewPresentor
