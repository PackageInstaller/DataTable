-- chunkname: @IQIGame\\Module\\Home\\HomeModule.lua

local HomeScene = require("IQIGame/Scene/Home/HomeScene")

HomeModule = {
	isReady = false,
	__RoomUnlockData = {}
}

function HomeModule.Initialize()
	HomeModule.__RoomUnlockData = {}

	ForPairs(CfgHomeLvTable, function(_lvCid, _lvCfg)
		ForArray(_lvCfg.UnlockRoom, function(_, _roomCid)
			HomeModule.__RoomUnlockData[_roomCid] = _lvCfg.Lv
		end)
	end)
end

function HomeModule.Reload(currentRoom, homePOD)
	HomeModule.currentRoom = currentRoom
	HomeModule.homePOD = homePOD

	RedDotModule.CheckRedDot_HomeLandTask()
end

function HomeModule.Shutdown()
	if HomeModule.homeScene == nil then
		return
	end

	HomeModule.ExitHomeScene()
end

function HomeModule.EnterHomeScene()
	if HomeModule.homeScene ~= nil then
		logError("当前已经在家园中,需要切换家园场景走 EnterRoom 流程")

		return
	end

	HomeModule.isReady = false

	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, HomeModule.__OnUILoaded)
	UIModule.Open(Constant.UIControllerName.MainUI, Constant.UILayer.DefaultUI)
end

function HomeModule.__OnUILoaded(sender, args)
	if args.UIName ~= Constant.UIControllerName.MainUI then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, HomeModule.__OnUILoaded)
	HomeModule.__OnEnterHomeScene()
end

function HomeModule.__OnEnterHomeScene()
	HomeModule.__AddListeners()

	local sceneCid = 30600001

	if HomeModule.forceEnterDefaultScene then
		HomeModule.forceEnterDefaultScene = false
	else
		local roomId = WorldMapModule.GetCurrentRoomId()

		if roomId then
			sceneCid = WorldMapModule.GetRoomSceneCfgWithRoomId(roomId).Id
		end
	end

	HomeModule.homeScene = HomeScene.New(sceneCid)
	HomeModule.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Home, HomeModule.__OnFrameUpdate, 1, -1)

	HomeModule.updateFrameTimer:Start()
end

function HomeModule.ExitHomeScene()
	HomeModule.__RemoveListeners()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Home)

	if HomeModule.updateFrameTimer ~= nil then
		HomeModule.updateFrameTimer:Stop()

		HomeModule.updateFrameTimer = nil
	end

	if HomeModule.homeScene ~= nil then
		HomeModule.homeScene:Dispose()

		HomeModule.homeScene = nil
	end
end

function HomeModule.__AddListeners()
	EventDispatcher.AddEventListener(EventID.HomeSceneReadyToShow, HomeModule.__OnHomeSceneReadyToShow)
end

function HomeModule.__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.HomeSceneReadyToShow, HomeModule.__OnHomeSceneReadyToShow)
end

function HomeModule.__OnHomeSceneReadyToShow()
	if not HomeModule.isReady then
		HomeModule.isReady = true
	else
		EventDispatcher.Dispatch(EventID.SetMainUIScreenMaskActive, false)
	end
end

function HomeModule.__OnFrameUpdate()
	HomeModule.homeScene:OnFrameUpdate()
end

function HomeModule.GetPlayer()
	if not HomeModule.homeScene then
		return nil
	end

	return HomeModule.homeScene.playerActor
end

function HomeModule.GetCurrentHomeRoom()
	if not HomeModule.homeScene then
		return
	end

	return HomeModule.homeScene.room
end

function HomeModule.EnterOrnamentEditorMode()
	if HomeModule.homeScene == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.HomeOrnamentPutUI, Constant.UILayer.DefaultUI)
	HomeModule.homeScene:EnterOrnamentEditorMode()
end

function HomeModule.ExitOrnamentEditorMode()
	if HomeModule.homeScene == nil then
		return
	end

	UIModule.Close(Constant.UIControllerName.HomeOrnamentPutUI)
	HomeModule.homeScene:ExitOrnamentEditorMode()
end

function HomeModule.RefreshRoomByTime()
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	room:RefreshByTime()
end

function HomeModule.ChangeRoomBGM(soundId)
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	room:__ChangeBGM(soundId)
end

function HomeModule.GetCurrentRoomCid()
	return WorldMapModule.GetCurrentRoomId()
end

function HomeModule.GetHomeLevel()
	return HomeModule.homePOD.lv
end

function HomeModule.IsRoomOpen(roomCid)
	if roomCid == nil then
		return false
	end

	local roomData = WorldMapModule.GetRoomDataWithRoomID(roomCid)

	if not roomData then
		return
	end

	local isOpen = roomData:GetIsUnlock()

	return isOpen
end

function HomeModule.GetRoomData(roomCid)
	return HomeModule.homePOD.rooms[roomCid]
end

function HomeModule.GetHomeLevelConfig(lv)
	local cfg

	ForPairs(CfgHomeLvTable, function(_cid, _cfg)
		if _cfg.Lv ~= lv then
			return
		end

		cfg = _cfg

		return true
	end)

	return cfg
end

function HomeModule.GetRoomWorkHeroList(roomCid)
	local heroList = {}

	ForPairs(HomeModule.homePOD.workHeros, function(_heroCid, _tackCid)
		local taskCfg = CfgHomeDispTaskTable[_tackCid]

		if taskCfg.Room ~= roomCid then
			return
		end

		table.insert(heroList, _heroCid)
	end)

	return heroList
end

function HomeModule.GetRoleWorkRoomCid(heroCid)
	local roomCid = HomeModule.homePOD.workHeros[heroCid]

	return roomCid
end

function HomeModule.GetRoomDefaultSkinCid(roomCid)
	local homeRoomData = CfgHomeRoomTable[roomCid]
	local itemCfg = CfgItemTable[homeRoomData.DefSceneId]

	return itemCfg.LikeId
end

function HomeModule.GetRoomDefaultSkinCfg(roomCid)
	local skinCid = HomeModule.GetRoomDefaultSkinCid(roomCid)

	return CfgHomeSceneTable[skinCid]
end

function HomeModule.GetRoomUnlockLevel(roomCid)
	return HomeModule.__RoomUnlockData[roomCid]
end

function HomeModule.GetDispTaskRefreshUseCount()
	return HomeModule.homePOD.dispRefreshTaskCount
end

function HomeModule.GetDispTaskRefreshData()
	local homeLv = HomeModule.GetHomeLevel()
	local homeLvConfig = HomeModule.GetHomeLevelConfig(homeLv)
	local useCount = HomeModule.GetDispTaskRefreshUseCount()
	local lastCount = homeLvConfig.EverydayTaskRefreshLimit - useCount

	if lastCount <= 0 then
		return 0, 0, 0
	end

	local curCount = useCount + 1
	local curCostIndex = #homeLvConfig.EverydayTaskRefreshCost

	if curCount < curCostIndex then
		curCostIndex = curCount
	end

	local curCost = homeLvConfig.EverydayTaskRefreshCost[curCostIndex]

	return lastCount, curCount, curCost
end

function HomeModule.GetDispTaskIDList()
	local taskList = {}

	ForPairs(HomeModule.homePOD.task, function(_taskCid, _dispTaskPOD)
		if _dispTaskPOD == nil then
			return
		end

		table.insert(taskList, _dispTaskPOD)
	end)
	table.sort(taskList, function(a, b)
		local legal, result = HomeModule.__DispTaskSortByStatus(a, b)

		if legal then
			return result
		end

		legal, result = HomeModule.__DispTaskSortByQuality(a, b)

		if legal then
			return result
		end

		legal, result = HomeModule.__DispTaskSortByCid(a, b)

		if legal then
			return result
		end

		return false
	end)

	local idList = {}

	ForArray(taskList, function(k, v)
		table.insert(idList, v.cid)
	end)

	return idList
end

function HomeModule.GetDispTask(taskCid)
	return HomeModule.homePOD.task[taskCid]
end

function HomeModule.GetAllFinishTaskCidList()
	local cidList = {}

	ForPairs(HomeModule.homePOD.task, function(_tackCid, _dispTaskPOD)
		if _dispTaskPOD.status ~= Constant.HomeLandDispTaskType.Finish then
			return
		end

		table.insert(cidList, _dispTaskPOD.cid)
	end)

	return cidList
end

function HomeModule.CheckHasFinishTaskByRoomCid(roomCid)
	local result = false
	local taskCidList = HomeModule.GetAllFinishTaskCidList()

	ForArray(taskCidList, function(_, _taskCid)
		local taskCfg = CfgHomeDispTaskTable[_taskCid]

		result = taskCfg.Room == roomCid

		return result
	end)

	return result
end

function HomeModule.IsAllTaskFinish()
	local isFinish = false

	ForPairs(HomeModule.homePOD.task, function(_taskCid, _dispTaskPOD)
		if _dispTaskPOD == nil then
			return
		end

		isFinish = _dispTaskPOD.status == Constant.HomeLandDispTaskType.Finish

		return not isFinish
	end)

	return isFinish
end

function HomeModule.GetTaskSpotRecoverLimit()
	local lv = HomeModule.GetHomeLevel()
	local lvCfg = HomeModule.GetHomeLevelConfig(lv)

	if lvCfg == nil then
		return 0
	end

	return lvCfg.DispTaskSpotRecoverLimt
end

function HomeModule.__DispTaskSortByStatus(a, b)
	if a.status == b.status then
		return false, false
	end

	if a.status == Constant.HomeLandDispTaskType.Receive then
		return true, false
	end

	if b.status == Constant.HomeLandDispTaskType.Receive then
		return true, true
	end

	return true, a.status > b.status
end

function HomeModule.__DispTaskSortByQuality(a, b)
	if a.cid == b.cid then
		return false, false
	end

	local taskCfg_A = CfgHomeDispTaskTable[a.cid]
	local taskCfg_B = CfgHomeDispTaskTable[b.cid]

	if taskCfg_A.Quality == taskCfg_B.Quality then
		return false, false
	end

	return true, taskCfg_A.Quality > taskCfg_B.Quality
end

function HomeModule.__DispTaskSortByCid(a, b)
	if a.cid == b.cid then
		return false, false
	end

	return true, a.cid > b.cid
end

function HomeModule.GetRoomComponentWithId(componentId)
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	return room:GetComponentWithId(componentId)
end

function HomeModule.GetVirtualCameraManager()
	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	return room.virtualCameraManager
end

function HomeModule.EnterRoom(roomCid)
	if HomeModule.currentRoom.info.cid == roomCid then
		return
	end

	net_home.enterRoot(roomCid)
end

function HomeModule.UpgradeHome()
	net_home.upgradeHome()
end

function HomeModule.RefreshDispTask()
	net_home.refreshDispTask()
end

function HomeModule.ExecuteDispTask(taskCid, heroCidList)
	net_home.executeDispTask(taskCid, heroCidList)
end

function HomeModule.SubmitDispTask(taskCid)
	net_home.submitDispTask(taskCid)
end

function HomeModule.ChangeRoomSkin(roomCid, skinCid)
	net_home.changeRoomSkin(roomCid, skinCid)
end

function HomeModule.UpgradePart(partCid)
	net_home.upgradePart(partCid)
end

function HomeModule.OnEnterRootResult(homeRoomPOD)
	HomeModule.currentRoom = homeRoomPOD

	local sceneCid = HomeModule.currentRoom.info.homeRoomSkin.skinCid

	HomeModule.homeScene:ChangeRoom(sceneCid)
end

function HomeModule.OnUpgradeHomeResult(homePOD)
	HomeModule.homePOD = homePOD

	EventDispatcher.Dispatch(EventID.HomeDataChange)
	UIModule.Open(Constant.UIControllerName.HomelandUpgradeTipsUI, Constant.UILayer.UI)
end

function HomeModule.SubmitDispTaskResult(items)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
end

function HomeModule.OnNotifyHome(homePOD)
	HomeModule.homePOD = homePOD

	EventDispatcher.Dispatch(EventID.HomeDataChange)
end

function HomeModule.OnNotifyRoom(homeRoom)
	HomeModule.currentRoom = homeRoom
end

function HomeModule.OnNotifyUpdateTask(tasks)
	ForPairs(tasks, function(_taskCid, _task)
		HomeModule.homePOD.task[_taskCid] = _task
	end)
	EventDispatcher.Dispatch(EventID.HomeDispTaskChange)
end

function HomeModule.OnNotifyRemoveTask(tasks)
	ForArray(tasks, function(_, _taskCid)
		HomeModule.homePOD.task[_taskCid] = nil
	end)
	EventDispatcher.Dispatch(EventID.HomeDispTaskChange)
end

function HomeModule.OnRefreshDispTaskResult()
	local noticeCid = HomeLandApi:GetTaskRefreshSuccessTextID()

	if noticeCid == nil or noticeCid == 0 then
		return
	end

	NoticeModule.ShowNotice(noticeCid)
end

function HomeModule.OnExecuteDispTaskResult()
	local noticeCid = HomeLandApi:GetTaskExecuteTextID()

	if noticeCid == nil or noticeCid == 0 then
		return
	end

	NoticeModule.ShowNotice(noticeCid)
end
