-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerSceneEffect.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerSceneEffect", package.seeall)

local FightWorkTriggerSceneEffect = class("FightWorkTriggerSceneEffect", BaseWork)

function FightWorkTriggerSceneEffect:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerSceneEffect:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	local fightScene = GameSceneMgr.instance:getCurScene()

	if fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		if sceneObj then
			local sceneEntity = FightHelper.getEntity(FightEntityScene.MySideId)

			if sceneEntity then
				if self._config.param2 == 0 then
					sceneEntity.effect:removeEffectByEffectName(self._config.param1)
				else
					sceneEntity.effect:addGlobalEffect(self._config.param1)
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkTriggerSceneEffect:clearWork()
	return
end

return FightWorkTriggerSceneEffect
