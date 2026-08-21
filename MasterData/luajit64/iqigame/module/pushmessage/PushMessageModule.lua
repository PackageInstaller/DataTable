-- chunkname: @IQIGame\\Module\\PushMessage\\PushMessageModule.lua

local m = {}

function m.Reload()
	m.AddListener()

	if SettingModule.messageMainSwitch == 1 then
		m.RemoveAllLocalNotification()
	else
		m.SetDefaultPushMessage()
	end
end

function m.Shutdown()
	m.RemoveListener()
end

function m.AddListener()
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, m.HomeUpdateBuildingEvent)
	EventDispatcher.AddEventListener(EventID.HLWorkSuccess, m.OnWorkSuccess)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, m.OnChangeValue)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, m.PlayerInfoChanged)
end

function m.RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, m.HomeUpdateBuildingEvent)
	EventDispatcher.RemoveEventListener(EventID.HLWorkSuccess, m.OnWorkSuccess)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, m.OnChangeValue)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, m.PlayerInfoChanged)
end

function m.OnWorkSuccess()
	m.AddLocalNotification(Constant.PushMessage.TheTransactionCompleted)
end

function m.HomeUpdateBuildingEvent(cfgBuildingID)
	if cfgBuildingID == Constant.HomelandBuildType.BuildGold then
		m.AddLocalNotification(Constant.PushMessage.AlchemicalHarvest)
	elseif cfgBuildingID == Constant.HomelandBuildType.BuildWork then
		m.AddLocalNotification(Constant.PushMessage.TheTransactionCompleted)
	end
end

function m.OnChangeValue(id)
	if id == Constant.ItemID.ENERGY then
		m.CheckPushFullEnergy()
	end
end

function m.PlayerInfoChanged()
	m.CheckPushFullEnergy()
	m.CheckPushFreePhysicalStrength()
end

function m.CheckPushFreePhysicalStrength()
	m.AddLocalNotification(Constant.PushMessage.FreePhysicalStrength)
end

function m.CheckPushFullEnergy()
	m.AddLocalNotification(Constant.PushMessage.FullStrength)
end

function m.CheckHomeLandPushMessage()
	m.HomeUpdateBuildingEvent(Constant.HomelandBuildType.BuildGold)
	m.HomeUpdateBuildingEvent(Constant.HomelandBuildType.BuildWork)
end

function m.GetPushMessageDelayTime(cid)
	local delay = 0
	local noData = false

	if cid == Constant.PushMessage.FullStrength then
		local maxEnergy = -1
		local energyRecovery

		for i, v in pairsCfg(CfgPlayerLevelTable) do
			if v.Level == PlayerModule.PlayerInfo.baseInfo.pLv then
				maxEnergy = v.EnergyMax
				energyRecovery = v.EnergyRecovery

				break
			end
		end

		if maxEnergy == -1 then
			local tempLv = -1

			for i, v in pairsCfg(CfgPlayerLevelTable) do
				if tempLv < v.Level then
					tempLv = v.Level
					maxEnergy = v.EnergyMax
					energyRecovery = v.EnergyRecovery
				end
			end
		end

		local currentEnergy = PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY)

		if currentEnergy < maxEnergy and energyRecovery ~= nil then
			local desEnergy = maxEnergy - currentEnergy

			delay = desEnergy * energyRecovery * 60
		end
	elseif cid == Constant.PushMessage.FreePhysicalStrength then
		if UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVITY_FOOD) then
			local timeSecond = PlayerModule.GetServerTime()
			local date = getDateTimeTable(timeSecond)
			local cfgTab = {}

			for id, cfgDailySupportData in pairsCfg(CfgDailySupplyTable) do
				table.insert(cfgTab, cfgDailySupportData)
			end

			table.sort(cfgTab, function(a, b)
				return a.Id < b.Id
			end)

			for i = 1, #cfgTab do
				local cfgDailySupportData = cfgTab[i]
				local hm = string.split(cfgDailySupportData.OpenTime, ":")

				date.hour = tonumber(hm[1])
				date.min = tonumber(hm[2])
				date.sec = 0

				local startTimeSec = dateTimeToTimeStamp(date, PlayerModule.TimeZone)

				if timeSecond < startTimeSec then
					delay = startTimeSec - timeSecond

					break
				end
			end

			if delay <= 0 then
				date.hour = 24
				date.min = 0
				date.sec = 0

				local delayToday = dateTimeToTimeStamp(date, PlayerModule.TimeZone) - timeSecond
				local cfgDailySupportData = cfgTab[1]
				local hm = string.split(cfgDailySupportData.OpenTime, ":")
				local h = hm[1]
				local min = hm[2]

				delay = delayToday + h * 3600 + min * 60
			end
		end
	elseif cid == Constant.PushMessage.AlchemicalHarvest then
		local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildGold)

		noData = HomeLandLuaModule.homeLandBaseInfo == nil

		if buildingData then
			local productionPOD = buildingData.buildingPOD.productionData
			local num = 0

			for i, v in pairs(productionPOD.output) do
				num = num + v
			end

			local speed = buildingData.buildingPOD.productionData.oneProduceTime / CfgHomeLandProductionTable[36100001].ProduceItemNum[1]
			local nowTime = PlayerModule.GetServerTime()
			local endTime = buildingData.buildingPOD.productionData.nextProduceTime
			local passTime = speed * num + (buildingData.buildingPOD.productionData.oneProduceTime - (endTime - nowTime))
			local totalTime = speed * productionPOD.storageLimit

			delay = totalTime - passTime
		end
	elseif cid == Constant.PushMessage.TheTransactionCompleted then
		noData = HomeLandLuaModule.homeLandBaseInfo == nil

		local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildWork)

		if buildingData then
			delay = buildingData.workData:GetMaxResidueTime()
		end
	end

	return delay, noData
end

function m.SetDefaultPushMessage()
	for i, v in pairsCfg(CfgPushMessageTable) do
		local state = SettingModule.GetMessageChildSwitch(v.Id)

		if state == 1 then
			m.RemoveLocalNotification(v.Id)
		else
			m.AddLocalNotification(v.Id)
		end
	end
end

function m.AddLocalNotification(id)
	if SettingModule.messageMainSwitch == 1 or SettingModule.GetMessageChildSwitch(id) == 1 then
		return
	end

	local cfg = CfgPushMessageTable[id]
	local delay, noData = m.GetPushMessageDelayTime(id)

	if delay <= 0 then
		if not noData then
			m.RemoveLocalNotification(id)
		end

		return
	end

	JPushMono.instance:AddLocalNotification(id, cfg.Title, cfg.Word, delay)

	if GameEntry.Base.DevMode then
		log(" 添加更新推送 " .. id .. " " .. cfg.Title .. " delayTime " .. GetFormatTime(delay))
	end
end

function m.RemoveLocalNotification(id)
	JPushMono.instance:RemoveLocalNotification(id)

	if GameEntry.Base.DevMode then
		log("移除单条推送" .. id)
	end
end

function m.RemoveAllLocalNotification()
	JPushMono.instance:RemoveAllLocalNotification()

	if GameEntry.Base.DevMode then
		log("清除所有推送消息")
	end
end

PushMessageModule = m
