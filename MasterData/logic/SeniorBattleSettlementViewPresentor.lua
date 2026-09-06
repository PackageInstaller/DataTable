-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorBattleSettlementViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorBattleSettlementViewPresentor", package.seeall)

local SeniorBattleSettlementViewPresentor = class("SeniorBattleSettlementViewPresentor", ViewPresentor)

function SeniorBattleSettlementViewPresentor:ctor()
	SeniorBattleSettlementViewPresentor.super.ctor(self)
end

function SeniorBattleSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorBattleSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorbattlesettlementview.prefab"
	}
end

function SeniorBattleSettlementViewPresentor:buildViews()
	return {
		SeniorBattleSettlementView.New()
	}
end

return SeniorBattleSettlementViewPresentor
