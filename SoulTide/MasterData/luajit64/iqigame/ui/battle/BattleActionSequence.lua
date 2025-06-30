-- chunkname: @IQIGame\\UI\\Battle\\BattleActionSequence.lua

local m = {
	RoundHeight = 0,
	RoundControllers = {}
}
local BattleActionSequenceRound = require("IQIGame.UI.Battle.BattleActionSequenceRound")
local BattleActionSequenceCell = require("IQIGame.UI.Battle.BattleActionSequenceCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnTopRoundMoveOver()
		self:OnTopRoundMoveOver()
	end

	function self.DelegateOnBattleTurnEnd(unitId)
		self:OnBattleTurnEnd(unitId)
	end

	function self.DelegateOnBattleUnitDead(sender, args)
		self:OnBattleUnitDead(sender, args)
	end

	function self.DelegateOnChangeUnitSpeed(unitId, speed)
		self:OnChangeUnitSpeed(unitId, speed)
	end

	function self.DelegateOnUpdateWeakInfo(sender, args)
		self:OnUpdateWeakInfo(sender, args)
	end

	function self.DelegateOnCheckUnitUltimateSkillState(unitId, isAboutToCastUltimateSkill)
		self:CheckUnitUltimateSkillState(unitId, isAboutToCastUltimateSkill)
	end

	self.RoundHeight = self.RoundPrefab.transform.sizeDelta.y
	self.CellPool = UIObjectPool.New(30, function()
		return BattleActionSequenceCell.New(UnityEngine.Object.Instantiate(self.RolePrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RoundControllerPool = UIObjectPool.New(3, function()
		return BattleActionSequenceRound.New(UnityEngine.Object.Instantiate(self.RoundPrefab), self.CellPool)
	end, function(controller)
		local v = controller.View

		controller:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:Show()
	for i = 1, 2 do
		self:AddNewRound()
	end

	self.RoundControllers[2]:HideTitle()
	self.RoundControllers[1]:SetPosY(self.RoundHeight * 0)
	self.RoundControllers[2]:SetPosY(self.RoundHeight * -1)
end

function m:AddNewRound()
	local round = self.RoundControllerPool:Obtain()

	round:Reset()
	round.View.transform:SetParent(self.RoundContent.transform, false)
	table.insert(self.RoundControllers, round)

	return round
end

function m:ReleaseRound(round, isDestroy, resetCell)
	round.View:SetActive(false)

	if not isDestroy then
		round.View.transform:SetParent(self.View.transform, false)
	end

	round:Clear(resetCell)
	self.RoundControllerPool:Release(round)
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(BattleUnitDeadEventArgs.EventId, self.DelegateOnBattleUnitDead)
	GameEntry.LuaEvent:Subscribe(BattleUpdateUnitWeakInfoEventArgs.EventId, self.DelegateOnUpdateWeakInfo)
	EventDispatcher.AddEventListener(EventID.BattleTurnEnd, self.DelegateOnBattleTurnEnd)
	EventDispatcher.AddEventListener(EventID.BattleChangeUnitSpeed, self.DelegateOnChangeUnitSpeed)
	EventDispatcher.AddEventListener(EventID.BattleCheckUnitUltimateSkillState, self.DelegateOnCheckUnitUltimateSkillState)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(BattleUnitDeadEventArgs.EventId, self.DelegateOnBattleUnitDead)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateUnitWeakInfoEventArgs.EventId, self.DelegateOnUpdateWeakInfo)
	EventDispatcher.RemoveEventListener(EventID.BattleTurnEnd, self.DelegateOnBattleTurnEnd)
	EventDispatcher.RemoveEventListener(EventID.BattleChangeUnitSpeed, self.DelegateOnChangeUnitSpeed)
	EventDispatcher.RemoveEventListener(EventID.BattleCheckUnitUltimateSkillState, self.DelegateOnCheckUnitUltimateSkillState)
end

function m:Update(elapseSeconds, realElapseSeconds)
	for i = #self.RoundControllers, 1, -1 do
		local round = self.RoundControllers[i]

		round:Update(elapseSeconds, realElapseSeconds)
	end
end

function m:Hide()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.BattleActionSequenceCell)

	for i = 1, #self.RoundControllers do
		self:ReleaseRound(self.RoundControllers[i], false, true)
	end

	self.RoundControllers = {}
end

function m:NextRound()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.BattleActionSequenceCell)
	self:AddNewRound()

	local roundLength = #self.RoundControllers

	self.RoundControllers[roundLength]:SetPosY(self.RoundControllers[roundLength - 1].View.transform.anchoredPosition.y - self.RoundHeight)

	for i = 1, #self.RoundControllers do
		local round = self.RoundControllers[i]

		round:StartMoveToY(self.RoundHeight * (i - 2) * -1, i == 3 and 0.1 or 0, i == 1 and self.DelegateOnTopRoundMoveOver or nil)
	end

	local toBeCurRound = self.RoundControllers[2]

	toBeCurRound:Refresh(0)

	local toBeNextRound = self.RoundControllers[3]

	toBeNextRound:Refresh(1)
end

function m:OnBattleTurnEnd(unitId)
	self:NextTurn()
end

function m:NextTurn()
	local curRound = self.RoundControllers[1]

	curRound:NextTurn()
end

function m:OnTopRoundMoveOver()
	local round = self.RoundControllers[1]

	table.remove(self.RoundControllers, 1)
	self:ReleaseRound(round)
end

function m:OnBattleUnitDead(sender, args)
	for i = 1, #self.RoundControllers do
		local round = self.RoundControllers[i]

		round:UnitDead(args.UnitID)
	end
end

function m:OnChangeUnitSpeed(unitId, speed)
	local battleUnitData = BattleModule.GetBattleUnitData(unitId)

	if battleUnitData.IsDead then
		return
	end

	local nextRound = self.RoundControllers[#self.RoundControllers]

	nextRound:ReOrderBySpeed(unitId)
end

function m:OnUpdateWeakInfo(sender, args)
	for i = 1, #self.RoundControllers do
		local round = self.RoundControllers[i]

		round:OnWeakNumChange(args.UnitId, args.OldNum, args.Num)
	end
end

function m:CheckUnitUltimateSkillState(unitId, isAboutToCastUltimateSkill)
	for i = 1, #self.RoundControllers do
		local round = self.RoundControllers[i]

		round:CheckUnitUltimateSkillState(unitId, isAboutToCastUltimateSkill)
	end
end

function m:Dispose()
	for i = 1, #self.RoundControllers do
		self:ReleaseRound(self.RoundControllers[i], true)
	end

	self.RoundControllers = nil

	self.RoundControllerPool:Dispose()
	self.CellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
