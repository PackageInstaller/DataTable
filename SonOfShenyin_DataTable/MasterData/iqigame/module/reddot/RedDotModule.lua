-- chunkname: @IQIGame\\Module\\RedDot\\RedDotModule.lua

RedDotModule = {}

local isDebug = true

function RedDotModule.Subscribe(RedDotId, obj)
	RedDotTree.SetCallBack(RedDotId, obj)
end

function RedDotModule.Unsubscribe(RedDotId, obj)
	RedDotTree.RemoveCallBack(RedDotId, obj)
end

function RedDotModule.SetRedDotCnt(RedDotId, cnt, isNotifyServer)
	local delta = cnt - RedDotTree.NodeData[RedDotId].redDotCnt

	RedDotTree.ChangeRedDotCnt(RedDotId, delta, isNotifyServer)
end

function RedDotModule.GetRedDotCnt(redObj)
	for k, v in pairs(RedDotTree.NodeData) do
		if v.redDotCnt > 0 then
			for _, obj in pairs(v.objs) do
				if redObj:GetInstanceID() == obj:GetInstanceID() then
					return v.redDotCnt
				end
			end
		end
	end

	return 0
end

function RedDotModule.GetRedDotCntByRedDotID(redDotId)
	return RedDotTree.NodeData[redDotId].redDotCnt
end

function RedDotModule.Reload(redDotPODTb)
	if isDebug then
		local redDotsStr = ""

		for redDotId, state in pairs(redDotPODTb) do
			redDotsStr = redDotsStr .. "[id=" .. tostring(redDotId) .. ", state=" .. tostring(state) .. "], "
		end

		log("红点系统 - Reload 登录时初始化红点：{0}", redDotsStr)
	end

	for redDotId, state in pairs(redDotPODTb) do
		if state == 0 then
			RedDotModule.SetRedDotCnt(redDotId, 0)
		elseif state >= 1 then
			RedDotModule.SetRedDotCnt(redDotId, 1)
		else
			logError("红点系统 - Reload：pod.state={0} is invalid.", state)
		end
	end

	RedDotModule.InitClientRedDots()
end

function RedDotModule.Response_NotifyRedDot(redDots)
	if isDebug then
		local redDotsStr = ""

		for redDotId, state in pairs(redDots) do
			redDotsStr = redDotsStr .. "[id=" .. tostring(redDotId) .. ", state=" .. tostring(state) .. "], "
		end

		log("红点系统 - Response_NotifyRedDot 服务器通知客户端红点变化：{0}", redDotsStr)
	end

	for redDotId, state in pairs(redDots) do
		if state == 0 then
			RedDotModule.SetRedDotCnt(redDotId, 0)
		elseif state >= 1 then
			RedDotModule.SetRedDotCnt(redDotId, 1)
		else
			logError("红点系统 - Response_NotifyRedDot：state={0} is invalid.", state)
		end
	end
end

function RedDotModule.Initialize()
	RedDotTree.Init()
	RedDotModule.AddEventListeners()
	log("红点系统 - Init.")
end

function RedDotModule.Shutdown()
	RedDotTree.Shutdown()
	RedDotModule.RemoveEventListeners()
	log("红点系统 - Shutdown.")
end

function RedDotModule.ResetAllRedDot()
	for rdId, _ in pairs(CfgRedDotTable) do
		if CfgRedDotTable[rdId] ~= nil and CfgRedDotTable[rdId].Clientside ~= true and CfgRedDotTable[rdId].NodeType == 1 then
			RedDotModule.SetRedDotCnt(rdId, 0, false)
		end
	end
end

function RedDotModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.NewMailCountChangeEvent, RedDotModule.CheckRedDot_HomeMail)
	EventDispatcher.AddEventListener(EventID.UpdateFriend, RedDotModule.CheckRedDot_Friend_FriendApply)
	EventDispatcher.AddEventListener(EventID.TaskNotifyRemove, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyRemove)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyTask)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyFinish)
	EventDispatcher.AddEventListener(EventID.AddItem, RedDotModule.UpdateRedDot_ByAddItem)
	EventDispatcher.AddEventListener(EventID.DeleteItem, RedDotModule.UpdateRedDot_ByDeleteItem)
	EventDispatcher.AddEventListener(EventID.UpdateItem, RedDotModule.UpdateRedDot_ByUpdateItem)
	EventDispatcher.AddEventListener(EventID.RoleUpdateData, RedDotModule.UpdateRedDot_CheckRedDot_Warlock_ByHeroUpdate)
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, RedDotModule.UpdateRedDot_CheckRedDot_ShopCommodityUpdate)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, RedDotModule.UpdateRedDot_CheckRedDot_ActivityUpdate)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, RedDotModule.UpdateRedDot_CheckRedDot_UnlockFunction)
	EventDispatcher.AddEventListener(EventID.HomeDataChange, RedDotModule.UpdateRedDot_CheckRedDot_HomeLandUpdate)
	EventDispatcher.AddEventListener(EventID.HomeDispTaskChange, RedDotModule.UpdateRedDot_CheckRedDot_HomeLandTaskUpdate)
end

function RedDotModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.NewMailCountChangeEvent, RedDotModule.CheckRedDot_HomeMail)
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, RedDotModule.CheckRedDot_Friend_FriendApply)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyRemove, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyRemove)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, RedDotModule.CheckRedDot_TaskType_ByTaskNotifyFinish)
	EventDispatcher.RemoveEventListener(EventID.AddItem, RedDotModule.UpdateRedDot_ByAddItem)
	EventDispatcher.RemoveEventListener(EventID.DeleteItem, RedDotModule.UpdateRedDot_ByDeleteItem)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, RedDotModule.UpdateRedDot_ByUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, RedDotModule.UpdateRedDot_CheckRedDot_Warlock_ByHeroUpdate)
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, RedDotModule.UpdateRedDot_CheckRedDot_ShopCommodityUpdate)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, RedDotModule.UpdateRedDot_CheckRedDot_ActivityUpdate)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, RedDotModule.UpdateRedDot_CheckRedDot_UnlockFunction)
	EventDispatcher.RemoveEventListener(EventID.HomeDataChange, RedDotModule.UpdateRedDot_CheckRedDot_HomeLandUpdate)
	EventDispatcher.RemoveEventListener(EventID.HomeDispTaskChange, RedDotModule.UpdateRedDot_CheckRedDot_HomeLandTaskUpdate)
end

function RedDotModule.InitClientRedDots()
	RedDotModule.CheckRedDot_Warlock()
	RedDotModule.CheckRedDot_Warehouse()
	RedDotModule.CheckTaskRedDot()
	RedDotModule.CheckRedDot_Shop()
	RedDotModule.CheckRedDot_WelfareList()
	RedDotModule.CheckRedDot_ActivityList()
	RedDotModule.CheckRedDot_ActiveActivityList()
	RedDotModule.CheckRedDot_HomeMail()
	RedDotModule.CheckRedDot_Qusetionnair()
	RedDotModule.CheckFirstRedDot()
	RedDotModule.CheckCommunityRedDot()
	RedDotModule.CheckRedDot_Friend_FriendApply()
end

function RedDotModule.UpdateRedDot_ByAddItem(addItems)
	return
end

function RedDotModule.UpdateRedDot_ByDeleteItem(DeleteItems)
	return
end

function RedDotModule.UpdateRedDot_ByUpdateItem(UpdateItems)
	local needUpdateType_Warehouse = {}
	local needUpdateType_Warlock

	for _, item in pairs(UpdateItems) do
		local cfgItemData = CfgItemTable[item.cid]

		if cfgItemData ~= nil then
			needUpdateType_Warehouse[cfgItemData.DepotType] = true

			if cfgItemData.ItemTypes == Constant.ItemType.HeroDebris then
				needUpdateType_Warlock = true
			end
		end
	end

	for key, _ in pairs(needUpdateType_Warehouse) do
		if key == Constant.DepotType.Hero then
			RedDotModule.CheckRedDot_Warehouse_Character()
		end
	end

	RedDotModule.CheckRedDot_Warlock()
end

function RedDotModule.UpdateRedDot_CheckRedDot_Warlock_ByHeroUpdate()
	RedDotModule.CheckRedDot_Warlock()
end

function RedDotModule.CheckRedDot_HomeMail()
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Home_Mail, MailModule.newMailCount > 0 and 1 or 0)
end

function RedDotModule.CheckRedDot_Friend_FriendApply()
	local newApplyCount = #FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.LeftMenu_Friend_Application, newApplyCount > 0 and 1 or 0)
end

function RedDotModule:CheckRedDot_Warehouse()
	RedDotModule.CheckRedDot_Warehouse_Character()
end

local co_WaitToUpdate_WarehouseCharacter

function RedDotModule.CheckRedDot_Warehouse_Character()
	if co_WaitToUpdate_WarehouseCharacter == nil then
		co_WaitToUpdate_WarehouseCharacter = coroutine.start(function()
			coroutine.wait(0.5)
			RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Warehouse_Character, RedDotModule.CanShowRedDot_Warehouse_Tab(Constant.DepotType.Hero) and 1 or 0)

			co_WaitToUpdate_WarehouseCharacter = nil
		end)
	end
end

function RedDotModule.CanShowRedDot_Warehouse_Tab(tabType)
	local items = WarehouseModule.GetAllItemsByTabType(tabType)

	for i = 1, #items do
		if tabType == Constant.DepotType.Hero and RedDotModule.CanShowRedDot_CharacterFragItem(items[i]:GetCfg()) then
			return true
		end
	end

	return false
end

function RedDotModule.CanShowRedDot_CharacterFragItem(cfgIdOrCfgData)
	local cfgItemData = type(cfgIdOrCfgData) == "number" and CfgItemTable[cfgIdOrCfgData] or cfgIdOrCfgData

	if cfgItemData ~= nil then
		if cfgItemData.ItemTypes == Constant.ItemType.HeroDebris then
			local combinId = cfgItemData.CombinationId[1]

			if combinId ~= nil and CfgCombinationTable[combinId] ~= nil and CfgCombinationTable[combinId].Output[1] ~= nil and CfgItemTable[CfgCombinationTable[combinId].Output[1]] ~= nil then
				local herocid = CfgItemTable[CfgCombinationTable[combinId].Output[1]].ActionParams[1]

				if WarlockModule.WarlockDataDic[herocid] ~= nil then
					return false
				end

				local nowCount = WarehouseModule.GetItemNumByCfgID(cfgItemData.Id)
				local compositeNeedCunt = CfgCombinationTable[cfgItemData.CombinationId[1]].Combination[2]

				return compositeNeedCunt <= nowCount
			else
				logError("红点系统 - CanShowRedDot_CharacterFragItem：combinId={0} is invalid.", combinId)
			end
		end
	else
		logError("红点系统 - CanShowRedDot_CharacterFragItem：cfgIdOrCfgData={0} is invalid.", cfgIdOrCfgData)
	end

	return false
end

local co_WaitToUpdateTask
local m_Table_WaitToUpdateTaskList = {}

function RedDotModule.CheckAddTaskToWaitUpdateList(taskCid)
	local cfgTaskData = TaskSystemModule.GetCfgTaskDataWithID(taskCid)

	if cfgTaskData ~= nil then
		local mainType = cfgTaskData.Type
		local extendType = cfgTaskData.TypeExtend

		if m_Table_WaitToUpdateTaskList == nil then
			m_Table_WaitToUpdateTaskList = {}
		end

		if m_Table_WaitToUpdateTaskList[mainType] == nil then
			m_Table_WaitToUpdateTaskList[mainType] = {}
		end

		m_Table_WaitToUpdateTaskList[cfgTaskData.Id] = cfgTaskData
	end
end

local co_WaitToFinishTask

function RedDotModule.CheckRedDot_TaskType_ByTaskNotifyFinish()
	if co_WaitToFinishTask == nil then
		co_WaitToFinishTask = coroutine.start(function()
			coroutine.wait(0.5)
			RedDotModule.CheckRedDot_WelfareList()
			RedDotModule.CheckRedDot_ActiveActivityList()

			co_WaitToFinishTask = nil
		end)
	end
end

function RedDotModule.CheckRedDot_TaskType_ByTaskNotifyRemove(tasks)
	local cfgTaskData

	for _, taskId in pairs(tasks) do
		RedDotModule.CheckAddTaskToWaitUpdateList(taskId)
	end

	if co_WaitToUpdateTask == nil then
		co_WaitToUpdateTask = coroutine.start(function()
			coroutine.wait(0.5)
			RedDotModule.CheckRedDot_WelfareList()
			RedDotModule.UpdateRedDot_TaskType()
			RedDotModule.CheckRedDot_ActiveActivityList()

			co_WaitToUpdateTask = nil
		end)
	end
end

function RedDotModule.CheckRedDot_TaskType_ByTaskNotifyTask(tasks)
	for _, taskTb in pairs(tasks) do
		RedDotModule.CheckAddTaskToWaitUpdateList(taskTb.cid)
	end

	if co_WaitToUpdateTask == nil then
		co_WaitToUpdateTask = coroutine.start(function()
			coroutine.wait(1)
			RedDotModule.UpdateRedDot_TaskType()
			RedDotModule.CheckRedDot_WelfareList()
			RedDotModule.CheckRedDot_ActiveActivityList()

			co_WaitToUpdateTask = nil
		end)
	end
end

function RedDotModule.UpdateRedDot_TaskType()
	if m_Table_WaitToUpdateTaskList == nil then
		return
	end

	RedDotModule.CheckTaskRedDot()
	RedDotModule.CheckCommunityRedDot()

	m_Table_WaitToUpdateTaskList = nil
end

local co_WaitToUpdate_Warlock

function RedDotModule.CheckRedDot_Warlock()
	if co_WaitToUpdate_Warlock == nil then
		co_WaitToUpdate_Warlock = coroutine.start(function()
			coroutine.wait(0.5)
			RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Warlock, RedDotModule.CanShowRedDot_Warlock() and 1 or 0)

			co_WaitToUpdate_Warlock = nil
		end)
	end
end

function RedDotModule.CanShowRedDot_Warlock()
	for key, _ in pairs(WarlockModule.WarlockDataDic) do
		if RedDotModule.CanShowRedDot_WarlockItem(key) then
			return true
		end

		if RedDotModule.CanShowRedDot_Warlock_BreachReward(key) then
			return true
		end
	end

	return false
end

function RedDotModule.CanShowRedDot_WarlockItem(heroCid)
	if WarlockModule.NeedShowNewHeroTag(heroCid) then
		return true
	end

	if RedDotModule.CanShowRedDot_Warlock_PersonalityItem(heroCid) then
		return true
	end

	if RedDotModule.CanShowRedDot_Warlock_BreachReward(heroCid) then
		return true
	end

	return false
end

function RedDotModule.CanShowRedDot_Warlock_PersonalityItem(heroCid)
	local heroInfo = WarlockModule.WarlockDataDic[heroCid]

	if heroInfo == nil then
		return false
	end

	local needCheck = true

	for i = 1, #heroInfo.PersonalityDataList do
		if not needCheck then
			break
		end

		if heroInfo.PersonalityDataList[i].isOpen == false then
			for j = 1, #heroInfo.PersonalityDataList[i].config.NeedItem, 2 do
				local ownedCount = WarehouseModule.GetItemNumByCfgID(heroInfo.PersonalityDataList[i].config.NeedItem[j])
				local needCount = heroInfo.PersonalityDataList[i].config.NeedItem[j + 1]

				if needCount <= ownedCount then
					return true
				else
					needCheck = false

					break
				end
			end
		end
	end

	return false
end

function RedDotModule.CanShowRedDot_Warlock_BreachReward(heroCid)
	local heroInfo = WarlockModule.WarlockDataDic[heroCid]

	if heroInfo == nil then
		return false
	end

	local breakLv = heroInfo.breakLv

	for i = breakLv, 1, -1 do
		if table.indexOf(heroInfo.breakPrize, i) == -1 then
			return true
		end
	end

	return false
end

function RedDotModule.CanShowRedDot_Warlock_BreachRewardByBreachLv(heroCid, breachLv)
	local heroInfo = WarlockModule.WarlockDataDic[heroCid]

	if heroInfo == nil then
		return false
	end

	local breakLv = heroInfo.breakLv

	for i = breakLv, 1, -1 do
		if table.indexOf(heroInfo.breakPrize, i) == -1 and i == breachLv then
			return true
		end
	end

	return false
end

function RedDotModule.CanShowRedDot_Warlock_LevelUp(heroCid)
	local HeroData = WarlockModule.WarlockDataDic[heroCid]

	if HeroData == nil then
		return false
	end

	if HeroData:GetStarLevel() == 5 then
		return false
	end

	local cfgHeroStarLevelData = RoleDevelopmentModule.GetHeroStarLvCfgs(heroCid)
	local isMaxStar = RoleDevelopmentModule.GetStarRiseCount(cfgHeroStarLevelData, HeroData.starLevel, HeroData.starTime) >= CfgHeroTable[heroCid].StarLevelSwitch

	if isMaxStar then
		return false
	end

	local lastCfg = RoleDevelopmentModule.GetNextStarCfg(cfgHeroStarLevelData, HeroData.starLevel, HeroData.starTime)

	if lastCfg == nil then
		return false
	end

	local enough = true

	ForArrayCustomStep(lastCfg.StarCost, function(_index, _itemCid)
		local totalCnt = WarehouseModule.GetItemNumByCfgID(_itemCid)

		enough = totalCnt >= lastCfg.StarCost[_index + 1]

		if not enough then
			return true
		end
	end, 2)

	return enough
end

function RedDotModule.CheckTaskRedDot()
	local mainCount = 0
	local branchCount = 0
	local dailyCount = 0
	local weeklyCount = 0
	local playerCount = 0
	local heroCount = 0
	local storyCount = 0
	local fightCount = 0
	local passNormalCount = 0
	local passDailyCount = 0
	local passWeekCount = 0
	local passLevelCount = 0
	local activitySignInCount = 0
	local activitySevenCount = 0
	local activityLevelCount = 0
	local communityCount = 0

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.GhostActivityUI, 0)

	RedDotModule.ghostBossTaskDic = {}

	for i, taskPod in pairs(TaskSystemModule.taskSystemDataDic) do
		repeat
			if taskPod.status ~= Constant.TaskStatus.hasDone then
				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Main) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					mainCount = mainCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Branch) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					branchCount = branchCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Daily) then
				do
					local currentSchedule = TaskSystemModule.GetActivityCurrentSchedule(Constant.MainTaskType.Daily)
					local totalSchedule = TaskSystemModule.GetActivityTotalSchedule(Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Activity)

					if taskPod.status == Constant.TaskStatus.hasDone then
						if taskPod.cfgTaskConfig.TypeExtend == Constant.ExtendTaskType.Daily_Activity then
							dailyCount = dailyCount + 1

							break
						end

						if currentSchedule < totalSchedule then
							dailyCount = dailyCount + 1
						end
					end
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Weekly) then
				do
					local currentSchedule = TaskSystemModule.GetActivityCurrentSchedule(Constant.MainTaskType.Weekly)
					local totalSchedule = TaskSystemModule.GetActivityTotalSchedule(Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Activity)

					if taskPod.status == Constant.TaskStatus.hasDone then
						if taskPod.cfgTaskConfig.TypeExtend == Constant.ExtendTaskType.Weekly_Activity then
							weeklyCount = weeklyCount + 1

							break
						end

						if currentSchedule < totalSchedule then
							weeklyCount = weeklyCount + 1
						end
					end
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Achievement, Constant.ExtendTaskType.AchievementEquip) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					playerCount = playerCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Achievement, Constant.ExtendTaskType.AchievementRole) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					heroCount = heroCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Achievement, Constant.ExtendTaskType.AchievementStory) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					storyCount = storyCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Achievement, Constant.ExtendTaskType.AchievementFight) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					fightCount = fightCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalMission) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					passNormalCount = passNormalCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_DailyMission) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					passDailyCount = passDailyCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_WeeklyMission) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					passWeekCount = passWeekCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_AllLevelReward) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					passLevelCount = passLevelCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Novice_7_DAY_SIGN) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					activitySignInCount = activitySignInCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Novice_7_DAY_TASK) then
				if taskPod.status ~= Constant.TaskStatus.hasDone or taskPod.cfgTaskConfig.TypeExtend[1] > 0 and not TaskSystemModule.isFinishAll(Constant.MainTaskType.Novice_7_DAY_TASK, {
					0,
					taskPod.cfgTaskConfig.TypeExtend[1]
				}) then
					break
				end

				activitySevenCount = activitySevenCount + 1

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Novice_7_DAY_GRADE) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					activityLevelCount = activityLevelCount + 1
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist) then
				if taskPod.status == Constant.TaskStatus.hasDone then
					RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.FirstRecharge, 1)
				end

				break
			end

			if TaskSystemModule.MatchTask(taskPod.cfgTaskConfig, Constant.MainTaskType.GhostBoss) and taskPod.status == Constant.TaskStatus.hasDone then
				RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.GhostActivityUI, 1)

				RedDotModule.ghostBossTaskDic[taskPod.extendType[1]] = true
			end
		until true
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Task_Main, mainCount + branchCount)
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Task_Daily, dailyCount)
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Task_Weekly, weeklyCount)

	if playerCount > 0 or storyCount > 0 or heroCount > 0 or fightCount > 0 then
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Task_Achieve, 1)
	else
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Task_Achieve, 0)
	end

	if not ActivityPassModule.GetPassLvIsMax() then
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.PassActivity_Normal, passNormalCount)
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.PassActivity_Daily, passDailyCount)
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.PassActivity_Week, passWeekCount)
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.PassActivity_RewardTab, passLevelCount)
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.MobilePhone_NoviceActivity_SignInTab, activitySignInCount)
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.MobilePhone_NoviceActivity_TaskTab, activitySevenCount)
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.MobilePhone_NoviceActivity_LevelRewardTab, activityLevelCount)
	EventDispatcher.Dispatch(EventID.OnTaskRedDotEvent)
end

function RedDotModule.CheckCommunityRedDot()
	local communityCount
	local taskData = TaskSystemModule.GetTaskDataByCid(CfgDiscreteDataTable[Constant.DiscreteData.CommunityTaskID].Data[1])

	communityCount = (taskData == nil or taskData.status == Constant.TaskStatus.hadGot or taskData.status == Constant.TaskStatus.hasDone) and 0 or 1

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Community, communityCount)
end

function RedDotModule.CheckRedDot_Community()
	return RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.Community) > 0
end

function RedDotModule.CheckFirstRedDot()
	local cnt = 0
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)

	if table.len(taskList) == 0 then
		cnt = 0
	end

	for i = 1, #taskList do
		if taskList[i].status == Constant.TaskStatus.hasDone then
			cnt = 1

			break
		end
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.FirstRecharge, cnt)
end

function RedDotModule.CheckDiceGameTaskRedDot()
	local cnt = 0
	local taskList = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.DiceGame, TaskSystemModule.sortType.Weight_ID, true, false)
	local len = #taskList

	for i = 1, len do
		if taskList[i].status == Constant.TaskStatus.hasDone then
			cnt = 1

			break
		end
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.DiceGame, cnt)
	EventDispatcher.Dispatch(EventID.DiceGameRedDotEvent)
end

function RedDotModule.CheckRedDot_FirstRecharge()
	RedDotModule.CheckFirstRedDot()

	return RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.FirstRecharge) > 0
end

function RedDotModule.CheckRedDot_DiceGame()
	return PlayerModule.PlayerInfo.richManPOD.richTime > 0 or RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.DiceGame) > 0
end

function RedDotModule.CheckRedDot_NoviceSign()
	return RedDotModule.CheckRedDot_ActivityNoviceSignIsCanReceive()
end

function RedDotModule.CheckRedDot_GlobalChannelActivity()
	local openServerSign = RedDotModule.CheckRedDot_GlobalChannelActivityIsCanReceive(Constant.ActivityID.OpenServerSignActivity)
	local mayDaySign = RedDotModule.CheckRedDot_GlobalChannelActivityIsCanReceive(Constant.ActivityID.MayDaySignActivity)

	return openServerSign or mayDaySign
end

function RedDotModule.CheckRedDot_AccRecharge()
	local AccRechargeActivity_1 = RedDotModule.CheckRedDot_AccRechargeActivityIsCanReceive(Constant.ActivityID.AccumulateRechargeActivity_1)
	local AccRechargeActivity_2 = RedDotModule.CheckRedDot_AccRechargeActivityIsCanReceive(Constant.ActivityID.AccumulateRechargeActivity_2)
	local AccRechargeActivity_3 = RedDotModule.CheckRedDot_AccRechargeActivityIsCanReceive(Constant.ActivityID.AccumulateRechargeActivity_3)

	return AccRechargeActivity_1 or AccRechargeActivity_2 or AccRechargeActivity_3
end

function RedDotModule.CheckRedDot_SummerSign()
	return RedDotModule.CheckRedDot_ActivitySummerSignIsCanReceive()
end

function RedDotModule.CheckRedDot_GameFormationView()
	for heroCid, heroData in pairs(WarlockModule.WarlockDataDic) do
		if RedDotModule.CheckRedDot_GameFormationView_Item(heroCid) == true then
			return true
		end
	end

	return false
end

function RedDotModule.CheckRedDot_GameFormationView_Item(heroCid)
	return FormationModule.IsNewRole(heroCid)
end

function RedDotModule.UpdateRedDot_CheckRedDot_ShopCommodityUpdate()
	RedDotModule.CheckRedDot_Shop()
end

function RedDotModule.CheckRedDot_Shop()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) then
		return false
	end

	for _, shopData in pairs(ShopModule.shopDataDic) do
		for _, commodityData in pairs(shopData.itemDic) do
			if commodityData.config.Free == true and commodityData.buyNum < commodityData.config.Time and commodityData.isBuy then
				RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Shop_FreeItem, 1)

				return true
			end
		end
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.Shop_FreeItem, 0)

	return false
end

function RedDotModule.CheckRedDot_PushGift()
	local commodityDatas = PlayerModule.GetLimitTimeGifts()

	if table.len(commodityDatas) <= 0 then
		return false
	end

	for k, v in pairs(commodityDatas) do
		if RedDotModule.CheckRedDot_PushGiftCommodityByID(v) then
			return true
		end
	end

	return false
end

function RedDotModule.CheckRedDot_PushGiftCommodityByID(commodityID)
	if commodityID == nil then
		return false
	end

	if PlayerModule.GetLimitTimeGiftDataByID(commodityID) == nil or PlayerModule.GetLimitTimeGiftDataByID(commodityID) < 0 then
		return false
	end

	return true
end

function RedDotModule.CheckRedDot_WelfareList()
	RedDotModule.CheckDiceGameTaskRedDot()

	local cnt = 0

	if RedDotModule.CheckRedDot_StrengthSupplyIsCanReceive() == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_ActivityPassIsCanReceiveByActivityType(Constant.ActivityType.ActivityType_LevelPass) == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_ActivityPassIsCanReceiveByActivityType(Constant.ActivityType.ActivityType_MainLine) == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_NoviceSign() == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_SummerSign() == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_GlobalChannelActivity(Constant.ActivityID.OpenServerSignActivity) == true then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_GlobalChannelActivity(Constant.ActivityID.MMayDaySignActivity) == true then
		cnt = 1
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.WelfareList, cnt)
end

function RedDotModule.CheckRedDot_StrengthSupplyIsCanReceive()
	local activityPod = ActivityModule.GetActivityPodByID(Constant.ActivityID.StrengthActivity)

	if activityPod == nil or activityPod.supplyPOD == nil or activityPod.supplyPOD.map == nil then
		return false
	end

	for k, v in pairs(activityPod.supplyPOD.map) do
		if v == 1 then
			return true
		end
	end

	return false
end

function RedDotModule.CheckRedDot_LevelPassIsCanReceive(activityListCfg)
	return RedDotModule.CheckRedDot_ActivityPassIsCanReceive(activityListCfg.ActivityID[1])
end

function RedDotModule.CheckRedDot_MainLinePassIsCanReceive(activityListCfg)
	return RedDotModule.CheckRedDot_ActivityPassIsCanReceive(activityListCfg.ActivityID[1])
end

function RedDotModule.CheckRedDot_ActivityPassIsCanReceive(activityId)
	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if activityPod == nil then
		return false
	end

	return RedDotModule._GetActivityPassTaskIsCanReceive(activityPod)
end

function RedDotModule.CheckRedDot_ActivityNoviceSignIsCanReceive()
	return RedDotModule._GetActivityNoviceSignIsCanReceive()
end

function RedDotModule.CheckRedDot_ActivitySummerSignIsCanReceive()
	return RedDotModule._GetActivitySummerSignIsCanReceive()
end

function RedDotModule.CheckRedDot_GlobalChannelActivityIsCanReceive(activityId)
	return RedDotModule._GlobalChannelActivityIsCanReceive(activityId)
end

function RedDotModule.CheckRedDot_ActivityPassIsCanReceiveByActivityType(type)
	local activityPod = ActivityModule.GetActivityPodByActivityType({
		type
	})

	if #activityPod == 0 then
		return false
	end

	for i = 1, #activityPod do
		local isCanReceive = RedDotModule._GetActivityPassTaskIsCanReceive(activityPod[i])

		if isCanReceive == true then
			return true
		end
	end

	return false
end

function RedDotModule._GetActivityPassTaskIsCanReceive(activityPod)
	if activityPod == nil then
		return false
	end

	local activityCfg = CfgActivityTable[activityPod.cid]
	local normalMainTaskType = activityCfg.ExtraParam[1]
	local normalExtTaskType = {
		activityCfg.ExtraParam[2],
		activityCfg.ExtraParam[3]
	}
	local highMainTaskType = activityCfg.ExtraParam[4]
	local highExtTaskType = {
		activityCfg.ExtraParam[5],
		activityCfg.ExtraParam[6]
	}
	local normalTrunkIsShow = TaskSystemModule.IsCanGetAward(normalMainTaskType, normalExtTaskType)
	local highTrunkIsShow = TaskSystemModule.IsCanGetAward(highMainTaskType, highExtTaskType)

	if normalTrunkIsShow == true or highTrunkIsShow == true then
		return true
	end

	return false
end

function RedDotModule._GetActivityNoviceSignIsCanReceive()
	local activityPod = ActivityModule.GetActivityPodByID(Constant.ActivityID.Novice_7_SIGN)

	if activityPod == nil or activityPod.stage == 0 then
		return false
	end

	local normalTrunkIsShow = TaskSystemModule.IsCanGetAward(6)

	if normalTrunkIsShow == true then
		return true
	end

	return false
end

function RedDotModule._GetActivitySummerSignIsCanReceive()
	local normalTrunkIsShow = TaskSystemModule.IsCanGetAward(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.SummerSign)

	if normalTrunkIsShow == true then
		return true
	end

	return false
end

function RedDotModule._GlobalChannelActivityIsCanReceive(activityId)
	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if activityPod == nil or activityPod.stage == 0 then
		return false
	end

	local normalTrunkIsShow = ActivityListModule.HasUnclaimedItemsInGlobalChannelActivity(activityId)

	if normalTrunkIsShow == true then
		return true
	end

	return false
end

function RedDotModule.CheckRedDot_ActivityList()
	local cnt = 0
	local activityDiceGame = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_DiceGame
	})[1]

	if activityDiceGame and activityDiceGame.stage ~= 0 and (RedDotModule.CheckRedDot_DiceGame() or RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.DiceGame) > 0) then
		cnt = 1
	end

	if RedDotModule.CheckRedDot_BattleActivity() > 0 then
		cnt = 1
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.ActivityList, cnt)
end

function RedDotModule.CheckRedDot_DupMultipleHasSurplus()
	local activityDatas = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_DupMultiple_11,
		Constant.ActivityType.ActivityType_DupMultiple_12
	})

	if #activityDatas == 0 then
		return false
	end

	local daySurplusCount = 0

	for i = 1, #activityDatas do
		local activityCfg = CfgActivityTable[activityDatas[i].cid]

		daySurplusCount = activityCfg.ExtraParam[2] - activityDatas[i].dupDropPOD.dayNum

		if daySurplusCount > 0 then
			return true
		end
	end

	return false
end

function RedDotModule.CheckRedDot_BattleActivity()
	local cnt = 0

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.BattleActivity_Chapter_Reward_List_Get, 0)
	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.BattleActivity, 0)

	local dup = PlayerModule.GetActivityDup()

	RedDotModule.BattleActivityChapterRedDot = {}

	for _, activityDup in pairs(dup) do
		local cfgChapter = CfgUtil.GetCfgActivityChapterDataWithID(activityDup.chapterId)
		local num = 0

		for _, v in pairs(activityDup.passStar) do
			for _, _ in pairs(v.conditionIds) do
				num = num + 1
			end
		end

		local len = #cfgChapter.RewardDrop

		for i = 1, len, 2 do
			local start = cfgChapter.RewardDrop[i]

			if not activityDup.starState[start] and num >= cfgChapter.RewardDrop[i] then
				cnt = 1

				RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.BattleActivity_Chapter_Reward_List_Get, cnt)

				RedDotModule.BattleActivityChapterRedDot[activityDup.chapterId] = true
			end
		end
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.BattleActivity, cnt)

	return cnt
end

function RedDotModule.CheckRedDot_ActiveActivityList()
	local cnt = 0

	if RedDotModule.CheckRedDot_AccRecharge() == true then
		cnt = 1
	end

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.ActivityList, cnt)
end

function RedDotModule.CheckRedDot_GhostGame()
	local activityPOD = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_GhostGame
	})[1]

	if activityPOD == nil then
		return false
	end

	if activityPOD[1] == nil then
		return false
	end

	local activityCfg = CfgActivityTable[activityPOD[1].cid]

	if activityCfg.ExtraParam[1] - activityPOD[1].ghostPOD.todayCount <= 0 then
		return false
	end

	return true
end

function RedDotModule.CheckRedDot_GhostGameTask()
	local activityPOD = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_GhostGame
	})

	if activityPOD[1] == nil then
		return false
	end

	local activityCfg = CfgActivityTable[activityPOD[1].cid]
	local taskScrollDataArray = TaskSystemModule.GetSortForTypeDataList(activityCfg.ExtraParam[2], nil, TaskSystemModule.sortType.Weight_ID, true, false)
	local SubmitIDs = TaskSystemModule.GetCanReceiveTaskIDList({
		taskScrollDataArray
	})

	if table.len(SubmitIDs) == 0 then
		return false
	end

	return true
end

function RedDotModule.CheckRedDot_AccRechargeActivityIsCanReceive(activityId)
	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if activityPod == nil or activityPod.stage == 0 then
		return false
	end

	local hasRewards = ActivityListModule.HasUnclaimedAccRechargeRewards(activityId)

	if hasRewards == true then
		return true
	end

	return false
end

local co_WaitToHomeLandUpdate

function RedDotModule.UpdateRedDot_CheckRedDot_HomeLandUpdate()
	if co_WaitToHomeLandUpdate ~= nil then
		return
	end

	co_WaitToHomeLandUpdate = coroutine.start(function()
		coroutine.wait(0.5)
		RedDotModule.CheckRedDot_HomeLandTask()

		co_WaitToHomeLandUpdate = nil
	end)
end

local co_WaitToHomeLandTaskUpdate

function RedDotModule.UpdateRedDot_CheckRedDot_HomeLandTaskUpdate()
	if co_WaitToHomeLandTaskUpdate ~= nil then
		return
	end

	co_WaitToHomeLandTaskUpdate = coroutine.start(function()
		coroutine.wait(0.5)
		RedDotModule.CheckRedDot_HomeLandTask()

		co_WaitToHomeLandTaskUpdate = nil
	end)
end

function RedDotModule.CheckRedDot_HomeLandTask()
	local finishTaskList = HomeModule.GetAllFinishTaskCidList()

	RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.HomeLand_Task, #finishTaskList)
end

local co_WaitToUpdateActivity

function RedDotModule.UpdateRedDot_CheckRedDot_ActivityUpdate()
	if co_WaitToUpdateActivity == nil then
		co_WaitToUpdateActivity = coroutine.start(function()
			coroutine.wait(1)
			RedDotModule.CheckRedDot_WelfareList()
			RedDotModule.CheckRedDot_ActivityList()
			RedDotModule.CheckRedDot_ActiveActivityList()
			RedDotModule.CheckRedDot_Qusetionnair()

			co_WaitToUpdateActivity = nil
		end)
	end
end

function RedDotModule.CheckRedDot_Qusetionnair()
	local questionConfig = PlayerModule.GetIsOpenQuestionnaire()

	if questionConfig == nil then
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.MobilePhone_Questionnair, 0)
	else
		RedDotModule.SetRedDotCnt(Constant.E_RedDotPath.MobilePhone_Questionnair, 1)
	end
end

function RedDotModule.UpdateRedDot_CheckRedDot_UnlockFunction()
	RedDotModule.CheckRedDot_Shop()
end

function RedDotModule.ClearRedDotByRedDotID(redDotID)
	RedDotModule.SetRedDotCnt(redDotID, 0)
	EventDispatcher.Dispatch(EventID.ClearRedDotEvent)
end
