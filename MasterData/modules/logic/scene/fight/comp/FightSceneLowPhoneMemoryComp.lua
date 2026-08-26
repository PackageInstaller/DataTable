-- chunkname: @modules/logic/scene/fight/comp/FightSceneLowPhoneMemoryComp.lua

module("modules.logic.scene.fight.comp.FightSceneLowPhoneMemoryComp", package.seeall)

local FightSceneLowPhoneMemoryComp = class("FightSceneLowPhoneMemoryComp", BaseSceneComp)

function FightSceneLowPhoneMemoryComp:onScenePrepared(sceneId, levelId)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self._onRoundEnd, self)
end

function FightSceneLowPhoneMemoryComp:_onRoundEnd()
	logNormal("clear no use effect")
	FightHelper.clearNoUseEffect()
end

function FightSceneLowPhoneMemoryComp:onSceneClose(sceneId, levelId)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self._onRoundEnd, self)
end

return FightSceneLowPhoneMemoryComp
