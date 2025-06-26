-- chunkname: @IQIGame\\Module\\Guild\\GuildModule.lua

local m = {
	guildTaskPoints = 0,
	isInGuildScene = false,
	status = false,
	vicePresidentMaxNum = 2,
	myApplyList = {},
	recommendGuildList = {},
	guildCallBack = Queue.New(),
	auditList = {},
	guildBaseList = {}
}
local GuildScene = require("IQIGame.Scene.Guild.GuildScene")
local GuildAreaData = require("IQIGame.Module.Guild.GuildAreaData")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local GuildHeadIconData = require("IQIGame.Module.Guild.GuildHeadIconData")
local GuildAvatarFrameData = require("IQIGame.Module.Guild.GuildAvatarFrameData")
local GuildMissData = require("IQIGame.Module.Guild.GuildMissData")

function m.Reload()
	m.AddListener()

	m.guildCallBack = Queue.New()

	m.GetMyApplyList()
end

function m.AddListener()
	return
end

function m.RemoveListener()
	return
end

function m.CheckIsApply(guidId)
	if m.myApplyList then
		for i, v in pairs(m.myApplyList) do
			if v.id == guidId then
				return true
			end
		end
	end

	return false
end

function m.RefreshArea()
	if m.guildAreaDic == nil then
		m.guildAreaDic = {}

		for i, v in pairsCfg(CfgGuildAreaTable) do
			local guildAreaData = GuildAreaData.New(v.Id, v.IsUnlocked > 0)

			table.insert(m.guildAreaDic, guildAreaData)
		end
	end
end

function m.EnterGuildScene()
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.Guild, m.OnSceneLoaded)
end

function m.OnSceneLoaded()
	m.guildScene = GuildScene.New()

	UIModule.Open(Constant.UIControllerName.GuildMainUI, Constant.UILayer.UI)

	m.timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.GuildMission, function()
		m.GetQuestProgress()
	end, 60, -1)

	m.GetQuestProgress()
	m.timer:Start()
	m.RefreshGuildMiss()
end

function m.ExitGuildScene()
	CommonActivitySceneModule.SwitchScene(m.DisposeGuildScene)
end

function m.GetSceneAreaPoint(cfgID)
	if m.guildScene then
		local v3 = m.guildScene:GetAreaPos(CfgGuildAreaTable[cfgID].PosIndex)

		return v3
	end

	return Vector3.New(0, 0, 0)
end

function m.GetMySelfGuildMemberData()
	if m.guildPOD and m.guildPOD.members then
		for i, v in pairs(m.guildPOD.members) do
			if v.player and v.player.pid == PlayerModule.PlayerInfo.baseInfo.pid then
				return v
			end
		end
	end

	return nil
end

function m.GetGuildDefaultHeadIcon()
	if m.DefaultHeadIcon == nil then
		for i, v in pairsCfg(CfgGuildHeadIconTable) do
			if v.Default then
				m.DefaultHeadIcon = v.Id

				break
			end
		end
	end

	return m.DefaultHeadIcon
end

function m.UpdateBuilding(building)
	if m.guildPOD then
		local isNew = true

		for i, v in pairs(m.guildPOD.buildings) do
			if v.cid == building.cid then
				isNew = false
				m.guildPOD.buildings[i] = building
			end
		end

		if isNew then
			table.insert(m.guildPOD.buildings, building)
		end
	end
end

function m.RefreshGuildDefaultData()
	if m.guildPOD then
		if m.guildPOD.base.headIcon == 0 then
			m.guildPOD.base.headIcon = m.GetGuildDefaultHeadIcon()
		end

		if m.guildPOD.base.avatarFrame == 0 then
			m.guildPOD.base.avatarFrame = m.GetGuildDefaultAvatarFrame()
		end
	end
end

function m.GetGuildDefaultAvatarFrame()
	if m.DefaultAvatarFrame == nil then
		for i, v in pairsCfg(CfgGuildAvatarFrameTable) do
			if v.Default then
				m.DefaultAvatarFrame = v.Id

				break
			end
		end
	end

	return m.DefaultAvatarFrame
end

function m.GetMembersCountByPosition(position)
	local num = 0

	if m.guildPOD.members then
		for i, v in pairs(m.guildPOD.members) do
			if v.position == position then
				num = num + 1
			end
		end
	end

	return num
end

function m.GetUnlockGuildHeadIcons()
	local tab = {}

	for i, v in pairsCfg(CfgGuildHeadIconTable) do
		local headIconData = GuildHeadIconData.New(v.Id)

		if headIconData.unLock == 1 then
			table.insert(tab, headIconData)
		elseif v.IsLockShow then
			table.insert(tab, headIconData)
		end
	end

	table.sort(tab, function(a, b)
		if a.unLock == b.unLock then
			return a.cfgInfo.Sort < b.cfgInfo.Sort
		end

		return a.unLock > b.unLock
	end)

	return tab
end

function m.GetUnlockGuildFrames()
	local tab = {}

	for i, v in pairsCfg(CfgGuildAvatarFrameTable) do
		local headFrameData = GuildAvatarFrameData.New(v.Id)

		if headFrameData.unLock == 1 then
			table.insert(tab, headFrameData)
		elseif v.IsLockShow then
			table.insert(tab, headFrameData)
		end
	end

	table.sort(tab, function(a, b)
		if a.unLock == b.unLock then
			return a.cfgInfo.Sort < b.cfgInfo.Sort
		end

		return a.unLock > b.unLock
	end)

	return tab
end

function m.GetBuildingData(buildID)
	if m.guildPOD then
		for i, v in pairs(m.guildPOD.buildings) do
			if v.cid == buildID then
				return v
			end
		end
	end

	return nil
end

function m.GetBuildingLevel(buildID)
	local buildLv = 1
	local buildMaxLv = 1

	if m.guildPOD then
		for i, v in pairs(m.guildPOD.buildings) do
			if v.cid == buildID then
				buildLv = v.lv

				break
			end
		end
	end

	for i, v in pairsCfg(CfgGuildBuildingLevelUpTable) do
		if v.BuildingId == buildID and buildMaxLv < v.Level then
			buildMaxLv = v.Level
		end
	end

	return buildLv, buildMaxLv
end

function m.GetBuildingLevelData(buildID, level)
	for i, v in pairsCfg(CfgGuildBuildingLevelUpTable) do
		if v.BuildingId == buildID and v.Level == level then
			return v
		end
	end

	return nil
end

function m.RefreshGuildMiss()
	local point = 0

	if m.guildMissionDataList == nil then
		m.guildMissionDataList = {}

		for i, v in pairsCfg(CfgGuildMissionTable) do
			if m.guildMissionDataList[v.Group] == nil then
				m.guildMissionDataList[v.Group] = {}
			end

			local data = GuildMissData.New(v.Id, 0, v.TargetNum, TaskModule.TaskStatus.CURRENT_TASK)

			table.insert(m.guildMissionDataList[v.Group], data)
		end

		for i, v in pairs(m.guildMissionDataList) do
			table.sort(v, function(a, b)
				return a.CfgInfo.DisplayOrder < b.CfgInfo.DisplayOrder
			end)
		end
	end

	local isChangeState = false

	for groupID, missionTab in pairs(m.guildMissionDataList) do
		for k, v in pairs(missionTab) do
			local targetType = v.CfgInfo.TargetType
			local newCurrentNum = m.guildPOD.questProgress[targetType]

			newCurrentNum = newCurrentNum == nil and 0 or newCurrentNum

			if not isChangeState and v.CurrentNum < v.TargetNum and newCurrentNum >= v.TargetNum then
				isChangeState = true
			end

			if v.CurrentNum >= v.TargetNum then
				point = point + v.CfgInfo.CompletePoint
			end

			local status = TaskModule.TaskStatus.CURRENT_TASK

			if PlayerModule.PlayerInfo.guildQuestGetRecord then
				if table.indexOf(PlayerModule.PlayerInfo.guildQuestGetRecord, v.Cid) ~= -1 then
					status = TaskModule.TaskStatus.FINISH_TASK
				elseif newCurrentNum >= v.CurrentNum and newCurrentNum > 0 and newCurrentNum >= v.TargetNum then
					status = 2
				end
			end

			if not isChangeState and v.TaskStatus ~= status then
				isChangeState = true
			end

			missionTab[k]:RefreshData(newCurrentNum, status)
		end
	end

	if m.guildTaskPoints ~= point then
		m.guildTaskPoints = point
		isChangeState = true
	end

	if isChangeState then
		EventDispatcher.Dispatch(EventID.GuildUpdateMissionEvent)
	end
end

function m.GetGuildTaskDataList(typeParams)
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.GUILD_TASK, typeParams)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.GUILD_TASK, typeParams)

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

function m.GetGuildTaskRedPoint()
	for groupID, dataList in pairs(m.guildMissionDataList) do
		for i, v in pairs(dataList) do
			if v.TaskStatus == 2 then
				return true
			end
		end
	end

	local dailyTaskDataList = m.GetGuildTaskDataList({
		1
	})

	for i, v in pairs(dailyTaskDataList) do
		if v.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end

function m.OpenGuild()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.GUILD) then
		return
	end

	if PlayerModule.PlayerInfo.guildId == 0 then
		UIModule.Open(Constant.UIControllerName.GuildIntroduceUI, Constant.UILayer.UI)
	else
		GuildModule.EnterGuild()
	end
end

function m.OnTouchArea(cid)
	local cfgData = CfgGuildAreaTable[cid]

	if cfgData.FunctionType == Constant.GuildFunctionType.Guild_Members then
		m.GetMemberList(function()
			UIModule.Open(Constant.UIControllerName.GuildMemberUI, Constant.UILayer.UI)
		end)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Build then
		UIModule.Open(Constant.UIControllerName.GuildDevelopUI, Constant.UILayer.UI)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Offer_A_Reward then
		GuildChallengeModule.GetScore(function()
			UIModule.Open(Constant.UIControllerName.GuildChallengeDetailInfoUI, Constant.UILayer.UI)
		end)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Task then
		UIModule.Open(Constant.UIControllerName.GuildMissionUI, Constant.UILayer.UI)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Shop then
		MallModule.OpenActivityMall(Constant.Mall_EntranceType.Guild)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Sign then
		if not PlayerModule.PlayerInfo.isGuildSign then
			m.Sign()
		end
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Board then
		UIModule.Open(Constant.UIControllerName.GuildMessageBoardUI, Constant.UILayer.UI)
	elseif cfgData.FunctionType == Constant.GuildFunctionType.Guild_Trial then
		if not GuildTrainingModule.IsOpen() then
			log("活动未开启")

			return
		end

		UIModule.Open(Constant.UIControllerName.GuildTrainingDetailInfoUI, Constant.UILayer.UI, {
			Area = cid
		})
	end
end

function m.CheckQuiteScene()
	if PlayerModule.PlayerInfo.guildId == 0 and m.isInGuildScene and not GuildChallengeModule.isFight then
		m.ExitGuild()
	end
end

function m.DisposeGuildScene()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.GuildMission)

	if m.guildScene then
		m.guildScene:Dispose()
	end

	m.guildScene = nil
end

function m.Shutdown()
	m.guildPOD = nil
	m.guildAreaDic = nil
	m.myApplyList = {}
	m.recommendGuildList = {}

	m.guildCallBack:Clear()

	m.auditList = {}
	m.guildBaseList = {}

	m.RemoveListener()
	CommonActivitySceneModule.Shutdown()
	m.DisposeGuildScene()

	m.isInGuildScene = false
end

function m.CreateGuild(name)
	SDKLoginModule.checkDirtyWords(name, function(contain, replaceContent)
		if contain then
			NoticeModule.ShowNotice(21066302)

			return
		end

		net_centerGuild.createGuild(name)
	end)
end

function m.EnterGuild()
	net_centerGuild.enterGuild()
end

function m.ExitGuild()
	net_centerGuild.exitGuild()
end

function m.GetRecommendGuildList()
	net_centerGuild.getRecommendGuildList()
end

function m.ApplyGuild(id)
	if PlayerModule.PlayerInfo.guildId ~= 0 then
		return
	end

	net_centerGuild.applyGuild(id)
end

function m.GetMyApplyList()
	if PlayerModule.PlayerInfo.guildId ~= 0 then
		return
	end

	net_centerGuild.getMyApplyList()
end

function m.CancelApplyGuild(id)
	net_centerGuild.cancelApplyGuild(id)
end

function m.GetAuditList()
	net_centerGuild.getAuditList()
end

function m.RefuseApply(pids)
	net_centerGuild.refuseApply(pids)
end

function m.AcceptApply(pid)
	if m.guildPOD.base.memberNum >= m.guildPOD.base.memberMaxNum then
		NoticeModule.ShowNotice(21066606)

		return
	end

	net_centerGuild.acceptApply(pid)
end

function m.GetMemberList(callBack)
	if callBack then
		m.guildCallBack:Enqueue(callBack)
	end

	net_centerGuild.getMemberList()
end

function m.AppointPosition(pid, position)
	net_centerGuild.appointPosition(pid, position)
end

function m.RemoveMember(pid)
	net_centerGuild.removeMember(pid)
end

function m.Impeachment()
	net_centerGuild.impeachment()
end

function m.CancelImpeachment()
	net_centerGuild.cancelImpeachment()
end

function m.Quit()
	net_centerGuild.quit()
end

function m.EditInfo(headIcon, avatarFrame, policy, auditType)
	net_centerGuild.editInfo(headIcon, avatarFrame, policy, auditType)
end

function m.ChangeName(name)
	SDKLoginModule.checkDirtyWords(name, function(contain, replaceContent)
		if contain then
			NoticeModule.ShowNotice(21066302)

			return
		end

		net_centerGuild.changeName(name)
	end)
end

function m.SearchGuild(txt, callBack)
	if callBack ~= nil then
		m.guildCallBack:Enqueue(callBack)
	end

	net_centerGuild.searchGuild(txt)
end

function m.UpBuildingLevel(buildingId)
	net_centerGuild.upBuildingLevel(buildingId)
end

function m.BuyBuildingEffect(buildingId)
	net_centerGuild.buyBuildingEffect(buildingId)
end

function m.Sign()
	net_guild.sign()
end

function m.GetGuildQuestRewards(ids)
	net_guild.getGuildQuestRewards(ids)
end

function m.GetQuestProgress()
	net_centerGuild.getQuestProgress()
end

function m.RefreshRedPoint()
	net_guild.refreshRedPoint()
end

function m.EditNotice(notice)
	SDKLoginModule.checkDirtyWords(notice, function(contain, replaceContent)
		if contain then
			NoticeModule.ShowNotice(21066713)
		end

		net_centerGuild.editNotice(notice)
	end)
end

function m.CreateGuildResult()
	m.EnterGuild()
end

function m.EnterGuildResult(guildPOD)
	m.guildPOD = guildPOD

	if PlayerModule.PlayerInfo.guildId == 0 then
		m.NotifyJoinGuild(guildPOD.base.id, guildPOD.base.name)
	end

	m.RefreshArea()
	m.RefreshGuildDefaultData()
	m.EnterGuildScene()
	m.RefreshGuildMiss()
	GuildChallengeModule.GetScore()

	m.isInGuildScene = true
end

function m.ExitGuildResult()
	UIModule.Close(Constant.UIControllerName.GuildMainUI)
	m.ExitGuildScene()

	m.isInGuildScene = false
end

function m.GetRecommendGuildListResult(guildBaseList)
	m.recommendGuildList = guildBaseList

	EventDispatcher.Dispatch(EventID.GuildUpdateRecommendGuildListEvent)
end

function m.ApplyGuildResult()
	m.GetMyApplyList()

	if PlayerModule.PlayerInfo.guildId ~= 0 then
		m.EnterGuild()
	end
end

function m.GetMyApplyListResult(guildBaseList)
	m.myApplyList = guildBaseList

	for i, v in ipairs(m.guildBaseList) do
		local isHave = false

		for k, v1 in pairs(m.myApplyList) do
			if v.guildId == v1.guildId then
				m.guildBaseList[i] = v1
			end
		end
	end

	EventDispatcher.Dispatch(EventID.GuildApplyListEvent)
end

function m.CancelApplyGuildResult(guildId)
	local pos = -1

	for i = 1, #m.myApplyList do
		local data = m.myApplyList[i]

		if data.id == guildId then
			pos = i

			break
		end
	end

	if pos ~= -1 then
		table.remove(m.myApplyList, pos)
	end

	EventDispatcher.Dispatch(EventID.GuildApplyListEvent)
end

function m.GetAuditListResult(auditList)
	m.auditList = auditList

	EventDispatcher.Dispatch(EventID.GuildUpdateAuditList)
end

function m.RefuseApplyResult(pids)
	m.GetAuditList()
end

function m.AcceptApplyResult(pid)
	m.GetAuditList()
	m.GetMemberList()
end

function m.GetMemberListResult(members)
	m.guildPOD.members = members
	m.guildPOD.newAuditCount = 0

	GuildTrainingModule.Refresh()
	EventDispatcher.Dispatch(EventID.GuildUpdateMembersEvent)
	EventDispatcher.Dispatch(EventID.GuildUpdateRedPointEvent)

	if m.guildCallBack.Size > 0 then
		local callBack = m.guildCallBack:Dequeue()

		callBack()
	end
end

function m.AppointPositionResult()
	m.GetMemberList()
end

function m.RemoveMemberResult()
	m.GetMemberList()
end

function m.ImpeachmentResult()
	return
end

function m.CancelImpeachmentResult()
	return
end

function m.QuitResult()
	m.ExitGuildScene()

	m.guildPOD = nil
	m.guildAreaDic = nil
	m.myApplyList = {}
	m.recommendGuildList = {}

	m.guildCallBack:Clear()

	m.auditList = {}

	CommonActivitySceneModule.Shutdown()
	m.DisposeGuildScene()

	PlayerModule.PlayerInfo.guildId = 0
	PlayerModule.PlayerInfo.guildName = nil

	GuildTrainingModule.ResetIntegral()
end

function m.EditInfoResult()
	return
end

function m.ChangeNameResult()
	return
end

function m.SearchGuildResult(guildBaseList)
	m.guildBaseList = guildBaseList

	if m.guildCallBack.Size > 0 then
		local callBack = m.guildCallBack:Dequeue()

		callBack(guildBaseList)
	end
end

function m.UpBuildingLevelResult(building)
	NoticeModule.ShowNotice(21066501)
	m.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.GuildUpdateBuildingEvent)
end

function m.BuyBuildingEffectResult(building)
	m.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.GuildUpdateBuildingEvent)
end

function m.SignResult(itemShows)
	if #itemShows > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end

	PlayerModule.PlayerInfo.isGuildSign = true

	EventDispatcher.Dispatch(EventID.UpdateDailySupply)
end

function m.GetGuildQuestRewardsResult(ids, items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	if PlayerModule.PlayerInfo.guildQuestGetRecord == nil then
		PlayerModule.PlayerInfo.guildQuestGetRecord = {}
	end

	for i, v in pairs(ids) do
		if table.indexOf(PlayerModule.PlayerInfo.guildQuestGetRecord, v) == -1 then
			table.insert(PlayerModule.PlayerInfo.guildQuestGetRecord, v)
		end

		m.guildTaskPoints = m.guildTaskPoints + CfgGuildMissionTable[v].CompletePoint
	end

	m.RefreshGuildMiss()
	EventDispatcher.Dispatch(EventID.UpdateDailySupply)
end

function m.GetQuestProgressResult(progress)
	m.guildPOD.questProgress = progress

	m.RefreshGuildMiss()
end

function m.RefreshRedPointResult(status)
	m.status = status

	EventDispatcher.Dispatch(EventID.GuildUpdateMainCityRedPointEvent)
end

function m.EditNoticeResult(notice)
	m.guildPOD.notice = notice

	EventDispatcher.Dispatch(EventID.GuildUpdateNoticeEvent)
end

function m.NotifyJoinGuild(guildId, guildName)
	PlayerModule.PlayerInfo.guildId = guildId
	PlayerModule.PlayerInfo.guildName = guildName

	EventDispatcher.Dispatch(EventID.GuildUpdatePlayerEvent)
end

function m.NotifyQuitGuild()
	PlayerModule.PlayerInfo.guildId = 0
	PlayerModule.PlayerInfo.guildName = nil

	GuildTrainingModule.ResetIntegral()
	EventDispatcher.Dispatch(EventID.GuildUpdatePlayerEvent)
	m.CheckQuiteScene()
end

function m.NotifyUpdateGuildBase(basePOD)
	if m.guildPOD then
		m.guildPOD.base = basePOD

		m.RefreshGuildDefaultData()
	end

	EventDispatcher.Dispatch(EventID.GuildUpdateEvent)
end

function m.NotifyUpdateGuild(pod)
	m.guildPOD = pod

	m.RefreshGuildDefaultData()
	EventDispatcher.Dispatch(EventID.GuildUpdateEvent)
end

function m.NotifyUpdateGuildFund(fund, fundDailyGetRecord)
	m.guildPOD.fund = fund
	m.guildPOD.fundDailyGetRecord = fundDailyGetRecord

	EventDispatcher.Dispatch(EventID.GuildUpdateEvent)
end

function m.NotifyNewAudit(newAuditCount)
	m.guildPOD.newAuditCount = newAuditCount

	EventDispatcher.Dispatch(EventID.GuildUpdateRedPointEvent)
end

GuildModule = m
