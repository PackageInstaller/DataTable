-- chunkname: @IQIGame\\Module\\Cooking\\CookingModule.lua

CookingModule = {
	unlockHomeLandCookBook = {}
}

local CookingQueueData = require("IQIGame.Module.Cooking.CookingQueueData")
local CookingMenuData = require("IQIGame.Module.Cooking.CookingMenuData")

function CookingModule.ReloadCookBook(unlockCookBook)
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildCooking)

	CookingModule.unlockHomeLandCookBook = {}

	for i, v in pairsCfg(CfgCookCombinationTable) do
		local isLock = false
		local lock = table.indexOf(unlockCookBook, v.Id) ~= -1

		if v.IsLock == false then
			if buildingData ~= nil and buildingData.buildingPOD.lv >= v.UnlockLevel then
				isLock = true
			end
		elseif lock then
			isLock = true
		end

		local menuData = CookingMenuData.New()

		menuData:Init(v.Id, isLock)
		table.insert(CookingModule.unlockHomeLandCookBook, menuData)
	end

	table.sort(CookingModule.unlockHomeLandCookBook, function(a, b)
		return a.cfgInfo.Sort < b.cfgInfo.Sort
	end)

	CookingModule.queueMax = CfgDiscreteDataTable[6520036].Data[1]

	CookingModule.UpdateQueue()
	EventDispatcher.AddEventListener(EventID.UpdateCookingEvent, CookingModule.UpdateCooking)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, CookingModule.HomeUpdateBuildingEvent)
end

function CookingModule.UpdateCooking()
	CookingModule.UpdateQueue()
end

function CookingModule.HomeUpdateBuildingEvent(cfgBuildingID)
	if cfgBuildingID == Constant.HomelandBuildType.BuildCooking then
		CookingModule.UpdateQueue()
	end
end

function CookingModule.UpdateQueue()
	CookingModule.cookingQueues = {}

	for i = 1, CookingModule.queueMax do
		local CookingQueueData = CookingQueueData.New()

		CookingQueueData:Init(i)

		CookingModule.cookingQueues[i] = CookingQueueData
	end

	local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildCooking)

	if homeLandBuildingData then
		local kitchenPOD = homeLandBuildingData.buildingPOD.kitchenPOD

		CookingModule.maxQueueCount = kitchenPOD.maxQueueCount

		for i = 1, #CookingModule.cookingQueues do
			local isLock = i <= CookingModule.maxQueueCount
			local cookQueueData = CookingModule.cookingQueues[i]
			local culinaryPOD

			for i, v in pairs(kitchenPOD.culinarys) do
				if v.id == cookQueueData.id then
					culinaryPOD = v

					break
				end
			end

			if culinaryPOD ~= nil then
				cookQueueData:Update(culinaryPOD.cid, culinaryPOD.status, culinaryPOD.finishTime, isLock, culinaryPOD.costs, culinaryPOD)
			else
				cookQueueData:Update(nil, 0, nil, isLock, {}, culinaryPOD)
			end
		end

		local num = 0

		for i = 1, kitchenPOD.maxQueueCount do
			local culinaryPOD = kitchenPOD.culinarys[i]

			if culinaryPOD == nil then
				num = num + 1
			end
		end

		CookingModule.workingQueueCount = kitchenPOD.maxQueueCount - num

		EventDispatcher.Dispatch(EventID.UpdateHomeLandOverview)
	end
end

function CookingModule.GetLongTimeQueue()
	local queueData
	local maxCD = 0

	for i, v in pairs(CookingModule.cookingQueues) do
		if v.unlock and v.status == 1 and v.finishTime then
			local cd = v.finishTime - PlayerModule.GetServerTime()

			if maxCD < cd then
				maxCD = cd
				queueData = v
			end
		end
	end

	return queueData, maxCD
end

function CookingModule.GetMenuDataByID(id)
	for i, v in pairs(CookingModule.unlockHomeLandCookBook) do
		if v.cid == id then
			return v
		end
	end

	return nil
end

function CookingModule.UpdateCookBook()
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildCooking)

	if buildingData then
		for i, v in pairs(CookingModule.unlockHomeLandCookBook) do
			if v.cfgInfo.IsLock == false and buildingData.buildingPOD.lv >= v.cfgInfo.UnlockLevel then
				v.unlock = true
			end
		end
	end
end

function CookingModule.UpdateUnlockCookBook(cookBookId, isGetReward)
	for i, v in pairs(CookingModule.unlockHomeLandCookBook) do
		if v.cid == cookBookId then
			v.unlock = true
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateUnlockCookBookEvent)
end

function CookingModule.GetCookBooks()
	local cookBooks = {}

	for i, v in pairs(CookingModule.unlockHomeLandCookBook) do
		if v.unlock then
			table.insert(cookBooks, v)
		elseif v.cfgInfo.LockShow == 1 then
			table.insert(cookBooks, v)
		end
	end

	table.sort(cookBooks, function(a, b)
		return a.cfgInfo.Sort < b.cfgInfo.Sort
	end)

	return cookBooks
end

function CookingModule.ISCookingMenuRedPoint()
	return false
end

function CookingModule.Shutdown()
	EventDispatcher.RemoveEventListener(EventID.UpdateCookingEvent, CookingModule.UpdateCooking)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, CookingModule.HomeUpdateBuildingEvent)
end
