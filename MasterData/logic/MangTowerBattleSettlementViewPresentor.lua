-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTowerBattleSettlementViewPresentor.lua

module("logic.extensions.mangtower.view.MangTowerBattleSettlementViewPresentor", package.seeall)

local MangTowerBattleSettlementViewPresentor = class("MangTowerBattleSettlementViewPresentor", ViewPresentor)

function MangTowerBattleSettlementViewPresentor:ctor()
	MangTowerBattleSettlementViewPresentor.super.ctor(self)
end

function MangTowerBattleSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MangTowerBattleSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/mangtower/mangtowerbattlesettlementview.prefab"
	}
end

function MangTowerBattleSettlementViewPresentor:buildViews()
	return {
		MangTowerBattleSettlementView.New()
	}
end

return MangTowerBattleSettlementViewPresentor
