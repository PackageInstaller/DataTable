-- chunkname: @modules/logic/fight/mgr/FightSceneTriggerSceneAnimatorMgr.lua

module("modules.logic.fight.mgr.FightSceneTriggerSceneAnimatorMgr", package.seeall)

local FightSceneTriggerSceneAnimatorMgr = class("FightSceneTriggerSceneAnimatorMgr", FightBaseClass)

function FightSceneTriggerSceneAnimatorMgr:onConstructor()
	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)
end

function FightSceneTriggerSceneAnimatorMgr:_onLevelLoaded()
	if self.sceneItemClass then
		self.sceneItemClass:disposeSelf()

		self.sceneItemClass = nil
	end

	self.sceneItemClass = self:newClass(FightSceneTriggerSceneAnimatorItem)
end

function FightSceneTriggerSceneAnimatorMgr:onDestructor()
	return
end

return FightSceneTriggerSceneAnimatorMgr
