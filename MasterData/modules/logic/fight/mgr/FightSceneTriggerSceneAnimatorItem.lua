-- chunkname: @modules/logic/fight/mgr/FightSceneTriggerSceneAnimatorItem.lua

module("modules.logic.fight.mgr.FightSceneTriggerSceneAnimatorItem", package.seeall)

local FightSceneTriggerSceneAnimatorItem = class("FightSceneTriggerSceneAnimatorItem", FightBaseClass)

function FightSceneTriggerSceneAnimatorItem:onConstructor()
	self.activeState = true
	self.cacheAni = {}

	self:com_registFightEvent(FightEvent.TriggerSceneAnimator, self._onTriggerSceneAnimator)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStageBefore)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset)
	self:_onLevelLoaded()
end

function FightSceneTriggerSceneAnimatorItem:_onLevelLoaded()
	self._fightScene = GameSceneMgr.instance:getCurScene()

	if not self._fightScene then
		return
	end

	if not self._fightScene.level then
		return
	end

	local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

	if not sceneObj then
		return
	end

	self.listenClass = gohelper.onceAddComponent(sceneObj, typeof(ZProj.FightSceneActiveState))

	if BootNativeUtil.isWindows() then
		local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

		if quality == ModuleEnum.Performance.High then
			RenderPipelineSetting.AddRCASSceneCompoment(sceneObj)
		end
	end

	self.listenClass:releaseCallback()
	self.listenClass:setCallback(self._onSceneStateChange, self)
end

function FightSceneTriggerSceneAnimatorItem:_onTriggerSceneAnimator(config)
	self._fightScene = self._fightScene or GameSceneMgr.instance:getCurScene()

	if self._fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		if not gohelper.isNil(sceneObj) then
			local ani = gohelper.findChildComponent(sceneObj, config.param1, typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play(config.param2, 0, 0)

				self.cacheAni[config.param1] = config.param2
			end
		end
	end
end

function FightSceneTriggerSceneAnimatorItem:_onSceneStateChange(state)
	FightController.instance:dispatchEvent(FightEvent.ChangeSceneVisible, state)

	if self._fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		if not gohelper.isNil(sceneObj) and self.activeState ~= state then
			self.activeState = state

			if self.activeState then
				for path, aniName in pairs(self.cacheAni) do
					local ani = gohelper.findChildComponent(sceneObj, path, typeof(UnityEngine.Animator))

					if ani then
						ani.speed = FightModel.instance:getSpeed()

						ani:Play(aniName .. "_idle", 0, 0)
					end
				end
			end
		end
	end
end

function FightSceneTriggerSceneAnimatorItem:_onRestartStageBefore()
	self.activeState = true
	self.cacheAni = {}
end

function FightSceneTriggerSceneAnimatorItem:_onSwitchPlaneClearAsset()
	self.activeState = true
	self.cacheAni = {}
end

function FightSceneTriggerSceneAnimatorItem:onDestructor()
	if self.listenClass then
		self.listenClass:releaseCallback()

		self.listenClass = nil
	end
end

return FightSceneTriggerSceneAnimatorItem
