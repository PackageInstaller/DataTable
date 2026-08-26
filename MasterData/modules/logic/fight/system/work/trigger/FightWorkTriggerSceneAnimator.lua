-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerSceneAnimator.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerSceneAnimator", package.seeall)

local FightWorkTriggerSceneAnimator = class("FightWorkTriggerSceneAnimator", BaseWork)

function FightWorkTriggerSceneAnimator:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerSceneAnimator:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	local fightScene = GameSceneMgr.instance:getCurScene()

	if fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		if sceneObj then
			FightController.instance:dispatchEvent(FightEvent.TriggerSceneAnimator, self._config)
		end
	end

	self:onDone(true)
end

function FightWorkTriggerSceneAnimator:clearWork()
	return
end

return FightWorkTriggerSceneAnimator
