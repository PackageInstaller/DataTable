-- chunkname: @IQIGame\\Module\\DualTeamExplore\\DualTeamExploreModule.lua

require("IQIGame.Module.DualTeamExplore.DTERequireCommand")
require("IQIGame.Scene.DualTeamExplore.InternalConst.DualTeamExploreExecStateEnum")

local DualTeamExploreScene = require("IQIGame.Scene.DualTeamExplore.DualTeamExploreScene")
local DualTeamExploreNodeData = require("IQIGame.Scene.DualTeamExplore.Path.DualTeamExploreNodeData")
local DualTeamExploreLevelAdaptor = require("IQIGame.Module.DualTeamExplore.DualTeamExploreLevelAdaptor")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

DualTeamExploreModule = {
	IsInScene = false,
	BattleStarted = false,
	ConfirmedMoveNodeId = 0,
	IsGathering = false,
	NodeDataMap = {},
	UnConfirmedMoveNodeIds = Queue.New(),
	ClientState = Queue.New()
}

function DualTeamExploreModule.Reload(dailyDupPOD)
	DualTeamExploreModule.DailyDupPOD = dailyDupPOD
	DualTeamExploreModule.TempCommands = {}
end

function DualTeamExploreModule.Update(dailyDupPOD)
	DualTeamExploreModule.DailyDupPOD = deepClonePOD(dailyDupPOD, DualTeamExploreModule.DailyDupPOD)
end

function DualTeamExploreModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[13]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and DualTeamExploreModule.DailyDupPOD ~= nil and DualTeamExploreModule.DailyDupPOD.common.status ~= 0
end

function DualTeamExploreModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.LoadSceneSuccess, DualTeamExploreModule.OnLoadSceneSuccess)
	EventDispatcher.AddEventListener(EventID.BattleEnd, DualTeamExploreModule.OnBattleEnd)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEMoveCommand), DualTeamExploreModule.OnMoveCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEExecutionCommand), DualTeamExploreModule.OnExecutionCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEOpenDialogCommand), DualTeamExploreModule.OnOpenDialogCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEUpdateNodeCommand), DualTeamExploreModule.OnUpdateNodeCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEUpdateTeamMemberAttrCommand), DualTeamExploreModule.OnUpdateTeamMemberAttrCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEGetItemCommand), DualTeamExploreModule.OnGetItemCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEUpdateTeamStatusCommand), DualTeamExploreModule.OnUpdateTeamStatusCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEUpdateLevelStatusCommand), DualTeamExploreModule.OnUpdateLevelStatusCommand)
	EventDispatcher.AddEventListener(DTECommandUtil.GetEventID(DTEBattleCommand), DualTeamExploreModule.OnBattleCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleInitCommandEventID, DualTeamExploreModule.OnBattleInitCommand)
end

function DualTeamExploreModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LoadSceneSuccess, DualTeamExploreModule.OnLoadSceneSuccess)
	EventDispatcher.RemoveEventListener(EventID.BattleEnd, DualTeamExploreModule.OnBattleEnd)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEMoveCommand), DualTeamExploreModule.OnMoveCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEExecutionCommand), DualTeamExploreModule.OnExecutionCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEOpenDialogCommand), DualTeamExploreModule.OnOpenDialogCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEUpdateNodeCommand), DualTeamExploreModule.OnUpdateNodeCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEUpdateTeamMemberAttrCommand), DualTeamExploreModule.OnUpdateTeamMemberAttrCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEGetItemCommand), DualTeamExploreModule.OnGetItemCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEUpdateTeamStatusCommand), DualTeamExploreModule.OnUpdateTeamStatusCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEUpdateLevelStatusCommand), DualTeamExploreModule.OnUpdateLevelStatusCommand)
	EventDispatcher.RemoveEventListener(DTECommandUtil.GetEventID(DTEBattleCommand), DualTeamExploreModule.OnBattleCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleInitCommandEventID, DualTeamExploreModule.OnBattleInitCommand)
end

function DualTeamExploreModule.SendEnterScene(levelCid, formationId1, formationId2, easyMode)
	if easyMode == nil then
		easyMode = false
	end

	net_dualTeamExplore.enterLevel(levelCid, formationId1, formationId2, easyMode)
end

function DualTeamExploreModule.OnEnterScene(levelPOD)
	DualTeamExploreModule.IsInScene = true
	DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.currLevelCid = levelPOD.levelCid

	DualTeamExploreModule.UpdateMapData(levelPOD)
	DualTeamExploreModule.AddListeners()
	SceneManager.ChangeScene(SceneID.DualTeamExplore)
end

function DualTeamExploreModule.OnLoadSceneSuccess(sceneID)
	if sceneID == SceneID.DualTeamExplore then
		DualTeamExploreModule.DualTeamExploreScene = DualTeamExploreScene.New()

		DualTeamExploreModule.DualTeamExploreScene:Init()
	end
end

function DualTeamExploreModule.ExitScene()
	DualTeamExploreModule.ClearOnExitScene()
	SceneManager.ChangeScene(SceneID.MainCity)
end

function DualTeamExploreModule.EnterPlotLevel(levelCid, easyMode)
	net_dualTeamExplore.plotLevel(levelCid, easyMode)
end

function DualTeamExploreModule.SendArriveNode(nodeId)
	local teamId = DualTeamExploreModule.GetCurrentTeamIndex()

	net_dualTeamExplore.move(teamId, nodeId)
	DualTeamExploreModule.UnConfirmedMoveNodeIds:Enqueue(nodeId)
end

function DualTeamExploreModule.SendStartBattle(selectTeamIndex)
	DualTeamExploreModule.BattleStarted = true

	net_dualTeamExplore.fight(selectTeamIndex)
end

function DualTeamExploreModule.ResponseStartBattle()
	DualTeamExploreModule.BattleStarted = false
end

function DualTeamExploreModule.NotifyStartBattle(isLocal, fightPOD, userdata)
	BattleLogicAdapter.Instance:StartMainFight(isLocal, PlayerModule.PlayerInfo.baseInfo.pid, fightPOD, userdata)
end

function DualTeamExploreModule.OnBattleInitCommand(sender, args)
	local command = args:ToLuaTable()

	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, DualTeamExploreModule.OnUIOpen)
	BattleModule.Init(command.BattleType)
	EventDispatcher.Dispatch(EventID.StopBGM)
	GameEntry.Data.Battle:InitBattleData(args.BattleCommand)
	BattleModule.InitBattle(command)
	BattleModule.StartFight(args.BattleCommand)
end

function DualTeamExploreModule.OnUIOpen(sender, args)
	local cfgSceneListData = CfgSceneListTable[SceneID.Battle]

	if args.UIName == cfgSceneListData.LoadingUI then
		GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, DualTeamExploreModule.OnUIOpen)
		BattleModule.HideAllUIExceptLoading(args.SerialId)
		DualTeamExploreModule.DualTeamExploreScene:SetActive(false)
	end
end

function DualTeamExploreModule.OnBattleEnd(battleOverCommand)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreBattleSettlementUI, Constant.UILayer.UI, {
		command = battleOverCommand,
		onClose = function()
			net_fight.fightOver(battleOverCommand.BattleType, battleOverCommand.FightResult, battleOverCommand.DmgRecords, battleOverCommand.Attacker, battleOverCommand.Defender, battleOverCommand.JsonOrder, battleOverCommand.UserData, battleOverCommand.Round, battleOverCommand.HealRecords, battleOverCommand.HurtRecords)
		end
	})
end

function DualTeamExploreModule.QuitBattle(win, teamIndex, teamPOD1, teamPOD2)
	function DualTeamExploreModule.OnBattleClearComplete()
		if teamPOD1 ~= nil then
			DualTeamExploreModule.UpdateTeamPOD(1, teamPOD1)
		end

		if teamPOD2 ~= nil then
			DualTeamExploreModule.UpdateTeamPOD(2, teamPOD2)
		end

		if win then
			DualTeamExploreModule.LevelPOD.currFightMonsterTeamId = 0
		end

		DualTeamExploreModule.CheckBattleState()
	end

	BattleModule.Shutdown(DualTeamExploreModule.OnBattleClear)

	DualTeamExploreModule.BattleStarted = false
end

function DualTeamExploreModule.OnBattleClear()
	BattleModule.RecoverAllHideUI()
	DualTeamExploreModule.DualTeamExploreScene:SetActive(true)
	GameEntry.Sound:StopAllLoadingSounds()
	GameEntry.Sound:StopAllLoadedSounds(3)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
	DualTeamExploreModule.OnBattleClearComplete()

	DualTeamExploreModule.OnBattleClearComplete = nil
end

function DualTeamExploreModule.TryShutdownBattle()
	if DualTeamExploreModule.BattleStarted then
		BattleModule.Shutdown()
		BattleLogicAdapter.Instance:ShutdownFight()

		DualTeamExploreModule.BattleStarted = false
	end
end

function DualTeamExploreModule.SendEnterMaze(teamId)
	MazeModule.SendEnterDualTeamExploreMaze(teamId)
end

function DualTeamExploreModule.OnEnterMaze(maze)
	DualTeamExploreModule.ClearOnExitScene()
	MazeModule.EnterMaze(maze)
end

function DualTeamExploreModule.SendInputNumber(result)
	net_dualTeamExplore.numberInput(result)
end

function DualTeamExploreModule.UpdateMapData(levelPOD)
	DualTeamExploreModule.LevelPOD = levelPOD

	for id, nodeData in pairs(DualTeamExploreModule.NodeDataMap) do
		nodeData.Expired = true
	end

	for i = 1, #DualTeamExploreModule.LevelPOD.nodes do
		local pod = DualTeamExploreModule.LevelPOD.nodes[i]
		local nodeData = DualTeamExploreModule.GetNodeDataById(pod.id)

		if nodeData == nil then
			nodeData = DualTeamExploreNodeData.New(pod.id)
			DualTeamExploreModule.NodeDataMap[pod.id] = nodeData
		end

		nodeData.Expired = false
	end

	local expiredIds = {}

	for id, nodeData in pairs(DualTeamExploreModule.NodeDataMap) do
		if nodeData.Expired then
			table.insert(expiredIds, id)
		end
	end

	for i = 1, #expiredIds do
		DualTeamExploreModule.NodeDataMap[expiredIds[i]] = nil
	end

	for i = 1, #DualTeamExploreModule.LevelPOD.nodes do
		local pod = DualTeamExploreModule.LevelPOD.nodes[i]
		local nodeData = DualTeamExploreModule.GetNodeDataById(pod.id)

		nodeData:Update(pod)
	end

	DualTeamExploreModule.CheckCurrentTeam()
end

function DualTeamExploreModule.AddCommand(command)
	if DualTeamExploreModule.Adaptor == nil then
		table.insert(DualTeamExploreModule.TempCommands, command)

		return
	end

	DualTeamExploreModule.Adaptor:AddCommand(command)
end

function DualTeamExploreModule.GetExploreUIAsset()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.ExploreHallUIBG
end

function DualTeamExploreModule.GetHeroTeam(teamIndex)
	local team

	if teamIndex == 1 then
		team = DualTeamExploreModule.LevelPOD.team1
	else
		team = DualTeamExploreModule.LevelPOD.team2
	end

	return team
end

function DualTeamExploreModule.GetLeaderResCfgData(teamIndex, is2D)
	local team = DualTeamExploreModule.GetHeroTeam(teamIndex)
	local firstSoulPrefabPOD

	for index, soulPrefabPOD in pairs(team.formationInfo.soulPrefabs) do
		firstSoulPrefabPOD = soulPrefabPOD

		break
	end

	local dressCid

	if is2D then
		dressCid = firstSoulPrefabPOD.dress2DCid
	else
		dressCid = firstSoulPrefabPOD.dress3DCid
	end

	local cfgDressData = CfgDressTable[dressCid]

	return CfgSoulResTable[cfgDressData.SoulResID]
end

function DualTeamExploreModule.GetHeroNodeData(teamIndex)
	local team = DualTeamExploreModule.GetHeroTeam(teamIndex)

	return DualTeamExploreModule.GetNodeDataById(team.currNodeId)
end

function DualTeamExploreModule.GetCurrentTeamIndex()
	return DualTeamExploreModule.LevelPOD.currTeam
end

function DualTeamExploreModule.CheckCurrentTeam(setCamera)
	DualTeamExploreModule.SetCurrentTeam(DualTeamExploreModule.LevelPOD.currTeam, setCamera)
end

function DualTeamExploreModule.SetCurrentTeam(index, setCamera)
	local teamPOD = DualTeamExploreModule.GetTeam(index)

	if teamPOD.stop then
		index = index % 2 + 1
	end

	if index == DualTeamExploreModule.LevelPOD.currTeam then
		return
	end

	DualTeamExploreModule.LevelPOD.currTeam = index

	if setCamera then
		DualTeamExploreModule.DualTeamExploreScene:MoveCameraToCurrentHero()
	end
end

function DualTeamExploreModule.IsLockingInput()
	return DualTeamExploreModule.DualTeamExploreScene:IsLockingInput()
end

function DualTeamExploreModule.GetNodeDataById(nodeId)
	return DualTeamExploreModule.NodeDataMap[nodeId]
end

function DualTeamExploreModule.GetNodePODById(nodeId)
	for i = 1, #DualTeamExploreModule.LevelPOD.nodes do
		local nodePOD = DualTeamExploreModule.LevelPOD.nodes[i]

		if nodePOD.id == nodeId then
			return nodePOD
		end
	end

	return nil
end

function DualTeamExploreModule.IsSeparate()
	return DualTeamExploreModule.LevelPOD.separate
end

function DualTeamExploreModule.GetActiveTeamIndexes()
	local indexes = {}

	if DualTeamExploreModule.IsSeparate() then
		table.insert(indexes, DualTeamExploreModule.GetCurrentTeamIndex())
	else
		for i = 1, 2 do
			table.insert(indexes, i)
		end
	end

	return indexes
end

function DualTeamExploreModule.GetActiveAliveTeamIndexes()
	local indexes = {}
	local team

	if DualTeamExploreModule.IsSeparate() then
		local index = DualTeamExploreModule.GetCurrentTeamIndex()

		team = DualTeamExploreModule.GetTeam(index)

		if not team.dead then
			table.insert(indexes, index)
		end
	else
		for i = 1, 2 do
			team = DualTeamExploreModule.GetTeam(i)

			if not team.dead then
				table.insert(indexes, i)
			end
		end
	end

	return indexes
end

function DualTeamExploreModule.GetTeam(index)
	if index == 1 then
		return DualTeamExploreModule.LevelPOD.team1
	elseif index == 2 then
		return DualTeamExploreModule.LevelPOD.team2
	end

	logError("error team index " .. tostring(index))
end

function DualTeamExploreModule.OnMoveCommand(command)
	DualTeamExploreModule.UnConfirmedMoveNodeIds:Dequeue()

	local hasClientState = DualTeamExploreModule.HasClientState()

	if DualTeamExploreModule.UnConfirmedMoveNodeIds.Size == 0 then
		DualTeamExploreModule.ClearClientState()
	end

	if command.TeamIndex == 0 then
		command.TeamIndex = DualTeamExploreModule.LevelPOD.currTeam
	end

	if command.NodeId ~= 0 then
		DualTeamExploreModule.ConfirmedMoveNodeId = command.NodeId
	else
		command.NodeId = DualTeamExploreModule.ConfirmedMoveNodeId
	end

	DualTeamExploreModule.SetCurrentTeam(command.TeamIndex)

	if command.TeamIndex ~= 0 and command.NodeId ~= 0 then
		local teamPODs = {}

		if DualTeamExploreModule.IsSeparate() then
			if command.TeamIndex == 1 then
				teamPODs[1] = DualTeamExploreModule.LevelPOD.team1
			elseif command.TeamIndex == 2 then
				teamPODs[1] = DualTeamExploreModule.LevelPOD.team2
			end
		else
			teamPODs[1] = DualTeamExploreModule.LevelPOD.team1
			teamPODs[2] = DualTeamExploreModule.LevelPOD.team2
		end

		for i = 1, #teamPODs do
			local teamPOD = teamPODs[i]

			teamPOD.currNodeId = command.NodeId
		end

		local nodeData = DualTeamExploreModule.GetNodeDataById(command.NodeId)

		if nodeData.capacity == 1 then
			nodeData.occupierTeamId = command.TeamIndex

			local nodePOD = DualTeamExploreModule.GetNodePODById(command.NodeId)

			nodePOD.occupierTeamId = command.TeamIndex
		end
	end

	DualTeamExploreModule.DualTeamExploreScene:OnResponseMoveArrived(command.TeamIndex, command.NodeId, command.IsStop, hasClientState)
end

function DualTeamExploreModule.OnExecutionCommand(command)
	log("触发执行。 id：" .. command.ExecutionId)

	local cfgDualTeamExploreExecutionData = CfgDualTeamExploreExecutionTable[command.ExecutionId]

	if cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Battle then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Maze then
		DualTeamExploreModule.ShowMazeConfirmUI(tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[1]))
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Dialog then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.ChangeHP then
		UIModule.Open(Constant.UIControllerName.MazeTroopHpChangeUI, Constant.UILayer.Mid, {
			percentage = tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[1])
		}, true)
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Drop then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.ChangeNextNode then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.ChangeNodeData then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Gather then
		DualTeamExploreModule.StartGather()
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Notice then
		NoticeModule.ShowNotice(tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[1]))
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Assemble then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.InputNumber then
		DualTeamExploreModule.ShowInputNumberUI(tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[1]))
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.Transport then
		DualTeamExploreModule.TransportActiveHeroesTo(tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[1]), tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[2]))
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.CameraAnimation then
		local cameraShowParams = {}

		for i = 1, #cfgDualTeamExploreExecutionData.ExecutionParams do
			table.insert(cameraShowParams, tonumber(cfgDualTeamExploreExecutionData.ExecutionParams[i]))
		end

		DualTeamExploreModule.PlayCameraAnimation(cameraShowParams)
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.EndLevel then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType == Constant.DualTeamExploreExecutionType.SetTeamActive then
		-- block empty
	elseif cfgDualTeamExploreExecutionData.ExecutionType ~= Constant.DualTeamExploreExecutionType.ModifyPlayerParam then
		logError("未实现的执行：" .. cfgDualTeamExploreExecutionData.ExecutionType)
	end
end

function DualTeamExploreModule.OnGetItemCommand(command)
	if command.ShowItems ~= nil then
		for i = 1, #command.ShowItems do
			local itemShowPOD = command.ShowItems[i]

			NoticeModule.ShowFloatGetItem(itemShowPOD.cid, itemShowPOD.num)
		end
	end
end

function DualTeamExploreModule.StartLevel()
	DualTeamExploreModule.CheckResumeAction()

	DualTeamExploreModule.Adaptor = DualTeamExploreLevelAdaptor.New()

	for i = 1, #DualTeamExploreModule.TempCommands do
		DualTeamExploreModule.Adaptor:AddCommand(DualTeamExploreModule.TempCommands[i])
	end

	DualTeamExploreModule.TempCommands = {}
end

function DualTeamExploreModule.CheckResumeAction()
	DualTeamExploreModule.CheckBattleState()

	if DualTeamExploreModule.LevelPOD.currMazeCid ~= 0 then
		DualTeamExploreModule.ShowMazeConfirmUI(DualTeamExploreModule.LevelPOD.currMazeCid)

		DualTeamExploreModule.LevelPOD.currMazeCid = 0
	end

	if DualTeamExploreModule.LevelPOD.currNumberInputId ~= 0 then
		DualTeamExploreModule.ShowInputNumberUI(DualTeamExploreModule.LevelPOD.currNumberInputId)

		DualTeamExploreModule.LevelPOD.currNumberInputId = 0
	end

	if DualTeamExploreModule.LevelPOD.currTransportNodeId ~= 0 then
		DualTeamExploreModule.TransportActiveHeroesTo(1, DualTeamExploreModule.LevelPOD.currTransportNodeId)

		DualTeamExploreModule.LevelPOD.currTransportNodeId = 0
	end

	if DualTeamExploreModule.LevelPOD.currDialog ~= 0 then
		DualTeamExploreModule.OpenDialog(DualTeamExploreModule.LevelPOD.currDialog)

		DualTeamExploreModule.LevelPOD.currDialog = 0
	end
end

function DualTeamExploreModule.CheckBattleState()
	if DualTeamExploreModule.LevelPOD.currFightMonsterTeamId ~= 0 then
		if DualTeamExploreModule.IsSeparate() and (DualTeamExploreModule.LevelPOD.team1.dead or DualTeamExploreModule.LevelPOD.team2.dead) then
			UIModule.Open(Constant.UIControllerName.DualTeamExploreReviveUI, Constant.UILayer.UI, {
				onGiveUp = DualTeamExploreModule.GiveUp,
				onRevive = DualTeamExploreModule.Revive
			})
		elseif not DualTeamExploreModule.LevelPOD.team1.dead or not DualTeamExploreModule.LevelPOD.team2.dead then
			DualTeamExploreModule.ShowBattleConfirmUI(DualTeamExploreModule.LevelPOD.currFightMonsterTeamId)
		end
	end
end

function DualTeamExploreModule.ShowBattleConfirmUI(monsterTeamCid)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreBattleConfirmUI, Constant.UILayer.UI, {
		monsterTeamCid = monsterTeamCid
	})
end

function DualTeamExploreModule.PlayQuickFight()
	DualTeamExploreModule.Adaptor:CommandSwitch(false)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreQuickFight, true)

	local duration = 2

	DualTeamExploreModule.SuspendHeroesMove(Constant.DualTeamExploreClientState.QuickFight)
	DualTeamExploreModule.DualTeamExploreScene:PlayQuickFight(duration)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.DualTeamExplore, function()
		DualTeamExploreModule.Adaptor:CommandSwitch(true)
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreQuickFight, false)
	end, duration)

	timer:Start()
end

function DualTeamExploreModule.ShowMazeConfirmUI(mazeInstanceCid)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreMazeConfirmUI, Constant.UILayer.UI, {
		mazeInstanceCid = mazeInstanceCid
	})
end

function DualTeamExploreModule.ShowInputNumberUI(inputNumberCid)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreInputNumberUI, Constant.UILayer.UI, {
		cid = inputNumberCid
	})
end

function DualTeamExploreModule.OnOpenDialogCommand(command)
	DualTeamExploreModule.OpenDialog(command.DialogCid)
end

function DualTeamExploreModule.OpenDialog(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function DualTeamExploreModule.OnUpdateNodeCommand(command)
	DualTeamExploreModule.ChangeNodeData(command.NodePOD)
end

function DualTeamExploreModule.ChangeNodeData(nodePOD)
	local nodeData = DualTeamExploreModule.GetNodeDataById(nodePOD.id)

	if nodeData == nil then
		logError("替换节点数据错误：找不到节点id：" .. tostring(nodePOD.id))

		return
	end

	local oldNextNodes = table.clone(nodeData.nextNodes)

	nodeData:Update(nodePOD)

	local newNextNodes = nodeData.nextNodes

	DualTeamExploreModule.DualTeamExploreScene:ShowElement(nodeData)

	for i = 1, #DualTeamExploreModule.LevelPOD.nodes do
		local oldPOD = DualTeamExploreModule.LevelPOD.nodes[i]

		if oldPOD.id == nodePOD.id then
			for key, value in pairs(nodePOD) do
				oldPOD[key] = value
			end
		end
	end

	local addChangedNodes = {}

	for i = 1, #newNextNodes do
		local newNode = newNextNodes[i]

		if table.indexOf(oldNextNodes, newNode) == -1 then
			table.insert(addChangedNodes, {
				isAdd = true,
				endNodeData = newNode
			})
		end
	end

	for i = 1, #oldNextNodes do
		local oldNode = oldNextNodes[i]

		if table.indexOf(newNextNodes, oldNode) == -1 then
			table.insert(addChangedNodes, {
				isAdd = false,
				endNodeData = oldNode
			})
		end
	end

	for i = 1, #addChangedNodes do
		local data = addChangedNodes[i]

		DualTeamExploreModule.DualTeamExploreScene:RefreshPathBetween(nodeData, data.endNodeData, data.isAdd)
		EventDispatcher.Dispatch(EventID.DualTeamExploreChangeNextNode, nodeData, data.endNodeData, data.isAdd)
	end
end

function DualTeamExploreModule.StartGather()
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreGather, true)

	DualTeamExploreModule.IsGathering = true

	DualTeamExploreModule.Adaptor:CommandSwitch(false)
	DualTeamExploreModule.DualTeamExploreScene:ChangeGatherState(true)
	DualTeamExploreModule:SuspendHeroesMove(Constant.DualTeamExploreClientState.Gather)

	local timer = Timer.New(function()
		DualTeamExploreModule.IsGathering = false

		DualTeamExploreModule.Adaptor:CommandSwitch(true)
		DualTeamExploreModule.DualTeamExploreScene:ChangeGatherState(false)
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreGather, false)
	end, 1.5)

	timer:Start()
end

function DualTeamExploreModule.SuspendHeroesMove(clientState)
	DualTeamExploreModule.ClientState:Enqueue(clientState)
	DualTeamExploreModule.DualTeamExploreScene:SuspendHeroesMove()
end

function DualTeamExploreModule.ClearClientState()
	DualTeamExploreModule.ClientState:Clear()
end

function DualTeamExploreModule.HasClientState()
	return DualTeamExploreModule.ClientState.Size > 0
end

function DualTeamExploreModule.OnUpdateTeamMemberAttrCommand(command)
	for teamIndex = 1, 2 do
		local team = DualTeamExploreModule.GetTeam(teamIndex)

		for index, soulPrefabPOD in pairs(team.formationInfo.soulPrefabs) do
			if soulPrefabPOD.soulCid == command.SoulCid then
				soulPrefabPOD.power = command.power

				for attrId = 1, #command.Attr do
					soulPrefabPOD.attr[attrId] = command.Attr[attrId]
				end
			end
		end
	end

	EventDispatcher.Dispatch(EventID.DualTeamExploreUpdateDollPOD)
end

function DualTeamExploreModule.OnUpdateTeamStatusCommand(command)
	local team = DualTeamExploreModule.GetTeam(command.TeamIndex)

	team.stop = command.Stop

	DualTeamExploreModule.CheckCurrentTeam(true)
	EventDispatcher.Dispatch(EventID.DualTeamExploreCurrentTeamAutoChange)
end

function DualTeamExploreModule.OnUpdateLevelStatusCommand(command)
	DualTeamExploreModule.LevelPOD.separate = command.Separate

	DualTeamExploreModule.DualTeamExploreScene:RefreshHeroShow()
	EventDispatcher.Dispatch(EventID.DualTeamExploreSeparateOrUnite)
end

function DualTeamExploreModule.OnBattleCommand(command)
	if DualTeamExploreModule.LevelPOD.easyMode then
		DualTeamExploreModule.PlayQuickFight()
	else
		DualTeamExploreModule.LevelPOD.currFightMonsterTeamId = command.MonsterCid

		DualTeamExploreModule.ShowBattleConfirmUI(DualTeamExploreModule.LevelPOD.currFightMonsterTeamId)
	end
end

function DualTeamExploreModule.OnSettlement(isSuccess)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreSettlementUI, Constant.UILayer.UI, {
		isSuccess = isSuccess
	})

	DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.currLevelCid = 0
end

function DualTeamExploreModule.GiveUp()
	net_dualTeamExplore.giveup()
end

function DualTeamExploreModule.Revive()
	net_dualTeamExplore.revive()
end

function DualTeamExploreModule.OnRevive(teamIndex, teamPOD)
	DualTeamExploreModule.UpdateTeamPOD(teamIndex, teamPOD)
	DualTeamExploreModule.CheckBattleState()
end

function DualTeamExploreModule.UpdateTeamPOD(teamIndex, newTeamPOD)
	local oldTeamPOD = DualTeamExploreModule.GetTeam(teamIndex)

	deepClonePOD(newTeamPOD, oldTeamPOD)
	EventDispatcher.Dispatch(EventID.DualTeamExploreUpdateTeam)
end

function DualTeamExploreModule.ShowSeparateConfirmUI(onConfirm)
	if UIModule.HasUI(Constant.UIControllerName.DualTeamExploreSeparateConfirmUI) or UIModule.IsLoadingUI(Constant.UIControllerName.DualTeamExploreSeparateConfirmUI) then
		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreSeparateConfirmUI, Constant.UILayer.UI, {
		onConfirm = onConfirm
	})
end

function DualTeamExploreModule.TransportActiveHeroesTo(mode, nodeId)
	DualTeamExploreModule.DualTeamExploreScene:TransportActiveHeroesTo(mode, nodeId)
end

function DualTeamExploreModule.PlayCameraAnimation(showCidList)
	DualTeamExploreModule.DualTeamExploreScene:PlayCameraAnimation(showCidList)
end

function DualTeamExploreModule.MazeBackToLevel()
	local currentLevelCid = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.currLevelCid

	DualTeamExploreModule.SendEnterScene(currentLevelCid, 0, 0)
end

function DualTeamExploreModule.IsUnlockBoos(boosID)
	if DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD then
		return table.indexOf(DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.unlockBoss, boosID) ~= -1
	end

	return false
end

function DualTeamExploreModule.ExBossOpen()
	if DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD then
		return DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossOpen
	end

	return false
end

function DualTeamExploreModule.ChallengeBoss(formationId, levelCid, isFree)
	net_dualTeamExplore.challengeBoss(formationId, levelCid, isFree)
end

function DualTeamExploreModule.ChallengeExBoss(formationId, exBossIndex)
	net_dualTeamExplore.challengeExBoss(formationId, exBossIndex)
end

function DualTeamExploreModule.ChallengeBossResult(code)
	return
end

function DualTeamExploreModule.ChallengeExBossResult(code)
	return
end

function DualTeamExploreModule.NotifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, nil)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if openExBoss then
		NoticeModule.ShowNoticeByType(1, DualTeamExploreExBossDetailUIApi:GetString("OpenEXBoss"))
	end
end

function DualTeamExploreModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function DualTeamExploreModule.NotifyTicketsUpdate(value)
	DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.tickets = value

	EventDispatcher.Dispatch(EventID.DualTeamExploreUpdateTicket)
end

function DualTeamExploreModule.GetTaskDataList()
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DUAL_TEAM_EXPLORE)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.DUAL_TEAM_EXPLORE)

	for i = 1, #processing do
		local taskData = processing[i]
		local taskUIData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskUIDataList, taskUIData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		if cfgMainQuestData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
			local taskUIData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(taskUIDataList, taskUIData)
		end
	end

	return taskUIDataList
end

function DualTeamExploreModule.IsPassedLevel(levelCid, isEasyMode)
	local isPassed

	if isEasyMode then
		isPassed = table.indexOf(DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.finishEasyLevels, levelCid) ~= -1

		if not isPassed then
			isPassed = table.indexOf(DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.finishLevels, levelCid) ~= -1
		end
	else
		isPassed = table.indexOf(DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.finishLevels, levelCid) ~= -1
	end

	return isPassed
end

function DualTeamExploreModule.GetMallCidList()
	local controlCid = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[controlCid]

	return cfgDualTeamExploreControlData.MallIds
end

function DualTeamExploreModule.ClearOnExitScene()
	if not DualTeamExploreModule.IsInScene then
		return
	end

	DualTeamExploreModule.IsInScene = false

	ModuleTimerUtil.Stop(Constant.ModuleTimerName.DualTeamExplore)
	DualTeamExploreModule.RemoveListeners()
	DualTeamExploreModule.Adaptor:Dispose()

	DualTeamExploreModule.Adaptor = nil

	DualTeamExploreModule.DualTeamExploreScene:Dispose()

	DualTeamExploreModule.DualTeamExploreScene = nil
	DualTeamExploreModule.TempCommands = {}
	DualTeamExploreModule.ConfirmedMoveNodeId = 0

	DualTeamExploreModule.UnConfirmedMoveNodeIds:Clear()
	DualTeamExploreModule.ClearClientState()
end

function DualTeamExploreModule.Shutdown()
	DualTeamExploreModule.ClearOnExitScene()

	DualTeamExploreModule.DailyDupPOD = nil

	DualTeamExploreModule.TryShutdownBattle()

	DualTeamExploreModule.TempCommands = nil
end
