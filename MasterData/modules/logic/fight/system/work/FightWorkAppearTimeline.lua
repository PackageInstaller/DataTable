-- chunkname: @modules/logic/fight/system/work/FightWorkAppearTimeline.lua

module("modules.logic.fight.system.work.FightWorkAppearTimeline", package.seeall)

local FightWorkAppearTimeline = class("FightWorkAppearTimeline", BaseWork)

function FightWorkAppearTimeline.getAppearTimeline()
	if FightDataHelper.stateMgr.isReplay then
		return false, nil
	end

	local enemyEntityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local timeline = monsterGroupCO and monsterGroupCO.appearTimeline

	if string.nilorempty(timeline) then
		return false, nil
	end

	local timelineExtendCo = lua_fight_appear_timeline_extend.configDict[monsterGroupId]

	if timelineExtendCo then
		local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(timelineExtendCo.monsterIdList, "#")

		if monsterIdList then
			for _, monsterId in ipairs(monsterIdList) do
				local entity = FightWorkAppearTimeline.getTargetEntity(enemyEntityList, monsterId)

				if entity then
					return timeline, entity
				end
			end
		end

		return false, nil
	end

	if monsterGroupCO then
		if not monsterGroupCO.appearMonsterId then
			local monsterId = 0

			if monsterId == 0 then
				return false, nil
			end

			local targetEntity = FightWorkAppearTimeline.getTargetEntity(enemyEntityList, monsterId)

			if not targetEntity then
				return false, nil
			end

			return timeline, targetEntity
		end
	end
end

function FightWorkAppearTimeline.getTargetEntity(enemyEntityList, monsterId)
	for _, entity in ipairs(enemyEntityList) do
		if entity:getMO().modelId == monsterId then
			return entity
		end
	end
end

function FightWorkAppearTimeline:onStart()
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)

	if FightDataHelper.stateMgr.isReplay then
		self:onDone(true)

		return
	end

	self._timeline, self._targetEntity = FightWorkAppearTimeline.getAppearTimeline()

	if not self._timeline or string.nilorempty(self._timeline) then
		self:onDone(true)

		return
	end

	if not self._targetEntity then
		self:onDone(true)

		return
	end

	self:_beforePlayAppearTimeline()

	if self:_checkAllSpineLoaded() then
		self:_playTimeline()
	else
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onOneSpineLoaded, self)
		TaskDispatcher.runDelay(self._spineLoadedTimeout, self, 1)
	end
end

function FightWorkAppearTimeline:_beforePlayAppearTimeline()
	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		self:_hideEntity(entity)
	end

	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
end

function FightWorkAppearTimeline:_onOneSpineLoaded(unitSpine)
	self:_hideEntity(unitSpine.unitSpawn)

	if self:_checkAllSpineLoaded() then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onOneSpineLoaded, self)
		TaskDispatcher.cancelTask(self._spineLoadedTimeout, self)
		self:_playTimeline()
	end
end

function FightWorkAppearTimeline:_checkAllSpineLoaded()
	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		if entity.spine and gohelper.isNil(entity.spine:getSpineGO()) then
			return false
		end
	end

	return true
end

function FightWorkAppearTimeline:_spineLoadedTimeout()
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onOneSpineLoaded, self)
	self:_playTimeline()
end

function FightWorkAppearTimeline:_playTimeline()
	FightController.instance:registerCallback(FightEvent.SkipAppearTimeline, self._skipAppearTimeline, self)
	ViewMgr.instance:openView(ViewName.FightSkipTimelineView, self._timeline)

	local info = {
		actType = FightEnum.ActType.SKILL,
		fromId = self._targetEntity.id,
		toId = self._targetEntity.id,
		actId = FightEnum.AppearTimelineSkillId,
		actEffect = {}
	}
	local fakeFightStepData = FightStepData.New(info)

	fakeFightStepData.isFakeStep = true

	TaskDispatcher.runDelay(self._delayDone, self, 25)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self, LuaEventSystem.Low)
	self._targetEntity.skill:playTimeline(self._timeline, fakeFightStepData)
end

function FightWorkAppearTimeline:_skipAppearTimeline()
	if self._targetEntity and self._targetEntity.skill then
		self._targetEntity.skill:skipSkill()
		GameSceneMgr.instance:getScene(SceneType.Fight).camera:enableClearSlot(0.1)
	end
end

function FightWorkAppearTimeline:_onSkillEnd(attacker, skillId)
	self:_done()
end

function FightWorkAppearTimeline:_delayDone()
	logError("skill play timeout, skillId = " .. self._timeline)
	self:_done()
end

function FightWorkAppearTimeline:_done()
	self:_afterPlayAppearTimeline()
	self:_removeEvents()
	self:onDone(true)
end

function FightWorkAppearTimeline:_removeEvents()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._spineLoadedTimeout, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onOneSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)
	FightController.instance:unregisterCallback(FightEvent.SkipAppearTimeline, self._skipAppearTimeline, self)
end

function FightWorkAppearTimeline:_hideEntity(entity)
	if not entity then
		return
	end

	if entity.nameUI then
		entity.nameUI:setActive(false)
	end

	if entity.setAlpha then
		entity:setAlpha(0, 0)
	end
end

function FightWorkAppearTimeline:_afterPlayAppearTimeline()
	ViewMgr.instance:closeView(ViewName.FightSkipTimelineView)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	FightController.instance:dispatchEvent(FightEvent.AfterPlayAppearTimeline)
	TaskDispatcher.runDelay(self._delayRefreshAlpha, self, 0.01)

	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		if entity:isEnemySide() and entity.nameUI then
			entity.nameUI:setActive(true)
		end
	end
end

function FightWorkAppearTimeline:_delayRefreshAlpha()
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function FightWorkAppearTimeline:onResume()
	logError("skill step can't resume")
end

function FightWorkAppearTimeline:clearWork()
	self:_removeEvents()
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function FightWorkAppearTimeline:onDestroy()
	FightWorkAppearTimeline.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._delayRefreshAlpha, self)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

return FightWorkAppearTimeline
