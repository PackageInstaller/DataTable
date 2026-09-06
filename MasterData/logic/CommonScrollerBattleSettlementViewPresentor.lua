-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/CommonScrollerBattleSettlementViewPresentor.lua

module("logic.extensions.youtharenathird.view.CommonScrollerBattleSettlementViewPresentor", package.seeall)

local CommonScrollerBattleSettlementViewPresentor = class("CommonScrollerBattleSettlementViewPresentor", ViewPresentor)

function CommonScrollerBattleSettlementViewPresentor:ctor()
	CommonScrollerBattleSettlementViewPresentor.super.ctor(self)
end

function CommonScrollerBattleSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CommonScrollerBattleSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/commonscrollerbattlesettlementview.prefab"
	}
end

function CommonScrollerBattleSettlementViewPresentor:buildViews()
	return {
		CommonScrollerBattleSettlementView.New()
	}
end

return CommonScrollerBattleSettlementViewPresentor
