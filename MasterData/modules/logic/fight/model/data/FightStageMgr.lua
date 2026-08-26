-- chunkname: @modules/logic/fight/model/data/FightStageMgr.lua

module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

local FightStageMgr = FightDataClass("FightStageMgr", FightDataMgrBase)

FightStageMgr.StageType = {
	Operate = GameUtil.getEnumId(),
	Play = GameUtil.getEnumId()
}
FightStageMgr.FightStateType = {
	Enter = GameUtil.getEnumId(),
	DouQuQu = GameUtil.getEnumId(),
	Season2AutoChangeHero = GameUtil.getEnumId(),
	DistributeCard = GameUtil.getEnumId(),
	Distribute1Card = GameUtil.getEnumId(),
	OperationView2PlayView = GameUtil.getEnumId(),
	SendOperation2Server = GameUtil.getEnumId(),
	PlaySeasonChangeHero = GameUtil.getEnumId(),
	ClothSkill = GameUtil.getEnumId(),
	AutoCardPlaying = GameUtil.getEnumId(),
	AiJiAoQteIng = GameUtil.getEnumId()
}
FightStageMgr.OperateStateType = {
	Discard = GameUtil.getEnumId(),
	DiscardEffect = GameUtil.getEnumId(),
	SeasonChangeHero = GameUtil.getEnumId(),
	BindContract = GameUtil.getEnumId(),
	RecordSkill = GameUtil.getEnumId(),
	DeviceDiscard = GameUtil.getEnumId()
}

function FightStageMgr:onConstructor()
	self.curStage = nil
	self.operateStates = {}
	self.operateParam = {}
	self.fightStates = {}
	self.fightStateParam = {}
end

function FightStageMgr:getCurStage()
	return self.curStage
end

function FightStageMgr:setStage(stage)
	local lastStage = self.curStage

	self.curStage = stage

	for i, mgr in ipairs(FightDataMgr.instance.mgrList) do
		mgr:onStageChanged(stage, lastStage)
	end

	for i, mgr in ipairs(FightLocalDataMgr.instance.mgrList) do
		mgr:onStageChanged(stage, lastStage)
	end

	self:com_sendFightEvent(FightEvent.StageChanged, stage, lastStage)
end

function FightStageMgr:getCurOperateState()
	return self.operateStates[#self.operateStates]
end

function FightStageMgr:getCurOperateParam()
	return self.operateParam[#self.operateParam]
end

function FightStageMgr:enterFightState(state, param)
	table.insert(self.fightStates, state)

	param = param or 0

	table.insert(self.fightStateParam, param)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, state, param)
end

function FightStageMgr:exitFightState(state)
	local index

	for i = #self.fightStates, 1, -1 do
		if state == self.fightStates[i] then
			index = i

			break
		end
	end

	if not index then
		return
	end

	table.remove(self.fightStates, index)

	local param = table.remove(self.fightStateParam, index)

	FightController.instance:dispatchEvent(FightEvent.ExitFightState, state, param)
end

function FightStageMgr:enterOperateState(state, param)
	table.insert(self.operateStates, state)

	param = param or 0

	table.insert(self.operateParam, param)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, state, param)
end

function FightStageMgr:exitOperateState(state)
	local index

	for i = #self.operateStates, 1, -1 do
		if state == self.operateStates[i] then
			index = i

			break
		end
	end

	if not index then
		return
	end

	table.remove(self.operateStates, index)

	local param = table.remove(self.operateParam, index)

	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, state, param)
end

function FightStageMgr:isEmptyOperateState(filterOperateState)
	if #self.operateStates == 0 then
		return true
	end

	for i, v in ipairs(self.operateStates) do
		if not filterOperateState or not filterOperateState[v] then
			return false
		end
	end

	return true
end

function FightStageMgr:inOperateState(state, filterOperateState)
	if filterOperateState and filterOperateState[state] then
		return false
	end

	for i = #self.operateStates, 1, -1 do
		if state == self.operateStates[i] then
			return true
		end
	end
end

function FightStageMgr:inFightState(state, filterFightState)
	if filterFightState and filterFightState[state] then
		return false
	end

	for i = #self.fightStates, 1, -1 do
		if state == self.fightStates[i] then
			return true
		end
	end
end

function FightStageMgr:isOperateStage()
	local curStage = self:getCurStage()

	return curStage == FightStageMgr.StageType.Operate
end

function FightStageMgr:isPlayStage()
	local curStage = self:getCurStage()

	return curStage == FightStageMgr.StageType.Play
end

function FightStageMgr:isFree(filterOperateState, filterFightState)
	if self.dataMgr.stateMgr.isReplay then
		return
	end

	if not self:isOperateStage() then
		return
	end

	if self.dataMgr.stateMgr.isAuto then
		return
	end

	if self:inFightState(FightStageMgr.FightStateType.OperationView2PlayView) then
		return
	end

	if self:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		return
	end

	if self:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if self:inFightState(FightStageMgr.FightStateType.DouQuQu, filterFightState) then
		return
	end

	if not self:isEmptyOperateState(filterOperateState) then
		return
	end

	return true
end

return FightStageMgr
