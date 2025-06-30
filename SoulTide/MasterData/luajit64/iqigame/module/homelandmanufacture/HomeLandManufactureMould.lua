-- chunkname: @IQIGame\\Module\\HomeLandManufacture\\HomeLandManufactureMould.lua

HomeLandManufactureMould = {
	homeManufactureItemDic = {}
}

local ManufactureQueueData = require("IQIGame.Module.HomeLandManufacture.ManufactureQueueData")
local HomeLandManufactureItemData = require("IQIGame.Module.HomeLand.HomeLandManufactureItemData")

function HomeLandManufactureMould.ReloadManufactureItem(unlockManufactureItem)
	HomeLandManufactureMould.homeManufactureItemDic = {}

	local HomeManufactureItem

	for i, v in pairsCfg(CfgHomeLandManufactureItemTable) do
		HomeManufactureItem = HomeLandManufactureItemData.New()

		HomeManufactureItem:Init(v.Id)
		HomeManufactureItem:UpdateUnLock(not v.IsLock)

		HomeLandManufactureMould.homeManufactureItemDic[#HomeLandManufactureMould.homeManufactureItemDic + 1] = HomeManufactureItem
	end

	for i, v in pairs(unlockManufactureItem) do
		local ManufactureItem = HomeLandManufactureMould.GetHomeManufactureItemData(v)

		ManufactureItem:UpdateUnLock(true)
	end

	HomeLandManufactureMould.queueMax = CfgDiscreteDataTable[6520036].Data[2]

	HomeLandManufactureMould.UpdateQueue()
	EventDispatcher.AddEventListener(EventID.HomeLandManufactureResultEvent, HomeLandManufactureMould.ManufactureResultEvent)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, HomeLandManufactureMould.HomeUpdateBuildingEvent)
end

function HomeLandManufactureMould.ManufactureResultEvent()
	HomeLandManufactureMould.UpdateQueue()
end

function HomeLandManufactureMould.HomeUpdateBuildingEvent(cfgBuildingID)
	if cfgBuildingID == Constant.HomelandBuildType.BuildManufacture then
		HomeLandManufactureMould.UpdateQueue()
	end
end

function HomeLandManufactureMould.UpdateQueue()
	HomeLandManufactureMould.manufactureQueues = {}

	for i = 1, HomeLandManufactureMould.queueMax do
		local manufactureQueueData = ManufactureQueueData.New()

		manufactureQueueData:Init(i)

		HomeLandManufactureMould.manufactureQueues[i] = manufactureQueueData
	end

	local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildManufacture)

	if homeLandBuildingData then
		local manufacturePOD = homeLandBuildingData.buildingPOD.manufacture

		HomeLandManufactureMould.maxQueueCount = manufacturePOD.maxQueueCount
		HomeLandManufactureMould.workingQueueCount = 0

		for i = 1, #HomeLandManufactureMould.manufactureQueues do
			local isLock = i <= HomeLandManufactureMould.maxQueueCount
			local manufactureQueueData = HomeLandManufactureMould.manufactureQueues[i]
			local makePOD

			for i, v in pairs(manufacturePOD.makes) do
				if v.id == manufactureQueueData.id then
					makePOD = v

					break
				end
			end

			if makePOD ~= nil then
				HomeLandManufactureMould.workingQueueCount = HomeLandManufactureMould.workingQueueCount + 1

				manufactureQueueData:Update(makePOD.cid, makePOD.status, makePOD.finishTime, makePOD.costs, isLock)
			else
				manufactureQueueData:Update(nil, 0, nil, {}, isLock)
			end
		end

		EventDispatcher.Dispatch(EventID.UpdateHomeLandOverview)
	end
end

function HomeLandManufactureMould.GetLongTimeQueue()
	local queueData
	local maxCD = 0

	for i, v in pairs(HomeLandManufactureMould.manufactureQueues) do
		if v.status == 1 and v.finishTime then
			local cd = v.finishTime - PlayerModule.GetServerTime()

			if maxCD < cd then
				maxCD = cd
				queueData = v
			end
		end
	end

	return queueData, maxCD
end

function HomeLandManufactureMould.GetHomeManufactureItemData(cid)
	for i, v in pairs(HomeLandManufactureMould.homeManufactureItemDic) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function HomeLandManufactureMould.UpdateManufactureItem(manufactureItemCid)
	local ManufactureItem = HomeLandManufactureMould.GetHomeManufactureItemData(manufactureItemCid)

	if ManufactureItem then
		ManufactureItem:UpdateUnLock(true)
	end
end

function HomeLandManufactureMould.GetManufactureByType(selectType, types)
	local tab = {}

	for i, v in ipairs(HomeLandManufactureMould.homeManufactureItemDic) do
		if selectType == 0 then
			if table.indexOf(types, v.cfgManufactureItem.Tyoe) ~= -1 then
				table.insert(tab, v)
			end
		elseif v.cfgManufactureItem.Tyoe == selectType then
			table.insert(tab, v)
		end
	end

	return tab
end

function HomeLandManufactureMould.GetManufactureItemsThemeID(ThemeID)
	local tab = {}

	for i, v in ipairs(HomeLandManufactureMould.homeManufactureItemDic) do
		if v.cfgManufactureItem.ThemeID == ThemeID then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		local res = false
		local lockA = a.isLock and 1 or 0
		local lockB = b.isLock and 1 or 0

		if lockA == lockB then
			res = a.cfgManufactureItem.Sort < b.cfgManufactureItem.Sort
		else
			res = lockB < lockA
		end

		return res
	end)

	return tab
end

function HomeLandManufactureMould.GetManufactureDecorateThemeByType(type)
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandDecorateThemeTable) do
		if v.Tpye == type and v.Id ~= 10001 then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.Id < b.Id
	end)

	return tab
end

function HomeLandManufactureMould.GetCompleteThemeNumber(themeId)
	local num = 0
	local tab = HomeLandManufactureMould.GetManufactureItemsThemeID(themeId)
	local totalNum = #tab

	for i, v in pairs(tab) do
		local have = v:HaveNumber()

		if have > 0 then
			num = num + 1
		end
	end

	return num, totalNum
end

function HomeLandManufactureMould.Shutdown()
	EventDispatcher.RemoveEventListener(EventID.HomeLandManufactureResultEvent, HomeLandManufactureMould.ManufactureResultEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, HomeLandManufactureMould.HomeUpdateBuildingEvent)
end

function HomeLandManufactureMould.Make(buildingCid, queueId, manufactureItemCid)
	net_home.make(buildingCid, queueId, manufactureItemCid)
end

function HomeLandManufactureMould.CancelMake(buildingCid, queueId)
	net_home.cancelMake(buildingCid, queueId)
end

function HomeLandManufactureMould.RewardMake(buildingCid, queueId)
	net_home.rewardMake(buildingCid, queueId)
end

function HomeLandManufactureMould.CompleteMake(buildingCid, queueId, time)
	net_home.completeMake(buildingCid, queueId, time)
end

function HomeLandManufactureMould.MakeResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.HomeLandManufactureResultEvent, building.cid)
end

function HomeLandManufactureMould.CancelMakeResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.HomeLandManufactureResultEvent, building.cid)
end

function HomeLandManufactureMould.RewardMakeResult(building, itemAward)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.HomeLandManufactureResultEvent, building.cid)

	if itemAward ~= nil and #itemAward > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAward)
	end
end

function HomeLandManufactureMould.CompleteMakeResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.HomeLandManufactureResultEvent, building.cid)
end
