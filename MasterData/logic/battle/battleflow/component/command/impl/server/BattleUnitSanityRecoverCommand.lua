-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleUnitSanityRecoverCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleUnitSanityRecoverCommand", package.seeall)

local BattleUnitSanityRecoverCommand = class("BattleUnitSanityRecoverCommand", BattleCommandBase)

function BattleUnitSanityRecoverCommand:onInit()
	self._entityId = 0
	self._sanityDelta = 0
	self._propertyValue = 0
	self._propertyBaseValue = 0
end

function BattleUnitSanityRecoverCommand:onClear()
	if self._timelineTask then
		self._timelineTask:clear()
	end

	self._entityId = 0
	self._sanityDelta = 0
end

function BattleUnitSanityRecoverCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleUnitSanityRecoverCommand:setRecoverValue(sanity)
	self._sanityDelta = sanity

	return self
end

function BattleUnitSanityRecoverCommand:setPropertyValue(propertyValue)
	self._propertyValue = propertyValue

	return self
end

function BattleUnitSanityRecoverCommand:setPropertyBaseValue(propertyBaseValue)
	self._propertyBaseValue = propertyBaseValue

	return self
end

function BattleUnitSanityRecoverCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleUnitSanityRecoverCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	self:_cameraFollow(battleFlow, runningContext)

	local followDuaration = runningContext:getParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime)

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(followDuaration, self._doSanityRecoverAnim, self)
	self._timelineTask:addTask(self:_getRecoverAnimTime())
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:addFinishListener(self._onAnimFinish, self)
	self._timelineTask:start(runningContext)
end

function BattleUnitSanityRecoverCommand:_cameraFollow(battleFlow, runningContext)
	local cmd = BattleAdjustFollowCenterCommand:create(0, self._entityId)

	cmd:execute(battleFlow, runningContext)
end

function BattleUnitSanityRecoverCommand:_doSanityRecoverAnim()
	local unitMgr = BattleMgr.instance:getActiveBattleFlow().unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	unit.effectPlayer:playUniqueEffect(BattleConst.SANITY_ADD)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_general_sanrecover)
	BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_gaolizhi)

	local cameraMgr = BattleMgr.instance:getCameraMgr()

	cameraMgr:playRandomAnimation(BattleConst.DelayOnePointFive)

	if BattleSkillTriggeredCommand:needPlayCastAnimation(unit) then
		unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Cast)
	end

	unit.property:setBaseAttribute(BattleExtension_pb.Attribute.CURRENT_SAN, self._propertyBaseValue)
	unit.property:setAttribute(BattleExtension_pb.Attribute.CURRENT_SAN, self._propertyValue)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
end

function BattleUnitSanityRecoverCommand:_getRecoverAnimTime()
	local unitMgr = BattleMgr.instance:getActiveBattleFlow().unitMgr
	local unit = unitMgr:getUnit(self._entityId)
	local animationTime = BattleConst.DelayZeroPointFive

	if BattleSkillTriggeredCommand:needPlayCastAnimation(unit) then
		animationTime = unit.meshModel:getAnimationDuration(UnitAnimState.Cast)
	end

	animationTime = math.max(animationTime, 1.6)

	return animationTime
end

function BattleUnitSanityRecoverCommand:_onAnimFinish()
	self:finish(true)
end

function BattleUnitSanityRecoverCommand:toString()
	return "BattleUnitSanityRecoverCommand"
end

return BattleUnitSanityRecoverCommand
