-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\RestaurantOperationModule.lua

local m = {
	isFight = false,
	GlobalCid = 1,
	ROEventMonster = {},
	ROEventPlot = {},
	ROBossRankData = {},
	ROPostControl = {},
	ROPlayers = {},
	moneyIncome = {}
}

require("IQIGame.Module.CommonActivity.RestaurantOperation.RestaurantOperationConstant")

local ROEventData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROEventData")
local RestaurantOperationScene = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationScene")
local ROPostControlData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROPostControlData")
local ROPlayerData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROPlayerData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD then
		m.GlobalCid = m.DailyDupPOD.common.openCount

		m.InitData()
	end

	m.AddListeners()
	ROAnswerGameModule.Reload()
	ROCardGameModule.Reload()
	ROFruitCleanGameModule.Reload()
	ROPuzzleGameModule.Reload()
end

function m.InitData()
	ROAnswerGameModule.InitData()
	ROPuzzleGameModule.InitData()

	m.ROEventMonster = {}
	m.ROEventPlot = {}

	for i, v in pairsCfg(CfgRestaurantOperationEventControlTable) do
		if v.Group == m.GlobalCid then
			local roEventData = ROEventData.New(v.Id, v.Type)

			if v.Type == RestaurantOperationConstant.EventType.Event_Fight then
				table.insert(m.ROEventMonster, roEventData)
			elseif v.Type == RestaurantOperationConstant.EventType.Event_Plot then
				table.insert(m.ROEventPlot, roEventData)
			end
		end
	end

	table.sort(m.ROEventMonster, function(a, b)
		return a.cid < b.cid
	end)
	table.sort(m.ROEventPlot, function(a, b)
		return a.cid < b.cid
	end)

	m.ROPostControl = {}

	for j, k in pairsCfg(CfgRestaurantOperationPostControlTable) do
		if k.Group == m.GlobalCid then
			local posPod

			if m.ROAttributePOD then
				for i, v in pairs(m.ROAttributePOD.postInfo) do
					if v.type == k.Id then
						posPod = v

						break
					end
				end
			end

			local postData = ROPostControlData.New(k.Id, posPod)

			table.insert(m.ROPostControl, postData)
		end
	end

	m.ROBossRankData = {}

	for i, v in pairsCfg(CfgRestaurantOperationRankTable) do
		if v.Group == m.GlobalCid then
			table.insert(m.ROBossRankData, v)
		end
	end

	m.ROPlayers = {}

	for i, v in pairsCfg(CfgRestaurantOperationPlayerTable) do
		if v.Group == m.GlobalCid then
			local playerData = ROPlayerData.New(v.Id, nil)

			table.insert(m.ROPlayers, playerData)
		end
	end

	m.moneyIncome = {}

	for i, v in pairsCfg(CfgRestaurantOperationIncomeTable) do
		if v.Group == m.GlobalCid and v.IncomeItem > 0 then
			table.insert(m.moneyIncome, v)
		end
	end

	table.sort(m.moneyIncome, function(a, b)
		return a.IncomeItem < b.IncomeItem
	end)
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[23]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0
end

function m.CanNotEnter()
	return m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 1
end

function m.GetExploreUIAsset()
	local cfgRestaurantOperationControlData = CfgRestaurantOperationControlTable[m.GlobalCid]

	return cfgRestaurantOperationControlData.ExploreHallUIBG
end

function m.SetRestaurantSceneActive(top)
	if m.ROScene then
		m.ROScene:SetActive(top)
	end
end

function m.GetModifyCostData(count)
	if m.modifyTimes == nil then
		m.modifyTimes = {}

		for i, v in pairsCfg(CfgRestaurantOperationModifyCostTable) do
			if v.Group == m.GlobalCid then
				table.insert(m.modifyTimes, v)
			end
		end

		table.sort(m.modifyTimes, function(a, b)
			return a.ModifyTime < b.ModifyTime
		end)
	end

	local index = count > #m.modifyTimes and #m.modifyTimes or count

	return m.modifyTimes[index]
end

function m.ChallengeBossIsPass(groupID, bossID)
	local max = 0

	if m.DailyDupPOD and m.DailyDupPOD.restaurantOperationPOD then
		max = m.DailyDupPOD.restaurantOperationPOD.combatTraining[groupID]
		max = max or 0
	end

	return bossID <= max
end

function m.GetWorksNum()
	local num = 0
	local maxNum = 0

	if m.ROAttributePOD and m.ROAttributePOD.positionInformation then
		maxNum = #m.ROAttributePOD.positionInformation

		for i, v in pairs(m.ROAttributePOD.positionInformation) do
			if v.location and v.location > 0 then
				num = num + 1
			end
		end
	end

	return num, maxNum
end

function m.CheckEventPlot()
	local haveNewPlot = false
	local nextPloEvent
	local preStoryCom = false
	local conditionResult = false

	if m.ROAttributePOD and m.ROAttributePOD.dialogId == 0 then
		for i = 1, #m.ROEventPlot do
			local data = m.ROEventPlot[i]

			if table.indexOf(m.ROAttributePOD.plot, data.cid) == -1 then
				nextPloEvent = data

				break
			end
		end

		if nextPloEvent then
			preStoryCom = m.CheckPreStory(nextPloEvent.cid)
			conditionResult = nextPloEvent:IsUnlock()
		end
	end

	haveNewPlot = preStoryCom and conditionResult

	return haveNewPlot, nextPloEvent
end

function m.CheckPreStory(cid)
	local complete = false
	local eventData = m.GetPlotEventData(cid)
	local preStory = eventData:GetCfgData().PreStory

	if preStory > 0 then
		if m.ROAttributePOD and m.ROAttributePOD.plot and table.indexOf(m.ROAttributePOD.plot, preStory) ~= -1 then
			complete = true
		end
	else
		complete = true
	end

	return complete
end

function m.CheckConditions(conditionCidTable)
	if #conditionCidTable <= 0 then
		return true, nil
	end

	local result = true
	local failedReason = ""

	for i = 1, #conditionCidTable do
		local conditionCid = conditionCidTable[i]
		local res, failed = ConditionModule.Check(conditionCid)

		if not res then
			failedReason = "conditionCid = " .. conditionCid .. " failedReason:" .. failed
			result = res
		end
	end

	return result, failedReason
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.IsShow() and m.GlobalCid ~= m.DailyDupPOD.common.openCount then
		m.GlobalCid = m.DailyDupPOD.common.openCount

		m.InitData()
	end
end

function m.GetPlotEventData(cid)
	for i, v in pairs(m.ROEventPlot) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetMonsterEventData(cid)
	for i, v in pairs(m.ROEventMonster) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetBuildingData()
	for i, v in pairsCfg(CfgRestaurantOperationBuildingTable) do
		if v.Group == m.GlobalCid and v.Level == m.ROAttributePOD.level then
			return v
		end
	end

	return nil
end

function m.CanGetReceiveIncome()
	local result = false
	local count = 0
	local upperLimit = 0
	local cfgRestaurantOperationControlData = CfgRestaurantOperationControlTable[m.GlobalCid]

	upperLimit = cfgRestaurantOperationControlData.MaxTimes

	if m.DailyDupPOD and m.DailyDupPOD.restaurantOperationPOD then
		count = m.DailyDupPOD.restaurantOperationPOD.numberOfReturns
		count = count or 0
		result = count >= cfgRestaurantOperationControlData.MainUiGetButton
	end

	return result, count, upperLimit
end

function m.UpdatePostControl()
	for i, v in pairs(m.ROAttributePOD.postInfo) do
		local roPostControlData = m.GetROPostControlData(v.type)

		roPostControlData.postPOD = v
	end
end

function m.UpdatePostInformation(positionInformationPOD, addAttrs)
	if m.ROAttributePOD then
		local isNew = true

		for i, v in pairs(m.ROAttributePOD.positionInformation) do
			if v.id == positionInformationPOD.id then
				isNew = false
				m.ROAttributePOD.positionInformation[i] = positionInformationPOD
			end
		end

		if isNew then
			positionInformationPOD.postType = 0
			positionInformationPOD.location = 0

			table.insert(m.ROAttributePOD.positionInformation, positionInformationPOD)
		end
	end

	local roPlayerData = m.GetROPlayerData(positionInformationPOD.id)

	roPlayerData.posInfo = positionInformationPOD

	EventDispatcher.Dispatch(EventID.UpdateROWorkerEvent, roPlayerData, addAttrs)
end

function m.GetCfgMaxLvBuildingData()
	if m._cfgMaxLvBuildingData == nil then
		local lv = 1

		for i, v in pairsCfg(CfgRestaurantOperationBuildingTable) do
			if v.Group == m.GlobalCid and lv <= v.Level then
				m._cfgMaxLvBuildingData = v
				lv = v.Level
			end
		end
	end

	return m._cfgMaxLvBuildingData
end

function m.GetROPlayerData(cid)
	for i, v in pairs(m.ROPlayers) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetROPostControlData(cid)
	for i, v in pairs(m.ROPostControl) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.CheckEventRed()
	if m.DailyDupPOD and m.DailyDupPOD.restaurantOperationPOD then
		for i, v in pairs(m.DailyDupPOD.restaurantOperationPOD.event) do
			if not v.status then
				return true
			end
		end
	end

	return false
end

function m.GetRestaurantTaskDataList(typeParams)
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.RESTAURANT_OPERATION_TASK, typeParams)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.RESTAURANT_OPERATION_TASK, typeParams)

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

function m.EnterRestaurantScene()
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.Restaurant, m.OnSceneLoaded)
end

function m.ExitRestaurantScene()
	CommonActivitySceneModule.Jump(m.DisposeRestaurantScene, 10901007)
end

function m.ChangeSceneArea(type)
	if m.ROScene and m.ROScene.sceneType ~= type then
		m.ROScene.isLockInput = false

		m.ROScene:ClearScene()
		m.ROScene:ChangeSceneArea(type, true)
	end
end

function m.CheckResumeDialog()
	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		m.currDialog = nil
	end
end

function m.OnSceneLoaded()
	m.ROScene = RestaurantOperationScene.New()
end

function m.DisposeRestaurantScene()
	if m.ROScene then
		m.ROScene:Dispose()
	end

	m.ROScene = nil
end

function m.Shutdown()
	ROAnswerGameModule.Shutdown()
	ROCardGameModule.Shutdown()
	ROFruitCleanGameModule.Shutdown()
	ROPuzzleGameModule.Shutdown()

	m.currDialog = nil

	m.RemoveListeners()

	m.GlobalCid = 0
	m.DailyDupPOD = nil
	m.isFight = false

	m.DisposeRestaurantScene()
end

function m.GetRestaurantInfo()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.getRestaurantInfo()
end

function m.TransactDocuments()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.transactDocuments()
end

function m.Practice(id)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.practice(id)
end

function m.LevelUp()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.levelUp()
end

function m.Work(id, post, location, state)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.work(id, post, location, state)
end

function m.ReceiveIncome()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.receiveIncome()
end

function m.ReadBurst()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_restaurant.readBurst()
end

function m.OpenDialog(cid)
	net_restaurant.openDialog(cid)
end

function m.CombatTraining(bossId, formationId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.isFight then
		return
	end

	m.isFight = true

	net_restaurant.combatTraining(bossId, formationId)
end

function m.BossTraining(formationId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.isFight then
		return
	end

	m.isFight = true

	net_restaurant.bossTraining(formationId)
end

function m.GetRestaurantInfoResult(restaurantOperationAttributePOD)
	m.ROAttributePOD = restaurantOperationAttributePOD
	m.currDialog = m.ROAttributePOD.dialogId

	for i, v in pairs(m.ROAttributePOD.positionInformation) do
		local roPlayerData = m.GetROPlayerData(v.id)

		roPlayerData.posInfo = v
	end

	m.UpdatePostControl()
	RestaurantOperationModule.EnterRestaurantScene()
end

function m.TransactDocumentsResult(positionInformationPOD)
	m.UpdatePostInformation(positionInformationPOD)
end

function m.PracticeResult(positionInformationPOD, beforeAtt, restaurantOperationAttribute)
	if GameEntry.Base.DevMode then
		log("进修返回 ")
	end

	m.ROAttributePOD = restaurantOperationAttribute

	m.UpdatePostInformation(positionInformationPOD, beforeAtt)

	for i, v in pairs(m.ROAttributePOD.positionInformation) do
		local roPlayerData = m.GetROPlayerData(v.id)

		roPlayerData.posInfo = v
	end

	m.UpdatePostControl()
end

function m.LevelUpResult(restaurantOperationAttributePOD)
	m.ROAttributePOD = restaurantOperationAttributePOD

	for i, v in pairs(m.ROAttributePOD.positionInformation) do
		local roPlayerData = m.GetROPlayerData(v.id)

		roPlayerData.posInfo = v
	end

	m.UpdatePostControl()
	EventDispatcher.Dispatch(EventID.ROBuildLevelUpEvent)
	NoticeModule.ShowNotice(21045093)
end

function m.WorkResult(posts, positionInformationPOD, post, location)
	m.ROAttributePOD.postInfo = posts

	m.UpdatePostControl()
	m.UpdatePostInformation(positionInformationPOD)
	EventDispatcher.Dispatch(EventID.ROUpdateScenePlayerEvent, positionInformationPOD, post, location)
end

function m.ReceiveIncomeResult(items)
	if #items > 0 then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationGetPanelUI, Constant.UILayer.UI, {
			cid = Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT,
			items = items,
			args = {}
		})
	end

	m.DailyDupPOD.restaurantOperationPOD.numberOfReturns = 0

	EventDispatcher.Dispatch(EventID.ROReceiveIncomeEvent)
end

function m.ReadBurstResult()
	for i, v in pairs(m.DailyDupPOD.restaurantOperationPOD.event) do
		v.status = true
	end

	EventDispatcher.Dispatch(EventID.ROUpdateEvent)
end

function m.OpenDialogResult(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function m.SelectDialogResult(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		EventDispatcher.Dispatch(EventID.ROPlotEndEvent)
	end
end

function m.CombatTrainingResult()
	return
end

function m.BossTrainingResult()
	return
end

function m.NotifyReceiveIncome(number)
	if m.DailyDupPOD and m.DailyDupPOD.restaurantOperationPOD then
		m.DailyDupPOD.restaurantOperationPOD.numberOfReturns = number
	end

	EventDispatcher.Dispatch(EventID.ROReceiveIncomeEvent)
end

function m.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	rewardData.battleType = 0

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	m.DailyDupPOD.restaurantOperationPOD.combatTraining = monster

	for i, v in pairs(m.ROEventMonster) do
		for j, k in pairs(v.monsters) do
			local pass = m.ChallengeBossIsPass(k:GetCfgData().GroupNum, k.cid)

			k.isPass = pass
		end
	end

	EventDispatcher.Dispatch(EventID.ROUpdateChallengeEvent)
end

function m.NotifyBossTraining(win, cid, dmgRecords)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, {}, nil, dmgRecords)

	rewardData.battleType = 0

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.NotifyEventIsFinish(eventId)
	if m.ROAttributePOD and table.indexOf(m.ROAttributePOD.plot, eventId) == -1 then
		table.insert(m.ROAttributePOD.plot, eventId)
	end

	if CfgRestaurantOperationControlTable[m.GlobalCid].UnlockEvent == eventId then
		m.DailyDupPOD.restaurantOperationPOD.exBossLock = true
	end

	EventDispatcher.Dispatch(EventID.ROPlotEndEvent)
end

function m.NotifyEmergency(list)
	if GameEntry.Base.DevMode then
		log("收到通知更新事件")
	end

	m.DailyDupPOD.restaurantOperationPOD.event = list

	EventDispatcher.Dispatch(EventID.ROUpdateEvent)
end

function m.NotifyEarnings(income)
	if RestaurantOperationModule.ROAttributePOD then
		RestaurantOperationModule.ROAttributePOD.income = income
	end

	EventDispatcher.Dispatch(EventID.ROReceiveIncomeEvent)
end

RestaurantOperationModule = m
