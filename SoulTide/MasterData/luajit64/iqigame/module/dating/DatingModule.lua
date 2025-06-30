-- chunkname: @IQIGame\\Module\\Dating\\DatingModule.lua

DatingModule = {
	clickUnableDating = {}
}

function DatingModule.IsCanDatingBySoulID(soulID)
	local tab = {}

	for k, v in pairsCfg(CfgDatingChooseTable) do
		if v.SoulId == soulID then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(tb1, tb2)
		return tb1.DegreeLvl < tb2.DegreeLvl
	end)

	local soulData = SoulModule.GetSoulData(soulID)
	local firstData = tab[1]
	local top = true
	local degreeLv = 1

	if firstData and soulData.favorLv < firstData.DegreeLvl then
		top = false
		degreeLv = firstData.DegreeLvl
	end

	return top, degreeLv
end

function DatingModule.GetOpenDatingEvent(soulId)
	local num = 0
	local maxNum = 0
	local datingChooseTab = DatingModule.GetDatingChooseBySoulID(soulId)
	local types = {}

	for i, v in pairs(datingChooseTab) do
		local type = v.DatingType

		if table.indexOf(types, type) == -1 then
			table.insert(types, type)
		end
	end

	local datingEvents = {}

	for i, v in pairs(types) do
		local ta = DatingModule.GetDatingEvents(soulId, v)

		for k, v1 in pairs(ta) do
			table.insert(datingEvents, v1)
		end
	end

	maxNum = #datingEvents

	local girlPOD = GirlModule.GetSoulGirlData(soulId)

	if girlPOD then
		for k, v in pairs(datingEvents) do
			if girlPOD.datingRecord then
				for i, m in pairs(girlPOD.datingRecord) do
					if i == v.Id then
						num = num + 1
					end
				end
			end
		end
	end

	return num, maxNum
end

function DatingModule.IsDatingEventOpen(datingEvent)
	local top = false
	local girlPOD = GirlModule.GetSoulGirlData(datingEvent.SoulId)
	local soulData = SoulModule.GetSoulData(datingEvent.SoulId)
	local needDownDatingId = datingEvent.NeedDownDatingId
	local isFavorLv = false

	if soulData and soulData.favorLv >= datingEvent.UnlockLevel then
		isFavorLv = true
	end

	local isNeedDownDating = false

	if girlPOD and girlPOD.datingRecord then
		for i, v in pairs(girlPOD.datingRecord) do
			if i == needDownDatingId then
				isNeedDownDating = true

				break
			end
		end
	end

	if needDownDatingId == nil or needDownDatingId == 0 then
		isNeedDownDating = true
	end

	top = isFavorLv and isNeedDownDating

	return top
end

function DatingModule.GetEventSate(datingEvent)
	local isUnlock = DatingModule.IsDatingEventOpen(datingEvent)
	local state = 1

	if isUnlock then
		local girlPOD = GirlModule.GetSoulGirlData(datingEvent.SoulId)
		local isHave = false

		if girlPOD and girlPOD.datingRecord then
			for i, v in pairs(girlPOD.datingRecord) do
				if i == datingEvent.Id then
					isHave = true

					break
				end
			end
		end

		state = isHave == true and 3 or 2
	end

	return state
end

function DatingModule.DatingEventIsRed(datingEvent)
	local eventState = DatingModule.GetEventSate(datingEvent)
	local isAmple = true

	for i = 1, #datingEvent.Cost, 2 do
		local needItemID = datingEvent.Cost[i]
		local needNum = datingEvent.Cost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

		isAmple = isAmple and needNum <= haveNum
	end

	if eventState == 2 and isAmple then
		return true
	end

	return false
end

function DatingModule.DatingTypeIsRed(soulID)
	local events = DatingModule.GetDatingEventsByDatingTypeShow(soulID)

	for i, v in pairs(events) do
		local top = DatingModule.DatingEventIsRed(v)

		if top then
			return true
		end
	end

	return false
end

function DatingModule.DatingSoulIsRed(soulID)
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.DATING)

	if result then
		local top = DatingModule.DatingTypeIsRed(soulID)

		if top then
			return true
		end
	end

	return false
end

function DatingModule.GetDatingChooseBySoulID(soulID)
	local tab = {}

	for k, v in pairsCfg(CfgDatingChooseTable) do
		if v.SoulId == soulID then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	return tab
end

function DatingModule.GetDatingEvents(soulID, datingType)
	local events = {}

	for i, v in pairsCfg(CfgDatingEventsTable) do
		if v.DatingType == datingType and v.SoulId == soulID then
			table.insert(events, v)
		end
	end

	table.sort(events, function(tab1, tab2)
		return tab1.Id < tab2.Id
	end)

	return events
end

function DatingModule.GetDatingEventsByDatingTypeShow(soulID)
	local events = {}

	for i, v in pairsCfg(CfgDatingEventsTable) do
		if v.SoulId == soulID then
			table.insert(events, v)
		end
	end

	table.sort(events, function(tab1, tab2)
		return tab1.Id < tab2.Id
	end)

	return events
end

function DatingModule.Dating(soulCid, chooseCid)
	local cfg = CfgDatingEventsTable[chooseCid]

	UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
		2,
		function(tab)
			net_dating.dating(tab[1], tab[2])
		end,
		{
			soulCid,
			chooseCid
		},
		cfg.Name
	})
end

function DatingModule.ReverseDating(soulCid, eventCid)
	net_dating.reverseDating(soulCid, eventCid)
end

function DatingModule.NotifyDatingEnd(soulCid, eventCid, getItems, favorData)
	local cfgDatingEvent = CfgDatingEventsTable[eventCid]

	if #getItems > 0 then
		local memoryEndData = MemoryEndServerData:New()
		local littleTitle = DatingUIApi:GetString("TextComplete")

		memoryEndData:InitDating(cfgDatingEvent.Name, littleTitle, soulCid, getItems, favorData[3], favorData[4], favorData[1], favorData[2])
		UIModule.Open(Constant.UIControllerName.MemorySettlement, Constant.UILayer.UI, memoryEndData)
	end

	local soulData = SoulModule.GetSoulData(soulCid)
	local cfgSoulFavor = soulData:GetCfgSoulFavor()

	if cfgSoulFavor and cfgSoulFavor.FullRankTip and cfgSoulFavor.FullRankTip ~= "" then
		NoticeModule.ShowNoticeByType(1, cfgSoulFavor.FullRankTip)
	end
end

function DatingModule.NotifyDating(soulCid, datingRecord)
	GirlModule.UpdateDatingEvent(soulCid, datingRecord)
	EventDispatcher.Dispatch(EventID.UpdateGirUIRedPoint, soulCid)
end
