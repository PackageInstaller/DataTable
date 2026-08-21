-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/logic/BattleLocalLogic.lua

module("logic.battle.battleflow.component.logic.BattleLocalLogic", package.seeall)

local BattleLocalLogic = class("BattleLocalLogic", IBattleFlowComp, IBattleLogic)

function BattleLocalLogic:onInit()
	self._activeCampId = false
	self._activeCampOperator = false
end

function BattleLocalLogic:onStart()
	self:_setEvent(true)

	self._campOperator = self.flow.campOperator or false
	self._campPlayer = self.flow.campPlayer or false
	self._model = self.flow.model or false
	self._settingModel = self.flow.settingModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._activeCampId = false
	self._activeCampOperator = false
end

function BattleLocalLogic:onClear()
	self:_setEvent(false)

	self._campOperator = false
	self._campPlayer = false
	self._model = false
	self._settingModel = false
	self._unitMgr = false
	self._activeCampId = false
	self._activeCampOperator = false
end

function BattleLocalLogic:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_NEXT_OPERATE, self._onReceiveNextOperate, self)
	end
end

function BattleLocalLogic:handlePlayerStarted(campId)
	if not self._model:isRecord() and self._model:getOperateCampId() == campId then
		self:_showOperatableSignOfCamp(campId)

		self._activeCampOperator = self._campOperator
	else
		self._activeCampOperator = self._campPlayer
	end

	self._activeCampId = campId

	self._activeCampOperator:beginOperateCamp(campId)
end

function BattleLocalLogic:handlePlayerEnded(campId)
	if self._activeCampId == campId then
		self:_clearOperatableSignOfCamp(campId)
		self._activeCampOperator:endOperateCamp(campId)

		self._activeCampId = false
		self._activeCampOperator = false
	elseif BattleLog.enableError then
		BattleLog.error(string.format("BattleLocalLogic::campId is not equal! activeCampId = %s,campId = %s", self._activeCampId, campId))
	end
end

function BattleLocalLogic:checkBattleEnded()
	if self._model:getResultMO():isValid() then
		if BattleLog.enableLog then
			BattleLog.log("BattleLocalLogic::battle ended")
		end

		if self:_needShowUndoResult() then
			ViewMgr.instance:open(ViewName.BattleResultFailView, true)
		else
			BattleMgr.instance:exit()
		end

		return true
	end

	return false
end

function BattleLocalLogic:isActiveCampId(campId)
	return self._activeCampId == campId
end

function BattleLocalLogic:isOperateCamp()
	return self:isActiveCampId(self.flow.model:getOperateCampId())
end

function BattleLocalLogic:_needShowUndoResult()
	if not self._settingModel:isSupportUndo() then
		return false
	end

	local resultMO = self._model:getResultMO()

	return not resultMO:isRealEnd()
end

function BattleLocalLogic:_onReceiveNextOperate(eventId)
	if self._activeCampOperator then
		self._activeCampOperator:tryOperateNextUnit()
	end
end

function BattleLocalLogic:_showOperatableSignOfCamp(campId)
	local unitMgr = self._unitMgr
	local units = unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		if not unit.property:isStateActive(BattleEnum.State.STEPPED) then
			unit.sign:setOperatableSignVisible(true)
		end
	end
end

function BattleLocalLogic:_clearOperatableSignOfCamp(campId)
	local unitMgr = self._unitMgr
	local units = unitMgr:getUnitsByCampId(campId)

	for _, unit in pairs(units) do
		unit.property:inactiveState(BattleEnum.State.STEPPED)
		unit.property:inactiveState(BattleEnum.State.SKIPPED_STEP)
		unit.sign:setOperatableSignVisible(false)
		unit.stateEffect:refreshStateEffect()
	end
end

return BattleLocalLogic
