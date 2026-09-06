-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchTotalRankViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchTotalRankViewPresentor", package.seeall)

local SummerTreasureSnatchTotalRankViewPresentor = class("SummerTreasureSnatchTotalRankViewPresentor", ViewPresentor)

function SummerTreasureSnatchTotalRankViewPresentor:ctor()
	SummerTreasureSnatchTotalRankViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchTotalRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchTotalRankViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchtotalrankview.prefab"
	}
end

function SummerTreasureSnatchTotalRankViewPresentor:buildViews()
	return {
		SummerTreasureSnatchTotalRankView.New()
	}
end

return SummerTreasureSnatchTotalRankViewPresentor
