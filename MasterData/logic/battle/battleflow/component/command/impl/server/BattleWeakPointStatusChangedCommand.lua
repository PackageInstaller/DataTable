-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleWeakPointStatusChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleWeakPointStatusChangedCommand", package.seeall)

local BattleWeakPointStatusChangedCommand = class("BattleWeakPointStatusChangedCommand", BattleTimingCommandBase)

function BattleWeakPointStatusChangedCommand:parseServerCommand(cmdParser, weakPointStatusChangedEventNO)
	local cmd = BattleWeakPointStatusChangedCommand:createInstance()

	cmd:setEntityId(weakPointStatusChangedEventNO.entity)
	cmd:setType(weakPointStatusChangedEventNO.type)

	local beforeList = BattleTableUtil.getTempList()
	local afterList = BattleTableUtil.getTempList()
	local handlers = BattleTableUtil.getTempList()

	BattleWeakPointStatusChangedCommand:_splitEffects(weakPointStatusChangedEventNO.effects, beforeList, afterList)

	local sequenceCmd = BattleSequenceCommand:createInstance()

	if BattleGroupEntityAddCommand:hasGroupEntityAddEffect(weakPointStatusChangedEventNO.entity) and #beforeList > 0 then
		for _, eventNO in ipairs(beforeList) do
			local entityAddHandler = SkillAttackPointHandlerUtil.parseEventNO2Handler(eventNO)

			if entityAddHandler then
				table.insert(handlers, entityAddHandler)
			end
		end

		sequenceCmd:addCommand(BattleGroupEntityAddCommand:create(weakPointStatusChangedEventNO.entity, handlers))
	else
		sequenceCmd:addCommand(BattleParallelCommand:create(cmdParser, beforeList))
	end

	sequenceCmd:addCommand(BattleParallelCommand:create(cmdParser, afterList))
	BattleTableUtil.releaseTempList(beforeList)
	BattleTableUtil.releaseTempList(afterList)
	BattleTableUtil.releaseTempList(handlers)
	cmd:setEffectCommand(sequenceCmd)
	cmdParser:addCommand(cmd)
end

function BattleWeakPointStatusChangedCommand:_splitEffects(effects, beforeList, afterList)
	for _, eventNO in ipairs(effects) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_entitiesAdded) then
			table.insert(beforeList, eventNO)
		else
			table.insert(afterList, eventNO)
		end
	end
end

function BattleWeakPointStatusChangedCommand:calculateUnitFocusPosition(unit)
	return BattleUnitUtil.getUnitDiffFocusPos(unit)
end

function BattleWeakPointStatusChangedCommand:onInit()
	self._entityId = false
	self._type = 0
	self._effectCommand = false
	self._timelineTask = TimelineTask.New()
	self._waitingTaskCount = 0
end

function BattleWeakPointStatusChangedCommand:onClear(interrupt)
	if self._effectCommand then
		self._effectCommand:safeInterrupt()

		self._effectCommand = false
	end

	self._type = 0
	self._entityId = false
	self._waitingTaskCount = 0

	self._timelineTask:clear()
end

function BattleWeakPointStatusChangedCommand:_clear(interrupt)
	if interrupt and self._effectCommand then
		self._effectCommand:clear(true)
	end
end

function BattleWeakPointStatusChangedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleWeakPointStatusChangedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	local isBroken = self._type == 0

	if isBroken then
		BattleDispatcher:dispatchEvent(BattleEventType.OnWeakPointBroken, self._entityId)
	end

	if unit.property:isStateActive(BattleEnum.State.DEAD) then
		self:_processImmediately(unit)

		return
	end

	if isBroken then
		self:_processWeakPointBroken(unit)
	else
		self:_processWeakPointResume(unit)
	end
end

function BattleWeakPointStatusChangedCommand:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:_tryFinish()
end

function BattleWeakPointStatusChangedCommand:_onTimelineTaskFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if unit and unit.property:isStateActive(BattleEnum.State.PLAYING_DEAD_ANIMATION) then
		BattleUnitDieUtil.handleDie(unit)
	end

	self:_tryFinish()
end

function BattleWeakPointStatusChangedCommand:_onLinkWeakPointTimelineTaskFinish()
	self:_executeEffectCommands()
	self:_tryFinish()
end

function BattleWeakPointStatusChangedCommand:_initWaitingTask()
	self._waitingTaskCount = 2
end

function BattleWeakPointStatusChangedCommand:_tryFinish()
	self._waitingTaskCount = self._waitingTaskCount - 1

	if self._waitingTaskCount <= 0 then
		self:finish(true)
	end
end

function BattleWeakPointStatusChangedCommand:_processImmediately(unit)
	self._waitingTaskCount = 1

	self:_executeEffectCommands()
end

function BattleWeakPointStatusChangedCommand:_processWeakPointBroken(unit)
	local weakPointSkill = unit.skill:getWeakPointSkill()

	self:_initWaitingTask()
	unit.property:inactiveState(BattleEnum.State.HAS_WEAK_POINT)
	unit.property:inactiveState(BattleEnum.State.WEAK_POINT_PERFORMANCED)
	unit.property:activeState(BattleEnum.State.WEAKPOINT_FROZEN)

	local isShowWeakPointFrozen = BattleUnitUtil.isShowWeakPointFrozen(unit)

	if not isShowWeakPointFrozen then
		local duaration = unit.meshModel:getAnimationDuration(UnitAnimState.Change) + BattleConst.DelayZeroPointOne

		self._timelineTask:addTask(0, self._tLinkWeakPointBrokenFocusUnit, self)
		self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayLinkWeakPointBrokenEffect, self)
		self._timelineTask:addTask(duaration)
		self._timelineTask:addFinishListener(self._onLinkWeakPointTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(unit)
	else
		self._timelineTask:addTask(0, self._tFocusUnit, self)
		self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayBrokenEffect, self)
		self._timelineTask:addTask(0.5, self._tEnableGlichEffect, self)
		self._timelineTask:addTask(0.43, self._tBrokenChangeMaterial, self)
		self._timelineTask:addTask(BattleConst.HitHalfTime, self._tFrozenHitAnimation, self)
		self._timelineTask:addTask(BattleConst.DelayOne)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(unit)
	end
end

function BattleWeakPointStatusChangedCommand:_tLinkWeakPointBrokenFocusUnit(unit)
	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

	VirtualCameraMgr.instance:doFollowPosition(x, y, z, BattleConst.DelayZeroPointOne)
end

function BattleWeakPointStatusChangedCommand:_tPlayLinkWeakPointBrokenEffect(unit)
	self:_interruptMultiSkill(unit)
	unit.bubble:showBubble(BattleEnum.BubbleType.SKILL_TRIGGER_HINT, BattleConst.WeakPointBrokenSkillCode, BattleConst.DelayOne)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
end

function BattleWeakPointStatusChangedCommand:_tFocusUnit(unit)
	local x, y, z = BattleWeakPointStatusChangedCommand:calculateUnitFocusPosition(unit)

	VirtualCameraMgr.instance:doFollowPosition(x, y, z, BattleConst.DelayZeroPointOne)
end

function BattleWeakPointStatusChangedCommand:_tPlayHitAnimation(unit)
	unit.meshModelMover:playMappedAnimationIfExists(UnitAnimState.Hit, false, true)
	BattleUnitUtil.play3dAudio(unit, unit.property:getHitAudio())
end

function BattleWeakPointStatusChangedCommand:_tEnableGlichEffect(unit)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH, true, BattleConst.DefaultStateKey)
end

function BattleWeakPointStatusChangedCommand:_tPlayBrokenEffect(unit)
	BattleDispatcher:dispatchEvent(BattleEventType.OnStartPlayWeakPointBroken, unit.property:getEntityId())

	if BattleMapEnum.WeakPointBreakEffect[unit.property:getModelCode()] then
		self:_tPlaySpecialBrokenEffect(unit)
	else
		self:_tPlayNormalBrokenEffect(unit)
	end
end

function BattleWeakPointStatusChangedCommand:_tPlayNormalBrokenEffect(unit)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_break_freeze, nil, nil, nil)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local effectUnit = unit.effectPlayer:playEffect(BattleConst.WEAK_POINT_BROKEN, EffectTimelineUnit)
	local size = unit.meshModel:getBodySize()
	local goAvatar = unit.mountRoot:getAvatarRoot()
	local x, y, z = TransformUtils.GetLocalPosition(goAvatar.transform, 0, 0, 0)

	effectUnit.transform:setLocalPositionXYZ(x, size.y, z)
	effectUnit.bindings:setGenericBinding(SkillTimelineContext.NormalRelativeVirtualCameraTrack, virtualCamera:getVirtualCameraAnimator())
end

function BattleWeakPointStatusChangedCommand:_tPlaySpecialBrokenEffect(unit)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_break_freeze, nil, nil, nil)

	local effectUnit = unit.effectPlayer:playEffect(BattleMapEnum.WeakPointBreakEffect[unit.property:getModelCode()].effectCode, EffectTimelineUnit)
	local goAvatar = unit.mountRoot:getAvatarRoot()
	local x, y, z = TransformUtils.GetLocalPosition(goAvatar.transform, 0, 0, 0)

	effectUnit.transform:setLocalPositionXYZ(x, 0, z)
end

function BattleWeakPointStatusChangedCommand:_tBrokenChangeMaterial(unit)
	self:_executeEffectCommands()
	self:_interruptMultiSkill(unit)
	unit.material:switchMaterial(BattleResourceName.WeakpointBrokenMaterial, true)
	unit.meshModelMover:playMappedAnimation(UnitAnimState.Hit, false, true)
	BattleUnitUtil.play3dAudio(unit, unit.property:getHitAudio())
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	self:_setPermanentEffectVisible(unit, false)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH, false, BattleConst.DefaultStateKey)
end

function BattleWeakPointStatusChangedCommand:_tFrozenHitAnimation(unit)
	unit.stateEffect:refreshStateEffect()
end

function BattleWeakPointStatusChangedCommand:_interruptMultiSkill(unit)
	BattleEntityDeadCommand:interruptMultiSkill(unit)
end

function BattleWeakPointStatusChangedCommand:_setPermanentEffectVisible(unit, visible)
	local effectUnit = unit.effectPlayer:getLoopEffect(BattleConst.ELITE_ENEMY_EFFECT)

	if not effectUnit then
		return
	end

	goutil.setActive(effectUnit.mainGO, visible)
end

function BattleWeakPointStatusChangedCommand:_processWeakPointResume(unit)
	local weakPointSkill = unit.skill:getWeakPointSkill()
	local isShowWeakPointFrozen = BattleUnitUtil.isShowWeakPointFrozen(unit)

	self:_initWaitingTask()
	unit.property:activeState(BattleEnum.State.HAS_WEAK_POINT)
	unit.property:inactiveState(BattleEnum.State.WEAK_POINT_PERFORMANCED)
	unit.property:inactiveState(BattleEnum.State.WEAKPOINT_FROZEN)

	if isShowWeakPointFrozen then
		local duaration = unit.meshModel:getAnimationDuration(UnitAnimState.Change) + BattleConst.DelayZeroPointOne

		self._timelineTask:addTask(0, self._tLinkWeakPointBrokenFocusUnit, self)
		self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayLinkWeakPointResumeEffect, self)
		self._timelineTask:addTask(duaration)
		self._timelineTask:addFinishListener(self._onLinkWeakPointTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(unit)
	else
		self._timelineTask:addTask(0, self._tFocusUnit, self)
		self._timelineTask:addTask(BattleConst.DelayZeroPointTwo)
		self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayWeakPointResumeEffect, self)
		self._timelineTask:addTask(BattleConst.DelayZeroPointFive, self._tResumeChangeMaterial, self)
		self._timelineTask:addTask(BattleConst.DelayOnePointFive)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(unit)
	end
end

function BattleWeakPointStatusChangedCommand:_tPlayWeakPointResumeEffect(unit)
	local effectCode = unit.transform:isComposite() and BattleConst.WEAK_POINT_RESUME_BOSS or BattleConst.WEAK_POINT_RESUME
	local effectUnit = unit.effectPlayer:playEffect(effectCode, false)
	local size = unit.meshModel:getBodySize()
	local goAvatar = unit.mountRoot:getAvatarRoot()
	local x, y, z = TransformUtils.GetLocalPosition(goAvatar.transform, 0, 0, 0)

	effectUnit.transform:setLocalPositionXYZ(x, size.y, z)
end

function BattleWeakPointStatusChangedCommand:_tResumeChangeMaterial(unit)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	unit.stateEffect:refreshStateEffect()
	self:_setPermanentEffectVisible(unit, true)
	self:_executeEffectCommands()
end

function BattleWeakPointStatusChangedCommand:_tPlayLinkWeakPointResumeEffect(unit)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Idle)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Hit)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Hit2)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Death)
	unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Change2)
	unit.stateEffect:refreshStateEffect()
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
end

function BattleWeakPointStatusChangedCommand:_executeEffectCommands()
	if not self._effectCommand then
		return
	end

	local battleFlow = BattleMgr.instance:getActiveBattleFlow()
	local runningContext = BattleMgr.instance:getCmdExecuter():getContext()

	self._effectCommand:setCommandHandler(self)
	self._effectCommand:execute(battleFlow, runningContext)
end

function BattleWeakPointStatusChangedCommand:toString()
	return string.format("[weak point status changed command entityId = %s, type = %s,commands = %s]", self._entityId, self._type, self._effectCommand:toString())
end

function BattleWeakPointStatusChangedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleWeakPointStatusChangedCommand:setType(type)
	self._type = type

	return self
end

function BattleWeakPointStatusChangedCommand:setEffectCommand(effectCommand)
	self._effectCommand = effectCommand

	return self
end

return BattleWeakPointStatusChangedCommand
