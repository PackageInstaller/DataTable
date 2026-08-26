-- chunkname: @modules/logic/scene/fight/comp/FightSceneViewComp.lua

module("modules.logic.scene.fight.comp.FightSceneViewComp", package.seeall)

local FightSceneViewComp = class("FightSceneViewComp", BaseSceneComp)

function FightSceneViewComp:onScenePrepared(sceneId, levelId)
	return
end

function FightSceneViewComp:onSceneClose(sceneId, levelId)
	FightTLDeviceCardTriggerPowerEffect.clearFlyNode()
	ViewMgr.instance:closeView(ViewName.FightView)
	ViewMgr.instance:closeView(ViewName.FightSkillSelectView, true)
	ViewMgr.instance:closeView(ViewName.FightTechniqueView, true)
	ViewMgr.instance:closeView(ViewName.FightTechniqueTipsView, true)
	ViewMgr.instance:closeView(ViewName.FightStatView, true)
	ViewMgr.instance:closeView(ViewName.FightSkillTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightCardIntroduceView, true)
	ViewMgr.instance:closeView(ViewName.FightCardMixIntroduceView, true)
	ViewMgr.instance:closeView(ViewName.FightCardDescView, true)
	ViewMgr.instance:closeView(ViewName.FightFocusView, true)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView, true)
	ViewMgr.instance:closeView(ViewName.FightSpecialTipView, true)
	ViewMgr.instance:closeView(ViewName.FightQuitTipView, true)
	ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	ViewMgr.instance:closeView(ViewName.FightDiceView, true)
	ViewMgr.instance:closeView(ViewName.HelpView, true)
	SeasonFightHandler.closeSeasonFightRuleTipView()
	ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)
	ViewMgr.instance:closeView(ViewName.FightSeasonChangeHeroSelectView, true)
	ViewMgr.instance:closeView(ViewName.FightChangeHeroSelectSkillTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightNaNaTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightCardDeckView, true)
	ViewMgr.instance:closeView(ViewName.FightBloodPoolTipsView, true)
	ViewMgr.instance:closeView(ViewName.FightAiJiAoQteView, true)
	ViewMgr.instance:closeView(ViewName.FightAiJiAoQteSelectView, true)
	ViewMgr.instance:closeView(ViewName.FightPlayChoiceCardView, true)
	ViewMgr.instance:closeView(ViewName.FightNuoDiKaQteView, true)
	ViewMgr.instance:closeView(ViewName.FightBLESelectCrystalView, true)
	ViewMgr.instance:closeView(ViewName.FightS02SSWLSelectCardView, true)
	ViewMgr.instance:closeView(ViewName.Fight3_5BaiFuZhangWheelSelectCardView, true)
	ViewMgr.instance:closeView(ViewName.Fight3_5BaiFuZhangWheelView, true)
end

return FightSceneViewComp
