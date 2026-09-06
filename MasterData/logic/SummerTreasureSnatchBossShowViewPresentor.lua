-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBossShowViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBossShowViewPresentor", package.seeall)

local SummerTreasureSnatchBossShowViewPresentor = class("SummerTreasureSnatchBossShowViewPresentor", ViewPresentor)

function SummerTreasureSnatchBossShowViewPresentor:ctor()
	SummerTreasureSnatchBossShowViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchBossShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchBossShowViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchbossshowview.prefab"
	}
end

function SummerTreasureSnatchBossShowViewPresentor:buildViews()
	return {
		SummerTreasureSnatchBossShowView.New()
	}
end

return SummerTreasureSnatchBossShowViewPresentor
