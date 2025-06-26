-- chunkname: @IQIGame\\Module\\Player\\PlayerModule.lua

PlayerModule = {
	CurrAdditiveSceneID = 0,
	_ReloadTime = 0,
	BattleSpeed = 1,
	MazeStageSpeed = 1,
	_ServerTime = 0,
	CurrSceneID = 0,
	InGame = false,
	TimeZone = 8,
	_lastPlayerLv = 0,
	_LastPangClientTime = 0,
	InMaze = false,
	PlayerInfo = {
		advanceLevelChaseFlag = false,
		todayOpenVisitTreasureChest = 0,
		todayHelpHomeCount = 0,
		isGuildSign = false,
		disableGuide = false,
		dressUpRotateSwitch = 0,
		treasurePlayerStatus = 0,
		abyssCid = 0,
		backflowTime = 0,
		guildId = 0,
		baseInfo = {
			guid = 0,
			intro = "",
			payPoint = 0,
			title = 0,
			showSoulCid = 0
		},
		guildChatCaches = {},
		unlockGirlBackgrounds = {},
		unlockChatBackgrounds = {},
		playerSetting = {},
		unlockChapterTasks = {},
		commandChallengeLayerIDs = {},
		abyssCids = {},
		dressUpRotateList = {}
	},
	InitSceneID = SceneID.MainCity
}

function PlayerModule.GetServerTime()
	return PlayerModule._ServerTime + (UnityEngine.Time.realtimeSinceStartup - PlayerModule._LastPangClientTime)
end

function PlayerModule.StateLogOut()
	PlayerModule.InGame = false
end

function PlayerModule.Load(playerPOD)
	LuaCodeInterface.SetBuglyUserId(playerPOD.baseInfo.pid)

	PlayerModule._ReloadTime = UnityEngine.Time.time
	PlayerModule.PlayerInfo = playerPOD
	PlayerModule._lastPlayerLv = playerPOD.baseInfo.pLv
	PlayerModule.InGame = true
	PlayerModule.InMaze = false

	PlayerModule.CustomizePlayerInfo()
	PlayerModule.SetInitScene()
	WarehouseModule.Reload(playerPOD.warehouse)
	DressModule.Reload(playerPOD.dresses)
	SoulModule.Reload(playerPOD.souls)
	SoulPrefabModule.Reload(playerPOD.soulPrefabs)
	ShopModule.Reload(playerPOD.shops)
	TaskModule.ReloadTask(playerPOD.quests, playerPOD.finishQuestList, playerPOD.failQuestList)
	GiftModule.ReloadGift(playerPOD.remainderGiveGiftNum)
	MailModule.ReloadMail(playerPOD.newMailCount)
	FondleModule.ReloadFondle(playerPOD.fondleNum, playerPOD.nextRecoveryFondleTime)
	SettingModule.ReloadData(playerPOD.unlockHeadIcons, playerPOD.unlockLoginBackgrounds, playerPOD.unlockAvatarFrames, playerPOD.unlockTitle)
	FriendModule.Reload(playerPOD.friends)
	ChatModule.Reload(playerPOD.chatRoom, playerPOD.unlockChatEmojis)
	WeatherModule.ReloadData(playerPOD.currentWeatherCid)
	SignInModule.ReloadData(playerPOD.signInfo)
	HLWorkModule.Reload(playerPOD.todayHomeWorkCount)
	MallModule.Reload(playerPOD.mallBuyCountRecords)
	GuideModule.ReloadServerGuideData(playerPOD.currentGuide, playerPOD.finishGuide)
	ChatModule.ShowClientMessage(ChatModule.CHANNEL_SYSTEM, ChatUIApi:GetString("healthyGameNotice"))
	ChurchModule.ReloadData(playerPOD.exchangeRecords)
	MemoryModule.ReloadData(playerPOD.soulMemoryChapters)
	MemoryNewModule.ReloadData(playerPOD.soulNewStorys)
	TownModule.ReloadData(playerPOD.townInfo)
	TownAreaModule.Reload()
	MemorySModule.Reload()
	DailyDupModule.Reload(playerPOD.dailyDups)
	LotteryModule.Reload(playerPOD.lotteryShows)
	ActiveOperationEventModule.Reload(playerPOD.opEventsStatus, playerPOD.opEventsDatas)
	PurchaseTipModule.Reload()
	PushMessageModule.Reload()
	ActiveModule.Reload()
	ActiveWelcomeBackModule.Reload()
	FishingModule.Reload(playerPOD.fishingData)
	GirlModule.Reload()
	RefundsGiftPackModule.Reload()
	GuildModule.Reload()
	JewelryModule.Reload()
	CelebrationGiftModule.Reload()
	MazeChallengeBonusModule.Reload()
	CommandChallengeModule.Reload()
	GmListModule.ShowPlayerGUI()
	EventDispatcher.Dispatch(EventID.PlayerInfoChanged)
end

function PlayerModule.CustomizePlayerInfo()
	local currMazes = {}

	for i, v in pairs(PlayerModule.PlayerInfo.currMazes) do
		currMazes[v] = v
	end

	PlayerModule.PlayerInfo.currMazes = currMazes
end

function PlayerModule.SetInitScene()
	PlayerModule.InitSceneID = SceneID.MainCity

	if PlayerModule.PlayerInfo.currDialog ~= 0 then
		local cfgDialogData = CfgDialogTable[PlayerModule.PlayerInfo.currDialog]

		if cfgDialogData.sysType == 1 or cfgDialogData.sysType == 5 or cfgDialogData.sysType == 6 then
			PlayerModule.InitSceneID = SceneID.Girl
		elseif cfgDialogData.sysType == 2 then
			PlayerModule.InitSceneID = SceneID.Home
		elseif cfgDialogData.sysType == 3 or cfgDialogData.sysType == 4 then
			PlayerModule.InitSceneID = SceneID.MainCity
			TownModule.inTown = true
		end
	end
end

function PlayerModule.UpdateHeroInfo(playerBaseInfoPOD)
	for k, v in pairs(playerBaseInfoPOD) do
		PlayerModule.PlayerInfo.baseInfo[k] = v

		PlayerModule.OnPlayerSomeInfoChange(k, v)
		EventDispatcher.Dispatch(EventID.PlayerSomeInfoChange, k, v)
	end

	EventDispatcher.Dispatch(EventID.PlayerInfoChanged)
end

function PlayerModule.SyncServerTime(serverTime)
	PlayerModule._ServerTime = serverTime
	PlayerModule._LastPangClientTime = UnityEngine.Time.realtimeSinceStartup

	LuaCodeInterface.SyncServerTime(serverTime, PlayerModule._LastPangClientTime)
end

function PlayerModule.GetItemCD(cid)
	if PlayerModule.PlayerInfo.ItemUseRecords == nil then
		return 0
	end

	local itemUsePOD

	for i, v in ipairs(PlayerModule.PlayerInfo.itemUseRecords) do
		if v.itemCid == cid then
			itemUsePOD = v

			break
		end
	end

	if itemUsePOD == nil then
		return 0
	end

	local cfgItemData = CfgItemTable[cid]
	local cd

	if cfgItemData.UseCoolDownType == 1 then
		cd = cfgItemData.UseCoolDownValue - (PlayerModule.GetServerTime() - itemUsePOD.useTime)

		if cd < 0 then
			cd = 0
		end

		return cd
	end
end

function PlayerModule.OnQuittedCardGame()
	DialogModule.Resume()
end

function PlayerModule.CheckResumeDialog()
	if not PlayerModule.InMaze and PlayerModule.PlayerInfo.currDialog ~= 0 then
		DialogModule.OpenDialog(PlayerModule.PlayerInfo.currDialog, false, true)
	end
end

function PlayerModule.OnSelectDialogResult(nextCid)
	PlayerModule.PlayerInfo.currDialog = nextCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextCid)
end

function PlayerModule.UpdateFinishMaze(mazeInsCid)
	table.insert(PlayerModule.PlayerInfo.finishMazes, mazeInsCid)
end

function PlayerModule.UpdateQuickFinishMaze(mazeInsCid)
	table.insert(PlayerModule.PlayerInfo.quickChallenge, mazeInsCid)
end

function PlayerModule.UnlockEvent(eventCid)
	table.insert(PlayerModule.PlayerInfo.unlockedEvents, eventCid)
end

function PlayerModule.FunctionTypeOpen(functionTypeId)
	table.insert(PlayerModule.PlayerInfo.functionTypes, functionTypeId)
end

function PlayerModule.EnergyRecovery(energy, nextRecoveryEnergyTime)
	if PlayerModule.InGame then
		PlayerModule.PlayerInfo.nextRecoveryEnergyTime = nextRecoveryEnergyTime
		PlayerModule.PlayerInfo.numAttrs[Constant.ItemID.ENERGY] = energy

		EventDispatcher.Dispatch(EventID.PlayerNumAttrsChange, Constant.ItemID.ENERGY, energy)
	end
end

function PlayerModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.QuittedCardGame, PlayerModule.OnQuittedCardGame)
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, PlayerModule.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Subscribe(L2DPlayCVEventArgs.EventId, PlayerModule.L2DPlayCVEvent)
end

function PlayerModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.QuittedCardGame, PlayerModule.OnQuittedCardGame)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, PlayerModule.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Unsubscribe(L2DPlayCVEventArgs.EventId, PlayerModule.L2DPlayCVEvent)
end

function PlayerModule.LoadSceneExtSucceeded(sender, args)
	if args.SceneID == SceneID.MainCity or args.SceneID == SceneID.Home or args.SceneID == SceneID.Girl then
		PlayerModule.CheckResumeDialog()
	end
end

function PlayerModule.UpdatePlayerGlobalBuff(globalBuffs)
	PlayerModule.PlayerInfo.globalBuffs = globalBuffs

	EventDispatcher.Dispatch(EventID.PlayerGlobalBuffChange)
end

function PlayerModule.UpdatePlayerParams(paramID, value)
	PlayerModule.PlayerInfo.playerParams[paramID] = value

	EventDispatcher.Dispatch(EventID.UpdatePlayerParams)
end

function PlayerModule.UpdateNumAttrs(numAttrs)
	if not PlayerModule.InGame then
		return
	end

	for k, v in pairs(numAttrs) do
		PlayerModule.PlayerInfo.numAttrs[k] = v

		EventDispatcher.Dispatch(EventID.PlayerNumAttrsChange, k, v)
	end
end

function PlayerModule.Update(realElapseSeconds)
	if not PlayerModule.InGame then
		return
	end
end

function PlayerModule.UpdateFormationTeam(newFormation)
	local updateIndex = 0

	for i = 1, #PlayerModule.PlayerInfo.formations do
		local curFormation = PlayerModule.PlayerInfo.formations[i]

		if curFormation ~= nil and curFormation.id == newFormation.id then
			updateIndex = i

			break
		end
	end

	if updateIndex ~= 0 then
		PlayerModule.PlayerInfo.formations[updateIndex] = newFormation
	else
		table.insert(PlayerModule.PlayerInfo.formations, newFormation)
	end

	EventDispatcher.Dispatch(EventID.UpdateFormationTeam)
end

function PlayerModule.UpdateMazeInfo(pod)
	PlayerModule.PlayerInfo.mazeInfoPOD[pod.cid] = pod

	EventDispatcher.Dispatch(EventID.PlayerUpdateMazeInfoPOD, pod)
end

function PlayerModule.GetNumAttrValue(itemCid)
	local value = PlayerModule.PlayerInfo.numAttrs[itemCid]

	if value == nil then
		value = 0
	end

	return value
end

function PlayerModule.SetAutoFightMode(battleType, autoFightMode)
	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.AutoFight, tostring(autoFightMode))
end

function PlayerModule.GetAutoFightMode(battleType)
	local cfgBattleAreaData = CfgBattleAreaTable[BattleModule.GetBattleAreaCid()]
	local isAutoFightUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.AUTO_FIGHT) and cfgBattleAreaData.Auto

	if not isAutoFightUnlock then
		return Constant.Battle.AutoFightModeManual
	end

	local autoFightMode = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.AutoFight)

	if autoFightMode == nil or autoFightMode == "" then
		return Constant.Battle.AutoFightModeManual
	end

	return tonumber(autoFightMode)
end

function PlayerModule.SaveBattleSpeed(battleType, speed)
	PlayerModule.BattleSpeed = speed

	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.BattleSpeed, tostring(speed))
end

function PlayerModule.SaveMazeStageSpeed(speed)
	PlayerModule.MazeStageSpeed = speed

	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MazeStageSpeed, tostring(speed))
end

function PlayerModule.GetBattleSpeed(battleType)
	local cfgBattleAreaData = CfgBattleAreaTable[BattleModule.GetBattleAreaCid()]

	if not cfgBattleAreaData.Speed then
		return 1
	end

	local speedStr = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.BattleSpeed)
	local speed = tonumber(speedStr)

	if speed == nil then
		return PlayerModule.BattleSpeed
	end

	if table.indexOf(Constant.Battle.SpeedList, speed) == -1 then
		return 1
	end

	return speed
end

function PlayerModule.GetMazeStageSpeed()
	local speedStr = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MazeStageSpeed)
	local speed = tonumber(speedStr)

	if speed == nil then
		return PlayerModule.MazeStageSpeed
	end

	return speed
end

function PlayerModule.L2DPlayCVEvent(sender, args)
	return
end

function PlayerModule.Shutdown()
	PlayerModule.RemoveEventListeners()
end

function PlayerModule.Init()
	PlayerModule.AddEventListeners()
end

function PlayerModule.OnPlayerSomeInfoChange(key, value)
	if key == "pLv" then
		if value > PlayerModule._lastPlayerLv then
			if UIModule.HasUI(Constant.UIControllerName.GuideUI) == false and PlayerModule.CurrSceneID ~= SceneID.Maze and PlayerModule.CurrSceneID ~= SceneID.Battle and PlayerModule.CurrSceneID ~= 0 then
				UIModule.Open(Constant.UIControllerName.PlayerLevelUpTipUI, Constant.UILayer.Tooltip, {
					PlayerModule._lastPlayerLv,
					value
				})
			end

			LoginModule.UpdateRoleLevelUpToSDK(value)
		end

		PlayerModule._lastPlayerLv = value
	end
end

function PlayerModule.IsRuneUnlock(runeCid)
	local cfgRuneData = CfgRuneTable[runeCid]

	if cfgRuneData.IsUnlock then
		return true
	end

	for i = 1, #PlayerModule.PlayerInfo.unlockRunes do
		if PlayerModule.PlayerInfo.unlockRunes[i] == runeCid then
			return true
		end
	end

	return false
end

function PlayerModule.UpdateUnlockRune(runeCid)
	table.insert(PlayerModule.PlayerInfo.unlockRunes, runeCid)
	EventDispatcher.Dispatch(EventID.UnlockEndlessMazeRune, runeCid)
end

function PlayerModule.GetUnlockRuneNumByChapter(chapterCid)
	local num = 0

	for i = 1, #PlayerModule.PlayerInfo.unlockRunes do
		local cfgRuneData = CfgRuneTable[PlayerModule.PlayerInfo.unlockRunes[i]]

		if cfgRuneData.UnlockChapter == chapterCid then
			num = num + 1
		end
	end

	for id, cfgRuneData in pairsCfg(CfgRuneTable) do
		if cfgRuneData.UnlockChapter == chapterCid and cfgRuneData.IsUnlock then
			num = num + 1
		end
	end

	return num
end

function PlayerModule.SendBuyMazeCount(mazeCid)
	net_maze.buyMazeCount(mazeCid)
end

function PlayerModule.OpenHiddenMaze(chapterCid)
	net_maze.openHiddenMaze(chapterCid)
end

function PlayerModule.UpdateOpenExtraMazes(mazeCids)
	PlayerModule.PlayerInfo.openExtraMazes = mazeCids
end

function PlayerModule.GetUnfinishedMazeCid(chapterType)
	for k, mazeCid in pairs(PlayerModule.PlayerInfo.currMazes) do
		local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]
		local type = CfgChapterTable[cfgMazeInstanceData.ChapterId].Type

		if type == chapterType then
			return mazeCid
		end
	end

	return nil
end

function PlayerModule.NotifyTodayOpenVisitTreasureChest(todayOpenVisitTreasureChest)
	PlayerModule.PlayerInfo.todayOpenVisitTreasureChest = todayOpenVisitTreasureChest

	EventDispatcher.Dispatch(EventID.HomeLandVisitEvent)
end

function PlayerModule.NotifyTodayHelpHomeCount(todayHelpHomeCount)
	PlayerModule.PlayerInfo.todayHelpHomeCount = todayHelpHomeCount

	EventDispatcher.Dispatch(EventID.HomeLandVisitEvent)
end

function PlayerModule.NotifyTodayHelpBuildingCount(todayHelpBuildingCount)
	PlayerModule.PlayerInfo.todayHelpBuildingCount = todayHelpBuildingCount

	EventDispatcher.Dispatch(EventID.HomeLandVisitEvent)
end

function PlayerModule.NotifyUnlockTownEvent(eventCid)
	table.insert(PlayerModule.PlayerInfo.unlockTownEvents, eventCid)
end

function PlayerModule.UpdateCurrMazes(currMazes)
	PlayerModule.PlayerInfo.currMazes = currMazes
end

function PlayerModule.IsPrologueEnabled()
	return GmListModule.EnableOpenAnim()
end

function PlayerModule.HasFreeDailySupply()
	local dailyRefreshTimeTable = {}

	dailyRefreshTimeTable.hour = Constant.Player.DailyResetTimeHour
	dailyRefreshTimeTable.min = Constant.Player.DailyResetTimeMin

	for id, cfgDailySupplyData in pairsCfg(CfgDailySupplyTable) do
		local startTimeTable = {}
		local hm = string.split(cfgDailySupplyData.OpenTime, ":")

		startTimeTable.hour = tonumber(hm[1])
		startTimeTable.min = tonumber(hm[2])

		local endTimeTable = {}

		hm = string.split(cfgDailySupplyData.EndTime, ":")
		endTimeTable.hour = tonumber(hm[1])
		endTimeTable.min = tonumber(hm[2])

		local state = PlayerModule.GetSupplyState(startTimeTable, endTimeTable, dailyRefreshTimeTable, id)

		if state == 3 then
			return true
		end
	end

	return false
end

function PlayerModule.GetSupplyState(startTimeTable, endTimeTable, dailyRefreshTimeTable, supplyCid)
	local function getTimeSecByDateTable(dateTable, hm, deltaDay)
		dateTable.hour = hm.hour
		dateTable.min = hm.min
		dateTable.sec = 0

		local timeStamp = dateTimeToTimeStamp(dateTable, PlayerModule.TimeZone)

		return timeStamp + 86400 * deltaDay
	end

	local isEndTimeAtTomorrow = endTimeTable.hour < startTimeTable.hour or endTimeTable.hour == startTimeTable.hour and endTimeTable.min < startTimeTable.min
	local currentTime = PlayerModule.GetServerTime()
	local date = getDateTimeTable(currentTime)
	local lastEndTime = getTimeSecByDateTable(date, endTimeTable, isEndTimeAtTomorrow and 0 or -1)
	local todayRefreshTime = getTimeSecByDateTable(date, dailyRefreshTimeTable, 0)
	local startTime = getTimeSecByDateTable(date, startTimeTable, 0)
	local thisEndTime = getTimeSecByDateTable(date, endTimeTable, isEndTimeAtTomorrow and 1 or 0)
	local tomorrowRefreshTime = getTimeSecByDateTable(date, dailyRefreshTimeTable, 1)
	local hasClaimed = table.indexOf(PlayerModule.PlayerInfo.dailySupplyList, supplyCid) ~= -1
	local isState1 = todayRefreshTime < currentTime and currentTime < startTime
	local isState2 = hasClaimed
	local isState3 = not hasClaimed and (startTime <= currentTime and currentTime < thisEndTime or currentTime < lastEndTime)
	local isState4 = not hasClaimed and (lastEndTime <= currentTime and currentTime < todayRefreshTime or thisEndTime <= currentTime and currentTime < tomorrowRefreshTime)

	if isState1 then
		return 1
	elseif isState2 then
		return 2
	elseif isState3 then
		return 3
	elseif isState4 then
		return 1
	end

	logError("每日补给状态错误：不属于任何状态。hasClaimed: " .. tostring(hasClaimed) .. " Server time: " .. currentTime .. " startTime: " .. startTime .. " endTime: " .. thisEndTime .. " dailyRefreshTime: " .. todayRefreshTime)

	return 0
end

function PlayerModule.UpdateEquipmentPrefab(pod)
	for i = 1, #PlayerModule.PlayerInfo.equipmentPrefabs do
		local equipmentPrefabPOD = PlayerModule.PlayerInfo.equipmentPrefabs[i]

		if equipmentPrefabPOD.id == pod.id then
			PlayerModule.PlayerInfo.equipmentPrefabs[i] = pod

			break
		end
	end

	EventDispatcher.Dispatch(EventID.EquipPrefabChanged, pod)
end

function PlayerModule.HasMazeChapterCanClaimExploreReward()
	for chapterCid, cfgChapterData in pairsCfg(CfgChapterTable) do
		if PlayerModule.CanClaimExploreReward(cfgChapterData) then
			return true
		end
	end

	return false
end

function PlayerModule.CanClaimExploreReward(cfgChapterData)
	if cfgChapterData.Type == 2 then
		local isUnlock = ConditionModule.Check(cfgChapterData.LockCondition)

		if isUnlock then
			local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.EXPLORE_POINT_TASK, {
				cfgChapterData.Id
			})

			for i = 1, #processing do
				local taskData = processing[i]

				if taskData.finNum >= taskData.tgtNum then
					return true
				end
			end
		end
	end

	return false
end

function PlayerModule.GetNormalMazeExploreProgressData()
	local cfgChapterData, cfgMazeInstanceData
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeNormal)

	if unfinishedMazeCid ~= nil then
		cfgMazeInstanceData = CfgMazeInstanceTable[unfinishedMazeCid]
		cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	else
		cfgChapterData, cfgMazeInstanceData = PlayerModule.GetLatestNormalMazeData()
	end

	return cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid
end

function PlayerModule.GetLatestNormalMazeData()
	local cfgChapterDataList = {}
	local maxOrder = 0

	for id, cfgChapterData in pairsCfg(CfgChapterTable) do
		if cfgChapterData.Type == 2 then
			if ConditionModule.Check(cfgChapterData.LockCondition) then
				table.insert(cfgChapterDataList, cfgChapterData)
			end

			maxOrder = math.max(maxOrder, cfgChapterData.Order)
		end
	end

	if #cfgChapterDataList == 0 then
		logError("There is no available maze")

		return nil, nil
	end

	table.sort(cfgChapterDataList, function(cfgChapterData1, cfgChapterData2)
		return cfgChapterData1.Order < cfgChapterData2.Order
	end)

	local latestUnlockChapterData

	for i = 1, #cfgChapterDataList do
		local cfgChapterData = cfgChapterDataList[i]

		if latestUnlockChapterData == nil or cfgChapterData.Order > latestUnlockChapterData.Order then
			latestUnlockChapterData = cfgChapterData
		end
	end

	local canChallengeMaxOrderMaze, minOrderMaze

	for id, cfgMazeInstanceData in pairsCfg(CfgMazeInstanceTable) do
		if cfgMazeInstanceData.ChapterId == latestUnlockChapterData.Id then
			local isUnlock = (cfgMazeInstanceData.QuickChallengeLockCondition ~= 0 and {
				ConditionModule.Check(cfgMazeInstanceData.QuickChallengeLockCondition)
			} or {
				ConditionModule.Check(cfgMazeInstanceData.LockCondition)
			})[1]
			local isLevelEnough = PlayerModule.PlayerInfo.baseInfo.pLv >= cfgMazeInstanceData.LockLevel

			if isUnlock and isLevelEnough and (canChallengeMaxOrderMaze == nil or cfgMazeInstanceData.Order > canChallengeMaxOrderMaze.Order) then
				canChallengeMaxOrderMaze = cfgMazeInstanceData
			end

			if minOrderMaze == nil or cfgMazeInstanceData.Order < minOrderMaze.Order then
				minOrderMaze = cfgMazeInstanceData
			end
		end
	end

	if canChallengeMaxOrderMaze == nil then
		return latestUnlockChapterData, minOrderMaze
	end

	return latestUnlockChapterData, canChallengeMaxOrderMaze, maxOrder
end

function PlayerModule.GetMazeLeftCount(mazeCid)
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[mazeCid]
	local leftCount = mazeInfoPOD == nil and cfgMazeInstanceData.TimesLimit or cfgMazeInstanceData.TimesLimit + mazeInfoPOD.buyCount - mazeInfoPOD.enterCount

	return leftCount, cfgMazeInstanceData.TimesLimit
end

function PlayerModule.UpdateAbyssCid(abyssCid)
	PlayerModule.PlayerInfo.abyssCid = abyssCid

	EventDispatcher.Dispatch(EventID.UpdateAbyss)
end

function PlayerModule.UpdateAbyssCids(abyssCids)
	PlayerModule.PlayerInfo.abyssCids = abyssCids

	EventDispatcher.Dispatch(EventID.UpdateAbyss)
end

function PlayerModule.UpdateItemDebts(itemDebts)
	PlayerModule.PlayerInfo.itemDebts = itemDebts

	EventDispatcher.Dispatch(EventID.UpdateItemDebts)
end

function PlayerModule.HasItemDebt()
	local hasDebt = false

	for cid, value in pairs(PlayerModule.PlayerInfo.itemDebts) do
		if cid ~= 0 and value ~= 0 then
			hasDebt = true
		end

		break
	end

	return hasDebt
end

function PlayerModule.IsMazeFinished(mazeCid)
	return table.indexOf(PlayerModule.PlayerInfo.quickChallenge, mazeCid) ~= -1
end

function PlayerModule.OnNotifyExecution(id)
	local cfgExecutionData = CfgExecutionTable[id]

	if cfgExecutionData.ShowType == Constant.ExecutionShowType.Dreamland and cfgExecutionData.ExecutionType == Constant.ExecutionType.DropItem then
		for i = 1, #cfgExecutionData.Params, 2 do
			local itemCid = tonumber(cfgExecutionData.Params[i])
			local itemNum = tonumber(cfgExecutionData.Params[i + 1])

			if itemCid ~= 0 and itemNum ~= nil then
				NoticeModule.ShowFloatGetItem(itemCid, itemNum)
			else
				logError("执行参数错误，id：" .. id .. "， type：102，params：" .. tableToString(cfgExecutionData.Params))
			end
		end
	end

	if cfgExecutionData.ExecutionType == Constant.ExecutionType.MonsterAcademyGameOver then
		MonsterAcademyModule.ExitMonsterAcademyScene()
	end

	if cfgExecutionData.ExecutionType == Constant.ExecutionType.OpenMonsterSelectPanelUI then
		MonsterAcademyModule.ExecutionOpenSelectPanel(cfgExecutionData.Params[1])
	end
end

function PlayerModule.NotifySoulWhisperUnlock(whisperId)
	if table.indexOf(PlayerModule.PlayerInfo.unlockSoulWhispers, whisperId) == -1 then
		table.insert(PlayerModule.PlayerInfo.unlockSoulWhispers, whisperId)
	end

	EventDispatcher.Dispatch(EventID.UpdateSoulWhisperUnlock)
end
