-- chunkname: @IQIGame\\Module\\CommonActivity\\FishingActivity\\FishingActivityModule.lua

local m = {
	playingEventCid = 0,
	isOpenAutoAttack = true,
	success = false,
	playingDialogCid = 0,
	globalCid = 1,
	fishIllustratedDataList = {},
	fishEventDataList = {},
	fishSkillDataList = {},
	fishSkillActionDataList = {}
}

require("IQIGame.Module.CommonActivity.FishingActivity.FishingActivityConstant")

local FishingActivityIllustratedData = require("IQIGame.Module.CommonActivity.FishingActivity.FishingActivityIllustratedData")
local FishingActivityEventData = require("IQIGame.Module.CommonActivity.FishingActivity.FishingActivityEventData")
local FishingActivitySkillData = require("IQIGame.Module.CommonActivity.FishingActivity.FishingActivitySkillData")
local FishingActivitySkillActionData = require("IQIGame.Module.CommonActivity.FishingActivity.FishingActivitySkillActionData")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD then
		m.globalCid = m.dailyDupPOD.common.openCount

		if m.dailyDupPOD.fishingActivityPOD then
			m.InitData()
		end
	end

	m.AddListeners()
end

function m.InitData()
	if not m.IsShow() then
		return
	end

	m.fishIllustratedDataList = {}

	for i, v in pairsCfg(CfgFishActiveFishListTable) do
		if v.Group == m.globalCid then
			local pod

			if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.book then
				pod = m.dailyDupPOD.fishingActivityPOD.book[v.Id]
			end

			local fishIllustratedData = FishingActivityIllustratedData.New(v.Id, pod)

			fishIllustratedData:RefreshUnlock(m.dailyDupPOD.fishingActivityPOD.roleLevel)
			table.insert(m.fishIllustratedDataList, fishIllustratedData)
		end
	end

	m.fishEventDataList = {}

	for i, v in pairsCfg(CfgFishActiveEventControlTable) do
		if v.Group == m.globalCid then
			local isUnlock = m.IsUnlockFishEvent(v.Id)
			local isGetReward = m.IsGetRewardFishEvent(v.Id)
			local fishEventData = FishingActivityEventData.New(v.Id, isUnlock, isGetReward)

			table.insert(m.fishEventDataList, fishEventData)
		end
	end

	m.fishSkillDataList = {}

	for i, v in pairsCfg(CfgFishActiveSkillTable) do
		if v.Group == m.globalCid then
			local lv = 1

			if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.skillLevel then
				lv = m.dailyDupPOD.fishingActivityPOD.skillLevel[v.Id] or 1
			end

			local fishSkillData = FishingActivitySkillData.New(v.Id, lv)

			table.insert(m.fishSkillDataList, fishSkillData)
		end
	end

	m.fishSkillActionDataList = {}

	for i, v in pairsCfg(CfgFishActiveSkillActionTable) do
		if v.Group == m.globalCid then
			local lv = 1

			if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.actionLevel then
				lv = m.dailyDupPOD.fishingActivityPOD.actionLevel[v.Id] or 1
			end

			local fishSkillActionData = FishingActivitySkillActionData.New(v.Id, lv)

			table.insert(m.fishSkillActionDataList, fishSkillActionData)
		end
	end
end

function m.GetSkillActionDataByCid(cid)
	for i, v in pairs(m.fishSkillActionDataList) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetFishingSkillDataByGroup(group)
	for i, v in pairs(m.fishSkillDataList) do
		if v.cid == group then
			return v
		end
	end

	return nil
end

function m.GetPlayerCfgLevelData()
	if m.playerLevelData and m.playerLevelData.Group == m.globalCid and m.playerLevelData.Level == m.dailyDupPOD.fishingActivityPOD.roleLevel then
		return m.playerLevelData
	end

	for i, v in pairsCfg(CfgFishActiveLevelTable) do
		if v.Group == m.globalCid and v.Level == m.dailyDupPOD.fishingActivityPOD.roleLevel then
			m.playerLevelData = v

			break
		end
	end

	return m.playerLevelData
end

function m.GetFishIllustrated(cid)
	for i, v in pairs(m.fishIllustratedDataList) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetFishIllustratedNum()
	local num = 0
	local totalNum = #m.fishIllustratedDataList

	for i, v in pairs(m.fishIllustratedDataList) do
		if v.isUnlock then
			num = num + 1
		end
	end

	return num, totalNum
end

function m.IsGetRewardFishEvent(cid)
	local isGetReward = false

	if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.getStoryList then
		isGetReward = table.indexOf(m.dailyDupPOD.fishingActivityPOD.getStoryList, cid) ~= -1
	end

	return isGetReward
end

function m.GetMaxWeight()
	local maxWeight = 0

	if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.maxWeight then
		for i, v in pairs(m.dailyDupPOD.fishingActivityPOD.maxWeight) do
			if maxWeight < v then
				maxWeight = v
			end
		end
	end

	return maxWeight
end

function m.IsUnlockFishEvent(cid)
	local isUnlock = m.IsGetRewardFishEvent(cid)

	if not isUnlock then
		local preStory = CfgFishActiveEventControlTable[cid].PreStory
		local isUnlockPreStory = true

		if preStory > 0 then
			isUnlockPreStory = m.IsGetRewardFishEvent(preStory)
		end

		local unlockCondition = true
		local UnlockParameter = CfgFishActiveEventControlTable[cid].UnlockParameter

		if UnlockParameter > 0 then
			if CfgFishActiveEventControlTable[cid].Type == 1 then
				local roleLv = m.dailyDupPOD.fishingActivityPOD.roleLevel or 0

				unlockCondition = UnlockParameter <= roleLv
			elseif CfgFishActiveEventControlTable[cid].Type == 2 then
				local fishIllustrated = m.GetFishIllustrated(UnlockParameter)

				if fishIllustrated then
					unlockCondition = fishIllustrated.captureTimes > 0
				else
					unlockCondition = false
				end
			end
		end

		isUnlock = isUnlockPreStory and unlockCondition
	end

	return isUnlock
end

function m.SkillActionIsUnlock(skillActionCid)
	local cfgSkillActionData = CfgFishActiveSkillActionTable[skillActionCid]

	if cfgSkillActionData.IsUnLock then
		for i = 1, #cfgSkillActionData.NeedSkillID, 2 do
			local needSkillActionID = cfgSkillActionData.NeedSkillID[i]
			local needLv = cfgSkillActionData.NeedSkillID[i + 1]
			local skillActionData = m.GetSkillActionDataByCid(needSkillActionID)

			if skillActionData == nil then
				return false
			elseif needLv > skillActionData.lv then
				return false
			end
		end
	end

	return true
end

function m.AddListeners()
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, m.OnCloseDialog)
end

function m.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, m.OnCloseDialog)
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[28]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.CanNotEnter()
	return m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 1
end

function m.IsUnlockAutoAttack()
	local cfgControlData = CfgFishActiveControlTable[m.globalCid]

	if m.dailyDupPOD.fishingActivityPOD and m.dailyDupPOD.fishingActivityPOD.roleLevel >= cfgControlData.AutoLevel then
		return true
	end

	return false
end

function m.GetExploreUIAsset()
	local cfgControlData = CfgFishActiveControlTable[m.globalCid]

	return cfgControlData.ExploreHallUIBG
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.IsShow() and m.globalCid ~= m.dailyDupPOD.common.openCount then
		m.globalCid = m.dailyDupPOD.common.openCount

		m.InitData()
	end
end

function m.UpdateFishEvent()
	for i, v in pairs(m.fishEventDataList) do
		v.isUnlock = m.IsUnlockFishEvent(v.cid)
		v.isGetReward = m.IsGetRewardFishEvent(v.cid)
	end
end

function m.CanGetRewardEvent()
	for i, v in pairs(m.fishEventDataList) do
		if v:CanGetReward() then
			return true
		end
	end

	return false
end

function m.UpdateMaxFishWeight(fishPOD)
	local oldWeight = m.GetMaxWeight()

	if oldWeight < fishPOD.weight then
		m.dailyDupPOD.fishingActivityPOD.maxWeight[fishPOD.fishId] = fishPOD.weight
	end
end

function m.UpdateTotalFishWeight(fishPOD)
	if m.dailyDupPOD.fishingActivityPOD.totalWeight == nil then
		m.dailyDupPOD.fishingActivityPOD.totalWeight = 0
	end

	m.dailyDupPOD.fishingActivityPOD.totalWeight = m.dailyDupPOD.fishingActivityPOD.totalWeight + fishPOD.weight
end

function m.UpdateFishBook(fishPOD)
	if m.dailyDupPOD.fishingActivityPOD.book == nil then
		m.dailyDupPOD.fishingActivityPOD.book = {}
	end

	if m.dailyDupPOD.fishingActivityPOD.book[fishPOD.fishId] == nil then
		m.dailyDupPOD.fishingActivityPOD.book[fishPOD.fishId] = fishPOD
	else
		local oldPOD = m.dailyDupPOD.fishingActivityPOD.book[fishPOD.fishId]

		oldPOD.num = oldPOD.num + fishPOD.num

		if fishPOD.weight > oldPOD.weight then
			oldPOD.weight = fishPOD.weight
		end
	end

	local fishIllustrated = m.GetFishIllustrated(fishPOD.fishId)

	fishIllustrated:Update(m.dailyDupPOD.fishingActivityPOD.book[fishPOD.fishId])
end

function m.OpenFishingActivityStory(eventData)
	local dialogCid = eventData:GetCfgData().Parameter

	if not eventData.isGetReward then
		m.playingDialogCid = dialogCid
		m.playingEventCid = eventData.cid
	end

	DialogModule.OpenDialog(dialogCid, false, false)
end

function m.OnCloseDialog(dialogCid)
	if m.playingDialogCid == dialogCid then
		m.GetStoryRewards()
	end
end

function m.GetFishingActivityTaskDataList(typeParams)
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.FISHING_ACTIVITY_TASK, typeParams)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.FISHING_ACTIVITY_TASK, typeParams)

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

function m.Shutdown()
	m.globalCid = 0
	m.playingDialogCid = 0
	m.playingEventCid = 0
	m.dailyDupPOD = nil
	m.success = false
	m.fishPOD = nil
	m.fishIllustratedDataList = {}
	m.fishSkillActionDataList = {}
	m.fishSkillDataList = {}

	m.RemoveListeners()
end

function m.Fishing()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_fishingActivity.fishing()
end

function m.FishingConfirm(suc)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	m.success = suc

	net_fishingActivity.fishingConfirm(suc)
end

function m.GetAutoFishingRewards()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_fishingActivity.getAutoFishingRewards()
end

function m.UpRole()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_fishingActivity.upRole()
end

function m.UpSkill(cid)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_fishingActivity.upSkill(cid)
end

function m.UpAction(cid)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_fishingActivity.upAction(cid)
end

function m.GetStoryRewards()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.playingEventCid > 0 then
		local isUnlock = m.IsUnlockFishEvent(m.playingEventCid)
		local isGetReward = m.IsGetRewardFishEvent(m.playingEventCid)

		if isUnlock and not isGetReward then
			net_fishingActivity.getStoryRewards(m.playingEventCid)
		else
			m.playingEventCid = 0
		end
	end
end

function m.FishingResult(fish)
	m.fishPOD = fish

	EventDispatcher.Dispatch(EventID.FishingActivityThrowBiteEvent, fish)
end

function m.FishingConfirmResult()
	if m.success then
		m.UpdateMaxFishWeight(m.fishPOD)
		m.UpdateTotalFishWeight(m.fishPOD)
		m.UpdateFishBook(m.fishPOD)
		m.UpdateFishEvent()
		EventDispatcher.Dispatch(EventID.FishingActivityUpdateWeightEvent)
	end

	EventDispatcher.Dispatch(EventID.FishingActivityEndEvent, m.success, m.fishPOD)
end

function m.GetAutoFishingRewardsResult(fishes, autoFishingRewardsTim)
	for i, v in pairs(fishes) do
		m.UpdateMaxFishWeight(v)
		m.UpdateTotalFishWeight(v)
		m.UpdateFishBook(v)
	end

	m.UpdateFishEvent()

	m.dailyDupPOD.fishingActivityPOD.autoFishingRewardsTime = autoFishingRewardsTim

	EventDispatcher.Dispatch(EventID.FishingActivityUpdateWeightEvent)
	UIModule.Open(Constant.UIControllerName.FishingActivityAutoUI, Constant.UILayer.UI, fishes)
end

function m.UpRoleResult(level)
	m.dailyDupPOD.fishingActivityPOD.roleLevel = level

	for i, v in pairs(m.fishIllustratedDataList) do
		v:RefreshUnlock(level)
	end

	m.UpdateFishEvent()
	EventDispatcher.Dispatch(EventID.FishingActivityUpdateEvent)
end

function m.UpSkillResult(id, level)
	m.dailyDupPOD.fishingActivityPOD.skillLevel[id] = level

	for i, v in pairs(m.fishSkillDataList) do
		if v.cid == id then
			v.lv = level
		end
	end

	EventDispatcher.Dispatch(EventID.FishingActivityUpdateEvent)
end

function m.UpActionResult(id, level)
	m.dailyDupPOD.fishingActivityPOD.actionLevel[id] = level

	for i, v in pairs(m.fishSkillActionDataList) do
		if v.cid == id then
			v:SetLv(level)
		end

		v:RefreshUnlock()
	end

	EventDispatcher.Dispatch(EventID.FishingActivityUpdateEvent)
end

function m.GetStoryRewardsResult(itemShows)
	if #itemShows > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end

	if m.playingEventCid > 0 then
		m.dailyDupPOD.fishingActivityPOD.getStoryList = m.dailyDupPOD.fishingActivityPOD.getStoryList or {}

		if table.indexOf(m.dailyDupPOD.fishingActivityPOD.getStoryList, m.playingEventCid) == -1 then
			table.insert(m.dailyDupPOD.fishingActivityPOD.getStoryList, m.playingEventCid)
		end

		m.UpdateFishEvent()

		m.playingEventCid = 0

		EventDispatcher.Dispatch(EventID.FishingActivityUpdateEvent)
	end
end

FishingActivityModule = m
