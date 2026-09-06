-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchMainViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchMainViewPresentor", package.seeall)

local SummerTreasureSnatchMainViewPresentor = class("SummerTreasureSnatchMainViewPresentor", ViewPresentor)

function SummerTreasureSnatchMainViewPresentor:ctor()
	SummerTreasureSnatchMainViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchmainview.prefab"
	}
end

function SummerTreasureSnatchMainViewPresentor:buildViews()
	return {
		SummerTreasureSnatchMainView.New()
	}
end

return SummerTreasureSnatchMainViewPresentor
