-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompDieHandler.lua

module("logic.battle.unit.comp.BattleUnitCompDieHandler", package.seeall)

local BattleUnitCompDieHandler = class("BattleUnitCompDieHandler", BattleUnitCompBase)
local kLocalSettingKey = "BattleUnitCompDieHandler"

function BattleUnitCompDieHandler:onInit()
	self._deadTimelineTask = TimelineTask.New()
	self._deathEffectCode = false
	self._deathTimelinePlayer = false
	self._isLogicRemoved = false
	self._isPerformanced = false
end

function BattleUnitCompDieHandler:onReset()
	self._isLogicRemoved = false
	self._isPerformanced = false

	self._deadTimelineTask:clear()

	if self._timelineTask then
		self._timelineTask:clear()
	end

	self:_clearDeadTimelinePlayer()
end

function BattleUnitCompDieHandler:onDestroy()
	self._deadTimelineTask:clear()

	if self._timelineTask then
		self._timelineTask:clear()
	end

	self:_clearDeadTimelinePlayer()
end

function BattleUnitCompDieHandler:onRevive()
	self._deadTimelineTask:clear()

	if self._timelineTask then
		self._timelineTask:clear()
	end

	self:_clearDeadTimelinePlayer()
end

function BattleUnitCompDieHandler:setLogicRemoved()
	self._isLogicRemoved = true

	if self._isPerformanced then
		self:_hideUnit()
	end
end

function BattleUnitCompDieHandler:isPerformanced()
	return self._isPerformanced
end

function BattleUnitCompDieHandler:handleDie(deadType, isSanityDeath)
	local unit = self._unit

	isSanityDeath = isSanityDeath or unit.property:getDeadPerformLost()
	self._deadType = deadType
	self._isSanityDeath = isSanityDeath
	self._deathEffectCode = self:_getDeathEffectCode(isSanityDeath)

	if isSanityDeath then
		self:_adjustCameraPosAndHandleDie()
	else
		self:_handleDie()
	end
end

function BattleUnitCompDieHandler:_adjustCameraPosAndHandleDie()
	local cmd = BattleAdjustFollowCenterCommand:create(0, self._unit.property:getEntityId())
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local runningContext = flow.cmdExecuter:getContext()

	cmd:execute(flow, runningContext)

	local duaration = runningContext:getParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime)

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(duaration, self._onAdjustCameraFinish, self)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:start()
end

function BattleUnitCompDieHandler:_onAdjustCameraFinish()
	self:_handleDie()
end

function BattleUnitCompDieHandler:_handleDie()
	local deadType = self._deadType
	local isSanityDeath = self._isSanityDeath
	local unit = self._unit

	if deadType == BattleEnum.PerformanceDeadType.Animation then
		local deathAnimation = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)

		if not unit.meshModel:containsAnimation(deathAnimation) then
			if enableWarnLog then
				printWarn("cannot find animation", deathAnimation)
			end

			self:_playDeadEffect()

			return
		end

		if unit.stateEffect:isFrozen() then
			self:_playDeadEffect()

			return
		end

		if isSanityDeath then
			self:_playDeadEffect()
			self._unit.effectPlayer:stopLoopEffect(BattleConst.LOW_SANITY)
		end

		self:_playDeadAnimation(not isSanityDeath)
	elseif deadType == BattleEnum.PerformanceDeadType.FrozenDeath then
		local deathAnimation = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)

		unit.meshModel:frozenAnimationToLastFrame(deathAnimation)
		self:_playDeadEffect()
	else
		self:_playDeadEffect()
	end
end

function BattleUnitCompDieHandler:_playDeadAnimation(needWaitAnimation)
	local unit = self._unit

	unit.meshModel:clearQueue()
	unit.material:killAll(true)
	unit.material:doMainAlpha(1, 0)
	unit.material:setAlphaEnable(false)
	unit.stateEffect:refreshStateEffect()
	unit.property:activeState(BattleEnum.State.PLAYING_DEAD_ANIMATION)
	BattleUnitDieUtil.playDeathAnimation(unit, true)

	if needWaitAnimation then
		local myDeathAnimation = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)
		local duration = unit.meshModel:getAnimationDuration(myDeathAnimation)

		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(duration)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:addFinishListener(self._onAnimationPlayFinish, self)
		self._timelineTask:start()
	end
end

function BattleUnitCompDieHandler:handleDisappear()
	local unit = self._unit

	unit.material:doMainAlpha(0, 1)
	unit.material:setAlphaEnable(true)
	unit.effectPlayer:playEffect(BattleCampAdjustmentUtil.getPlaceEffectId(unit))
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityHandleDie, unit.property:getEntityId())
	self:_hideUIForDeath()
	self._deadTimelineTask:clear()
	self._deadTimelineTask:addTask(1, self._tCompleteDeadEffect, self)
	self._deadTimelineTask:setTimeScale(BattleTime.timeScale)
	self._deadTimelineTask:start()
end

function BattleUnitCompDieHandler:_onAnimationPlayFinish()
	self._unit.property:inactiveState(BattleEnum.State.PLAYING_DEAD_ANIMATION)
	self:_playDeadEffect()
end

function BattleUnitCompDieHandler:_playDeadEffect()
	self:_hideUIForDeath()

	local url = EffectUtil.getEffectUrl(self._deathEffectCode)
	local player = SkillSimpleSoloPlayer:createInstance()

	self._deathTimelinePlayer = player

	player:setUnit(self._unit)
	player:setBuildResourceListener(self._onBuildEffect, self)
	player:setFinishListener(self._onEffectFinish, self)
	player:play(url)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_dead, nil, nil, nil)
end

function BattleUnitCompDieHandler:_hideUIForDeath()
	self._unit.uiProxy:setVisible(false, true)
	self._unit.sceneProxy:setVisible(false)
	self._unit.buff:clearAllBuff()
end

function BattleUnitCompDieHandler:_onBuildEffect(directorSetter, goTimeline)
	local goFeature = goutil.findChild(goTimeline, SkillTimelineContext.UnitFeature)

	if not goFeature then
		return
	end

	SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goFeature, self._unit.mountRoot:getAvatarRoot())
end

function BattleUnitCompDieHandler:_onEffectFinish()
	self:_removeUnitFromScene()
end

function BattleUnitCompDieHandler:_tCompleteDeadEffect()
	self:_removeUnitFromScene()
end

function BattleUnitCompDieHandler:removeUnitFromScene()
	self:_removeUnitFromScene()
end

function BattleUnitCompDieHandler:_removeUnitFromScene()
	self._isPerformanced = true

	if not self._isLogicRemoved then
		local entityId = self._unit.property:getEntityId()

		if BattleLog.enableLog then
			BattleLog.log(string.format("unit[%s] will not destroy,because it is not remove from logic", entityId))
		end

		return
	end

	self:_hideUnit()
end

function BattleUnitCompDieHandler:_getDeathEffectCode(isSanityDeath)
	if isSanityDeath then
		return BattleConst.EFFECT_DEATH_ROLE
	end

	if not self._unit.transform:isComposite() then
		return BattleConst.EFFECT_DEATH_MONSTERS[1]
	end

	local rectangle = self._unit.transform:getRectangle()
	local size = rectangle:getMaxx() - rectangle:getMinx() + 1
	local effectIndex = Mathf.Clamp(size, 1, #BattleConst.EFFECT_DEATH_MONSTERS)

	return BattleConst.EFFECT_DEATH_MONSTERS[effectIndex]
end

function BattleUnitCompDieHandler:_clearDeadTimelinePlayer()
	if self._deathTimelinePlayer then
		self._deathTimelinePlayer:returnSelf()

		self._deathTimelinePlayer = false
	end
end

function BattleUnitCompDieHandler:_hideUnit()
	self._unit:setVisible(false, kLocalSettingKey)
end

return BattleUnitCompDieHandler
