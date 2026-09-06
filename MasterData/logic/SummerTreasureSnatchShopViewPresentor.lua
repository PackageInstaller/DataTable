-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchShopViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchShopViewPresentor", package.seeall)

local SummerTreasureSnatchShopViewPresentor = class("SummerTreasureSnatchShopViewPresentor", ViewPresentor)

function SummerTreasureSnatchShopViewPresentor:ctor()
	SummerTreasureSnatchShopViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchShopViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchshopview.prefab"
	}
end

function SummerTreasureSnatchShopViewPresentor:buildViews()
	return {
		SummerTreasureSnatchShopView.New()
	}
end

return SummerTreasureSnatchShopViewPresentor
