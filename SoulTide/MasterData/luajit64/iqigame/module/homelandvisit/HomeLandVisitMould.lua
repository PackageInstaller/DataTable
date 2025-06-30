-- chunkname: @IQIGame\\Module\\HomeLandVisit\\HomeLandVisitMould.lua

HomeLandVisitMould = {
	lastGetBoxTime = 0,
	createTreasureChest = {}
}

function HomeLandVisitMould.CheckShowHelpBtnCondition(decorateCid)
	local value = CfgDiscreteDataTable[6520014].Data[1]
	local todayHelpCount = value > PlayerModule.PlayerInfo.todayHelpHomeCount
	local isGetMaxCount = false
	local isCanDayCount = false
	local isWorking = false

	if decorateCid then
		local cfgDecorate = CfgHomeLandDecorateTable[decorateCid]
		local cfgBuilding = CfgHomeLandBuildingTable[cfgDecorate.FunctionBuilding]
		local buildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuilding.Id)
		local buildingNum = 0

		if buildingData and buildingData.buildingPOD then
			buildingNum = #buildingData.buildingPOD.helpLogs
		end

		local maxNum = cfgBuilding.CanHelpTimes[1]

		if maxNum ~= nil then
			isGetMaxCount = buildingNum < maxNum
		end

		local doNum = 0

		for k, v in pairs(PlayerModule.PlayerInfo.todayHelpBuildingCount) do
			if buildingData and buildingData.buildingPOD and k == buildingData.buildingPOD.id then
				doNum = doNum + v
			end
		end

		local dayNum = cfgBuilding.CanHelpTimes[2]

		if dayNum ~= nil then
			isCanDayCount = doNum < dayNum
		end

		if buildingData then
			isWorking = buildingData:IsWorking(decorateCid)
		end
	end

	if todayHelpCount and isGetMaxCount and isCanDayCount and isWorking then
		return true
	end

	return false
end

function HomeLandVisitMould.ReloadTreasureChest(visitTreasureChest)
	HomeLandVisitMould.createTreasureChest = {}
	HomeLandVisitMould.visitTreasureChest = visitTreasureChest

	if HomeLandVisitMould.timer == nil then
		HomeLandVisitMould.timer = Timer.New(function()
			HomeLandVisitMould.TimerUpdate()
		end, 1, -1)
	end

	HomeLandVisitMould.timer:Start()
	GameEntry.LuaEvent:Subscribe(HomelandCollarChestEventArgs.EventId, HomeLandVisitMould.OnCollarChest)
end

function HomeLandVisitMould.OnCollarChest(sender, args)
	local maxNum = CfgDiscreteDataTable[6520015].Data[1]
	local todayOpenVisitTreasure = maxNum - PlayerModule.PlayerInfo.todayOpenVisitTreasureChest

	if todayOpenVisitTreasure <= 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HomeLandVisitUIApi:GetString("OpenTreasureChestErrorMsg"))

		return
	end

	local now = PlayerModule.GetServerTime()

	if now - HomeLandVisitMould.lastGetBoxTime < 3 then
		return
	end

	HomeLandVisitMould.lastGetBoxTime = now

	local treasureBoxID = args.TreasureBoxID

	HomeLandVisitMould.OpenVisitTreasureChest(treasureBoxID)
end

function HomeLandVisitMould.TimerUpdate()
	if HomeLandLuaModule.isCreate == false then
		return
	end

	if HomeLandVisitMould.visitTreasureChest then
		for i, v in pairs(HomeLandVisitMould.visitTreasureChest) do
			if table.indexOf(HomeLandVisitMould.createTreasureChest, i) == -1 then
				local time = PlayerModule.GetServerTime()
				local timeCD = CfgDiscreteDataTable[6520016].Data[2]
				local start = v + timeCD

				if start <= time then
					table.insert(HomeLandVisitMould.createTreasureChest, i)
					HomelandModule.Instance:AddVisitChest(i)
				end
			end
		end
	end
end

function HomeLandVisitMould.Shutdown()
	if HomeLandVisitMould.timer then
		HomeLandVisitMould.timer:Stop()

		HomeLandVisitMould.timer = nil
	end

	HomeLandVisitMould.createTreasureChest = {}
	HomeLandVisitMould.visitTreasureChest = {}

	GameEntry.LuaEvent:Unsubscribe(HomelandCollarChestEventArgs.EventId, HomeLandVisitMould.OnCollarChest)
end

function HomeLandVisitMould.OnNoticeGetItem(type, itemShows)
	local str = ""

	for i, v in pairs(itemShows) do
		str = str .. CfgItemTable[v.cid].Name .. " +" .. v.num .. " "
	end

	if str ~= "" then
		NoticeModule.ShowNoticeByType(1, HomeLandVisitUIApi:GetString("TextGetReward", type, str))
	end
end

function HomeLandVisitMould.VisitNextFriend()
	local friendDates = FriendModule.GetFriends(Constant.FriendType.TYPE_FRIEND)

	if #friendDates == 0 then
		NoticeModule.ShowNotice(21042031)

		return
	end

	local visitData
	local index = 1

	if HomeLandVisitMould.visitFriendData == nil then
		if HomeLandLuaModule.targetPid then
			for i = 1, #friendDates do
				if friendDates[i].pId == HomeLandLuaModule.targetPid then
					index = i

					break
				end
			end
		end

		visitData = friendDates[index]

		if HomeLandLuaModule.targetPid == visitData.pId then
			local next = index + 1

			if next > #friendDates then
				next = 1
			end

			visitData = friendDates[next]
		end
	else
		for i = 1, #friendDates do
			if friendDates[i].pId == HomeLandVisitMould.visitFriendData.pId then
				index = i

				break
			end
		end

		local next = index + 1

		if next > #friendDates then
			next = 1
		end

		visitData = friendDates[next]
	end

	HomeLandVisitMould.visitFriendData = visitData

	if visitData then
		if HomeLandLuaModule.targetPid == visitData.pId then
			NoticeModule.ShowNotice(21042032)

			return
		end

		if not HomeLandLuaModule.isVisitHome then
			net_home.exitHome()
		end

		HomeLandLuaModule.Shutdown()
		HomeLandLuaModule.VisitHome(visitData.serverId, visitData.pId)
	end
end

function HomeLandVisitMould.Help(id, target)
	net_home.help(id, target)
end

function HomeLandVisitMould.OpenVisitTreasureChest(boxId)
	net_home.openVisitTreasureChest(boxId)
end

function HomeLandVisitMould.HelpResult(id, itemShows)
	if itemShows ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
		HomeLandVisitMould.OnNoticeGetItem(1, itemShows)
	end

	if PlayerModule.PlayerInfo.todayHelpBuildingCount[id] then
		PlayerModule.PlayerInfo.todayHelpBuildingCount[id] = PlayerModule.PlayerInfo.todayHelpBuildingCount[id] + 1
	else
		PlayerModule.PlayerInfo.todayHelpBuildingCount[id] = 1
	end

	EventDispatcher.Dispatch(EventID.HomeLandVisitEvent)
end

function HomeLandVisitMould.OpenVisitTreasureChestResult(boxId, itemShows)
	GameEntry.LuaEvent:Fire(nil, HomelandPlayEndChestEventArgs():Fill(boxId))

	local timer = Timer.New(function()
		if #itemShows > 0 then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
			HomeLandVisitMould.OnNoticeGetItem(2, itemShows)
		end
	end, 1)

	timer:Start()
end
