-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkModule.lua

local m = {
	IsFight = false,
	GlobalCid = 1,
	ParkPlayerAttr = {},
	AmusementParkBossRankData = {},
	AmusementParkEventPlot = {},
	AmusementParkEventMonster = {},
	MoneyIncome = {},
	AmusementParkPlayers = {},
	AmusementParkBuilds = {},
	AmusementParkNpcTab = {},
	ParkGameShowInfoList = {}
}

require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkConstant")

local AmusementParkScene = require("IQIGame.Scene.AmusementPark.AmusementParkScene")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local AmusementParkEventData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkEventData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local AmusementParkPlayerData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkPlayerData")
local AmusementParkBuildData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkBuildData")
local AmusementParkAttrData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkAttrData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD then
		m.GlobalCid = m.DailyDupPOD.common.openCount

		m.InitData()
	end

	m.AddListeners()
	AmusementParkAnswerGameModule.Reload()
	AmusementParkPuzzleGameModule.Reload()
	AmusementParkDollMachineGameModule.Reload()
	AmusementParkBirdGameModule.Reload()
	AmusementParkOneConnectGameModule.Reload()
end

function m.InitData()
	AmusementParkAnswerGameModule.InitData()
	AmusementParkOneConnectGameModule.InitData()

	m.ParkPlayerAttr = {
		AmusementParkConstant.RoleAttr.RoleAttr_Manual,
		AmusementParkConstant.RoleAttr.RoleAttr_Intelligence,
		AmusementParkConstant.RoleAttr.RoleAttr_Affinity
	}
	m.AmusementParkEventMonster = {}
	m.AmusementParkEventPlot = {}

	for i, v in pairsCfg(CfgAmusementParkEventControlTable) do
		if v.Group == m.GlobalCid then
			local parkEventData = AmusementParkEventData.New(v.Id, v.Type)

			if v.Type == AmusementParkConstant.EventType.Event_Fight then
				table.insert(m.AmusementParkEventMonster, parkEventData)
			elseif v.Type == AmusementParkConstant.EventType.Event_Plot then
				table.insert(m.AmusementParkEventPlot, parkEventData)
			end
		end
	end

	table.sort(m.AmusementParkEventMonster, function(a, b)
		return a.cid < b.cid
	end)
	table.sort(m.AmusementParkEventPlot, function(a, b)
		return a.cid < b.cid
	end)

	m.AmusementParkBossRankData = {}

	for i, v in pairsCfg(CfgAmusementParkRankTable) do
		if v.Group == m.GlobalCid then
			table.insert(m.AmusementParkBossRankData, v)
		end
	end

	m.MoneyIncome = {}

	for i, v in pairsCfg(CfgAmusementParkIncomeTable) do
		if v.Group == m.GlobalCid and v.IncomeItem > 0 then
			table.insert(m.MoneyIncome, v)
		end
	end

	table.sort(m.MoneyIncome, function(a, b)
		return a.IncomeItem < b.IncomeItem
	end)

	m.AmusementParkNpcTab = {}

	for i, v in pairsCfg(CfgAmusementParkRoleTable) do
		if v.Group == m.GlobalCid and v.Type ~= AmusementParkConstant.RoleType.Player_Soul then
			m.AmusementParkNpcTab[v.Type] = m.AmusementParkNpcTab[v.Type] or {}

			table.insert(m.AmusementParkNpcTab[v.Type], v)
		end
	end
end

function m.RefreshAmusementParkPlayers()
	m.AmusementParkPlayers = {}

	for i, v in pairs(m.AmusementParkInfoPOD.amusementParkVoRolesHave) do
		local playData = AmusementParkPlayerData.New(v.id, v)

		table.insert(m.AmusementParkPlayers, playData)
	end
end

function m.RefreshAmusementParkBuilds()
	m.AmusementParkBuilds = {}

	for i, v in pairs(m.AmusementParkInfoPOD.unitList) do
		local buildData = AmusementParkBuildData.New(v.unitID, v)

		table.insert(m.AmusementParkBuilds, buildData)
	end
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[25]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0
end

function m.CanNotEnter()
	return m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 1
end

function m.GetExploreUIAsset()
	local cfgAmusementParkControlData = CfgAmusementParkControlTable[m.GlobalCid]

	return cfgAmusementParkControlData.ExploreHallUIBG
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.GlobalCid = m.DailyDupPOD.common.openCount

	if m.IsShow() then
		m.InitData()
	end
end

function m.SetAmusementParkSceneActive(top)
	if m.AmusementParkScene then
		m.AmusementParkScene:SetActive(top)
	end
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.EnterAmusementParkScene()
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.AmusementPark, m.OnSceneLoaded)
end

function m.ExitAmusementParkScene()
	CommonActivitySceneModule.Jump(m.DisposeAmusementParkScene, 10901009)
end

function m.OnSceneLoaded()
	m.AmusementParkScene = AmusementParkScene.New()
end

function m.CheckResumeDialog()
	if m.CurrDialog ~= nil and m.CurrDialog ~= 0 then
		DialogModule.OpenDialog(m.CurrDialog, false, true)

		m.CurrDialog = nil
	end
end

function m.CheckEventRed()
	if m.DailyDupPOD and m.DailyDupPOD.amusementParkPOD then
		for i, v in pairs(m.DailyDupPOD.amusementParkPOD.event) do
			if not v.status then
				return true
			end
		end
	end

	return false
end

function m.GetRankParkAttr()
	local attrs = {}

	for type, v in pairs(m.AmusementParkInfoPOD.amusementParkAttPOD.attr) do
		local attrData = AmusementParkAttrData.New(type, v)

		table.insert(attrs, attrData)
	end

	table.sort(attrs, function(a, b)
		return a:GetCfgData().Tpye < b:GetCfgData().Tpye
	end)

	return attrs
end

function m.GetParkAttrByType(type)
	local attrs = m.GetRankParkAttr()

	for i, v in pairs(attrs) do
		if v.attrType == type then
			return v.attrValue
		end
	end

	return 0
end

function m.GetRandomPathNum()
	local num = 6
	local regionalBoundary = 1

	if m.AmusementParkInfoPOD.amusementParkAttPOD.level < 4 then
		num = 6
		regionalBoundary = 1
	elseif m.AmusementParkInfoPOD.amusementParkAttPOD.level < 5 then
		num = 10
		regionalBoundary = 2
	elseif m.AmusementParkInfoPOD.amusementParkAttPOD.level < 7 then
		num = 14
		regionalBoundary = 3
	elseif m.AmusementParkInfoPOD.amusementParkAttPOD.level < 9 then
		num = 18
		regionalBoundary = 4
	elseif m.AmusementParkInfoPOD.amusementParkAttPOD.level >= 9 then
		num = 24
		regionalBoundary = 5
	end

	return num, regionalBoundary
end

function m.GetBuildCaches()
	local caches = {}

	for i, v in pairs(m.AmusementParkInfoPOD.postList) do
		local landPOD = m.GetParkLandByAreaPos(v)

		if landPOD then
			local cache = {}

			cache.post = landPOD.post
			cache.unit = landPOD.unitID

			table.insert(caches, cache)
		end
	end

	return caches
end

function m.CheckEventPlot()
	local haveNewPlot = false
	local nextPloEvent
	local preStoryCom = false
	local conditionResult = false

	if m.AmusementParkInfoPOD and m.AmusementParkInfoPOD.dialogId == 0 then
		for i = 1, #m.AmusementParkEventPlot do
			local data = m.AmusementParkEventPlot[i]

			if table.indexOf(m.AmusementParkInfoPOD.plot, data.cid) == -1 then
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
		if m.AmusementParkInfoPOD and m.AmusementParkInfoPOD.plot and table.indexOf(m.AmusementParkInfoPOD.plot, preStory) ~= -1 then
			complete = true
		end
	else
		complete = true
	end

	return complete
end

function m.CheckParkAttr(attrType, needValue)
	local attrNum = m.GetParkAttrByType(attrType)

	if attrType == AmusementParkConstant.ParkAttr.ParkAttr_Level then
		attrNum = m.AmusementParkInfoPOD.amusementParkAttPOD.level
	elseif attrType == AmusementParkConstant.ParkAttr.ParkAttr_PlayerNum then
		attrNum = #m.AmusementParkInfoPOD.amusementParkVoRolesHave
	end

	local result = needValue <= attrNum

	return result, attrNum
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

function m.GetParkLandByAreaPos(pos)
	for i, v in pairs(m.AmusementParkInfoPOD.unitList) do
		if v.post == pos then
			return v
		end
	end

	return nil
end

function m.GetMonsterEventData(cid)
	for i, v in pairs(m.AmusementParkEventMonster) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetAmusementParkBuildData(buildingId)
	for i, v in pairs(m.AmusementParkBuilds) do
		if v.cid == buildingId then
			return v
		end
	end

	return nil
end

function m.GetPlotEventData(cid)
	for i, v in pairs(m.AmusementParkEventPlot) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.ChallengeBossIsPass(groupID, bossID)
	local max = 0

	if m.AmusementParkInfoPOD and m.AmusementParkInfoPOD.boss then
		max = m.AmusementParkInfoPOD.boss[groupID]
		max = max or 0
	end

	return bossID <= max
end

function m.CanGetReceiveIncome()
	local result = false
	local count = 0
	local upperLimit = 0
	local cfgAmusementParkControlData = CfgAmusementParkControlTable[m.GlobalCid]

	upperLimit = cfgAmusementParkControlData.MaxTimes

	if m.DailyDupPOD and m.DailyDupPOD.amusementParkPOD then
		count = m.DailyDupPOD.amusementParkPOD.numberOfReturns
		count = count or 0
		result = count >= cfgAmusementParkControlData.MainUiGetButton
	end

	return result, count, upperLimit
end

function m.GetParkPlayerData(cid)
	for i, v in pairs(m.AmusementParkPlayers) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetAmusementParkTaskDataList(typeParams)
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.AMUSEMENT_PARK_TASK, typeParams)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.AMUSEMENT_PARK_TASK, typeParams)

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

function m.OpenBuildFunction(buildData)
	local cfgFunctionData = buildData:GetBuildFunctionData()

	if cfgFunctionData then
		if cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Player then
			UIModule.Open(Constant.UIControllerName.AmusementParkPlayerUI, Constant.UILayer.UI, {
				Index = 2,
				SelectBuild = buildData.cid
			})
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Challenge then
			UIModule.Open(Constant.UIControllerName.AmusementParkChallengeUI, Constant.UILayer.UI)
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_ExBoss then
			if not AmusementParkModule.DailyDupPOD.amusementParkPOD.exBossIsLock then
				NoticeModule.ShowNotice(21045090)

				return
			end

			UIModule.Open(Constant.UIControllerName.AmusementParkBossUI, Constant.UILayer.UI)
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_DollMachine then
			AmusementParkDollMachineGameModule.StartDollMachineGame()
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_FlyBird then
			AmusementParkBirdGameModule.StartBirdGame()
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_OneStroke then
			AmusementParkOneConnectGameModule.StartOneConnectGame()
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_StackedBlocks then
			AmusementParkPuzzleGameModule.StartPuzzleGame()
		elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Answer then
			AmusementParkAnswerGameModule.StartAnswerGame()
		end
	end
end

function m.DisposeAmusementParkScene()
	if m.AmusementParkScene then
		m.AmusementParkScene:Dispose()
	end

	m.AmusementParkScene = nil
end

function m.Shutdown()
	AmusementParkAnswerGameModule.Shutdown()
	AmusementParkPuzzleGameModule.Shutdown()
	AmusementParkDollMachineGameModule.Shutdown()
	AmusementParkBirdGameModule.Shutdown()
	AmusementParkOneConnectGameModule.Shutdown()

	m.IsFight = false
	m.CurrDialog = nil
	m.GlobalCid = 0
	m.DailyDupPOD = nil
	m.AmusementParkPlayers = {}
	m.AmusementParkNpcTab = {}

	m.RemoveListeners()
	m.DisposeAmusementParkScene()
end

function m.GetAmusementParkInfo()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.getAmusementParkInfo()
end

function m.GetAmusementParkInfoTemporarily()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.getAmusementParkInfoTemporarily()
end

function m.Build(post, buildingId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.build(post, buildingId)
end

function m.ChangeLayout(dragBuildAreaPos, targetBuildAreaPos, dragBuildID, targetBuildID)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	for i, v in pairs(m.AmusementParkInfoPOD.unitList) do
		if v.unitID == dragBuildID then
			v.post = targetBuildAreaPos
		end

		if v.unitID == targetBuildID then
			v.post = dragBuildAreaPos
		end
	end

	m.RefreshAmusementParkBuilds()

	local caches = m.GetBuildCaches()

	net_amusementPark.changeLayout(caches)
end

function m.ConfirmChanges()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	local caches = m.GetBuildCaches()

	net_amusementPark.confirmChanges(caches)
end

function m.ParkLevelUp(post)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.parkLevelUp(post)
end

function m.RandomActionFigure()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.randomActionFigure()
end

function m.Recruit(id)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.recruit(id)
end

function m.RoleLevelUp(id)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.roleLevelUp(id)
end

function m.RoleDeploy(bId, rId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.roleDeploy(bId, rId)
end

function m.RoleUnDeploy(bId, rId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.roleUnDeploy(bId, rId)
end

function m.OpenDialog(eventId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.openDialog(eventId)
end

function m.ReceiveIncome()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.receiveIncome()
end

function m.CombatTraining(bossId, formationId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.IsFight then
		return
	end

	m.IsFight = true

	net_amusementPark.combatTraining(bossId, formationId)
end

function m.BossTraining(formationId)
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.IsFight then
		return
	end

	m.IsFight = true

	net_amusementPark.bossTraining(formationId)
end

function m.ReadBurst()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.readBurst()
end

function m.GetLittleGameInfo()
	if m.CanNotEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_amusementPark.getLittleGameInfo()
end

function m.GetAmusementParkInfoResult(amusementParkInfoPOD)
	m.AmusementParkInfoPOD = amusementParkInfoPOD
	m.CurrDialog = m.AmusementParkInfoPOD.dialogId

	m.RefreshAmusementParkPlayers()
	m.RefreshAmusementParkBuilds()
	m.EnterAmusementParkScene()
end

function m.GetAmusementParkInfoTemporarilyResult(unitList)
	m.AmusementParkInfoPOD.unitList = unitList

	m.RefreshAmusementParkBuilds()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
	UIModule.Close(Constant.UIControllerName.AmusementParkMainEditUI)
end

function m.BuildResult(id)
	EventDispatcher.Dispatch(EventID.APBuildEffect, id)
end

function m.ChangeLayoutResult(amusementParkAttPOD)
	m.AmusementParkInfoPOD.amusementParkAttPOD = amusementParkAttPOD

	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.ConfirmChangesResult(amusementParkAttPOD, unitList)
	m.AmusementParkInfoPOD.amusementParkAttPOD = amusementParkAttPOD
	m.AmusementParkInfoPOD.unitList = unitList

	m.RefreshAmusementParkBuilds()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.ParkLevelUpResult(id)
	EventDispatcher.Dispatch(EventID.APBuildLevelUpEffect, id)
end

function m.RandomActionFigureResult(amusementParkVoRolePODs)
	m.AmusementParkInfoPOD.amusementParkVoRoles = amusementParkVoRolePODs

	EventDispatcher.Dispatch(EventID.APUpdateRandomSoulEvent)
end

function m.RecruitResult(amusementParkVoRoles, amusementParkVoRolesHave)
	m.AmusementParkInfoPOD.amusementParkVoRoles = amusementParkVoRoles
	m.AmusementParkInfoPOD.amusementParkVoRolesHave = amusementParkVoRolesHave

	m.RefreshAmusementParkPlayers()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.RoleLevelUpResult(amusementParkVoRolePOD)
	for i, v in pairs(m.AmusementParkInfoPOD.amusementParkVoRolesHave) do
		if v.id == amusementParkVoRolePOD.id then
			m.AmusementParkInfoPOD.amusementParkVoRolesHave[i] = amusementParkVoRolePOD
		end
	end

	m.RefreshAmusementParkPlayers()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.RoleDeployResult(amusementParkVoRolePOD)
	for i, v in pairs(m.AmusementParkInfoPOD.amusementParkVoRolesHave) do
		if v.id == amusementParkVoRolePOD.id then
			m.AmusementParkInfoPOD.amusementParkVoRolesHave[i] = amusementParkVoRolePOD
		end
	end

	m.RefreshAmusementParkPlayers()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.RoleUnDeployResult(amusementParkVoRolePOD)
	for i, v in pairs(m.AmusementParkInfoPOD.amusementParkVoRolesHave) do
		if v.id == amusementParkVoRolePOD.id then
			m.AmusementParkInfoPOD.amusementParkVoRolesHave[i] = amusementParkVoRolePOD
		end
	end

	m.RefreshAmusementParkPlayers()
	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.OpenDialogResult(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function m.SelectDialogResult(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		EventDispatcher.Dispatch(EventID.APPlotEndEvent)
	end
end

function m.ReceiveIncomeResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	m.DailyDupPOD.amusementParkPOD.numberOfReturns = 0

	EventDispatcher.Dispatch(EventID.APReceiveIncomeEvent)
end

function m.CombatTrainingResult()
	return
end

function m.BossTrainingResult()
	return
end

function m.ReadBurstResult()
	for i, v in pairs(m.DailyDupPOD.amusementParkPOD.event) do
		v.status = true
	end

	EventDispatcher.Dispatch(EventID.APUpdateEvent)
end

function m.GetLittleGameInfoResult(info)
	m.ParkGameShowInfoList = info

	EventDispatcher.Dispatch(EventID.APUpdateParkGameShowInfoEvent)
end

function m.NotifyAmusementParkInfo(amusementParkLandPODs, post)
	m.AmusementParkInfoPOD.unitList = amusementParkLandPODs
	m.AmusementParkInfoPOD.postList = post

	m.RefreshAmusementParkBuilds()

	for i, v in pairs(amusementParkLandPODs) do
		if CfgAmusementParkControlTable[m.GlobalCid].ExBuildingId == v.unitID then
			m.DailyDupPOD.amusementParkPOD.exBossIsLock = true
		end
	end
end

function m.NotifyAmusementParkInfoPOD(amusementParkAttPOD)
	m.AmusementParkInfoPOD.amusementParkAttPOD = amusementParkAttPOD

	EventDispatcher.Dispatch(EventID.APUpdateInfoEvent)
end

function m.NotifyEventIsFinish(eventId)
	if m.AmusementParkInfoPOD and table.indexOf(m.AmusementParkInfoPOD.plot, eventId) == -1 then
		table.insert(m.AmusementParkInfoPOD.plot, eventId)
	end

	EventDispatcher.Dispatch(EventID.APPlotEndEvent)
end

function m.NotifyReceiveIncome(number)
	if GameEntry.Base.DevMode then
		log("可领取的收益总次数 " .. number)
	end

	if m.DailyDupPOD and m.DailyDupPOD.amusementParkPOD then
		m.DailyDupPOD.amusementParkPOD.numberOfReturns = number
	end

	EventDispatcher.Dispatch(EventID.APReceiveIncomeEvent)
end

function m.NotifyEmergency(list)
	if GameEntry.Base.DevMode then
		log("收到通知更新事件")
	end

	m.DailyDupPOD.amusementParkPOD.event = list

	EventDispatcher.Dispatch(EventID.APUpdateEvent)
end

function m.NotifyBossTraining(win, cid, dmgRecords)
	m.IsFight = false

	AmusementParkBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, {}, nil, dmgRecords)

	rewardData.battleType = 4

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	m.IsFight = false

	AmusementParkBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	rewardData.battleType = 4

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	m.AmusementParkInfoPOD.boss = monster

	for i, v in pairs(m.AmusementParkEventMonster) do
		for j, k in pairs(v.monsters) do
			local pass = m.ChallengeBossIsPass(k:GetCfgData().GroupNum, k.cid)

			k.isPass = pass
		end
	end

	EventDispatcher.Dispatch(EventID.APUpdateChallengeEvent)
end

function m.NotifyItemGMAdd(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

AmusementParkModule = m
