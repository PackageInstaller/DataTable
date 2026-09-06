-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBuffViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBuffViewPresentor", package.seeall)

local SummerTreasureSnatchBuffViewPresentor = class("SummerTreasureSnatchBuffViewPresentor", ViewPresentor)

function SummerTreasureSnatchBuffViewPresentor:ctor()
	SummerTreasureSnatchBuffViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchbuffview.prefab"
	}
end

function SummerTreasureSnatchBuffViewPresentor:buildViews()
	return {
		SummerTreasureSnatchBuffView.New()
	}
end

return SummerTreasureSnatchBuffViewPresentor
