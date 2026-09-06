-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBattleSettlementViewPresentor.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBattleSettlementViewPresentor", package.seeall)

local SummerTreasureSnatchBattleSettlementViewPresentor = class("SummerTreasureSnatchBattleSettlementViewPresentor", ViewPresentor)

function SummerTreasureSnatchBattleSettlementViewPresentor:ctor()
	SummerTreasureSnatchBattleSettlementViewPresentor.super.ctor(self)
end

function SummerTreasureSnatchBattleSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerTreasureSnatchBattleSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/summertreasuresnatch/summertreasuresnatchbattlesettlementview.prefab"
	}
end

function SummerTreasureSnatchBattleSettlementViewPresentor:buildViews()
	return {
		SummerTreasureSnatchBattleSettlementView.New()
	}
end

return SummerTreasureSnatchBattleSettlementViewPresentor
