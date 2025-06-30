-- chunkname: @IQIGame\\Module\\Player\\PlayerModule.lua

local json = require("Util.json")

PlayerModule = {}
PlayerModule.PlayerInfo = {
	disableGuide = false,
	baseInfo = {
		weekResetTime = 0,
		sdkName = "",
		openId = "",
		guid = 0,
		intro = "",
		todayResetTime = 0,
		monthResetTime = 0,
		showHeroCid = 0
	}
}
PlayerModule.TimeZone = 8
PlayerModule._ServerTime = 0
PlayerModule._LastPangClientTime = 0
PlayerModule.InGame = false
PlayerModule.InGaming = false
PlayerModule._ReloadTime = 0
PlayerModule.CurrSceneID = 0
PlayerModule.CurrAdditiveSceneID = 0
PlayerModule.InitSceneID = SceneID.MainCity
PlayerModule.IsFirstQuit = false
PlayerModule.CurLoginFlag = true
PlayerModule.HideTestTitle = true
PlayerModule.isOpenLoginGM = true
PlayerModule.CompleteSpecialEventID = nil
PlayerModule.AccountType = 0

function PlayerModule.GetServerTime()
	return PlayerModule._ServerTime + (UnityEngine.Time.realtimeSinceStartup - PlayerModule._LastPangClientTime)
end

function PlayerModule.GetServerTimeByMs()
	return math.floor((PlayerModule._ServerTime + (UnityEngine.Time.realtimeSinceStartup - PlayerModule._LastPangClientTime)) * 1000)
end

function PlayerModule.GetIsInTime(startTime, endTime)
	local currentTime = tonumber(PlayerModule.GetServerTimeByMs())
	local sT = tonumber(startTime)
	local eT = tonumber(endTime)

	if sT <= currentTime and currentTime <= eT then
		return true
	end

	return false
end

function PlayerModule.StateLogOut()
	PlayerModule.InGame = false
	PlayerModule.InGaming = false
end

function PlayerModule.Load(playerPOD)
	PlayerModule._ReloadTime = UnityEngine.Time.time
	PlayerModule.PlayerInfo = playerPOD
	PlayerModule.InGaming = true

	GlobalBuffModule.Reload(playerPOD.globalBuffPODs)
	WarehouseModule.Reload(playerPOD.warehouse)
	WarlockModule.Reload(playerPOD.heros)
	UserInfoModule.Reload(playerPOD)
	CombatFormationModel.Reload(playerPOD.formations)
	FormationModule.Reload(playerPOD.formations)
	FriendModule.Reload(playerPOD.friends)
	AssistInFightingModule.Reload(playerPOD.baseInfo.helpHeros)
	MailModule.ReloadMail(playerPOD.newMailCount)
	TaskSystemModule.Reload(playerPOD.tasks, playerPOD.finishTasks, playerPOD.taskCompleteTime)
	LotteryModule.Reload(playerPOD.drawPODs, playerPOD.drawShowGroupRecords)
	MonthCardModule.Reload(playerPOD.monthCardPOD, playerPOD.monthCard)
	SignInModule.Reload(playerPOD.signPOD)
	GuideModule.ReloadServerGuideData(playerPOD.currentGuide, playerPOD.finishGuide)
	StoryChapterModule.Reload(playerPOD.generalDups)
	ResourceChapterModule.Reload(playerPOD.dailyDups)
	EquipChapterModule.Reload(playerPOD.equipDups)
	BossChapterModule.Reload(playerPOD.bossDups)
	TowerChapterModule.Reload(playerPOD.climbTowerDups)
	ActivityModule.Reload(playerPOD.activitys)
	GmOrderModule.Reload()
	ActivityPassModule.Reload(playerPOD.passPOD)
	AchievementModule.Reload(playerPOD.baseInfo.achieveShow)
	MazeModule.InitLabyrinthDataPOD(playerPOD.labyrinthStagePOD)
	HomeModule.Reload(playerPOD.currentRoom, playerPOD.home)

	PlayerModule.CurLoginFlag = PlayerModule.PlayerInfo.baseInfo.loginFlag

	ShopModule.Reload(playerPOD.shopPODs)
	WorldMapModule.Reload(playerPOD.sceneMapPOD)
	ChallengeWorldBossModule.Reload(playerPOD.worldBossDups)
	CenterRankModule.Reload()
	PlayerModule.__RefreshKanBanData()
	RedDotModule.Reload(playerPOD.redDot)
	PlayerModule.__InitPlayerCatchData(playerPOD.saveData)
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

function PlayerModule.GetPlayerPid()
	if PlayerModule.PlayerInfo ~= nil and PlayerModule.PlayerInfo.baseInfo ~= nil then
		return tostring(PlayerModule.PlayerInfo.baseInfo.pid)
	end

	logError("PlayerModule.GetPlayerPid : get playerPid failed.")

	return ""
end

function PlayerModule.GetSpecialEventDataByEvnetID(eventID)
	for k, v in pairs(PlayerModule.PlayerInfo.baseInfo.specialEvents) do
		if v.eventId == eventID then
			return v
		end
	end

	return nil
end

function PlayerModule.GetSpecialEventDataByHeroCid(heroID)
	for k, v in pairs(PlayerModule.PlayerInfo.baseInfo.specialEvents) do
		if v.hcid == heroID then
			return v
		end
	end

	return nil
end

function PlayerModule.GetHeroInfo(pid, serverId, hcid)
	net_player.getHeroInfo(pid, serverId, hcid)
end

function PlayerModule.GetHeroInfoAndOpenRoleDetailsUI(pid, serverId, hcid)
	net_player.getHeroInfo(pid, serverId, hcid)
end

function PlayerModule.GetEventAward(eventID)
	PlayerModule.CompleteSpecialEventID = eventID

	net_player.gainEventAward(eventID)
end

function PlayerModule.GetHeroInfoResult(code, heroPOD)
	local WarlockData = WarlockData.New()

	WarlockData:Initialize(heroPOD)
end

function PlayerModule.PlayerLevelChange(lv, items)
	local data = {
		lv = lv,
		items = items
	}

	EventDispatcher.Dispatch(EventID.PlayerLvChange, data)
	EventDispatcher.Dispatch(EventID.WorldMapRoom_RefreshAllComponentsEvent)
end

function PlayerModule.GetEventAwardResult(itemAwards)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
	EventDispatcher.Dispatch(EventID.GetSpecialEventAwardsEvent, PlayerModule.CompleteSpecialEventID)

	PlayerModule.CompleteSpecialEventID = nil
end

function PlayerModule.SavePlayerPosAndStateC2S(transformPos, state)
	local infomationPod = {}

	infomationPod.x = transformPos.position.x
	infomationPod.y = transformPos.position.y
	infomationPod.z = transformPos.position.z
	infomationPod.state = state

	net_player.saveLittleInfomation(infomationPod)
end

function PlayerModule.AddEventListeners()
	GameEntry.Input:InitTapGesture()
	GameEntry.Input:InitLongPressGesture()

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + PlayerModule.OnTapGesture
	GameEntry.Input.LongPressGesture.StateUpdated = GameEntry.Input.LongPressGesture.StateUpdated + PlayerModule.OnLongPressGesture
end

function PlayerModule.RemoveEventListeners()
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - PlayerModule.OnTapGesture
	GameEntry.Input.LongPressGesture.StateUpdated = GameEntry.Input.LongPressGesture.StateUpdated - PlayerModule.OnLongPressGesture

	GameEntry.Input:RemoveTapGesture()
	GameEntry.Input:RemoveLongPressGesture()
end

function PlayerModule.OnTapGesture(tapGesture)
	EventDispatcher.Dispatch(EventID.OnTapGesture, tapGesture)
end

function PlayerModule.OnLongPressGesture(longPressGesture)
	EventDispatcher.Dispatch(EventID.OnLongPressGesture, longPressGesture)
end

function PlayerModule.Init()
	DigitalRubyShared.FingersScript.Instance.canResetStateOnSceneManagerSceneLoaded = false

	PlayerModule.AddEventListeners()
end

function PlayerModule.Shutdown()
	PlayerModule.RemoveEventListeners()
end

function PlayerModule.GetIsOpenQuestionnaire()
	local activityPods = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_Questionnaire
	})

	if table.len(activityPods) == 0 or activityPods[1].stage == 0 then
		return nil
	end

	local activityCfg = CfgActivityTable[activityPods[1].cid]
	local questionCfg

	for k, v in pairsCfg(CfgQuestionnaireTable) do
		if v.RefActivityId == activityCfg.Id then
			questionCfg = v

			break
		end
	end

	if PlayerModule.PlayerInfo.baseInfo.questionnaires ~= nil and table.len(PlayerModule.PlayerInfo.baseInfo.questionnaires) > 0 then
		local hasQustionID = table.search(PlayerModule.PlayerInfo.baseInfo.questionnaires, function(k, v)
			if k == questionCfg.Id then
				return true
			end

			return false
		end)

		if hasQustionID ~= nil then
			questionCfg = nil
		end
	end

	return questionCfg
end

local questionKey = "d35fb323-c6cb-4d9a-b3f0-a9358aefe6d7"

function PlayerModule.GetQuestionUrl(url, cid, questionID)
	local jsonTable = {
		sid = LoginModule.selectedServerInfo.serverId,
		pid = PlayerModule.PlayerInfo.baseInfo.pid,
		cid = cid
	}
	local jsonStr = json.encode(jsonTable)
	local sojumpparm = StringSecurityUtils.EncodeBase64(jsonStr)
	local wjxactivity = questionID
	local encryptStr = wjxactivity .. sojumpparm .. questionKey
	local parmsign = StringSecurityUtils.SHA1Encrypt(encryptStr)
	local requsetUrl = string.format("%s?sojumpparm=%s&parmsign=%s", url, sojumpparm, parmsign)

	return requsetUrl
end

function PlayerModule.GetSex()
	return PlayerModule.PlayerInfo.baseInfo.sex
end

function PlayerModule.GetName()
	return PlayerModule.PlayerInfo.baseInfo.pName
end

function PlayerModule.GetExp()
	return PlayerModule.PlayerInfo.baseInfo.exp
end

function PlayerModule.GetLevel()
	return PlayerModule.PlayerInfo.baseInfo.pLv
end

function PlayerModule.GetActivityDup()
	return PlayerModule.PlayerInfo.activityDups
end

function PlayerModule.GetRichManPOD()
	return PlayerModule.PlayerInfo.richManPOD
end

function PlayerModule.GetTowerDupPod()
	return PlayerModule.PlayerInfo.climbTowerDups
end

function PlayerModule.GetChallengeDupPod()
	return PlayerModule.PlayerInfo.challengeDups
end

function PlayerModule.GetSceneMapFinishActionsPod()
	return PlayerModule.PlayerInfo.sceneMapPOD.finishActions
end

function PlayerModule.GetFinishedMessageGroup(id)
	return PlayerModule.PlayerInfo.finishMsgGroups[id]
end

function PlayerModule.GetCrusadeData()
	return PlayerModule.PlayerInfo.crusadeDupPODs
end

function PlayerModule.GetTrackTaskCid()
	return PlayerModule.PlayerInfo.baseInfo.currentTrackTaskCid
end

function PlayerModule.GetAccountType()
	local data = ServerParamData.New()

	data.type = "KUAI_SHOU_LOG_ACCOUNT_TYPE"

	local jsonStr = LoginModule.CreateLoginParam(data)

	url = LoginModule.GetRequestUrl(Constant.LoginConst.ServerParamUrl)

	HttpModule.RequestPost(url, jsonStr, function(serverResponse)
		local responseData = LoginModule.HttpDecrypt(serverResponse)
		local response = json.decode(responseData)

		log("服务器参数 = " .. responseData)

		if response.code ~= 0 then
			warning("Send ServerParam error : " .. getErrorMsg(response.code))
		else
			PlayerModule.AccountType = tonumber(response.data.param)
		end
	end, function(data)
		return
	end)
end

function PlayerModule.GetServerParamByKey(key)
	for k, v in pairs(PlayerModule.PlayerInfo.serverParams) do
		if key == k then
			return v
		end
	end

	return nil
end

function PlayerModule.GetLimitTimeGifts()
	local limitTimeGiftDatas = {}

	for k, v in pairs(PlayerModule.PlayerInfo.limitedTimePkg) do
		if v > 0 then
			table.insert(limitTimeGiftDatas, k)
		end
	end

	table.sort(limitTimeGiftDatas, function(a, b)
		return a < b
	end)

	return limitTimeGiftDatas
end

function PlayerModule.GetLimitTimeGiftDataByID(commodityID)
	for k, v in pairs(PlayerModule.PlayerInfo.limitedTimePkg) do
		if k == commodityID then
			return v
		end
	end

	return nil
end

function PlayerModule.GetCommoDityIDAndPushUIType(pushUIType)
	local commodityIDs = PlayerModule.GetLimitTimeGifts()

	if table.len(commodityIDs) == 0 then
		return nil
	end

	for i = 1, #commodityIDs do
		local commodityCfg = CfgCommodityTable[commodityIDs[i]]
		local isPop = PlayerPrefsUtil.GetString("", commodityIDs[i] .. Constant.PlayerPrefsConst.LimitedTimeGiftPop .. PlayerModule.PlayerInfo.baseInfo.guid, "false")

		if table.indexOf(commodityCfg.PackageShowUI, pushUIType) ~= -1 and isPop == "false" then
			return commodityIDs[i]
		end
	end

	return nil
end

function PlayerModule.GetPushGiftCommoditysIsPop()
	local commodityIDs = PlayerModule.GetLimitTimeGifts()

	if table.len(commodityIDs) == 0 then
		return true
	end

	local expireCommodityID

	table.sort(commodityIDs, function(a, b)
		return PlayerModule.GetLimitTimeGiftDataByID(a) < PlayerModule.GetLimitTimeGiftDataByID(b)
	end)

	for i = 1, #commodityIDs do
		local isPop = PlayerPrefsUtil.GetString("", commodityIDs[i] .. Constant.PlayerPrefsConst.LimitedTimeGiftPop .. PlayerModule.PlayerInfo.baseInfo.guid, "false")

		if isPop == "true" and PlayerModule.GetLimitTimeGiftDataByID(commodityIDs[i]) ~= nil and PlayerModule.GetLimitTimeGiftDataByID(commodityIDs[i]) > 0 then
			expireCommodityID = commodityIDs[i]

			return false, expireCommodityID
		end
	end

	return true, expireCommodityID
end

function PlayerModule.SetKanBan(skinCid)
	net_player.setKanBan(skinCid)
end

function PlayerModule.SetKanBanPool(skinCidList)
	net_player.setKanBanPool(skinCidList)
end

function PlayerModule.SetRandomKanBan(isOn)
	net_player.setRandomKanBan(isOn)
end

function PlayerModule.OnChangeKanBanPOD(kanBanPOD)
	PlayerModule.PlayerInfo.baseInfo.kanBanPOD = kanBanPOD

	PlayerModule.__RefreshKanBanData()
end

function PlayerModule.__RefreshKanBanData()
	PlayerModule.__KanBanSkinList = {}

	ForArrayByCount(1, 5, 1, function(_index)
		local skinCid = PlayerModule.PlayerInfo.baseInfo.kanBanPOD.kanbanPool[_index]

		if skinCid == nil then
			skinCid = 0
		end

		table.insert(PlayerModule.__KanBanSkinList, skinCid)
	end)
	EventDispatcher.Dispatch(EventID.OnChangeKanBanPOD)
end

function PlayerModule.GetDisplaySkinList()
	return PlayerModule.__KanBanSkinList
end

function PlayerModule.InDisplaySkinList(skinCid)
	local result = false

	ForArray(PlayerModule.__KanBanSkinList, function(_, _skinCid)
		result = _skinCid == skinCid

		if result then
			return true
		end
	end)

	return result
end

function PlayerModule.SetDisplaySkinListWithSwitchDisplayViewData(displaySkinList)
	PlayerModule.__TempDisplaySkinList = displaySkinList
end

function PlayerModule.GetDisplaySkinListWithSwitchDisplayViewData()
	return PlayerModule.__TempDisplaySkinList
end

function PlayerModule.InDisplaySkinListWithSwitchDisplayViewData(skinCid)
	local result = false

	ForArray(PlayerModule.__TempDisplaySkinList, function(_, _skinCid)
		result = _skinCid == skinCid

		if result then
			return true
		end
	end)

	return result
end

function PlayerModule.GetPlayerKanBanSkinCid()
	local skinCid = TryToNumber(PlayerModule.PlayerInfo.baseInfo.kanBanPOD.kanBanId, 0)

	if skinCid == 0 then
		return CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
	end

	return skinCid
end

function PlayerModule.GetPlayerEnergy()
	return PlayerModule.GetPlayerEnergyItemResourceCfg().RestoreLimit
end

function PlayerModule.GetPlayerEnergyItemResourceCfg()
	local rescourceId = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv].ItemResource
	local itemRecourcesCfg = CfgItemResourceTable[rescourceId]

	return itemRecourcesCfg
end

function PlayerModule.__InitPlayerCatchData(saveData)
	PlayerModule.__SaveData = saveData
	PlayerModule.__SaveDataQueue = Queue.New()
end

function PlayerModule.SavePlayerCatchData(key, value)
	local cacheData = {
		key = key,
		value = value
	}

	PlayerModule.__SaveDataQueue:Enqueue(cacheData)
	net_player.saveData(key, value)
end

function PlayerModule.GetPlayerCatchData(key)
	return PlayerModule.__SaveData[key]
end

function PlayerModule.OnSavePlayerCatchDataSuccess()
	log("保存数据成功.")

	if PlayerModule.__SaveDataQueue.Size > 0 then
		local cacheData = PlayerModule.__SaveDataQueue:Dequeue()

		PlayerModule.__SaveData[cacheData.key] = cacheData.value
	end

	EventDispatcher.Dispatch(EventID.OnSaveDataSuccess)
end

function PlayerModule.GetUsingPaintingItemCid()
	local cacheData = PlayerModule.GetPlayerCatchData(Constant.SaveDataKey.PaintingItemCid)
	local selectCid = TryToNumber(cacheData, 10000)

	if CfgUIPaintingItemTable[selectCid] == nil then
		return 10000
	end

	return selectCid
end
