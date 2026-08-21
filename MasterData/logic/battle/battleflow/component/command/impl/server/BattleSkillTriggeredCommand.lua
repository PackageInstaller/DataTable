-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillTriggeredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillTriggeredCommand", package.seeall)

local BattleSkillTriggeredCommand = class("BattleSkillTriggeredCommand", BattleCommandBase)

function BattleSkillTriggeredCommand:parseServerCommand(cmdParser, skillTriggeredEventNO)
	local hasEffects = #skillTriggeredEventNO.effects > 0

	if not hasEffects then
		if BattleLog.enableLog then
			BattleLog.log(string.format("BattleSkillTriggeredCommand::one skill triggered effects has skipped,entityId = %s,code = %s", skillTriggeredEventNO.entity, skillTriggeredEventNO.code))
		end

		return
	end

	local isStepAgain = BattleCmdUtil.isStepEndedThenStepAgainTrigger(cmdParser, skillTriggeredEventNO, true)

	if isStepAgain then
		if not cmdParser:hasFlag(BattleCmdParser.Flag_AfterMain) then
			local sequence = BattleSequenceCommand:createInstance()

			cmdParser:pushCmdContainer(sequence)
			self:_parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
			cmdParser:popCmdContainer()
			cmdParser:setParam(BattleCmdParser.Param_AfterStepEndedCommand, sequence)
		else
			local stepAgainCommand = self:_createAsStepAgain(skillTriggeredEventNO)

			cmdParser:setParam(BattleCmdParser.Param_AfterStepEndedCommand, stepAgainCommand)
			self:_parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
		end
	else
		self:_parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
	end
end

function BattleSkillTriggeredCommand:needPlayCastAnimation(unit)
	if unit.property:isStateActive(BattleEnum.State.SNIPING) or unit.property:isStateActive(BattleEnum.State.STEPPED) or unit.property:isStateActive(BattleEnum.State.WEAKPOINT_FROZEN) or not unit.property:checkStateOperatable() then
		return false
	end

	return true
end

function BattleSkillTriggeredCommand:parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
	cmdParser:setParam(BattleCmdParser.Param_SkillTriggerAttackerId, skillTriggeredEventNO.entity)
	self:_parseServerCommandAsNormal(cmdParser, skillTriggeredEventNO)
	cmdParser:clearParam(BattleCmdParser.Param_SkillTriggerAttackerId)
end

function BattleSkillTriggeredCommand:_parseServerCommandAsNormal(cmdParser, skillTriggeredEventNO)
	local skillTriggeredCmd = false
	local resultCollection = false
	local playCast = false
	local globalSkillCommand = false

	for idx, effectNO in ipairs(skillTriggeredEventNO.effects) do
		local animState = effectNO.timelineRes
		local events = effectNO.events
		local isGlobalSkill = SkillPerformanceConfig.instance:isGlobalSkill(animState)
		local isSpecial = SkillPerformanceConfig.instance:isSpecialPerformance(animState)

		if isSpecial and not isGlobalSkill then
			self:_combineContinuousNormalPassive(cmdParser, skillTriggeredCmd, resultCollection, playCast, globalSkillCommand)

			skillTriggeredCmd = false
			resultCollection = false
			playCast = false

			self:_parseAsSpecialPassive(cmdParser, skillTriggeredEventNO, effectNO)
		else
			if not skillTriggeredCmd then
				skillTriggeredCmd = BattleSkillTriggeredCommand:createInstance()

				skillTriggeredCmd:setEntityId(skillTriggeredEventNO.entity)
				skillTriggeredCmd:setSkillCode(skillTriggeredEventNO.code)

				if isGlobalSkill then
					globalSkillCommand = self:_prepareForGlobalSkill(animState, skillTriggeredCmd, cmdParser)
				end

				cmdParser:addCommand(skillTriggeredCmd)

				resultCollection = BattlePerformanceResultCollection:createInstance()
			end

			resultCollection:parseEventNOList(events)

			if isGlobalSkill or BattlePerformanceResultCollection:checkPlayCast(events) then
				playCast = true
			end
		end
	end

	self:_combineContinuousNormalPassive(cmdParser, skillTriggeredCmd, resultCollection, playCast, globalSkillCommand)
end

function BattleSkillTriggeredCommand:_prepareForGlobalSkill(animState, skillTriggeredCmd, cmdParser)
	local globalSkillCommand = BattleGlobalSkillPerformanceCommand:createInstance()

	cmdParser:addCommand(globalSkillCommand)

	local globalEffect = SkillPerformanceConfig.instance:getGlobalSkillEffect(animState)

	globalSkillCommand:setGlobalEffect(globalEffect)
	globalSkillCommand:setSkillId(skillTriggeredCmd:getSkillCode())

	return globalSkillCommand
end

function BattleSkillTriggeredCommand:_parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(skillTriggeredEventNO.entity)

	if unit and not unit.property:isMaskEnable(BattleUnitFlagMask.MaskIntangible) and not cmdParser:hasFlag(BattleCmdParser.Flag_EntityStep) then
		cmdParser:addCommand(BattleAdjustFollowCenterCommand:create(skillTriggeredEventNO.entity, 0))
	end

	BattleSkillTriggeredCommand:parseServerCommandWithoutCheck(cmdParser, skillTriggeredEventNO)
end

function BattleSkillTriggeredCommand:_combineContinuousNormalPassive(cmdParser, skillTriggeredCmd, resultCollection, playCast, globalSkillCommand)
	if skillTriggeredCmd then
		if globalSkillCommand then
			local victimId, unionIndex = resultCollection:getOneVictim()

			globalSkillCommand:setEntityId(resultCollection:getOneVictim())
			globalSkillCommand:setUnionIndex(unionIndex)
		end

		resultCollection:tryMergeDamage()
		cmdParser:setParam(BattleCmdParser.Param_PerformanceResultCollection, resultCollection)

		local sequenceCommand = BattleSequenceCommand:createInstance()
		local playBubble = playCast

		if resultCollection:hasTagExceptChase() then
			playBubble = true
		end

		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.normalList))
		cmdParser:pushCmdContainer(sequenceCommand)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.tagEventList)
		cmdParser:popCmdContainer()
		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.hpChangedList))
		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.specialPropertyModifiedList))
		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.buffRemovedList))
		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.entityDeadList))
		sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.triggeringList))
		skillTriggeredCmd:setEffectCommand(sequenceCommand)
		skillTriggeredCmd:setPlayCast(playCast)
		skillTriggeredCmd:setPlayBubble(playBubble)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.weakPointBrokenList)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.afterPerformanceList)
		cmdParser:clearReusableParam(BattleCmdParser.Param_PerformanceResultCollection)
	end
end

function BattleSkillTriggeredCommand:_parseAsSpecialPassive(cmdParser, skillTriggeredEventNO, effectNO)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(skillTriggeredEventNO.entity)
	local targetUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local enterCmd = BattleEnterPerformanceCommand:parseClientCommand(cmdParser, false, skillTriggeredEventNO.entity, skillTriggeredEventNO.entity, skillTriggeredEventNO.code, targetUnionIndex, skillTriggeredEventNO.strengthen)

	enterCmd:setIsForceSolo(true)
	cmdParser:addCommand(BattleShowSkillHintBubbleCommand:create(skillTriggeredEventNO.entity, skillTriggeredEventNO.code))

	local cmd = BattleSkillPerformanceCommand:createInstance()

	cmd:setEntityId(skillTriggeredEventNO.entity)
	cmd:setSkillId(skillTriggeredEventNO.code)
	cmd:setAnimState(effectNO.timelineRes)
	cmdParser:addCommand(cmd)

	local collectionHandler = CollectionSkillAttackPointHandler:createInstance()

	cmd:addAttackPointHandler(collectionHandler)

	local resultCollection = BattlePerformanceResultCollection:createInstance()

	resultCollection:parseEventNOList(effectNO.events)

	local normalList = resultCollection.normalList

	for _, eventNO in ipairs(normalList) do
		local attackPointHandler = SkillAttackPointHandlerUtil.parseEventNO2Handler(eventNO)

		if attackPointHandler then
			cmd:addAttackPointHandler(attackPointHandler)
		else
			collectionHandler:addFromEventNO(cmdParser, eventNO)
		end
	end

	local entityDeadList = resultCollection.entityDeadList

	for _, eventNO in ipairs(entityDeadList) do
		cmd:addDeadEntityId(eventNO.entityDead.entity)
	end

	collectionHandler:addFromEventNOList(cmdParser, resultCollection.buffRemovedList)
	collectionHandler:addFromEventNOList(cmdParser, resultCollection.specialPropertyModifiedList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.hpChangedList)
	cmdParser:addCommand(BattleExitPerformanceCommand:createInstance())
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.weakPointBrokenList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.tagEventList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.entityDeadList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.triggeringList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.afterPerformanceList)
	resultCollection:returnSelf()
end

function BattleSkillTriggeredCommand:_createAsStepAgain(skillTriggeredEventNO)
	local cmd = BattleSkillTriggeredCommand:createInstance()

	cmd:setEntityId(skillTriggeredEventNO.entity)
	cmd:setSkillCode(skillTriggeredEventNO.code)
	cmd:setEffectCommand(BattleStepAgainCommand:create(skillTriggeredEventNO.entity))

	return cmd
end

function BattleSkillTriggeredCommand:onInit()
	self._entityId = 0
	self._skillCode = 0
	self._sourceType = 0
	self._effectCommand = false
	self._timelineTask = TimelineTask.New()
	self._remainTaskCount = 0
	self._runningContext = false
	self._playCast = true
	self._playBubble = false
end

function BattleSkillTriggeredCommand:onClear(interrupt)
	if self._effectCommand then
		self._effectCommand:safeInterrupt()

		self._effectCommand = false
	end

	self._entityId = 0
	self._skillCode = 0
	self._sourceType = 0

	self._timelineTask:clear()

	self._remainTaskCount = 0
	self._runningContext = false
	self._playCast = true
	self._playBubble = false
end

function BattleSkillTriggeredCommand:execute(battleFlow, runningContext)
	self._runningContext = runningContext

	self._runningContext:setParam(BattleCmdRunningContext.Param_DamageIndex, 0)

	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillTriggeredCommand::cannot find unit[%s]", self._entityId))
		end

		self._remainTaskCount = 1

		self:_onPlayTriggerEffects(battleFlow)

		return
	end

	if self._playBubble then
		local bubbleSkillId = BattleUnitUtil.getPerformSkillId(unit, self._skillCode)

		unit.bubble:showBubble(BattleEnum.BubbleType.SKILL_TRIGGER_HINT, bubbleSkillId, BattleConst.DelayOne)
	end

	if self._playCast then
		local halfAnimationTime = BattleConst.DelayOne

		if not unit.property:isMaskEnable(BattleUnitFlagMask.MaskIntangible) then
			if self:_checkPlayAnimation(unit) and BattleSkillTriggeredCommand:needPlayCastAnimation(unit) then
				halfAnimationTime = halfAnimationTime * 0.5

				unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Cast)
			end
		else
			halfAnimationTime = 0
		end

		local waitTime = math.max(BattleConst.DelayOne - halfAnimationTime, halfAnimationTime) + BattleConst.DelayZeroPointOne

		self._remainTaskCount = 2

		self._timelineTask:addTask(halfAnimationTime, self._onPlayTriggerEffects, self)
		self._timelineTask:addTask(waitTime)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(battleFlow)
	else
		self._remainTaskCount = 1

		self:_onPlayTriggerEffects(battleFlow)
	end
end

function BattleSkillTriggeredCommand:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:_onTimelineTaskFinish()
end

function BattleSkillTriggeredCommand:_checkPlayAnimation(unit)
	local skillMO = unit.skill:getActiveSkillById(self._skillCode)
	local sourceType = skillMO and skillMO:getSourceType()
	local sourceEntityId = skillMO and skillMO:getSourceEntityId()

	if sourceType == BattleExtension_pb.SkillSourceType.ADDITIONAL_TERRAIN then
		return false
	elseif sourceType == BattleExtension_pb.SkillSourceType.ENTITY and unit.property:getEntityId() ~= sourceEntityId then
		return false
	end

	return true
end

function BattleSkillTriggeredCommand:_onTimelineTaskFinish()
	self._remainTaskCount = self._remainTaskCount - 1

	if self._remainTaskCount <= 0 then
		self:_onBeforeFinish()
		self:finish(true)
	end
end

function BattleSkillTriggeredCommand:_onPlayTriggerEffects(context)
	if not self._effectCommand then
		self:_onTimelineTaskFinish()

		return
	end

	self._effectCommand:setCommandHandler(self)
	self._effectCommand:execute(context, self._runningContext)
end

function BattleSkillTriggeredCommand:_onBeforeFinish()
	self._runningContext:setParam(BattleCmdRunningContext.Param_DamageIndex, 0)
end

function BattleSkillTriggeredCommand:toString()
	return string.format("[skill triggered command entityId = %s,skillCode = %s, cast = %s]", self._entityId, self._skillCode, tostring(self._playCast))
end

function BattleSkillTriggeredCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSkillTriggeredCommand:getEntityId()
	return self._entityId
end

function BattleSkillTriggeredCommand:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function BattleSkillTriggeredCommand:setPlayCast(status)
	self._playCast = status

	return self
end

function BattleSkillTriggeredCommand:setPlayBubble(status)
	self._playBubble = status

	return self
end

function BattleSkillTriggeredCommand:setEffectCommand(effectCommand)
	self._effectCommand = effectCommand

	return self
end

function BattleSkillTriggeredCommand:getSkillCode()
	return self._skillCode
end

return BattleSkillTriggeredCommand
