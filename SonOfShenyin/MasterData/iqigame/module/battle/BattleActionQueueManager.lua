-- chunkname: @IQIGame\\Module\\Battle\\BattleActionQueueManager.lua

local BattleRoundAction = require("IQIGame/Module/Battle/BattleRoundAction")
local m = {
	isRoundStart = false
}

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	self.roundActionQueue = Queue.New()
	self.current = nil
	self.latest = nil
	self.isRoundStart = false
	self.battleOverCommand = nil

	function self.__delegateBattleStartCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【Start】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleStartCommand(command)
		BattleModule.OnBattleStartCommandEventHandler(command)
	end

	function self.__delegateBattleRoundCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【Round】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleRoundCommand(command)
		self:__AddRoundAction(command)
	end

	function self.__delegateBattleChooseSkillCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【ChooseSkill】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleChooseSkillCommand(command)
		self:__AddTurnChooseSkill(command)
	end

	function self.__delegateBattleTurnCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【Turn】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleTurnCommand(command)
		self:__AddTurnAction(command)
	end

	function self.__delegateBattleRoundEndCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【RoundEnd】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleRoundEndCommand(command)
		self:__AddRoundEndAction(command)
	end

	function self.__delegateBattleOverCommand(sender, args)
		local command = args:ToLuaTable()

		BattleModule.Log("BattleCommand 【Over】==> {0}", tableToString(command))
		BattleModule.RecordDamage_BattleOverCommand(command)
		self:__AddBattleOverCommand(command)
	end

	function self.__delegateQuitBattle()
		self:QuitBattle()
	end

	self:__AddBattleCommandListener()
end

function m:Start()
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_START_FIGHT)
end

function m:Dispose()
	self.isRoundStart = false

	self:__RemoveBattleCommandListener()
	BattleTeamActionModule.UnTrustRound()

	if self.current ~= nil then
		self.current:Dispose()
	end

	self.current = nil
	self.latest = nil

	for i = 1, self.roundActionQueue.Size do
		local roundAction = self.roundActionQueue:Dequeue()

		roundAction:Dispose()
	end

	self.roundActionQueue = nil
end

function m:__AddBattleCommandListener()
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleStartCommandEventID, self.__delegateBattleStartCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleRoundCommandEventID, self.__delegateBattleRoundCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleChooseSkillCommandEventID, self.__delegateBattleChooseSkillCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleTurnCommandEventID, self.__delegateBattleTurnCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleRoundEndCommandEventID, self.__delegateBattleRoundEndCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleOverCommandEventID, self.__delegateBattleOverCommand)
	EventDispatcher.AddEventListener(EventID.QuitBattle, self.__delegateQuitBattle)
end

function m:__RemoveBattleCommandListener()
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleStartCommandEventID, self.__delegateBattleStartCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleRoundCommandEventID, self.__delegateBattleRoundCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleChooseSkillCommandEventID, self.__delegateBattleChooseSkillCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleTurnCommandEventID, self.__delegateBattleTurnCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleRoundEndCommandEventID, self.__delegateBattleRoundEndCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleOverCommandEventID, self.__delegateBattleOverCommand)
	EventDispatcher.RemoveEventListener(EventID.QuitBattle, self.__delegateQuitBattle)
end

function m:__AddRoundAction(roundCommand)
	local roundAction = BattleRoundAction.New(roundCommand)

	self.latest = roundAction

	self.roundActionQueue:Enqueue(roundAction)
end

function m:__AddTurnChooseSkill(chooseSkillCommand)
	self.latest:OnAddTurnChooseSkill(chooseSkillCommand)
end

function m:__AddTurnAction(turnCommand)
	self.latest:OnAddRoundTurn(turnCommand)
	BattleModule.Log("收到战斗回合出手数据 MoverID： {0}", turnCommand.MoverID)
end

function m:__AddRoundEndAction(roundEndCommand)
	if self.current == nil then
		self.latest:SetRoundEndCommand(roundEndCommand)
	else
		self.current:SetRoundEndCommand(roundEndCommand)
	end
end

function m:__AddBattleOverCommand(battleOverCommand)
	self.battleOverCommand = battleOverCommand

	if BattleModule.restartBattle then
		self.battleOverCommand = nil

		return
	end

	if BattleModule.forceBattleOver then
		BattleModule.ExecuteBattleOver()

		return
	end

	if not self.isRoundStart then
		return
	end

	if BattleModule.CheckBattleTroopIsAllDied(BattleModule.attackBattleTroopType) then
		BattleModule.ExecuteBattleOver()

		return
	end

	if BattleModule.CheckBattleTroopIsAllDied(BattleModule.defineBattleTroopType) then
		BattleModule.ExecuteBattleOver()

		return
	end
end

function m:StartFirstRound()
	self.isRoundStart = true
end

function m:Update()
	if self.isRoundStart == false then
		return
	end

	if self.current == nil then
		self:__StartNextRound()

		return
	end

	BattleTeamActionModule.OnRoundActionUpdate(self.current)

	if not self.current.isComplete then
		if self.battleOverCommand ~= nil and self.current.turnCommandQueue.Size == 0 then
			BattleModule.ExecuteBattleOver()
		end

		return
	end

	local lastAction = self.current

	lastAction:Dispose()

	lastAction = nil
	self.current = nil
end

function m:__StartNextRound()
	if self.roundActionQueue.Size == 0 then
		if self.battleOverCommand ~= nil then
			BattleModule.ExecuteBattleOver()
		end

		return
	end

	self.current = self.roundActionQueue:Dequeue()

	BattleTeamActionModule.OnStartRound(self.current)
end

function m:WaitRoundActionReady()
	return self.roundActionQueue.Size > 0
end

function m:QuitBattle()
	if BattleModule.forceBattleOver then
		return
	end

	BattleModule.forceBattleOver = true

	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_GIVE_UP)
end

function m:DequeueBattleOverCommand()
	local cmd = self.battleOverCommand

	self.battleOverCommand = nil

	return cmd
end

return m
