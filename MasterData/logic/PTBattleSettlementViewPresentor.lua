-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/PTBattleSettlementViewPresentor.lua

module("logic.extensions.peaktournament.view.common.PTBattleSettlementViewPresentor", package.seeall)

local PTBattleSettlementViewPresentor = class("PTBattleSettlementViewPresentor", ViewPresentor)

function PTBattleSettlementViewPresentor:ctor()
	PTBattleSettlementViewPresentor.super.ctor(self)
end

function PTBattleSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTBattleSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorbattlesettlementview.prefab"
	}
end

function PTBattleSettlementViewPresentor:buildViews()
	return {
		PTBattleSettlementView.New()
	}
end

return PTBattleSettlementViewPresentor
