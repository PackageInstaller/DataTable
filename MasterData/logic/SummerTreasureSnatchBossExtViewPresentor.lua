-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBossExtViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBossExtViewPresentor", package.seeall)

local SummerTreasureSnatchBossExtViewPresentor = class("SummerTreasureSnatchBossExtViewPresentor", ViewPresentor)

function SummerTreasureSnatchBossExtViewPresentor:ctor()
	SummerTreasureSnatchBossExtViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchBossExtViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummerTreasureSnatchBossExtViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchbossextview.prefab"
	}
end

function SummerTreasureSnatchBossExtViewPresentor:buildViews()
	return {
		SummerTreasureSnatchBossExtView.New()
	}
end

return SummerTreasureSnatchBossExtViewPresentor
