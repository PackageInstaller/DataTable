-- chunkname: @IQIGame\\Module\\Maze\\MazeModule.lua

MazeModule = {
	ShowingSoulDeadUI = false,
	StartCountdown = false,
	EnteredMaze = false,
	IsQuickFightIgnoreType = 0,
	CommandSwitchOn = true,
	FlagOnLoadSceneComplete = false,
	CanMainUITweenShow = false,
	IsMazeFinishSuccess = false,
	CheckTimeoutTimer = 0,
	IsCommandCountdownPause = false,
	CommandCountdownStartTime = 0,
	CommandCDPauseStartTime = 0,
	FlagOnEnterMaze = false,
	__CanDragCamera = true,
	CommandCDPauseTotalTime = 0,
	FlyRuneDataList = {}
}

local EntranceData = {}
local MazeScene = require("IQIGame.Scene.Maze.MazeScene")
local PathFinder = require("IQIGame.Util.PathFinder.PathFinder")
local MazeMapUIModule = require("IQIGame.Module.Maze.MazeMapUIModule")
local MazeStageModule = require("IQIGame.Module.Maze.MazeStageModule")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function MazeModule.Reload(items)
	return
end

function MazeModule.AbandonMaze(mazeCid)
	PlayerModule.PlayerInfo.currMazes[mazeCid] = nil
end

function MazeModule.EnterMaze(maze)
	if PlayerModule.InMaze then
		return
	end

	PlayerModule.InMaze = true
	MazeModule.EnteredMaze = true
	MazeDataModule.MazeInstanceID = maze.mazeCid
	PlayerModule.PlayerInfo.currMazes[maze.mazeCid] = maze.mazeCid

	GameEntry.LuaEvent:Subscribe(MazeLoadSceneCompleteEventArgs.EventId, MazeModule.InitAfterLoadSceneComplete)
	SceneManager.ChangeScene(SceneID.Maze)
	MazeDataModule.Init()
	xpcall(function()
		MazeModule.AddMazeGlobalListeners()
	end, function(msg)
		logError("EnterMaze error: " .. tostring(msg))
	end)

	MazeModule.PathFinder = PathFinder.New()

	local mazeCfg = CfgMazeInstanceTable[maze.mazeCid]
	local chapterCfg = CfgChapterTable[mazeCfg.ChapterId]
	local chapterType = chapterCfg.Type

	if not GmListModule.EnableMazeCloudSaveData() and not chapterCfg.CloudSave and (maze.saveData == nil or maze.saveData == "") then
		local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Maze_Save)

		if dataTab ~= nil then
			local mazeDataTable = dataTab[tostring(chapterType)]

			if mazeDataTable ~= nil and mazeDataTable.LogicID == maze.id then
				maze.saveData = mazeDataTable.SaveData
				maze.saveVersion = mazeDataTable.Version
			end
		end
	end

	local timer = FrameTimer.New(function()
		MazeLogicAdapter.Instance:EnterMaze(maze)
	end, 3, 1)

	timer:Start()

	HorizontalRPGModule.enterOldMazeCid = maze.mazeCid
end

function MazeModule.SaveEntranceDataBeforeEnter(entranceDataList)
	MazeModule.EntranceDataList = entranceDataList
end

function MazeModule.SendEnterWorldMazeMsg(mazeCid, formationId)
	net_maze.enterMaze(mazeCid, formationId)
end

function MazeModule.SendEnterEndlessMaze(mazeCid, formationId)
	net_maze.enterAbyssMaze(mazeCid, formationId)
end

function MazeModule.SendEnterIllusionMaze(mazeCid, soulCid)
	net_maze.enterIllusionMaze(mazeCid, soulCid)
end

function MazeModule.SendEnterRpgMaze(mazeCid)
	if RpgMazeModule.DailyDupPOD == nil or RpgMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_rpgMaze.enterRPGMaze(mazeCid)
end

function MazeModule.SendEnterFortMaze(zoneId, formationID)
	net_lunaBattleLine.enterFortMaze(zoneId, formationID)
end

function MazeModule.SendEnterSealMaze(zoneId, formationID, assistPid)
	net_lunaBattleLine.enterSealMaze(zoneId, formationID, assistPid)
end

function MazeModule.SendEnterStrengthenMaze(zoneId, soulPrefabs)
	net_lunaBattleLine.enterStrengthenMaze(zoneId, soulPrefabs)
end

function MazeModule.SendEnterDualTeamExploreMaze(teamId)
	net_dualTeamExplore.enterDualTeamMaze(teamId)
end

function MazeModule.SendEnterEndlessPlusMaze(levelCid, formationId)
	net_abyssPlus.enterLevel(levelCid, formationId)
end

function MazeModule.SendEnterTestMaze(mazeCid, formationID)
	net_maze.enterTestMaze(mazeCid, formationID)
end

function MazeModule.ResponseMazeSettlement(result)
	NoticeModule.PauseNotice()

	PlayerModule.PlayerInfo.currMazes[MazeDataModule.MazeInstanceID] = nil
	MazeModule.IsMazeFinishSuccess = result.success
	MazeDataModule.SoulLvExpListBeforeQuit = {}

	local dollDataList = MazeDataModule.GetActiveDollDataList()

	for i = 1, #dollDataList do
		local mazeDollPOD = dollDataList[i]
		local soulData = MazeDataModule.GetSoulData(mazeDollPOD.soulCid)

		MazeDataModule.SoulLvExpListBeforeQuit[mazeDollPOD.soulCid] = {
			level = soulData.lv,
			exp = soulData.exp
		}
	end

	MazeDataModule.SettlementData = {}
	MazeDataModule.SettlementData.Success = result.success
	MazeDataModule.SettlementData.Score = result.score
	MazeDataModule.SettlementData.StarConditions = result.starConditions
	MazeDataModule.SettlementData.FirstRewards = result.firstRewards
	MazeDataModule.SettlementData.Rewards = result.rewards
	MazeDataModule.SettlementData.AddSoulExps = result.addSoulExps
	MazeDataModule.SettlementData.PlayerExp = result.playerExp
	MazeDataModule.SettlementData.Money = result.money
	MazeDataModule.SettlementData.RewardsBoxes = result.rewardsBoxes

	if MazeDataModule.ChapterType == Constant.Maze.ChapterTypeNormal then
		UIModule.Open(Constant.UIControllerName.MazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeIllusion then
		UIModule.Open(Constant.UIControllerName.IllusionMazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndless then
		local function openSettlementUI()
			UIModule.Open(Constant.UIControllerName.EndlessMazeSettlementUI, Constant.UILayer.UI)
		end

		if MazeDataModule.HasUnlockRuneItem() then
			UIModule.Close(Constant.UIControllerName.EndlessMazeRuneLockUI)
			UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLockUI, Constant.UILayer.UI, {
				turnToRune = true,
				onClose = openSettlementUI
			})
		else
			openSettlementUI()
		end
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeRpg then
		UIModule.Open(Constant.UIControllerName.MazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.IsScrollMaze() then
		UIModule.Open(Constant.UIControllerName.LunaMazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeLunaFort then
		UIModule.Open(Constant.UIControllerName.MazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeDualTeamExplore then
		UIModule.Open(Constant.UIControllerName.DualTeamExploreMazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndlessPlus then
		UIModule.Open(Constant.UIControllerName.EndlessPlusMazeSettlementUI, Constant.UILayer.UI)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalRPG then
		MazeModule.ExitMaze(function()
			HorizontalRPGModule.ExitTheOldMaze()
		end)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalChallenge then
		UIModule.Open(Constant.UIControllerName.MazeSettlementUI, Constant.UILayer.UI)
	else
		logError("未找到结算界面")
	end

	MazeModule.StartCountdown = false
end

function MazeModule.AddMazeGlobalListeners()
	MazeDataModule.AddEventListeners()
	MazeShopModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.QuittedCardGame, MazeModule.OnQuittedCardGame)
	EventDispatcher.AddEventListener(EventID.MazePlayerSomeInfoChange, MazeModule.OnPlayerInfoChange)
	EventDispatcher.AddEventListener(EventID.AddItem, MazeModule.OnAddItem)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, MazeModule.OnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.MazeSoulDead, MazeModule.OnSoulDead)
	EventDispatcher.AddEventListener(EventID.BattleEnd, MazeModule.OnBattleSettlement)
	EventDispatcher.AddEventListener(EventID.MazeUpdateData, MazeModule.OnMazeUpdateData)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, MazeModule.OnMazeUpdateNodeData)
	EventDispatcher.AddEventListener(EventID.MazeSceneInitialized, MazeModule.OnMazeSceneInitialized)
	EventDispatcher.AddEventListener(EventID.MazeUpdateEnergy, MazeModule.OnUpdateEnergy)
	EventDispatcher.AddEventListener(EventID.ExamMazeDurationChange, MazeModule.OnExamMazeDurationChange)
	EventDispatcher.AddEventListener(EventID.MazeMainUITweenShow, MazeModule.OnMazeMainUITweenShow)
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, MazeModule.OnCloseDialogUI)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleInitCommandEventID, MazeModule.OnBattleInitCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.WeakCommandEventId, MazeModule.OnWeak)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.MazeSettlementCommandEventId, MazeModule.OnMazeSettlement)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShowErrorCodeCommandEventId, MazeModule.OnMazeOperationError)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShowGetItemNoticeCommandEventId, MazeModule.OnNoticeGetItem)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShowRemoveItemNoticeCommandEventId, MazeModule.OnNoticeRemoveItem)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShowConditionFailNoticeCommandEventId, MazeModule.OnNoticeConditionFailed)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenDialogueCommandEventId, MazeModule.OnOpenDialogue)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenSelectUICommandEventId, MazeModule.OnOpenSelectUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.StartCardGameCommandEventId, MazeModule.OnStartCardGame)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.DialogSelectCommandEventId, MazeModule.OnSelectDialogResponded)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.SaveMazeCommandEventId, MazeModule.OnSaveMaze)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.StartJudgeCommandEventId, MazeModule.OnStartJudge)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.StartTurnTableCommandEventId, MazeModule.OnStartTurntableGame)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateWeatherCommandEventId, MazeModule.OnUpdateWeather)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NoticeCommandEventId, MazeModule.OnNotice)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ChooseWeatherCommandEventId, MazeModule.OnChooseWeather)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.WishCommandEventId, MazeModule.OnWish)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UploadMainQuestProgressCommandEventId, MazeModule.OnUploadMainQuestProgressToServer)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenSubmitItemCommandEventId, MazeModule.OnOpenSubmitItem)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenQTECommandEventId, MazeModule.OpenQTE)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.GatherStepRewardsCommandEventId, MazeModule.OnGetGatherStepReward)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.GatherStartedCommandEventId, MazeModule.OnStarGather)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.GatherEndedCommandEventId, MazeModule.OnEndGather)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ChangeTroopHpCommandEventId, MazeModule.OnTroopHpChange)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ChangeTroopSkillEnergyCommandEventId, MazeModule.OnTroopSpChange)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.StartReviveDollCommandEventId, MazeModule.OnReviveSouls)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.DoExecutionCommandEventId, MazeModule.OnDoExecution)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyMazeAlienEventUnlockCommandEventId, MazeModule.OnNotifyMazeAlienEventUnlockCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyMazeMonsterUnlockCommandEventId, MazeModule.OnNotifyMazeMonsterUnlockCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneGetCommandEventId, MazeModule.OnRuneGet)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneEffectCommandEventId, MazeModule.OnRuneEffect)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneEvolutionCommandEventId, MazeModule.OnRuneEvolution)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneSplitCommandEventId, MazeModule.OnRuneSplit)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneStrengthenCommandEventId, MazeModule.OnRuneStrengthen)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenStrengthRuneCommandEventId, MazeModule.OnOpenStrengthenRuneUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenChooseRuneCommandEventId, MazeModule.OnOpenChooseRuneUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenReplaceRuneCommandEventId, MazeModule.OnOpenReplaceRuneUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenRuneShopCommandEventId, MazeModule.OnOpenRuneShopUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ScreenSwitchCommandEventId, MazeModule.OnCommandMoveCamera)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdatePlayerCameraCommandEventId, MazeModule.OnUpdatePlayerCameraCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.TriggerGuideCommandEventId, MazeModule.OnTriggerGuideCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyElementActionCommandEventId, MazeModule.OnNotifyElementAction)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.QuickFightCheckCommandEventId, MazeModule.OnQuickFightCheckCommand)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.MoveArrivedCommandEventId, MazeModule.OnHeroMoveArrived)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.TransportCommandEventId, MazeModule.OnStartTransport)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.EnterMazeCommandEventId, MazeModule.OnEnterMaze)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyElementIntroduceCommandEventId, MazeModule.OnShowElementIntroduction)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenClockCommandEventId, MazeModule.OnOpenClockUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenStageCommandEventId, MazeModule.OnShowMazeStage)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.CloseStageCommandEventId, MazeModule.OnHideMazeStage)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShowMazeStageAnimationCommandEventId, MazeModule.OnChangeMazeStageAnimation)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenReMakeRuneCommandEventId, MazeModule.OnOpenReMakeRuneUI)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ReMakeChooseRuneCommandEventId, MazeModule.OnReMakeChooseRune)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyMazeLevelResChangeCommandEventId, MazeModule.OnMazeLevelResChange)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.CountdownEventCommandEventId, MazeModule.OnCountdownEventCommand)
end

function MazeModule.RemoveMazeGlobalListeners()
	MazeDataModule.RemoveEventListeners()
	MazeShopModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.QuittedCardGame, MazeModule.OnQuittedCardGame)
	EventDispatcher.RemoveEventListener(EventID.MazePlayerSomeInfoChange, MazeModule.OnPlayerInfoChange)
	EventDispatcher.RemoveEventListener(EventID.AddItem, MazeModule.OnAddItem)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, MazeModule.OnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.MazeSoulDead, MazeModule.OnSoulDead)
	EventDispatcher.RemoveEventListener(EventID.BattleEnd, MazeModule.OnBattleSettlement)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateData, MazeModule.OnMazeUpdateData)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, MazeModule.OnMazeUpdateNodeData)
	EventDispatcher.RemoveEventListener(EventID.MazeSceneInitialized, MazeModule.OnMazeSceneInitialized)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateEnergy, MazeModule.OnUpdateEnergy)
	EventDispatcher.RemoveEventListener(EventID.ExamMazeDurationChange, MazeModule.OnExamMazeDurationChange)
	EventDispatcher.RemoveEventListener(EventID.MazeMainUITweenShow, MazeModule.OnMazeMainUITweenShow)
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, MazeModule.OnCloseDialogUI)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleInitCommandEventID, MazeModule.OnBattleInitCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.WeakCommandEventId, MazeModule.OnWeak)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.MazeSettlementCommandEventId, MazeModule.OnMazeSettlement)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShowErrorCodeCommandEventId, MazeModule.OnMazeOperationError)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShowGetItemNoticeCommandEventId, MazeModule.OnNoticeGetItem)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShowRemoveItemNoticeCommandEventId, MazeModule.OnNoticeRemoveItem)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShowConditionFailNoticeCommandEventId, MazeModule.OnNoticeConditionFailed)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenDialogueCommandEventId, MazeModule.OnOpenDialogue)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenSelectUICommandEventId, MazeModule.OnOpenSelectUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.StartCardGameCommandEventId, MazeModule.OnStartCardGame)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.DialogSelectCommandEventId, MazeModule.OnSelectDialogResponded)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.SaveMazeCommandEventId, MazeModule.OnSaveMaze)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.StartJudgeCommandEventId, MazeModule.OnStartJudge)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.StartTurnTableCommandEventId, MazeModule.OnStartTurntableGame)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateWeatherCommandEventId, MazeModule.OnUpdateWeather)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NoticeCommandEventId, MazeModule.OnNotice)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ChooseWeatherCommandEventId, MazeModule.OnChooseWeather)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.WishCommandEventId, MazeModule.OnWish)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UploadMainQuestProgressCommandEventId, MazeModule.OnUploadMainQuestProgressToServer)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenSubmitItemCommandEventId, MazeModule.OnOpenSubmitItem)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenQTECommandEventId, MazeModule.OpenQTE)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.GatherStepRewardsCommandEventId, MazeModule.OnGetGatherStepReward)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.GatherStartedCommandEventId, MazeModule.OnStarGather)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.GatherEndedCommandEventId, MazeModule.OnEndGather)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ChangeTroopHpCommandEventId, MazeModule.OnTroopHpChange)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ChangeTroopSkillEnergyCommandEventId, MazeModule.OnTroopSpChange)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.StartReviveDollCommandEventId, MazeModule.OnReviveSouls)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.DoExecutionCommandEventId, MazeModule.OnDoExecution)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyMazeAlienEventUnlockCommandEventId, MazeModule.OnNotifyMazeAlienEventUnlockCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyMazeMonsterUnlockCommandEventId, MazeModule.OnNotifyMazeMonsterUnlockCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneGetCommandEventId, MazeModule.OnRuneGet)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneEffectCommandEventId, MazeModule.OnRuneEffect)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneEvolutionCommandEventId, MazeModule.OnRuneEvolution)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneSplitCommandEventId, MazeModule.OnRuneSplit)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneStrengthenCommandEventId, MazeModule.OnRuneStrengthen)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenStrengthRuneCommandEventId, MazeModule.OnOpenStrengthenRuneUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenChooseRuneCommandEventId, MazeModule.OnOpenChooseRuneUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenReplaceRuneCommandEventId, MazeModule.OnOpenReplaceRuneUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenRuneShopCommandEventId, MazeModule.OnOpenRuneShopUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ScreenSwitchCommandEventId, MazeModule.OnCommandMoveCamera)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdatePlayerCameraCommandEventId, MazeModule.OnUpdatePlayerCameraCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.TriggerGuideCommandEventId, MazeModule.OnTriggerGuideCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyElementActionCommandEventId, MazeModule.OnNotifyElementAction)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.QuickFightCheckCommandEventId, MazeModule.OnQuickFightCheckCommand)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.MoveArrivedCommandEventId, MazeModule.OnHeroMoveArrived)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.TransportCommandEventId, MazeModule.OnStartTransport)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.EnterMazeCommandEventId, MazeModule.OnEnterMaze)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyElementIntroduceCommandEventId, MazeModule.OnShowElementIntroduction)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenClockCommandEventId, MazeModule.OnOpenClockUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenStageCommandEventId, MazeModule.OnShowMazeStage)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.CloseStageCommandEventId, MazeModule.OnHideMazeStage)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShowMazeStageAnimationCommandEventId, MazeModule.OnChangeMazeStageAnimation)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenReMakeRuneCommandEventId, MazeModule.OnOpenReMakeRuneUI)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ReMakeChooseRuneCommandEventId, MazeModule.OnReMakeChooseRune)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyMazeLevelResChangeCommandEventId, MazeModule.OnMazeLevelResChange)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.CountdownEventCommandEventId, MazeModule.OnCountdownEventCommand)
end

function MazeModule.OnCloseDialogUI(startDialogCid)
	MazeModule.ResumeCommandCountdown()
end

function MazeModule.OnCountdownEventCommand(sender, args)
	local command = args:ToLuaTable()
	local countdownPOD = command.Countdown

	MazeDataModule.PlayerInfo.Countdown = countdownPOD
	MazeModule.CommandCountdownStartTime = countdownPOD == nil and 0 or PlayerModule.GetServerTime() + countdownPOD.Countdown - CfgMazeCountdownTable[countdownPOD.CID].TimeLimit

	MazeModule.StartOrStopCommandCountdown(countdownPOD)
end

function MazeModule.OnMazeLevelResChange(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.MazeLevelResID = command.Cid

	local cfgMazeLevelResData = CfgMazeLevelResTable[command.Cid]

	MazeModule.MazeScene:ChangeLevelRes(cfgMazeLevelResData)

	if HorizontalRPGModule.CheckHorizontalMazeInstance(MazeDataModule.MazeInstanceID) then
		HorizontalRPGModule.ModifyWeather(command.Cid)
	end
end

function MazeModule.OnReMakeChooseRune(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.MazeRemakeRuneSuccess)
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSelectUI, Constant.UILayer.UI, {
		runes = command.RuneList,
		onConfirm = function(index)
			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REMAKE_CHOOSE_RUNE, {
				Index = index
			})
		end
	})
end

function MazeModule.OnOpenReMakeRuneUI(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneRemakeUI, Constant.UILayer.UI, {
		count = command.Count,
		addPrice = command.BuffChangePrice
	})
end

function MazeModule.OnChangeMazeStageAnimation(sender, args)
	if MazeModule.MazeStageModule == nil then
		return
	end

	local command = args:ToLuaTable()

	MazeModule.MazeStageModule:ChangeAnimation(command.AnimationCid)
end

function MazeModule.OnHideMazeStage(sender, args)
	if MazeModule.MazeStageModule == nil then
		return
	end

	MazeModule.MazeStageModule:StartHideStage()
end

function MazeModule.OnShowMazeStage(sender, args)
	if MazeModule.MazeStageModule == nil then
		return
	end

	local command = args:ToLuaTable()

	MazeModule.MazeStageModule:ShowStage(command.Id)
	MazeModule.PauseCommandCountdown()
end

function MazeModule.OnMazeMainUITweenShow()
	MazeModule.CanMainUITweenShow = true
end

function MazeModule.OnOpenClockUI(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeClockUI, Constant.UILayer.UI, {
		cid = command.Cid,
		retryCount = command.RetryCount,
		speedChange = command.SpeedChange,
		brickList = command.MazeClockItems
	})
end

function MazeModule.OnShowElementIntroduction(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.ElementIntroduceUI, Constant.UILayer.UI, {
		cid = command.CfgId
	})
end

function MazeModule.OnEnterMaze(sender, args)
	MazeLogicAdapter.Instance:Pause()
end

function MazeModule.Prepared()
	MazeLogicAdapter.Instance:Resume()
	MazeModule.StartTimer()
	MazeModule.CheckCommandCountdown()
end

function MazeModule.OnExamMazeDurationChange(addValue)
	NoticeModule.ShowTimeChangeNotice(addValue)
end

function MazeModule.OnUpdateEnergy()
	if MazeDataModule.PlayerInfo.Energy <= 0 then
		MazeModule.SendLeaveMazeOrder()
	end
end

function MazeModule.OnStartTransport(sender, args)
	if MazeModule.MazeScene == nil then
		return
	end

	local command = args:ToLuaTable()

	MazeModule.MazeScene:OnStartTransport(command.NodeID, command.Mode)
end

function MazeModule.OnHeroMoveArrived(sender, args)
	if MazeModule.MazeScene == nil then
		return
	end

	local command = args:ToLuaTable()

	MazeModule.MazeScene:OnHeroMoveArrived(command.NodeID, command.Stop)
end

function MazeModule.OnQuickFightCheckCommand(sender, args)
	local command = args:ToLuaTable()
	local cfgMonsterTeamData = CfgMonsterTeamTable[command.MonsterTeamId]

	if MazeModule.IsForceDisableQuickBattle() then
		MazeModule.ReallyStartQuickFight(false)
	elseif cfgMonsterTeamData.IsQuickBattleDefault then
		MazeModule.ReallyStartQuickFight(true)
	elseif MazeModule.IsQuickFightIgnoreType ~= 0 then
		local isQuick = false

		if MazeModule.IsQuickFightIgnoreType == 1 then
			isQuick = true
		end

		MazeModule.ReallyStartQuickFight(isQuick)
	else
		MazeModule.PauseCommandCountdown()
		UIModule.Open(Constant.UIControllerName.EndlessMazeCheckBattleUI, Constant.UILayer.Tooltip, {
			onClose = MazeModule.OnQuickBattleCheckUIConfirmed
		})
	end
end

function MazeModule.ReallyStartQuickFight(isQuick)
	if isQuick then
		MazeModule.PlayQuickFight()
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_QUICK_FIGHT_CHECK, {
		Quickly = isQuick
	})
end

function MazeModule.OnQuickBattleCheckUIConfirmed(isQuick)
	MazeModule.ResumeCommandCountdown()
	MazeModule.ReallyStartQuickFight(isQuick)
end

function MazeModule.OnNotifyElementAction(sender, args)
	local command = args:ToLuaTable()

	MazeModule.MazeScene:PlayElementAction(command.ActionCid)
end

function MazeModule.OnTriggerGuideCommand(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, command.Param)
end

function MazeModule.OnUpdatePlayerCameraCommand(sender, args)
	local command = args:ToLuaTable()

	MazeModule.__CanDragCamera = command.PlayerCameraType == 0
end

function MazeModule.OnCommandMoveCamera(sender, args)
	local command = args:ToLuaTable()

	MazeModule.MazeScene:CommandMoveCamera(command.ScreenSwitchs)
end

function MazeModule.OnOpenRuneShopUI(sender, args)
	local command = args:ToLuaTable()

	if UIModule.HasUI(Constant.UIControllerName.EndlessMazeRuneShopUI) then
		EventDispatcher.Dispatch(EventID.MazeRuneRefreshShop, command.ShopData)
	else
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneShopUI, Constant.UILayer.UI, {
			shopData = command.ShopData
		})
	end
end

function MazeModule.OnOpenReplaceRuneUI(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneReplaceUI, Constant.UILayer.UI, {
		oldRunes = command.BeReplaceRunes,
		newRunes = command.ReplaceRunes
	})
end

function MazeModule.OnOpenChooseRuneUI(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSelectUI, Constant.UILayer.UI, {
		runes = command.Runes,
		crystal = command.Crystal,
		onConfirm = function(index)
			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHOOSE_RUNE, {
				Index = index
			})
		end
	})
end

function MazeModule.OnOpenStrengthenRuneUI(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneStrengthenUI, Constant.UILayer.UI, {
		count = command.Count,
		discount = 1 + command.RuneStrengthCostChange / 100
	})
end

function MazeModule.OnRuneGet(sender, args)
	local command = args:ToLuaTable()
	local isUnseal = false

	if #command.Runes == 1 then
		local cfgRuneData = CfgRuneTable[command.Runes[1]]

		if cfgRuneData.GetNotice == Constant.Maze.RuneFeatureSeal then
			isUnseal = true
		end
	end

	if isUnseal then
		EventDispatcher.Dispatch(EventID.MazeTopRightRuneNotice, command.Runes[1], Constant.Maze.RuneNoticeTypeUnseal, {
			cid = command.Runes[1]
		})
	else
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneNoticeGetUI, Constant.UILayer.UI, command.Runes, true)
	end
end

function MazeModule.OnRuneEffect(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.MazeTopRightRuneNotice, command.RuneId, Constant.Maze.RuneNoticeTypeEffect, {
		cid = command.RuneId
	})
end

function MazeModule.OnRuneEvolution(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.MazeTopRightRuneNotice, command.OriginalRune, Constant.Maze.RuneNoticeTypeEvolution, {
		oldRuneCid = command.OriginalRune,
		newRuneCid = command.EvolutionRune
	})
end

function MazeModule.OnRuneSplit(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.MazeTopRightRuneNotice, command.RuneId, Constant.Maze.RuneNoticeTypeSplit, {
		cid = command.RuneId,
		splitRunes = command.SpliteRunes
	})
end

function MazeModule.OnRuneStrengthen(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneNoticeLevelUpUI, Constant.UILayer.UI, {
		runeCid = command.RuneId,
		level = command.Level
	})
end

function MazeModule.OnMazeUpdateNodeData(areaNodeData, isNewActive)
	if isNewActive then
		local nodeDataForNav = MazeModule.PathFinder:GetMapData()

		nodeDataForNav[areaNodeData.YIndex + 1][areaNodeData.XIndex + 1] = 0

		local pathNode = MazeModule.PathFinder:GetPathNode(areaNodeData.YIndex + 1, areaNodeData.XIndex + 1)

		for i = 1, #areaNodeData.NextNodes do
			local nextNodeId = areaNodeData.NextNodes[i]

			if nextNodeId ~= 0 then
				MazeModule.UpdateConnectedPathNode(areaNodeData, pathNode, nextNodeId)
			end
		end

		for i = 1, #areaNodeData.ParentNodes do
			local parentNodeId = areaNodeData.ParentNodes[i]

			if parentNodeId ~= 0 then
				MazeModule.UpdateConnectedPathNode(areaNodeData, pathNode, parentNodeId)
			end
		end
	end

	UIModule.Close(Constant.UIControllerName.MazeBagUI)
end

function MazeModule.UpdateConnectedPathNode(curNodeData, curPathNode, connectedNodeId)
	local nextNodeData = MazeDataModule.GetNodeDataById(connectedNodeId)

	if nextNodeData.IsActive then
		local nextPathNode = MazeModule.PathFinder:GetPathNode(nextNodeData.YIndex + 1, nextNodeData.XIndex + 1)
		local dirX = nextNodeData.XIndex - curNodeData.XIndex
		local dirY = nextNodeData.YIndex - curNodeData.YIndex
		local dirIndex = MazeModule.GetDirectionIndex(dirX, dirY)

		curPathNode.closeDirection[dirIndex] = false

		local reverseDirIndex = dirIndex + 4

		if reverseDirIndex > 8 then
			reverseDirIndex = reverseDirIndex - 8
		end

		nextPathNode.closeDirection[reverseDirIndex] = false
	end
end

function MazeModule.OnMazeUpdateData()
	MazeModule.FlagOnEnterMaze = true

	MazeModule.CommandSwitch(false)
	MazeModule.TryInitMazeScene()

	MazeModule.__CanDragCamera = MazeDataModule.PlayerInfo.PlayerCameraType == 0

	local nodeDataForNav = {}
	local nodeDataWithDirClose = {}

	for y = 1, MazeDataModule.MaxNodeYIndex + 1 do
		nodeDataForNav[y] = nodeDataForNav[y] or {}
		nodeDataWithDirClose[y] = nodeDataWithDirClose[y] or {}

		for x = 1, MazeDataModule.MaxNodeXIndex + 1 do
			nodeDataForNav[y][x] = PathFinder.BLOCK_GRID

			if MazeDataModule.MazeMapData.Nodes[x] ~= nil then
				local nodeData = MazeDataModule.MazeMapData.Nodes[x][y]

				if nodeData ~= nil then
					nodeDataWithDirClose[y][x] = nodeDataWithDirClose[y][x] or {
						true,
						true,
						true,
						true,
						true,
						true,
						true,
						true
					}

					if nodeData.IsActive then
						nodeDataForNav[y][x] = PathFinder.MOVABLE_GRID

						for i = 1, #nodeData.NextNodes do
							local nextNodeId = nodeData.NextNodes[i]

							if nextNodeId ~= 0 then
								local nextNodeData = MazeDataModule.GetNodeDataById(nextNodeId)

								if nextNodeData.IsActive then
									local dirX = nextNodeData.XIndex - nodeData.XIndex
									local dirY = nextNodeData.YIndex - nodeData.YIndex
									local dirIndex = MazeModule.GetDirectionIndex(dirX, dirY)

									if dirIndex == 0 then
										logError("Error in MazeModule.FindNodePath")
									end

									nodeDataWithDirClose[y][x][dirIndex] = false

									local reverseDirIndex = dirIndex + 4

									if reverseDirIndex > 8 then
										reverseDirIndex = reverseDirIndex - 8
									end

									nodeDataWithDirClose[nextNodeData.YIndex + 1] = nodeDataWithDirClose[nextNodeData.YIndex + 1] or {}
									nodeDataWithDirClose[nextNodeData.YIndex + 1][nextNodeData.XIndex + 1] = nodeDataWithDirClose[nextNodeData.YIndex + 1][nextNodeData.XIndex + 1] or {
										true,
										true,
										true,
										true,
										true,
										true,
										true,
										true
									}
									nodeDataWithDirClose[nextNodeData.YIndex + 1][nextNodeData.XIndex + 1][reverseDirIndex] = false
								end
							end
						end
					end
				end
			end
		end
	end

	MazeModule.PathFinder:InitMap(nodeDataForNav, nodeDataWithDirClose)
end

function MazeModule.GetDirectionIndex(directionX, directionY)
	local index = 0

	if directionX == 0 and directionY == -1 then
		index = 1
	elseif directionX == 1 and directionY == -1 then
		index = 2
	elseif directionX == 1 and directionY == 0 then
		index = 3
	elseif directionX == 1 and directionY == 1 then
		index = 4
	elseif directionX == 0 and directionY == 1 then
		index = 5
	elseif directionX == -1 and directionY == 1 then
		index = 6
	elseif directionX == -1 and directionY == 0 then
		index = 7
	elseif directionX == -1 and directionY == -1 then
		index = 8
	end

	return index
end

function MazeModule.OnNotifyMazeAlienEventUnlockCommand(sender, args)
	local command = args:ToLuaTable()

	net_maze.uploadMazeAlienEventUnlock(command.Cid, command.ElementCid)
end

function MazeModule.OnNotifyMazeMonsterUnlockCommand(sender, args)
	local command = args:ToLuaTable()

	net_maze.uploadMazeMonsterUnlock(command.Cid)
end

function MazeModule.OnDoExecution(sender, args)
	local command = args:ToLuaTable()
	local cfgExecutionData = CfgElementServiceActionExecutionTable[command.ExecutionCid]

	if cfgExecutionData.ExecutionType == Constant.ExecutionType.ExitTheMazeExecution then
		HorizontalRPGModule.DoOldMazeExecution(cfgExecutionData)

		return
	end

	if MazeDataModule.IsScrollMaze() then
		return
	end

	local cfgMazeGlobalData = CfgMazeGlobalTable[1004]
	local needPlayAnimationExecutions = string.split(cfgMazeGlobalData.Parameter, "|")

	if table.indexOf(needPlayAnimationExecutions, tostring(cfgExecutionData.ExecutionType)) == -1 then
		return
	end

	local actingElement

	for i = 1, #MazeModule.MazeScene.Elements do
		local element = MazeModule.MazeScene.Elements[i]

		if element.ElementPOD.ID == command.ElementID then
			actingElement = element

			break
		end
	end

	if actingElement == nil then
		local elementPOD = MazeDataModule.GetElementPOD(command.ElementID)

		if elementPOD == nil or not elementPOD.IsRemoved then
			local elementInfoStr

			if elementPOD == nil then
				elementInfoStr = " 找不到具体的元素数据"
			else
				elementInfoStr = " 元素cid " .. elementPOD.CID

				local areaNodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)

				if areaNodeData == nil then
					elementInfoStr = elementInfoStr .. " 找不到元素所在的节点"
				else
					elementInfoStr = elementInfoStr .. " 所在节点：x：" .. areaNodeData.XIndex .. ", y：" .. areaNodeData.YIndex .. " 节点cid：" .. areaNodeData.CID
				end
			end

			logError("元素播放执行前动画时，在迷宫里找不到该元素的实体。执行id：" .. command.ExecutionCid .. "。 MazeInstance.Id: " .. MazeDataModule.MazeInstanceID .. elementInfoStr)
		end

		return
	end

	cfgMazeGlobalData = CfgMazeGlobalTable[1005]

	local heroAnimationExecutions = string.split(cfgMazeGlobalData.Parameter, "|")

	if table.indexOf(heroAnimationExecutions, tostring(cfgExecutionData.ExecutionType)) ~= -1 then
		MazeModule.MazeScene.Hero.PreActionExecutionType = cfgExecutionData.ExecutionType
	end

	MazeModule.MazeScene.Hero:PauseMove(Constant.PauseMoveReason.PreExecution)

	actingElement.PreActionExecutionType = cfgExecutionData.ExecutionType

	actingElement:PauseMove(Constant.PauseMoveReason.PreExecution)

	local cfgElementAllData = CfgElementAllTable[actingElement.ElementPOD.CID]
	local cfgElementEntityData = CfgElementEntityTable[cfgElementAllData.EntityId]

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazePlayPreExecAnimation, true)
	MazeModule.CommandSwitch(false)
	MazeModule.CloseMazeManualUI()

	if cfgExecutionData.ExecutionType == 106 then
		MazeModule.PauseCommandCountdown()
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		if cfgExecutionData.ExecutionType == 106 then
			MazeModule.ResumeCommandCountdown()
		end

		MazeModule.CommandSwitch(true)
	end, cfgElementEntityData.InteractDuration)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		MazeModule.MazeScene.Hero:ResumeMove(Constant.PauseMoveReason.PreExecution)
		actingElement:ResumeMove(Constant.PauseMoveReason.PreExecution)
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazePlayPreExecAnimation, false)
	end, cfgElementEntityData.InteractDuration + 0.3)

	timer:Start()
end

function MazeModule.OnReviveSouls(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeSoulReviveUI, Constant.UILayer.UI, {
		maxNum = command.DollNum
	})
end

function MazeModule.OnSoulDead(dollPOD)
	local timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Maze, function()
		local isAllSoulDead = true
		local dollDataList = MazeDataModule.GetActiveDollDataList()

		for i = 1, #dollDataList do
			local pod = dollDataList[i]

			if pod.finalAttributes[Constant.Attribute.TYPE_HP] > 0 then
				isAllSoulDead = false

				break
			end
		end

		if isAllSoulDead then
			if MazeModule.SoulDeadQueue ~= nil then
				MazeModule.SoulDeadQueue:Clear()
			end

			return
		end

		if MazeModule.SoulDeadQueue == nil then
			MazeModule.SoulDeadQueue = Queue.New()
		end

		MazeModule.SoulDeadQueue:Enqueue(dollPOD)
		MazeModule.CheckOpenDollDeadUI()
	end, 1)

	timer:Start()
end

function MazeModule.CheckOpenDollDeadUI()
	if MazeModule.ShowingSoulDeadUI then
		return
	end

	if MazeModule.SoulDeadQueue.Size > 0 then
		UIModule.Open(Constant.UIControllerName.MazeSoulDeadUI, Constant.UILayer.UI, {
			dollPOD = MazeModule.SoulDeadQueue:Dequeue()
		}, true)

		MazeModule.ShowingSoulDeadUI = true
	end
end

function MazeModule.OnTroopHpChange(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeTroopHpChangeUI, Constant.UILayer.Mid, {
		percentage = command.Percentage
	}, true)
end

function MazeModule.OnTroopSpChange(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeTroopSpChangeUI, Constant.UILayer.Mid, {
		percentage = command.Percentage
	}, true)
end

function MazeModule.OnEndGather(sender, args)
	MazeModule.MazeScene.Hero.GatherCid = 0

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeGather, false)
end

function MazeModule.OnStarGather(sender, args)
	local command = args:ToLuaTable()

	MazeModule.MazeScene.Hero.GatherCid = command.GatherCID

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeGather, true)
end

function MazeModule.OnBattleInitCommand(sender, args)
	local command = args:ToLuaTable()

	BattleModule.Init(command.BattleType)
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, MazeModule.OnUIOpen)
	EventDispatcher.Dispatch(EventID.StopBGM)
	MazeModule.CommandSwitch(false)
	GameEntry.Data.Battle:InitBattleData(args.BattleCommand)
	BattleModule.InitBattle(command)
	BattleModule.StartFight(args.BattleCommand)
	MazeModule.PauseCommandCountdown()
end

function MazeModule.OnUIOpen(sender, args)
	local cfgSceneListData = CfgSceneListTable[SceneID.Battle]

	if args.UIName == cfgSceneListData.LoadingUI then
		GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, MazeModule.OnUIOpen)
		BattleModule.HideAllUIExceptLoading(args.SerialId)
		MazeModule.MazeScene:SetActive(false)

		if UIModule.HasUI(Constant.UIControllerName.ChatUI) or UIModule.IsLoadingUI(Constant.UIControllerName.ChatUI) then
			UIModule.Close(Constant.UIControllerName.ChatUI)
		end
	end
end

function MazeModule.OnGetGatherStepReward(sender, args)
	local command = args:ToLuaTable()
	local items = command.Items

	for i = 1, #items do
		local mazeRawItemPOD = items[i]
		local noticeCid = mazeRawItemPOD.CustomType == 1 and 21040103 or 21040102
		local cfgItemData = CfgItemTable[mazeRawItemPOD.CID]

		NoticeModule.ShowNoticeNoCallback(noticeCid, cfgItemData.Name, mazeRawItemPOD.Num)
	end
end

function MazeModule.OnOpenSubmitItem(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeSubmitItemUI, Constant.UILayer.UI, command.SubmitItemCID)
end

function MazeModule.OpenQTE(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeQTEUI, Constant.UILayer.UI, {
		command.Cid,
		command.ButtonCount,
		command.RetryCount,
		command.ChangeTimeType,
		command.ChangeTimeValue,
		0
	})
end

function MazeModule.OnTaskUpdate(taskCid)
	local cfgMainQuestData = CfgMainQuestTable[taskCid]

	if cfgMainQuestData.Type == TaskModule.TaskType.EXPLORE_POINT_TASK and TaskModule.IsTypeParamMatched(cfgMainQuestData.TypeParam, {
		1
	}) then
		local taskServerPodData = TaskModule.GetProcessingTaskByCid(taskCid)

		if taskServerPodData ~= nil and taskServerPodData.finNum >= taskServerPodData.tgtNum then
			NoticeModule.ShowTaskAccomplishedNotice(taskCid)
		end
	end
end

function MazeModule.OnAddItem(addItems)
	for i = 1, #addItems do
		local cfgItemData = CfgItemTable[addItems[i].cid]

		if cfgItemData.KeyItemPrompt then
			NoticeModule.ShowKeyItemNotice(cfgItemData.Id)
		elseif cfgItemData.Type == Constant.ItemType.Item and cfgItemData.SubType == Constant.ItemSubType.ItemUnlockRune then
			EventDispatcher.Dispatch(EventID.MazeFlyRuneOrItem, {
				{
					itemCid = cfgItemData.Id,
					itemInstanceId = addItems[i].id
				}
			})
		end
	end
end

function MazeModule.OnUploadMainQuestProgressToServer(sender, args)
	local command = args:ToLuaTable()

	net_maze.uploadMazeQuestProgress(command.QuestCid, command.FinNum)
end

function MazeModule.OnMazeSceneInitialized()
	MazeModule.CommandSwitch(true)
end

function MazeModule.InitAfterLoadSceneComplete(sender, args)
	MazeModule.FlagOnLoadSceneComplete = true

	GameEntry.LuaEvent:Unsubscribe(MazeLoadSceneCompleteEventArgs.EventId, MazeModule.InitAfterLoadSceneComplete)
	MazeModule.TryInitMazeScene()
end

function MazeModule.TryInitMazeScene()
	if MazeModule.FlagOnEnterMaze and MazeModule.FlagOnLoadSceneComplete then
		MazeModule.MapUIModule = MazeMapUIModule.New()
		MazeModule.MazeScene = MazeScene.New()

		MazeModule.MazeScene:Show()

		if not MazeDataModule.IsScrollMaze() then
			MazeModule.MazeStageModule = MazeStageModule.New()
		end

		MazeModule.FlagOnEnterMaze = false
		MazeModule.FlagOnLoadSceneComplete = false
		MazeModule.StartCountdown = false
	end
end

function MazeModule.OnWish(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.MazeWishUI, Constant.UILayer.UI, command.Wishes)
end

function MazeModule.OnChooseWeather(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.ChangeWeatherUI, Constant.UILayer.UI, command.Weathers)
end

function MazeModule.OnNotice(sender, args)
	local command = args:ToLuaTable()
	local noticeID = command.NoticeID

	NoticeModule.ShowNoticeNoCallback(noticeID, unpack(command.Args))
end

function MazeModule.OnUpdateWeather(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.WeatherCid = command.WeatherCid

	MazeBGMModule.ChangeWeatherSound()
	EventDispatcher.Dispatch(EventID.MazeUpdateWeather)
end

function MazeModule.OnStartTurntableGame(sender, args)
	local command = args:ToLuaTable()

	TurntableGameModule.StartGameInMaze(command)
end

function MazeModule.OnStartJudge(sender, args)
	local command = args:ToLuaTable()

	UIModule.Open(Constant.UIControllerName.DiceGameUI, Constant.UILayer.UI, {
		judgeCid = command.JudgeCid
	})
end

function MazeModule.OnPlayerInfoChange(propertyName, propertyValue, changeValue)
	return
end

function MazeModule.OnSaveMaze(sender, args)
	local command = args:ToLuaTable()
	local mazeCfgData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local chapterData = CfgChapterTable[mazeCfgData.ChapterId]

	if GmListModule.EnableMazeCloudSaveData() or chapterData.CloudSave then
		local netSuccess = net_maze.saveMaze(command.SaveJson, command.IsQuit, mazeCfgData.Version)

		if not netSuccess then
			NoticeModule.ShowNotice(21040133)
		end
	else
		local mazeDataTable = {}

		mazeDataTable.LogicID = MazeDataModule.LogicID
		mazeDataTable.Version = mazeCfgData.Version
		mazeDataTable.SaveData = command.SaveJson

		local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Maze_Save)

		if dataTab == nil then
			dataTab = {}
		end

		dataTab[tostring(chapterData.Type)] = mazeDataTable

		PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Maze_Save, dataTab)
		PlayerPrefsUtil.Save()

		if command.IsQuit then
			net_maze.saveMaze("", command.IsQuit, 0)
		end
	end
end

function MazeModule.OnSelectDialogResponded(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.CurrDialog = command.DialogCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, command.DialogCid)
end

function MazeModule.OnQuittedCardGame()
	if MazeDataModule.CurrDialog ~= 0 then
		DialogModule.OpenDialog(MazeDataModule.CurrDialog, true)
	end
end

function MazeModule.OnStartCardGame(sender, args)
	local command = args:ToLuaTable()

	CardGameModule.StartCardGameInMaze(command)
end

function MazeModule.OnOpenSelectUI(sender, args)
	local command = args:ToLuaTable()
	local cfgMazeSelectionData = CfgMazeSelectionTable[command.SelectionCID]

	if cfgMazeSelectionData.Type == Constant.MazeSelectionType.Auto then
		if MazeModule.MazeScene.ScrollStageController ~= nil then
			MazeModule.MazeScene.ScrollStageController:StartEvent(cfgMazeSelectionData)
		elseif MazeDataModule.IsScrollMaze() then
			logError("卷轴迷宫错误：打开选项时，卷轴还未初始化完毕")
		else
			logError("选项类型错误: 当前迷宫不支持选项类型3")
		end
	elseif cfgMazeSelectionData.Type == Constant.MazeSelectionType.HideAuto then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SELECTION_PANEL_END, {
			SelectIndex = 1
		})
	else
		UIModule.Open(Constant.UIControllerName.MazeSelectPanelUI, Constant.UILayer.Mid, {
			selectionCid = command.SelectionCID
		})
	end
end

function MazeModule.OnOpenDialogue(sender, args)
	local command = args:ToLuaTable()

	DialogModule.OpenDialog(command.DialogCID, true)
	MazeModule.PauseCommandCountdown()
end

function MazeModule.OnWeak(sender, args)
	local command = args:ToLuaTable()

	MazeModule.ReviveOrQuit(command)
end

function MazeModule.ReviveOrQuit(command)
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local freeLeftCount = cfgMazeInstanceData.ReviveTimes[1] - command.FreeReviveCount
	local buffLeftCount = cfgMazeInstanceData.ReviveTimes[2] - command.BuffReviveCount
	local propLeftCount = cfgMazeInstanceData.ReviveTimes[3] - command.PropReviveCount
	local treLeftCount = cfgMazeInstanceData.ReviveTimes[4] - command.TreReviveCount

	if freeLeftCount + buffLeftCount + propLeftCount + treLeftCount <= 0 then
		MazeModule.SendLeaveMazeOrder()
	else
		UIModule.Open(Constant.UIControllerName.MazeReviveUI, Constant.UILayer.Mid, command)
	end
end

function MazeModule.OnMazeSettlement(sender, args)
	local command = args:ToLuaTable()
	local settlementPOD = {}

	settlementPOD.success = command.Success
	settlementPOD.mazeData = command.MazeData
	settlementPOD.score = command.Score
	settlementPOD.openPathNodes = command.OpenPathNodes
	settlementPOD.completePathNodes = command.CompletePathNodes
	settlementPOD.playerParams = command.PlayerParams
	settlementPOD.killMonsterRecord = command.KillMonsterRecord
	settlementPOD.mazeItemDropGetCnts = command.MazeItemDropGetCnts
	settlementPOD.starConditions = command.StarConditions
	settlementPOD.getItems = command.GetItems
	settlementPOD.rewards = command.Rewards
	settlementPOD.deadCount = command.DeadCount
	settlementPOD.reviveCount = command.ReviveCount
	settlementPOD.duration = command.Duration
	settlementPOD.killBossCount = command.KillBossCount
	settlementPOD.fightWinCount = command.FightWinCount
	settlementPOD.completeNodeCount = command.CompleteNodeCount
	settlementPOD.records = command.Records
	settlementPOD.otherData = command.OtherData
	settlementPOD.dolls = command.Dolls
	settlementPOD.saveVersion = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID].Version

	net_maze.mazeSettlement(settlementPOD)
end

function MazeModule.OnNoticeConditionFailed(sender, args)
	local command = args:ToLuaTable()

	NoticeModule.ShowNoticeNoCallback(21040005, command.Reason)
end

function MazeModule.OnNoticeRemoveItem(sender, args)
	local command = args:ToLuaTable()
	local itemCid, itemNum, cfgItemData
	local str = ""

	for i = 1, #command.Items do
		itemCid = command.Items[i].CID
		itemNum = command.Items[i].Num
		cfgItemData = CfgItemTable[itemCid]

		if cfgItemData.IsRewardShow then
			str = str .. getTipText(Constant.TipConst.TIP_ITEM_NUM, cfgItemData.Name, itemNum)
			str = str .. " "
		end
	end

	local len = string.len(str)

	if len > 1 then
		str = string.sub(str, 1, len - 1)

		NoticeModule.ShowNoticeNoCallback(50000002, str)
	end
end

function MazeModule.OnNoticeGetItem(sender, args)
	local command = args:ToLuaTable()

	for i = 1, #command.Items do
		local cfgItemData = CfgItemTable[command.Items[i].CID]

		if cfgItemData.IsRewardShow then
			NoticeModule.ShowFloatGetItem(cfgItemData.Id, command.Items[i].Num)
		end
	end
end

function MazeModule.OnMazeOperationError(sender, args)
	local command = args:ToLuaTable()
	local code = command.Code
	local cfgClientErrorCodeData = CfgClientErrorCodeTable[code]

	if cfgClientErrorCodeData == nil then
		logError("code {0} not found in ClientErrorCode.csv.", code)

		return
	end

	NoticeModule.ShowNoticeNoCallback(21040005, cfgClientErrorCodeData.Describe)
end

function MazeModule.ExitMaze(customChangeSceneFunc)
	MazeModule.Shutdown()
	NoticeModule.NeedResumeNoticeAfterChangeScene()

	if customChangeSceneFunc == nil then
		SceneManager.ChangeScene(SceneID.MainCity)
	else
		customChangeSceneFunc()
	end
end

function MazeModule.CheckRecoverEntrance()
	if MazeModule.EntranceDataList ~= nil then
		for i = 1, #MazeModule.EntranceDataList do
			local data = MazeModule.EntranceDataList[i]
			local uiName = data.uiName
			local uiLayer = data.uiLayer
			local userdata = data.userData
			local validateFunc = data.validateFunc

			if validateFunc == nil or validateFunc() then
				UIModule.Open(uiName, uiLayer, userdata)
			end
		end

		MazeModule.EntranceDataList = nil
	end
end

function MazeModule.ResponseRevive()
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REVIVE, {
		Type = 4
	})
end

function MazeModule.Shutdown(isReset)
	if PlayerModule.InMaze then
		PlayerModule.InMaze = false

		xpcall(function()
			ModuleTimerUtil.Stop(Constant.ModuleTimerName.Maze)
			GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, MazeModule.OnUIOpen)
			MazeModule.RemoveMazeGlobalListeners()
		end, function(msg)
			logError("MazeModule.Shutdown error: " .. tostring(msg))
		end)
		xpcall(function()
			if MazeModule.MazeScene ~= nil then
				if MazeModule.MazeStageModule ~= nil then
					if MazeModule.IsStageShow() then
						MazeModule.MazeStageModule:HideStage(true)
					end

					MazeModule.MazeStageModule:Dispose()

					MazeModule.MazeStageModule = nil
				end

				MazeModule.MazeScene:SetActive(true)
				MazeModule.MazeScene:Dispose()

				MazeModule.MazeScene = nil
			end
		end, function(msg)
			logError("MazeModule.Shutdown error: " .. tostring(msg))
		end)
		xpcall(function()
			if MazeModule.MapUIModule ~= nil then
				MazeModule.MapUIModule:Dispose()

				MazeModule.MapUIModule = nil
			end
		end, function(msg)
			logError("MazeModule.Shutdown error: " .. tostring(msg))
		end)
		MazeModule.StartOrStopCommandCountdown(nil)
		BattleModule.Shutdown()
		MazeDataModule.Clear()
		MazeModule.Clear(isReset)
		GameEntry.Entity:ReleaseEntities("Terrain")
		GameEntry.Entity:ReleaseEntities("Element")
	end
end

function MazeModule.OnBattleClear()
	BattleModule.RecoverAllHideUI()
	MazeModule.MazeScene:SetActive(true)
	MazeModule.CommandSwitch(true)
	GameEntry.Sound:StopAllLoadingSounds()
	GameEntry.Sound:StopAllLoadedSounds(3)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function MazeModule.QuitBattle()
	BattleModule.Shutdown(MazeModule.OnBattleClear)
end

function MazeModule.OnBattleSettlement(command)
	UIModule.Open(Constant.UIControllerName.BattleSettlementUI, Constant.UILayer.UI, command)
	MazeModule.ResumeCommandCountdown()
end

function MazeModule.SendRestore(mazeCid)
	net_maze.restoreMaze(mazeCid)
end

function MazeModule.SendRevive()
	net_maze.revive()
end

function MazeModule.FindNodePath(targetAreaNodeData)
	local movePathNodes = {}
	local currentAreaNodeData = MazeModule.MazeScene.Hero.NodeData

	if MazeModule.IsOneStepNoBackward() then
		local isNextNode = false

		for i = 1, #currentAreaNodeData.NextNodes do
			if targetAreaNodeData.NodeId == currentAreaNodeData.NextNodes[i] then
				isNextNode = true
			end
		end

		if isNextNode then
			table.insert(movePathNodes, targetAreaNodeData)
		end

		return movePathNodes
	end

	local arrPathNodeList = MazeModule.PathFinder:FindPath(currentAreaNodeData.XIndex + 1, currentAreaNodeData.YIndex + 1, targetAreaNodeData.XIndex + 1, targetAreaNodeData.YIndex + 1)

	if arrPathNodeList ~= nil then
		for i = 2, #arrPathNodeList do
			local pathNode = arrPathNodeList[i]
			local nodeData = MazeDataModule.MazeMapData.Nodes[pathNode.x][pathNode.y]

			if nodeData == nil then
				logError("寻路错误：找不到节点：[" .. pathNode.x .. ", " .. pathNode.y .. "]. 最终目标节点id：" .. targetAreaNodeData.NodeId .. "，位置：" .. "[" .. targetAreaNodeData.XIndex .. ", " .. targetAreaNodeData.YIndex .. "]")

				return movePathNodes
			end

			table.insert(movePathNodes, nodeData)
		end
	end

	return movePathNodes
end

function MazeModule.IsOneStepNoBackward()
	return MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndlessPlus
end

function MazeModule.Sweep(mazeCid, count, formationId)
	MazeModule.__TempSweepMazeCid = mazeCid

	net_maze.mopUp(mazeCid, count, formationId)
end

function MazeModule.OnSweepComplete(mopUpInfos)
	local tempSweepMazeCid = MazeModule.__TempSweepMazeCid

	MazeModule.__TempSweepMazeCid = 0

	if mopUpInfos == nil then
		return
	end

	if not UIModule.HasUI(Constant.UIControllerName.MazeSweepUI) then
		UIModule.Open(Constant.UIControllerName.MazeSweepUI, Constant.UILayer.UI, {
			mopUpInfoList = mopUpInfos,
			mazeCid = tempSweepMazeCid
		})
	end

	EventDispatcher.Dispatch(EventID.MazeSweepResult, mopUpInfos, tempSweepMazeCid)
end

function MazeModule.SweepIllusionMaze(mazeCid, count)
	local passItemNum = WarehouseModule.GetItemNumByCfgID(1201061)

	if passItemNum <= 0 then
		logError("只有道具1201061数量大于0时才能扫荡")

		return
	end

	local dailyDupPOD = DailyDupModule.GetDailyDupPOD(7)
	local leftCount = DailyDupModule.GetLeftCount(dailyDupPOD)

	if leftCount <= 0 then
		NoticeModule.ShowNotice(21040092)

		return
	end

	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]

	if WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) < cfgMazeInstanceData.Cost then
		NoticeModule.ShowNotice(21045026)

		return
	end

	net_maze.illusionMopUp(mazeCid, count)
end

function MazeModule.OnSweepIllusionMazeComplete(mopUpInfos)
	UIModule.Open(Constant.UIControllerName.IllusionMazeSweepResultUI, Constant.UILayer.UI, {
		results = mopUpInfos
	})
end

function MazeModule.BuyLimitNum(mazeCid)
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]
	local costList = {}

	for i = 1, #cfgMazeInstanceData.BuyTimesCost do
		table.insert(costList, {
			cid = Constant.ItemID.TREASURE,
			num = cfgMazeInstanceData.BuyTimesCost[i]
		})
	end

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[mazeCid]
	local boughtCount = mazeInfoPOD == nil and 0 or mazeInfoPOD.buyCount

	NoticeModule.ShowBatchBuyConfirm(21040090, function()
		PlayerModule.SendBuyMazeCount(mazeCid)
	end, nil, nil, #costList, costList, boughtCount, 1, nil)
end

function MazeModule.Update(realElapseSeconds)
	if not PlayerModule.InMaze then
		return
	end

	if MazeModule.MazeStageModule ~= nil then
		MazeModule.MazeStageModule:Update(realElapseSeconds)
	end

	if MazeModule.StartCountdown then
		MazeModule.CheckTimeoutTimer = MazeModule.CheckTimeoutTimer + realElapseSeconds

		if MazeModule.CheckTimeoutTimer > 0.3 then
			MazeModule.CheckTimeoutTimer = 0

			if MazeDataModule.GetLeftTime() <= 0 then
				MazeModule.SendLeaveMazeOrder()

				MazeModule.StartCountdown = false

				EventDispatcher.Dispatch(EventID.MazeTimeout)
			end
		end
	end
end

function MazeModule.CheckQuitMaze()
	if not MazeModule.CommandSwitchOn then
		return
	end

	if MazeDataModule.ChapterType == Constant.Maze.ChapterTypeNormal then
		UIModule.Open(Constant.UIControllerName.MazeExitConfirmationUI, Constant.UILayer.Mid)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeRpg then
		UIModule.Open(Constant.UIControllerName.RpgMazeExitConfirmationUI, Constant.UILayer.Mid)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeIllusion then
		NoticeModule.ShowNotice(21040131, MazeModule.ConfirmAFK, MazeModule.ConfirmLeaveMaze)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeDualTeamExplore then
		UIModule.Open(Constant.UIControllerName.DualTeamExploreMazeExitConfirmationUI, Constant.UILayer.Mid)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalRPG then
		UIModule.Open(Constant.UIControllerName.HorizontalRpgMazeExitConfirmationUI, Constant.UILayer.Mid)
	elseif MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalChallenge then
		UIModule.Open(Constant.UIControllerName.MazeExitConfirmationUI, Constant.UILayer.Mid)
	else
		NoticeModule.ShowNotice(21040026, MazeModule.ConfirmAFK, MazeModule.ConfirmLeaveMaze)
	end
end

function MazeModule.ConfirmLeaveMaze()
	if MazeModule.CommandSwitchOn then
		MazeModule.SendLeaveMazeOrder()
	end
end

function MazeModule.ConfirmAFK()
	if MazeModule.CommandSwitchOn then
		MazeModule.SendAFKOrder()
	end
end

function MazeModule.PlayQuickFight()
	MazeModule.MazeScene:PlayQuickFight()
end

function MazeModule.StartTimer()
	MazeModule.StartCountdown = false

	if MazeModule.StartCountdown then
		MazeDataModule.StartTime = UnityEngine.Time.realtimeSinceStartup - MazeDataModule.PlayerInfo.Duration
	end
end

function MazeModule.SendLeaveMazeOrder()
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REQUEST_LEAVE_MAZE)
end

function MazeModule.SendAFKOrder()
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_AFK)
end

function MazeModule.AddFlyRuneData(data)
	table.insert(MazeModule.FlyRuneDataList, data)
end

function MazeModule.FlyRune()
	for i = 1, #MazeModule.FlyRuneDataList do
		EventDispatcher.Dispatch(EventID.MazeFlyRuneOrItem, MazeModule.FlyRuneDataList[i])
	end

	MazeModule.FlyRuneDataList = {}
end

function MazeModule.RemoveFirstFlyRuneData()
	table.remove(MazeModule.FlyRuneDataList, 1)
end

function MazeModule.PlayMaskedNormalEffect(effectID, position, delayPlayTime, playTime, layer, sortingLayerID, sortingNumber)
	return GameEntry.Effect:PlayNormalEffect(effectID, position, delayPlayTime, playTime, layer, sortingLayerID, sortingNumber, 1, true)
end

function MazeModule.PlayMaskedMountPointEffect(effectCid, mountPointCid, parentEntityId, mountPointGo, delayPlayTime, playTime, layer, sortingLayerID, sortingNumber)
	return GameEntry.Effect:PlayMountPointEffect(effectCid, mountPointCid, parentEntityId, mountPointGo, delayPlayTime, playTime, layer, sortingLayerID, sortingNumber, 1, true)
end

function MazeModule.StopEffect(playId)
	GameEntry.Effect:StopEffect(playId)
end

function MazeModule.CloseMazeManualUI()
	UIModule.Close(Constant.UIControllerName.MazeBagUI)
	UIModule.Close(Constant.UIControllerName.MazeTeamUI)
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneMainUI)
	UIModule.Close(Constant.UIControllerName.MazeExitConfirmationUI)
	UIModule.Close(Constant.UIControllerName.RpgMazeExitConfirmationUI)
	UIModule.Close(Constant.UIControllerName.ConfirmationUI)
	EventDispatcher.Dispatch(EventID.MazeCloseManualUI)
end

function MazeModule.CommandSwitch(isOn)
	MazeModule.CommandSwitchOn = isOn

	MazeLogicAdapter.Instance:CommandSwitch(isOn)
end

function MazeModule.GetCanDragCamera()
	return MazeModule.__CanDragCamera and not BattleModule.Initialized and not MazeDataModule.IsScrollMaze()
end

function MazeModule.GetEndlessMazeRuneSuitData()
	local function addMapValue(map, key, delta)
		if map[key] == nil then
			map[key] = delta
		else
			map[key] = map[key] + delta
		end
	end

	local suitMap = {}
	local cidList = {}
	local numList = {}

	for i = 1, #MazeDataModule.PlayerInfo.Runes do
		local mazeRunePOD = MazeDataModule.PlayerInfo.Runes[i]
		local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

		addMapValue(suitMap, cfgRuneData.QualityConstitute, 1)
		addMapValue(suitMap, cfgRuneData.TypeConstitute, 1)
	end

	local partList = {}

	for cid, num in pairs(suitMap) do
		table.insert(partList, {
			cid = cid,
			num = num
		})
	end

	table.sort(partList, function(data1, data2)
		return data1.num > data2.num
	end)

	for i = 1, #partList do
		table.insert(cidList, partList[i].cid)
		table.insert(numList, partList[i].num)
	end

	return cidList, numList
end

function MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)
	local legendCidList = {}

	if cidList == nil or numList == nil or #cidList == 0 or #cidList ~= #numList then
		cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	end

	for cid, cfgLegendConstituteData in pairsCfg(CfgLegendConstituteTable) do
		local isActive = true

		for i = 1, #cfgLegendConstituteData.RuneConstitute do
			local requireRuneSuitCid = cfgLegendConstituteData.RuneConstitute[i]
			local index = table.indexOf(cidList, requireRuneSuitCid)

			if index == -1 then
				isActive = false

				break
			end

			local requireRuneNum = cfgLegendConstituteData.ConstituteNum[i]

			if requireRuneNum > numList[index] then
				isActive = false

				break
			end
		end

		if isActive then
			table.insert(legendCidList, cid)
		end
	end

	return legendCidList
end

function MazeModule.GetEndlessMazeRuneSuitPartCount(suitCid, cidList, numList)
	local partNum = 0

	if cidList == nil or numList == nil or #cidList == 0 or #cidList ~= #numList then
		cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	end

	local index = table.indexOf(cidList, suitCid)

	if index ~= -1 then
		partNum = numList[index]
	end

	return partNum
end

function MazeModule.IsStageShow()
	if MazeModule.MazeStageModule == nil then
		return false
	end

	return MazeModule.MazeStageModule.IsShow
end

function MazeModule.CheckCanEnterMaze(mazeCid, formationPOD, isSweep, customSoulPrefabs)
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]

	if cfgMazeInstanceData.TimesLimit ~= 0 then
		local leftNum = PlayerModule.GetMazeLeftCount(mazeCid)

		if leftNum <= 0 then
			NoticeModule.ShowNotice(21040092)

			return false, 0
		end
	end

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[mazeCid]
	local cost = cfgMazeInstanceData.Cost

	if mazeInfoPOD == nil then
		cost = cfgMazeInstanceData.FirstCost
	end

	if cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) then
		NoticeModule.ShowNotice(21045026)

		return false, 0
	end

	if not isSweep then
		if #PlayerModule.PlayerInfo.formations == 0 then
			warning("阵型不存在")

			return false, 0
		end

		if cfgMazeInstanceData.MainWeakType ~= 0 then
			local canDealWithWeak = false
			local elements = {}

			for i = 1, #cfgMazeInstanceData.MonsterHead do
				local cfgMonsterData = CfgMonsterTable[cfgMazeInstanceData.MonsterHead[i]]

				for j = 1, #cfgMonsterData.WeakType do
					table.insert(elements, cfgMonsterData.WeakType[j])
				end
			end

			local lSoulPrefabs

			if customSoulPrefabs == nil then
				lSoulPrefabs = {}

				for prefabId, prefabIndex in pairs(formationPOD.formation) do
					local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

					if soulPrefabData.soulCid ~= nil then
						table.insert(lSoulPrefabs, soulPrefabData)
					end
				end
			else
				lSoulPrefabs = customSoulPrefabs
			end

			for i = 1, #lSoulPrefabs do
				local soulPrefabData = lSoulPrefabs[i]
				local skills = soulPrefabData:GetSkills()

				if skills ~= nil then
					for j = 1, #skills do
						local skillCid = skills[j]
						local cfgSkillData = CfgSkillTable[skillCid]

						if table.indexOf(elements, cfgSkillData.ShowDamageType) ~= -1 then
							canDealWithWeak = true

							break
						end
					end
				end

				if canDealWithWeak then
					break
				end
			end

			if not canDealWithWeak then
				return true, 21060002
			end
		end
	end

	return true, 0
end

function MazeModule.SetStageSpeed(speed)
	if MazeModule.MazeStageModule == nil then
		return
	end

	MazeModule.MazeStageModule:SetSpeed(speed)
end

function MazeModule.MoveToNextNode()
	MazeModule.MazeScene:AutoTapNextNode()
end

function MazeModule.GetWeakShowData(cfgMazeInstanceData)
	local elements = {}
	local elementTypeCountMap = {}

	for i = 1, #cfgMazeInstanceData.MonsterHead do
		local cfgMonsterData = CfgMonsterTable[cfgMazeInstanceData.MonsterHead[i]]

		for j = 1, #cfgMonsterData.WeakType do
			local count = elementTypeCountMap[cfgMonsterData.WeakType[j]]

			count = count or 0
			count = count + 1
			elementTypeCountMap[cfgMonsterData.WeakType[j]] = count
		end
	end

	for type, count in pairs(elementTypeCountMap) do
		if count == #cfgMazeInstanceData.MonsterHead then
			table.insert(elements, type)
		end
	end

	table.sort(elements, function(element1, element2)
		local main1 = element1 == cfgMazeInstanceData.MainWeakType and 1 or 0
		local main2 = element2 == cfgMazeInstanceData.MainWeakType and 1 or 0

		if main1 == main2 then
			return element1 < element2
		end

		return main2 < main1
	end)

	return elements
end

function MazeModule.QuickChallenge(MazeCid, formationID)
	net_maze.quickChallenge(MazeCid, formationID)
end

function MazeModule.NotificationQuickChallenge(win, cid, dmgRecords, items, quickChallenge)
	if win then
		PlayerModule.PlayerInfo.quickChallenge = quickChallenge
	end

	EventDispatcher.Dispatch(EventID.UpdateMaze)
	UIModule.Close(Constant.UIControllerName.MazeBossUI)

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.QuickChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function MazeModule.GetRewardShowData(cfgMazeInstanceData)
	local rewards = {}

	if table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgMazeInstanceData.Id) == -1 then
		for i = 1, #cfgMazeInstanceData.FirstRewards, 2 do
			local itemCid = cfgMazeInstanceData.FirstRewards[i]
			local cfgItemData = CfgItemTable[itemCid]

			if cfgItemData.IsPanelShow then
				table.insert(rewards, {
					isUncertain = false,
					isFirstPassReward = true,
					cid = itemCid,
					number = cfgMazeInstanceData.FirstRewards[i + 1]
				})
			end
		end
	end

	for i = 1, #cfgMazeInstanceData.RewardShow do
		table.insert(rewards, {
			number = 1,
			isUncertain = false,
			isFirstPassReward = false,
			cid = cfgMazeInstanceData.RewardShow[i]
		})
	end

	for i = 1, #cfgMazeInstanceData.RandomRewardShow do
		table.insert(rewards, {
			number = 1,
			isUncertain = true,
			isFirstPassReward = false,
			cid = cfgMazeInstanceData.RandomRewardShow[i]
		})
	end

	return rewards
end

function MazeModule.CheckCommandCountdown()
	local countdownPOD = MazeDataModule.PlayerInfo.Countdown

	if countdownPOD ~= nil then
		local cfgMazeCountdownData = CfgMazeCountdownTable[countdownPOD.CID]

		MazeModule.CommandCountdownStartTime = PlayerModule.GetServerTime() + countdownPOD.Countdown - cfgMazeCountdownData.TimeLimit
	end

	MazeModule.StartOrStopCommandCountdown(countdownPOD)
end

function MazeModule.StartOrStopCommandCountdown(countdownPOD)
	if countdownPOD ~= nil and MazeModule.IsCommandCountdownPause then
		MazeModule.CommandCDPauseStartTime = PlayerModule.GetServerTime()
	else
		MazeModule.CommandCDPauseStartTime = 0
	end

	MazeModule.CommandCDPauseTotalTime = 0

	MazeModule.ShowOrHideCommandCountdown(countdownPOD)
end

function MazeModule.ShowOrHideCommandCountdown(countdownPOD)
	if countdownPOD == nil then
		UIModule.Close(Constant.UIControllerName.MazeCountdownUI)
	elseif not MazeModule.IsCommandCountdownPause then
		UIModule.Open(Constant.UIControllerName.MazeCountdownUI, Constant.UILayer.Mid, {
			cid = countdownPOD.CID
		})
	end
end

function MazeModule.PauseCommandCountdown()
	MazeModule.__PauseOrResumeCommandCountdown(true)
end

function MazeModule.ResumeCommandCountdown()
	MazeModule.__PauseOrResumeCommandCountdown(false)
end

function MazeModule.__PauseOrResumeCommandCountdown(isPause)
	if MazeModule.IsCommandCountdownPause == isPause then
		return
	end

	MazeModule.IsCommandCountdownPause = isPause

	if isPause then
		MazeModule.CommandCDPauseStartTime = PlayerModule.GetServerTime()
	else
		MazeModule.CommandCDPauseTotalTime = MazeModule.CommandCDPauseTotalTime + (PlayerModule.GetServerTime() - MazeModule.CommandCDPauseStartTime)
	end

	MazeModule.ShowOrHideCommandCountdown(not isPause and MazeDataModule.PlayerInfo.Countdown or nil)
end

function MazeModule.GetCommandCountdownValue()
	local countdownPOD = MazeDataModule.PlayerInfo.Countdown

	if countdownPOD == nil then
		return 0
	end

	local cfgMazeCountdownData = CfgMazeCountdownTable[countdownPOD.CID]
	local countdown = cfgMazeCountdownData.TimeLimit - (PlayerModule.GetServerTime() - MazeModule.CommandCountdownStartTime - MazeModule.CommandCDPauseTotalTime)

	if countdown < 0 then
		countdown = 0
	end

	return countdown
end

function MazeModule.IsForceDisableQuickBattle()
	if not MazeDataModule.IsEndlessPlusLikeMaze() then
		return false
	end

	return not PlayerModule.IsMazeFinished(MazeDataModule.MazeInstanceID)
end

function MazeModule.Clear(isReset)
	if MazeModule.SoulDeadQueue ~= nil then
		MazeModule.SoulDeadQueue:Clear()

		MazeModule.SoulDeadQueue = nil
	end

	MazeModule.ShowingSoulDeadUI = false
	MazeModule.__CanDragCamera = true
	MazeModule.StartCountdown = false
	MazeModule.EnteredMaze = false
	MazeModule.FlyRuneDataList = {}
	MazeModule.CanMainUITweenShow = false
	MazeModule.CommandCountdownStartTime = 0
	MazeModule.IsCommandCountdownPause = false

	if isReset then
		MazeModule.IsQuickFightIgnoreType = 0
		MazeModule.EntranceDataList = nil
	end
end
