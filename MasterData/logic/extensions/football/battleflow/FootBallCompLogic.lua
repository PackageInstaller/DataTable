-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/battleflow/FootBallCompLogic.lua

module("logic.extensions.football.battleflow.FootBallCompLogic", package.seeall)

local FootBallCompLogic = class("FootBallCompLogic", IBattleFlowComp, IBattleLogic)

function FootBallCompLogic:onInit()
	self._activeCampId = false
	self._activeCampOperator = false
end

function FootBallCompLogic:onStart()
	self:_setEvent(true)

	self._campOperator = self.flow.campOperator or false
	self._campPlayer = self.flow.campPlayer or false
	self._model = self.flow.model or false
	self._unitMgr = self.flow.unitMgr or false
	self._activeCampId = false
	self._activeCampOperator = false
	self._firstAttackStageId = false
	self._footBallUnit = false
	self._isFocusOnFootBall = false
end

function FootBallCompLogic:onClear()
	self:_setEvent(false)
	self:_setFootBallUnitEvent(false)

	self._campOperator = false
	self._campPlayer = false
	self._model = false
	self._unitMgr = false
	self._activeCampId = false
	self._activeCampOperator = false
	self._firstAttackStageId = false
	self._footBallUnit = false
	self._isFocusOnFootBall = false
end

function FootBallCompLogic:onEnterDone()
	self._footBallUnit = self:_findFootballUnit()

	self:_setFootBallUnitEvent(true)
end

function FootBallCompLogic:_setFootBallUnitEvent(add)
	if not self._footBallUnit then
		return
	end

	if add then
		self._footBallUnit:addInnerEventListener(UnitActionType.PosChanged, self._onFootballPositionChanged, self)
	else
		self._footBallUnit:removeInnerEventListener(UnitActionType.PosChanged, self._onFootballPositionChanged, self)
	end
end

function FootBallCompLogic:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onReceiveScoreUpdate, self)
		GlobalDispatcher:addEventListener(EventType.FOOTBALL_RESET_POSITION, self._onReceiveSetPosition, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_SCORE_UPDATE, self._onReceiveScoreUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.FOOTBALL_RESET_POSITION, self._onReceiveSetPosition, self)
	end
end

function FootBallCompLogic:handlePlayerStarted(campId)
	if self._model:getOperateCampId() == campId then
		self:_showOperatableSignOfCamp(campId)

		self._activeCampOperator = self._campOperator
	else
		self._activeCampOperator = self._campPlayer

		self:_focusCameraToCamp(campId)
		BattleMainViewFacade.instance:setForOperatable()
	end

	self._activeCampId = campId

	self._activeCampOperator:beginOperateCamp(campId)
end

function FootBallCompLogic:handlePlayerEnded(campId)
	if self._activeCampId == campId then
		self:_clearOperatableSignOfCamp(campId)
		self._activeCampOperator:endOperateCamp(campId)

		self._activeCampId = false
		self._activeCampOperator = false
	elseif BattleLog.enableError then
		BattleLog.error(string.format("FootBallCompLogic::campId is not equal! activeCampId = %s,campId = %s", self._activeCampId, campId))
	end
end

function FootBallCompLogic:handleStageStarted(stageId)
	if not self._firstAttackStageId then
		self._firstAttackStageId = stageId

		GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_FIRST_ATTACK_STAGE_UPDATE, stageId)
	end
end

function FootBallCompLogic:handleStageEnded(stageId)
	local battleFieldInfo = self._model:getBattleFieldInfo()
	local campInfos = battleFieldInfo.campInfos

	for _, campInfo in pairs(campInfos) do
		if campInfo.stageId == stageId then
			self:_clearSteppedStateOfCamp(campInfo.campId)
		end
	end
end

function FootBallCompLogic:handleRoundStarted(round)
	self._firstAttackStageId = false
end

function FootBallCompLogic:checkBattleEnded()
	if self._model:getResultMO():isValid() then
		BattleMgr.instance:exit()

		return true
	end

	return false
end

function FootBallCompLogic:isActiveCampId(campId)
	return self._activeCampId == campId
end

function FootBallCompLogic:getFirstAttackStageId()
	return self._firstAttackStageId
end

function FootBallCompLogic:_onBeginCampAdjustment()
	local operateCampStageId = self._model:getOperateCampStageId()

	if operateCampStageId <= 0 then
		FloatWordMgr.instance:show("我方先手！")
	else
		FloatWordMgr.instance:show("对方先手！")
	end
end

function FootBallCompLogic:_onReceiveNextOperate(eventId)
	self._isFocusOnFootBall = false

	if self._activeCampOperator then
		self._activeCampOperator:tryOperateNextUnit()
	end
end

function FootBallCompLogic:_showOperatableSignOfCamp(campId)
	local unitMgr = self._unitMgr
	local units = unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		if not unit.property:isStateActive(BattleEnum.State.STEPPED) then
			unit.sign:setOperatableSignVisible(true)
		end
	end
end

function FootBallCompLogic:_clearOperatableSignOfCamp(campId)
	local unitMgr = self._unitMgr
	local units = unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		unit.property:inactiveState(BattleEnum.State.SKIPPED_STEP)
		unit.sign:setOperatableSignVisible(false)
	end
end

function FootBallCompLogic:_clearSteppedStateOfCamp(campId)
	local unitMgr = self._unitMgr
	local units = unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		unit.property:inactiveState(BattleEnum.State.STEPPED)
		unit.stateEffect:refreshStateEffect()
	end
end

function FootBallCompLogic:_focusCameraToCamp(campId)
	local units = self._unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		if not unit.property:isStateActive(BattleEnum.State.STEPPED) then
			local x, z = unit.mover:getPos()

			BattleCameraUtil.doFollowPosition(x, 0, z, BattleConst.DelayZeroPointFive)

			return
		end
	end
end

function FootBallCompLogic:_onReceiveScoreUpdate()
	self._isFocusOnFootBall = true
end

function FootBallCompLogic:_onReceiveSetPosition()
	self._isFocusOnFootBall = true

	FloatWordMgr.instance:show("足球情况异常，被空间之力强制移回出生点")
end

function FootBallCompLogic:_onFootballPositionChanged()
	if self._isFocusOnFootBall then
		local x, z = self._footBallUnit.mover:getPos()

		BattleCameraUtil.doFollowPosition(x, 0, z, BattleConst.DelayZeroPointFive)
	end
end

function FootBallCompLogic:_findFootballUnit()
	local units = self._unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if FootBallCompReleaseSkillAgent.isFootball(unit) then
			return unit
		end
	end
end

return FootBallCompLogic
