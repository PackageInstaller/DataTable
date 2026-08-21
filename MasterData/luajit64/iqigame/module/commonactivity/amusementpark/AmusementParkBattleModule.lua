-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkBattleModule.lua

local m = {
	FightStarted = false,
	State = 0,
	BattleAreaCid = 0,
	IsQuitingBattle = false
}
local BattleOverCommandData = require("IQIGame.Module.MainCity.BattleOverCommandData")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnBattleInitCommand(sender, args)
		self:OnBattleInitCommand(sender, args)
	end

	function self.DelegateOnBattleClear()
		self:OnBattleClear()
	end

	function self.DelegateOnBattleEnd(battleOverCommand)
		self:OnBattleEnd(battleOverCommand)
	end

	function self.DelegateOnUIOpen(sender, args)
		self:OnUIOpen(sender, args)
	end
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.BattleEnd, self.DelegateOnBattleEnd)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleInitCommandEventID, self.DelegateOnBattleInitCommand)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattleEnd, self.DelegateOnBattleEnd)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleInitCommandEventID, self.DelegateOnBattleInitCommand)
end

function m:StartBattle(isLocal, fightPOD, userdata)
	if self.State == Constant.Battle.BattleModuleStateStarted then
		return
	end

	self.FightStarted = true

	if self.IsQuitingBattle then
		logError("战斗状态错误，正在退出战斗。")
	end

	xpcall(function()
		self:AddListeners()
	end, function(msg)
		logError("发生错误.Self.State " .. tostring(self.State) .. " self.IsQuitingBattle " .. tostring(self.IsQuitingBattle) .. ".\nMessage: " .. tostring(msg))
	end)

	self.State = Constant.Battle.BattleModuleStateStarted
	self.BattleAreaCid = fightPOD.MapID

	BattleLogicAdapter.Instance:StartMainFight(isLocal, PlayerModule.PlayerInfo.baseInfo.pid, fightPOD, userdata)
end

function m:OnBattleInitCommand(sender, args)
	local command = args:ToLuaTable()

	BattleModule.Init(command.BattleType)
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.DelegateOnUIOpen)
	EventDispatcher.Dispatch(EventID.StopBGM)
	GameEntry.Data.Battle:InitBattleData(args.BattleCommand)
	BattleModule.InitBattle(command)
	BattleModule.StartFight(args.BattleCommand)
end

function m:OnUIOpen(sender, args)
	local cfgSceneListData = CfgSceneListTable[SceneID.Battle]

	if args.UIName == cfgSceneListData.LoadingUI then
		GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.DelegateOnUIOpen)
		BattleModule.HideAllUIExceptLoading(args.SerialId)

		if self.State == 1 then
			self:SetAmusementParkSceneActive(false)
		else
			logError("战斗loading打开时战斗已结束. State: " .. self.State)
		end
	end
end

function m:QuitBattle()
	self.IsQuitingBattle = true

	local success = BattleModule.Shutdown(self.DelegateOnBattleClear)

	if not success then
		self.IsQuitingBattle = false
	end

	self.State = Constant.Battle.BattleModuleStateNone
end

function m:OnBattleClear()
	self:SetAmusementParkSceneActive(true)
	self:Clear()
	BattleModule.RecoverAllHideUI()
	GameEntry.Sound:StopAllLoadingSounds()
	GameEntry.Sound:StopAllLoadedSounds(3)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function m:SetAmusementParkSceneActive(value)
	if AmusementParkModule.AmusementParkScene then
		AmusementParkModule.AmusementParkScene:SetActive(value)
	end
end

function m:OnBattleEnd(battleOverCommand)
	if self.BattleOverCommand == nil then
		self.BattleOverCommand = BattleOverCommandData.New()
	end

	self.BattleOverCommand:Initialize(battleOverCommand)
	net_fight.fightOver(battleOverCommand.BattleType, battleOverCommand.FightResult, battleOverCommand.DmgRecords, battleOverCommand.Attacker, battleOverCommand.Defender, battleOverCommand.JsonOrder, battleOverCommand.UserData, battleOverCommand.Round, battleOverCommand.HealRecords, battleOverCommand.HurtRecords)
end

function m:Clear()
	self.IsQuitingBattle = false
	self.FightStarted = false

	self:RemoveListeners()
end

function m:Shutdown()
	BattleModule.Shutdown()
	BattleLogicAdapter.Instance:ShutdownFight()

	self.State = Constant.Battle.BattleModuleShutdownByBackToLogin
	self.BattleOverCommand = nil

	self:Clear()
end

m.Instance = m.New()

return m
