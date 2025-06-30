-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyModule.lua

local m = {
	isSendingMessage = false,
	GlobalCid = 1,
	monsterAreaDic = {},
	archives = {},
	girlDic = {}
}

require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyConstant")

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local MonsterAcademyTaskData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyTaskData")
local MonsterAcademyScene = require("IQIGame.Scene.MonsterAcademy.MonsterAcademyScene")
local MonsterAcademyAreaData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyAreaData")
local MonsterAcademyArchiveData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyArchiveData")
local MonsterAcademyGirlData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyGirlData")
local MonsterAcademyItemData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyItemData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD then
		m.GlobalCid = m.DailyDupPOD.common.openCount
	end

	m.RefreshArchiveData()
	m.AddListeners()
end

function m.RefreshGameData()
	m.RefreshGirlData()
	m.RefreshAreaData()

	if m.SaveDataDetailPOD then
		m.currDialog = m.SaveDataDetailPOD.dialogId
	end
end

function m.RefreshAreaData()
	m.monsterAreaDic = {}

	for i, v in pairsCfg(CfgGalgameMonsterAreaTable) do
		if v.Group == m.GlobalCid then
			local unlock = false

			if v.IsUnlocked == 1 then
				unlock = true
			elseif m.SaveDataDetailPOD and m.SaveDataDetailPOD.basePOD then
				unlock = table.indexOf(m.SaveDataDetailPOD.basePOD.areaList, v.Id) ~= -1
			end

			local areaData = MonsterAcademyAreaData.New(v.Id, unlock)

			areaData:RefreshAreaFunction()
			table.insert(m.monsterAreaDic, areaData)
		end
	end

	if m.monsterAcademyScene then
		m.monsterAcademyScene:RefreshArea()
	end
end

function m.RefreshArchiveData()
	m.archives = {}

	for i = 1, 8 do
		local type = 1

		if i == 8 then
			type = 2
		end

		local archiveData = MonsterAcademyArchiveData.New(i, type)
		local saveDataPod

		if m.DailyDupPOD and m.DailyDupPOD.miniGalGameDataPOD.saveList then
			for k, v in pairs(m.DailyDupPOD.miniGalGameDataPOD.saveList) do
				if v.slot == i then
					saveDataPod = v

					break
				end
			end
		end

		archiveData:SetArchiveData(saveDataPod)

		m.archives[i] = archiveData
	end
end

function m.RefreshGirlData()
	m.girlDic = {}

	if m.SaveDataDetailPOD and m.SaveDataDetailPOD.girls then
		for i, v in pairs(m.SaveDataDetailPOD.girls) do
			local cfgGirl = CfgGalgameMonsterGirlListTable[v.girlId]

			if cfgGirl.Group == m.GlobalCid then
				local girlData = MonsterAcademyGirlData.New(v.girlId)

				girlData:Refresh(v)

				m.girlDic[v.girlId] = girlData
			else
				logError("解锁的妹子 girlId = " .. v.girlId .. " 不属于第" .. m.GlobalCid .. "期")
			end
		end
	end
end

function m.GetMonsterAcademyDays(year, month)
	local tab = {}

	for i, v in pairsCfg(CfgGalgameMonsterTimeTable) do
		if v.Group == m.GlobalCid and v.Month == month and v.Year == year then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.Day < b.Day
	end)

	return tab
end

function m.GetMonsterAcademyTripRecord(month)
	local tab = {}

	for i, v in pairs(m.SaveDataDetailPOD.scheduleList) do
		local cfg = m.GetCfgGalGameDataByDayNum(v.day)

		if cfg.Month == month and cfg.Group == m.GlobalCid then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.day < b.day
	end)

	return tab
end

function m.GetCfgGalGameDataByDayNum(DayNum)
	for i, v in pairsCfg(CfgGalgameMonsterTimeTable) do
		if v.Group == m.GlobalCid and v.DayNum == DayNum then
			return v
		end
	end

	return nil
end

function m.GetMonsterAcademyAreaData(cid)
	for i, v in pairs(m.monsterAreaDic) do
		if v.cfgID == cid then
			return v
		end
	end

	return nil
end

function m.GetTowerLayer()
	local currentLayer = 1

	for i, v in pairs(m.SaveDataDetailPOD.towerRecord) do
		local cfg = CfgGalgameMonstertowerTable[v]

		if currentLayer < cfg.Num and cfg.Group == m.GlobalCid then
			currentLayer = cfg.Num
		end
	end

	return currentLayer
end

function m.GetSceneAreaPoint(cfgID)
	if m.monsterAcademyScene then
		local cfg = CfgGalgameMonsterAreaTable[cfgID]
		local v3 = m.monsterAcademyScene:GetAreaPos(cfg.SiteIconPosition)

		return v3
	end

	return Vector3.New(0, 0, 0)
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.GlobalCid = m.DailyDupPOD.common.openCount
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[15]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0
end

function m.GetExploreUIAsset()
	local cfgGalGameMonsterActivityGlobalData = CfgGalgameMonsterActivityGlobalTable[m.GlobalCid]

	return cfgGalGameMonsterActivityGlobalData.ExploreHallUIBG
end

function m.EnterMonsterAcademyScene()
	if m.monsterAcademyScene ~= nil then
		local cfgSceneListData = CfgSceneListTable[SceneID.CommonActivity]

		UIModule.Open(cfgSceneListData.LoadingUI, Constant.UILayer.Top, {
			sceneId = cfgSceneListData.Id
		})
		UIModule.Close(Constant.UIControllerName.MonsterAcademyMainUI)
		m.monsterAcademyScene:ClearScene()
		m.monsterAcademyScene:Refresh()

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MonsterAcademy, function()
			UIModule.Open(Constant.UIControllerName.MonsterAcademyMainUI, Constant.UILayer.DefaultUI)
			UIModule.Close(cfgSceneListData.LoadingUI)
		end, 2)

		timer:Start()
	else
		CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.MonsterAcademy, m.OnSceneLoaded)
	end
end

function m.ExitMonsterAcademyScene()
	CommonActivitySceneModule.Jump(m.DisposeMonsterAcademyScene, 10901004)
end

function m.ExecutionOpenSelectPanel(areaID)
	if UIModule.HasUI(Constant.UIControllerName.MonsterAcademySelectPanelUI) then
		EventDispatcher.Dispatch(EventID.UpdateSelectPanelUI, areaID)
	else
		UIModule.Open(Constant.UIControllerName.MonsterAcademySelectPanelUI, Constant.UILayer.UI, {
			AreaCid = areaID
		})
	end
end

function m.CheckResumeDialog()
	local haveDialog = false

	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		haveDialog = true
		m.currDialog = nil
	end

	return haveDialog
end

function m.OnSceneLoaded()
	m.monsterAcademyScene = MonsterAcademyScene.New()

	UIModule.Open(Constant.UIControllerName.MonsterAcademyMainUI, Constant.UILayer.DefaultUI)
end

function m.DisposeMonsterAcademyScene()
	if m.monsterAcademyScene then
		m.monsterAcademyScene:Dispose()
	end

	m.monsterAcademyScene = nil
end

function m.ExecutionAreaFunctionOption(funCid, areaCid, girlCid)
	local cfgFunction = CfgGalgameMonsterSchoolFunctionTable[funCid]

	if cfgFunction.FunctionSubType == MonsterAcademyConstant.FunctionSubType.FunctionSubType_Mall then
		UIModule.Open(Constant.UIControllerName.MonsterAcademyMallUI, Constant.UILayer.UI, {
			FunctionIDs = {
				funCid
			}
		})
	elseif cfgFunction.FunctionSubType == MonsterAcademyConstant.FunctionSubType.FunctionSubType_Tower then
		UIModule.Open(Constant.UIControllerName.MonsterAcademyChallengeUI, Constant.UILayer.UI, {
			AreaCid = areaCid
		})
	else
		m.TriggerEvent(funCid)
	end
end

function m.GetAllItems()
	local items = {}

	if m.SaveDataDetailPOD and m.SaveDataDetailPOD.items then
		for i, v in pairs(m.SaveDataDetailPOD.items) do
			if v > 0 then
				local itemData = MonsterAcademyItemData.New(i, v)

				table.insert(items, itemData)
			end
		end
	end

	return items
end

function m.GetItemNum(cid)
	if m.SaveDataDetailPOD and m.SaveDataDetailPOD.items then
		for i, v in pairs(m.SaveDataDetailPOD.items) do
			if i == cid then
				return v
			end
		end
	end

	return 0
end

function m.GetMonsterAcademyAchievementData(TypeParam)
	local cfgGalgameMonsterActivityGlobalData = CfgGalgameMonsterActivityGlobalTable[m.GlobalCid]
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.MONSTER_ACADEMY_TASK, TypeParam)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.MONSTER_ACADEMY_TASK, TypeParam)

	for i = 1, #processing do
		local taskData = processing[i]

		if table.indexOf(cfgGalgameMonsterActivityGlobalData.AchievementsID, taskData.cid) ~= -1 then
			local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)
			local state = 1

			if uiTaskData.CurrentNum >= uiTaskData.TargetNum then
				state = 2
			end

			uiTaskData.sortNum = state

			table.insert(ret, uiTaskData)
		end
	end

	for i = 1, #finished do
		local taskCid = finished[i]

		if table.indexOf(cfgGalgameMonsterActivityGlobalData.AchievementsID, taskCid) ~= -1 then
			local cfgTaskData = CfgMainQuestTable[taskCid]

			if cfgTaskData.FinishIsShow == 1 then
				local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
				local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

				uiTaskData.sortNum = 3

				table.insert(ret, uiTaskData)
			end
		end
	end

	table.sort(ret, function(a, b)
		if a.sortNum == b.sortNum then
			return a.cid < b.cid
		end

		return a.sortNum < b.sortNum
	end)

	return ret
end

function m.GetTaskDataList()
	local taskDataList = {}
	local state, isFinish

	for i, v in pairsCfg(CfgGalgameMonsterTaskTable) do
		if v.Group == m.GlobalCid and v.Type ~= 20 then
			isFinish = table.indexOf(m.SaveDataDetailPOD.taskList, v.Id) ~= -1

			if isFinish then
				state = MonsterAcademyConstant.TaskState.FINISH
			else
				local isExpired = false

				if #v.EndTime > 0 then
					local d = v.EndTime[1]
					local dayOfPhase = v.EndTime[2]

					if d < m.SaveDataDetailPOD.basePOD.day or m.SaveDataDetailPOD.basePOD.day == d and dayOfPhase < m.SaveDataDetailPOD.basePOD.dayOfPhase then
						isExpired = true
					end
				end

				local prepended = true

				if #v.PreTask > 0 then
					for i, taskID in pairs(v.PreTask) do
						if table.indexOf(m.SaveDataDetailPOD.taskList, taskID) == -1 then
							prepended = false

							break
						end
					end
				end

				if isExpired then
					state = MonsterAcademyConstant.TaskState.FAIL
				elseif prepended and not isExpired then
					state = MonsterAcademyConstant.TaskState.CURRENT
				else
					state = MonsterAcademyConstant.TaskState.NOT_PICKED_UP
				end
			end

			local taskData = MonsterAcademyTaskData.New(v.Id, state)

			table.insert(taskDataList, taskData)
		end
	end

	return taskDataList
end

function m.GetResidueBuyTimes(cid)
	local residueTimes = CfgGalgameMonsterShopTable[cid].LimitTimes

	if m.SaveDataDetailPOD and m.SaveDataDetailPOD.shopRecord then
		local buyCount = m.SaveDataDetailPOD.shopRecord[cid]

		if buyCount == nil then
			buyCount = 0
		end

		residueTimes = CfgGalgameMonsterShopTable[cid].LimitTimes - buyCount
	end

	return residueTimes
end

function m.GetUseItemBuyCount(cid)
	local cfgShop = CfgGalgameMonsterShopTable[cid]
	local maxCount = 0

	if m.SaveDataDetailPOD.items then
		for i, v in pairs(m.SaveDataDetailPOD.items) do
			local count = 0

			if i == cfgShop.SellPrice then
				count = math.floor(v / cfgShop.Price)
				maxCount = count * cfgShop.ItemNum
			end
		end
	end

	return maxCount
end

function m.GetGameTime()
	for i, v in pairsCfg(CfgGalgameMonsterTimeTable) do
		if v.Group == m.GlobalCid and v.DayNum == m.SaveDataDetailPOD.basePOD.day then
			return v
		end
	end

	return nil
end

function m.GetAreaDatingFunction(areaCid)
	local tab = {}

	if m.SaveDataDetailPOD then
		for i, v in pairs(m.SaveDataDetailPOD.scheduleList) do
			if v.areaId == areaCid and v.functionId > 0 and v.status == 0 and v.day == m.SaveDataDetailPOD.basePOD.day then
				if v.dayOfPhase == -1 then
					table.insert(tab, v)
				elseif v.dayOfPhase == m.SaveDataDetailPOD.basePOD.dayOfPhase then
					table.insert(tab, v)
				end
			end
		end
	end

	return tab
end

function m.GetDateBtnRed()
	local top = false

	if m.SaveDataDetailPOD then
		for i, v in pairs(m.monsterAreaDic) do
			for j, functionData in pairs(v.areaFunDic) do
				if functionData.cfgFunction.AreaImage == 1 and functionData.schedulePOD and functionData.schedulePOD.day == m.SaveDataDetailPOD.basePOD.day and functionData.schedulePOD.status == 0 then
					top = true

					break
				end
			end
		end
	end

	return top
end

function m.PlayAddAttr(base)
	if m.SaveDataDetailPOD.basePOD then
		for k, v in pairs(base.baseProps) do
			local newValue = v
			local oldValue = m.SaveDataDetailPOD.basePOD.baseProps[k]

			if oldValue == nil then
				oldValue = 0
			end

			local num = newValue - oldValue

			if num ~= 0 then
				local cfgAttr = CfgGalgameMonsterAttributeTable[k]

				NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MonsterAcademyMainUIApi:GetString("TextGameBaseAttr", cfgAttr.Name, num))
			end
		end
	end
end

function m.RefreshAreaFunction()
	local isChange = false

	for i, v in pairs(m.monsterAreaDic) do
		local result = v:RefreshAreaFunction()

		isChange = isChange or result
	end

	if m.monsterAcademyScene and isChange then
		m.monsterAcademyScene:RefreshArea()
		EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateAreaEvent)
	end
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

function m.GetMessageCount(messageID, eventType)
	local count = 0

	if m.SaveDataDetailPOD.messageGroupCount then
		if messageID == 0 then
			for i, v in pairs(m.SaveDataDetailPOD.messageGroupCount) do
				local cfgMessageGroup = CfgGalgameMonsterMessageGroupTable[v.countId]

				if cfgMessageGroup.Type > 1 then
					if eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_DAY then
						count = count + v.recordCountOfDay
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK then
						count = count + v.recordCountOfWeek
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_MONTH then
						count = count + v.recordCountOfMonth
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_YEAR then
						count = count + v.recordCountOfYear
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_ALL then
						count = count + v.recordCountOfTotal
					end
				end
			end
		else
			local MiniGalGameCountPOD = m.SaveDataDetailPOD.messageGroupCount[messageID]

			if MiniGalGameCountPOD then
				local cfgMessageGroup = CfgGalgameMonsterMessageGroupTable[MiniGalGameCountPOD.countId]

				if cfgMessageGroup.Type > 1 then
					if eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_DAY then
						count = MiniGalGameCountPOD.recordCountOfDay
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK then
						count = MiniGalGameCountPOD.recordCountOfWeek
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_MONTH then
						count = MiniGalGameCountPOD.recordCountOfMonth
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_YEAR then
						count = MiniGalGameCountPOD.recordCountOfYear
					elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_ALL then
						count = MiniGalGameCountPOD.recordCountOfTotal
					end
				end
			end
		end
	end

	if m.girlDic then
		for i, v1 in pairs(m.girlDic) do
			for k, v2 in pairs(v1.girlMessagesRecord) do
				local complete = v2:IsComplete()

				if not complete then
					local cfgMessageGroup = CfgGalgameMonsterMessageGroupTable[v2.groupID]

					if cfgMessageGroup.Type > 1 then
						count = count + 1
					end
				end
			end
		end
	end

	return count
end

function m.GetMonsterAcademyAtt()
	if m.__MonsterAcademyAtt == nil then
		local tab = {}

		for i, v in pairsCfg(CfgGalgameMonsterAttributeTable) do
			if v.Group == m.GlobalCid then
				table.insert(tab, v.Id)
			end
		end

		table.sort(tab, function(a, b)
			return a < b
		end)

		m.__MonsterAcademyAtt = tab
	end

	return m.__MonsterAcademyAtt
end

function m.Shutdown()
	m.RemoveListeners()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.MonsterAcademy)
	CommonActivitySceneModule.Shutdown()
	m.DisposeMonsterAcademyScene()

	m.monsterAreaDic = {}
	m.DailyDupPOD = nil
	m.GlobalCid = 0
	m.currDialog = nil
	m.SaveDataDetailPOD = nil
	m.isSendingMessage = false
	m.__MonsterAcademyAtt = nil
end

function m.StartNewGame()
	net_miniGalGame.startNewGame()
end

function m.LoadGame(slotIdx)
	net_miniGalGame.loadGame(slotIdx)
end

function m.SaveGame(slotIdx)
	net_miniGalGame.saveGame(slotIdx)
end

function m.SubmitMiniGameOver(type, gameId, status)
	net_miniGalGame.submitMiniGameOver(type, gameId, status)
end

function m.TriggerEvent(eventID)
	if GameEntry.Base.DevMode then
		log("triggerEvent " .. eventID)
	end

	net_miniGalGame.triggerEvent(eventID)
end

function m.ShopBuy(shopCfgId, num)
	net_miniGalGame.shopBuy(shopCfgId, num)
end

function m.ItemUse(itemId, num)
	net_miniGalGame.itemUse(itemId, num)
end

function m.TowerFight(towerMonsterId)
	net_miniGalGame.towerFight(towerMonsterId)
end

function m.CallFromGirl(girl, status)
	net_miniGalGame.callFromGirl(girl, status)
end

function m.SendMessage(messageId, girlId)
	if GameEntry.Base.DevMode then
		log("发送短信 messageID=" .. messageId .. " girlId=" .. girlId)
	end

	net_miniGalGame.sendMessage(messageId, girlId)

	m.isSendingMessage = true
end

function m.StartNewGameResult(pod)
	m.SaveDataDetailPOD = pod

	m.RefreshGameData()
	MonsterAcademyModule.EnterMonsterAcademyScene()
end

function m.LoadGameResult(pod)
	m.SaveDataDetailPOD = pod

	m.RefreshGameData()
	MonsterAcademyModule.EnterMonsterAcademyScene()
	UIModule.Close(Constant.UIControllerName.MonsterAcademySLDataUI)
end

function m.SaveGameResult()
	return
end

function m.SelectDialogResult(nextDialogId)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogId)

	if nextDialogId == 0 then
		-- block empty
	end
end

function m.ItemUseResult()
	return
end

function m.NotifyGalItemsStatus(items)
	local tempTab = {}

	for i, v in pairs(items) do
		if m.SaveDataDetailPOD.items[i] == nil then
			tempTab[i] = v
		else
			local count = v - m.SaveDataDetailPOD.items[i]

			if count > 0 then
				tempTab[i] = count
			end
		end

		m.SaveDataDetailPOD.items[i] = v
	end

	for j, value in pairs(tempTab) do
		if j == 10002 then
			NoticeModule.ShowNoticeNoCallback(21045061, CfgGalgameMonsterItemTable[j].Name, value)
		else
			NoticeModule.ShowNoticeNoCallback(21045057, CfgGalgameMonsterItemTable[j].Name, value)
		end
	end

	m.RefreshAreaFunction()
	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateItemEvent)
end

function m.SubmitMiniGameOverResult(rewards)
	if #rewards > 0 then
		UIModule.Open(Constant.UIControllerName.MonsterAcademyGetPanelUI, Constant.UILayer.Tooltip, {
			items = rewards
		})
	end
end

function m.TriggerEventResult()
	log("TriggerEventResult ")
end

function m.CallFromGirlResult()
	return
end

function m.ShopBuyResult()
	NoticeModule.ShowNotice(21040017)
end

function m.TowerFightResult(towerMonsterId, fightStatus, rewards)
	if table.indexOf(m.SaveDataDetailPOD.towerRecord, towerMonsterId) == -1 and fightStatus > 0 then
		table.insert(m.SaveDataDetailPOD.towerRecord, towerMonsterId)
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademySettlementUI, Constant.UILayer.UI, {
		State = fightStatus,
		Rewards = rewards
	})
	UIModule.Close(Constant.UIControllerName.MonsterAcademyChallengeDetailUI)
	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateTowerEvent)
end

function m.SendMessageResult(messageId, girlId)
	if GameEntry.Base.DevMode then
		log("<<<<<<<<<<<<<发送短信返回 " .. messageId .. " 妹子 =" .. girlId)
	end

	m.girlDic[girlId]:RefreshGirlMessage()

	for i, v in pairs(m.girlDic[girlId].girlMessagesRecord) do
		if v.groupID == CfgGalgameMonsterMessageTable[messageId].Group then
			v:AddMessageProgress(messageId)
		end
	end

	EventDispatcher.Dispatch(EventID.MonsterAcademySendMessageResultEvent, messageId, girlId)

	m.isSendingMessage = false
end

function m.NotifyOpenDialog(dialogId, dynamicType, dynamicValue)
	if dynamicType == 1 then
		DialogModule.OpenDialog(dialogId, false, true)
	elseif dynamicType == 2 then
		UIModule.Open(Constant.UIControllerName.MonsterAcademySettlementUI, Constant.UILayer.UI, {
			State = dynamicValue,
			Rewards = {},
			CallBack = function()
				DialogModule.OpenDialog(dialogId, false, true)
			end
		})
	else
		DialogModule.OpenDialog(dialogId, false, true)
	end
end

function m.NotifyGalMiniGameStart(type, gameId)
	if type == MonsterAcademyConstant.MiniGameType.Jigsaw then
		m.__OpenMiniGameJigsaw(gameId)
	elseif type == MonsterAcademyConstant.MiniGameType.Fruit then
		m.__OpenMiniGameFruit(gameId)
	elseif type == MonsterAcademyConstant.MiniGameType.WhacAMole then
		m.__OpenMiniGameWhacAMole(gameId)
	else
		logError("can not find CfgGalgameMonsterGamesGlobalTable gameType [" .. tostring(type) .. "]")
	end
end

function m.__OpenMiniGameJigsaw(gameId)
	UIModule.Open(Constant.UIControllerName.MonsterAcademyGameJigsawUI, Constant.UILayer.UI, {
		gameId = gameId,
		callback = function(result)
			m.__OnMiniGameJigsawCallback(MonsterAcademyConstant.MiniGameType.Jigsaw, gameId, result)
		end
	})
end

function m.__OnMiniGameJigsawCallback(type, gameId, result)
	m.SubmitMiniGameOver(type, gameId, result.success and 1 or 0)
end

function m.__OpenMiniGameFruit(gameId)
	UIModule.Open(Constant.UIControllerName.MonsterAcademyGameFruitUI, Constant.UILayer.UI, {
		gameId = gameId,
		callback = function(result)
			m.__OnMiniGameFruitCallback(MonsterAcademyConstant.MiniGameType.Fruit, gameId, result)
		end
	})
end

function m.__OnMiniGameFruitCallback(type, gameId, result)
	m.SubmitMiniGameOver(type, gameId, result.success and 1 or 0)
end

function m.__OpenMiniGameWhacAMole(gameId)
	UIModule.Open(Constant.UIControllerName.MonsterAcademyGameMoleUI, Constant.UILayer.UI, {
		gameId = gameId,
		callback = function(result)
			m.__OnMiniGameWhacAMoleCallback(MonsterAcademyConstant.MiniGameType.WhacAMole, gameId, result)
		end
	})
end

function m.__OnMiniGameWhacAMoleCallback(type, gameId, result)
	m.SubmitMiniGameOver(type, gameId, result.success and 1 or 0)
end

function m.NotifyFight(fightId, win, rewards)
	if #rewards > 0 then
		UIModule.Open(Constant.UIControllerName.MonsterAcademyGetPanelUI, Constant.UILayer.Tooltip, {
			items = rewards
		})
	end
end

function m.NotifyGalShop(shopRecord)
	for i, v in pairs(shopRecord) do
		m.SaveDataDetailPOD.shopRecord[i] = v
	end

	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateShopEvent)
end

function m.NotifyGalGirlsData(girls)
	if m.SaveDataDetailPOD then
		if m.SaveDataDetailPOD.girls == nil then
			m.SaveDataDetailPOD.girls = {}
		end

		for k, new in pairs(girls) do
			local isNew = true
			local newFavor = new.favorAbility

			for i, v in pairs(m.SaveDataDetailPOD.girls) do
				if v.girlId == new.girlId then
					if newFavor < v.favorAbility then
						NoticeModule.ShowNoticeNoCallback(21045052, CfgGalgameMonsterGirlListTable[v.girlId].Name)
					elseif newFavor > v.favorAbility then
						NoticeModule.ShowNoticeNoCallback(21045051, CfgGalgameMonsterGirlListTable[v.girlId].Name)
					end

					isNew = false
					m.SaveDataDetailPOD.girls[i] = new
				end
			end

			if isNew then
				table.insert(m.SaveDataDetailPOD.girls, new)
			end
		end
	end

	m.RefreshGirlData()
	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateGirlEvent)
end

function m.NotifyGalBaseData(base)
	local isChange = false

	m.PlayAddAttr(base)

	if m.SaveDataDetailPOD then
		if m.SaveDataDetailPOD.basePOD.day ~= base.day or m.SaveDataDetailPOD.basePOD.dayOfPhase ~= base.dayOfPhase then
			isChange = true
		end

		if #m.SaveDataDetailPOD.basePOD.areaList ~= #base.areaList then
			m.SaveDataDetailPOD.basePOD = base

			m.RefreshAreaData()
			EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateAreaEvent)
		else
			m.SaveDataDetailPOD.basePOD = base

			m.RefreshAreaFunction()
		end

		if m.girlDic then
			for i, v in pairs(m.girlDic) do
				v:RefreshGirlFunction()
			end
		end

		if isChange then
			EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateBaseEvent)
		end
	end
end

function m.NotifyEventTriggeredCount(eventCount)
	if m.SaveDataDetailPOD then
		if m.SaveDataDetailPOD.triggeredCount == nil then
			m.SaveDataDetailPOD.triggeredCount = {}
		end

		for k, new in pairs(eventCount) do
			m.SaveDataDetailPOD.triggeredCount[k] = new
		end

		m.RefreshAreaFunction()
	end

	if m.girlDic then
		for i, v in pairs(m.girlDic) do
			v:RefreshGirlFunction()
		end
	end
end

function m.NotifyGalTaskFinish(taskId, rewards)
	if #rewards > 0 then
		UIModule.Open(Constant.UIControllerName.MonsterAcademyGetPanelUI, Constant.UILayer.Tooltip, {
			items = rewards
		})
	end

	if m.SaveDataDetailPOD then
		if m.SaveDataDetailPOD.taskList == nil then
			m.SaveDataDetailPOD.taskList = {}
		end

		if table.indexOf(m.SaveDataDetailPOD.taskList, taskId == -1) then
			table.insert(m.SaveDataDetailPOD.taskList, taskId)
		end
	end

	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateTaskEvent)
end

function m.NotifyUpdateSaveData(podList)
	if m.DailyDupPOD then
		local haveAutoSave = false

		for i, v in pairs(podList) do
			local isNew = true

			for k, oldValue in pairs(m.DailyDupPOD.miniGalGameDataPOD.saveList) do
				if oldValue.slot == v.slot then
					isNew = false
					m.DailyDupPOD.miniGalGameDataPOD.saveList[k] = v
				end
			end

			if isNew then
				table.insert(m.DailyDupPOD.miniGalGameDataPOD.saveList, v)
			end

			if v.slot == 8 then
				haveAutoSave = true
			end
		end

		if haveAutoSave then
			-- block empty
		end
	end

	m.RefreshArchiveData()
	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateSaveDataEvent)
end

function m.NotifyScheduleList(scheduleList)
	if m.SaveDataDetailPOD then
		if m.SaveDataDetailPOD.scheduleList == nil then
			m.SaveDataDetailPOD.scheduleList = {}
		end

		for k, new in pairs(scheduleList) do
			local isNew = true

			for i, v in pairs(m.SaveDataDetailPOD.scheduleList) do
				if v.id == new.id then
					isNew = false
					m.SaveDataDetailPOD.scheduleList[i] = new
				end
			end

			if isNew then
				table.insert(m.SaveDataDetailPOD.scheduleList, new)
			end
		end

		local isChange = false

		for i, v in pairs(m.monsterAreaDic) do
			local result = v:RefreshAreaFunction()

			isChange = isChange or result
		end

		if m.monsterAcademyScene and isChange then
			m.monsterAcademyScene:RefreshArea()
		end
	end

	if m.girlDic then
		for i, v in pairs(m.girlDic) do
			v:RefreshGirlFunction()
		end
	end

	EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateScheduleEvent)
end

function m.NotifyCallFromGirl(girl)
	UIModule.Open(Constant.UIControllerName.MonsterAcademyCallPhoneUI, Constant.UILayer.UI, girl)
end

function m.NotifyAchievementData(achievementData)
	if m.DailyDupPOD and m.DailyDupPOD.miniGalGameDataPOD.achievementData then
		for i, v in pairs(achievementData) do
			m.DailyDupPOD.miniGalGameDataPOD.achievementData[i] = v
		end
	end
end

function m.NotifyLocalAchievementData(achievementData)
	if m.SaveDataDetailPOD then
		for k, new in pairs(achievementData) do
			m.SaveDataDetailPOD.localAchievementData[k] = new
		end
	end
end

function m.NotifyItemUsedCount(itemUsedCount)
	if m.SaveDataDetailPOD then
		for i, v in pairs(itemUsedCount) do
			m.SaveDataDetailPOD.itemUsedCount[i] = v
		end
	end
end

function m.NotifyComplete(saveIdx, functionId)
	m.archives[saveIdx].saveDataPod.gameOver = true

	UIModule.Open(Constant.UIControllerName.MonsterAcademyFinalResultUI, Constant.UILayer.UI, functionId)
end

function m.NotifyMessageFromGirl(girlId, pod)
	if m.SaveDataDetailPOD and m.SaveDataDetailPOD.girls then
		for i, v in pairs(m.SaveDataDetailPOD.girls) do
			if girlId == v.girlId then
				if v.messageGroups == nil then
					v.messageGroups = {}
				end

				table.insert(m.SaveDataDetailPOD.girls[i].messageGroups, pod)
			end
		end

		m.girlDic[girlId]:RefreshGirlMessage()
		EventDispatcher.Dispatch(EventID.MonsterAcademyUpdateMessageEvent)
	end
end

function m.NotifyMessageGroupCount(MessageGroupCount)
	if m.SaveDataDetailPOD then
		for k, v in pairs(MessageGroupCount) do
			m.SaveDataDetailPOD.messageGroupCount[k] = v
		end
	end
end

MonsterAcademyModule = m
