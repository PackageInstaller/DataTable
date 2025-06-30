-- chunkname: @IQIGame\\Module\\Town\\TownModule.lua

TownModule = {
	inTown = false,
	TOWN_FUNCTION_SHOPPING = Constant.Function.shopping,
	TOWN_FUNCTION_PLOT = Constant.Function.plot,
	TOWN_FUNCTION_SOUL_NEW_STORY = Constant.Function.newMemory,
	townAreaDic = {}
}

local TownAreaData = require("IQIGame.Module.Town.TownAreaData")

function TownModule.ReloadData(data)
	if data == nil then
		return
	end

	TownModule.currentEventId = data.currentEventId
	TownModule.shoppingEventIds = data.shoppingEventIds
	TownModule.townAreaDic = {}
	TownModule.isShowRed = #data.executableEvents > 0

	for i, v in pairsCfg(CfgTownAreaTable) do
		local townArea
		local areaPOD = TownModule.GetAreaPOD(v.Id, data.areas)

		if areaPOD ~= nil then
			townArea = TownAreaData.New(areaPOD.cid, true, areaPOD.isNew)
		else
			local isLock = false

			if v.Id == 10110 then
				isLock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GUILD)
			end

			townArea = TownAreaData.New(v.Id, isLock, false)
		end

		table.insert(TownModule.townAreaDic, townArea)
	end

	for i, v in pairs(data.executableEvents) do
		local areaID = CfgTownEventTable[v].AreaId
		local areaData, key = TownModule.GetTownAreaData(areaID)

		if areaData ~= nil then
			areaData:AddDynamicFunction(v, CfgTownEventTable[v])

			TownModule.townAreaDic[key] = areaData
		end
	end

	TownModule.RefreshTownRandomShopping()

	local soulDataList = SoulModule.GetSortedUnlockSoulDataList()

	for i, v in pairs(soulDataList) do
		local memoryStoryInfo = MemoryNewModule.GetCanUnLockSoulNewStory(v.soulCid)

		if memoryStoryInfo then
			local areaData, key = TownModule.GetTownAreaData(memoryStoryInfo.cfgSoulNewStory.TownArea)

			if areaData ~= nil then
				areaData:AddSoulNewStory(memoryStoryInfo)

				TownModule.townAreaDic[key] = areaData
			end
		end
	end

	MainTipsModule.CheckTownNewStory()
end

function TownModule.UpdateTownAreaSoulNewStory(memoryStoryInfo)
	if memoryStoryInfo then
		local state = memoryStoryInfo:StoryState()

		if state == 2 then
			local areaData, key = TownModule.GetTownAreaData(memoryStoryInfo.cfgSoulNewStory.TownArea)

			if areaData ~= nil then
				areaData:AddSoulNewStory(memoryStoryInfo)

				TownModule.townAreaDic[key] = areaData
			end
		end

		EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
	end
end

function TownModule.RemoveTownAreaStory(storyCid)
	local cfgSoulNewStory = CfgSoulNewStoryTable[storyCid]
	local areaData, key = TownModule.GetTownAreaData(cfgSoulNewStory.TownArea)

	if areaData then
		local pos

		for i = 1, #areaData.townFunDic do
			if areaData.townFunDic[i].cfgID == storyCid then
				pos = i

				break
			end
		end

		if pos ~= nil then
			table.remove(areaData.townFunDic, pos)

			TownModule.townAreaDic[key] = areaData
		end

		EventDispatcher.Dispatch(EventID.UpdateTownPanel)
		EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
	end

	MainTipsModule.CheckTownNewStory()
end

function TownModule.RefreshGuildState()
	for i, v in pairs(TownModule.townAreaDic) do
		if v.cfgID == 10110 then
			TownModule.townAreaDic[i].isLock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GUILD)
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
end

function TownModule.GetFunctionDataByDialogCid(dialogCid)
	if TownModule.townAreaDic ~= nil then
		for i, v in pairs(TownModule.townAreaDic) do
			if v.townFunDic then
				for k, v1 in ipairs(v.townFunDic) do
					if v1.DialogId == dialogCid then
						return v1
					end
				end
			end
		end
	end

	return nil
end

function TownModule.GetTownAreaData(cid)
	local townAreaData, key

	if TownModule.townAreaDic ~= nil then
		for i, v in pairs(TownModule.townAreaDic) do
			if v.cfgID == cid then
				townAreaData = v
				key = i

				break
			end
		end
	end

	return townAreaData, key
end

function TownModule.GetAreaPOD(cid, serverDate)
	local areaPOD

	for i, v in pairs(serverDate) do
		if v.cid == cid then
			areaPOD = v

			break
		end
	end

	return areaPOD
end

function TownModule.ExecutionEvent(data)
	TownModule.currentFunctionData = data

	if data.functionType == TownModule.TOWN_FUNCTION_SHOPPING then
		local townAreaData, key = TownModule.GetTownAreaData(data.ownerShipAreaID)
		local needItemID = townAreaData.cfgInfo.WanderCost[1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)
		local needNum = townAreaData.cfgInfo.WanderCost[2]

		if haveNum < needNum then
			NoticeModule.ShowNoticeByType(1, TownUIApi:GetString("Error", CfgItemTable[needItemID].Name))

			return
		end

		TownModule.Shopping(data.cfgTownEvent.Id)
	elseif data.functionType == TownModule.TOWN_FUNCTION_PLOT then
		if data.threadType == Constant.LibraryStoryResType.TownResMainType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				3,
				function(tab)
					TownModule.ExecMainline(tab[1], tab[2])
				end,
				{
					data.ownerShipAreaID,
					data.cfgID
				},
				data.name
			})
		elseif data.threadType == Constant.LibraryStoryResType.TownResBranchType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				4,
				function(tab)
					TownModule.ExecMainline(tab[1], tab[2])
				end,
				{
					data.ownerShipAreaID,
					data.cfgID
				},
				data.name
			})
		end
	elseif data.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY then
		MemoryNewModule.currentSoulID = data.newStoryInfo.cfgSoulNewStory.SoulId

		MemoryNewModule.RequestGetSoulNewStory(data.newStoryInfo.cfgSoulNewStory.SoulId)
		MemoryNewModule.ExperienceNewStoryChapter(data.newStoryInfo.cid, 1)
	else
		JumpModule.Jump(data.cfgFunction.Id)
	end
end

function TownModule.IsHaveFunctionPlot()
	if TownModule.townAreaDic ~= nil then
		for i, v in pairs(TownModule.townAreaDic) do
			if v:IsFunctionPlot() then
				return true
			end
		end
	end

	return false
end

function TownModule.IsHaveFunctionPlotByID(id)
	if TownModule.townAreaDic ~= nil then
		for i, v in pairs(TownModule.townAreaDic) do
			if v:IsFunctionPlotByID(id) then
				return true
			end
		end
	end

	return false
end

function TownModule.GetHomeLandUnLockRooms()
	local roomEvents = {}

	if TownModule.townAreaDic ~= nil then
		for i, v in pairs(TownModule.townAreaDic) do
			if v.townFunDic then
				for j, k in pairs(v.townFunDic) do
					if k.cfgTownEvent and k.cfgTownEvent.RoomId > 0 then
						table.insert(roomEvents, k)
					end
				end
			end
		end
	end

	return roomEvents
end

function TownModule.Shopping(areaCid)
	net_town.shopping(areaCid)
end

function TownModule.ExecMainline(areaCid, eventCid)
	net_town.execMainline(areaCid, eventCid)
end

function TownModule.EnterArea(areaCid)
	local areaData, key = TownModule.GetTownAreaData(areaCid)

	if areaData.isNew == true then
		net_town.enterArea(areaCid)
	end
end

function TownModule.RefreshTownRandomShopping()
	for i, v in pairs(TownModule.shoppingEventIds) do
		local cfgEvent = CfgTownEventTable[v]
		local areaData, key = TownModule.GetTownAreaData(cfgEvent.AreaId)

		if areaData ~= nil then
			areaData:AddRandomSopping(v)

			TownModule.townAreaDic[key] = areaData
		end
	end
end

function TownModule.ShoppingResult()
	return
end

function TownModule.ExecMainlineResult(areaCid, eventCid)
	local areaData, key = TownModule.GetTownAreaData(areaCid)
	local pos

	for i = 1, #areaData.townFunDic do
		if areaData.townFunDic[i].cfgID == eventCid then
			pos = i

			break
		end
	end

	if pos ~= nil then
		table.remove(areaData.townFunDic, pos)

		TownModule.townAreaDic[key] = areaData
	end

	EventDispatcher.Dispatch(EventID.UpdateTownPanel)
	EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
end

function TownModule.EnterAreaResult(areaCid)
	local areaData, key = TownModule.GetTownAreaData(areaCid)

	if key ~= nil then
		TownModule.townAreaDic[key].isNew = false
	end

	EventDispatcher.Dispatch(EventID.UpdateTownPanel)
end

function TownModule.NotifyUnlockArea(area)
	for i, v in pairs(area) do
		local areaData, key = TownModule.GetTownAreaData(v.cid)

		if areaData == nil then
			local townArea = TownAreaData.New(v.cid, true, v.isNew)

			table.insert(TownModule.townAreaDic, townArea)
		else
			TownModule.townAreaDic[key].isNew = v.isNew
		end
	end
end

function TownModule.NotifyEvent(ids)
	for i, v in pairs(ids) do
		local areaID = CfgTownEventTable[v].AreaId
		local areaData, key = TownModule.GetTownAreaData(areaID)

		if areaData ~= nil then
			areaData:AddDynamicFunction(v, CfgTownEventTable[v])

			TownModule.townAreaDic[key] = areaData
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
end

function TownModule.NotifyShoppingFinish(areaCid, itemAwards)
	if #itemAwards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
	end
end

function TownModule.NotifyMainlineFinish(itemAwards)
	if #itemAwards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
	end
end

function TownModule.notifyShoppingEventRefresh(ids)
	local toRemoveIds = {}

	if TownModule.shoppingEventIds ~= nil then
		for i, v in pairs(TownModule.shoppingEventIds) do
			local exist = false

			for m, n in pairs(ids) do
				if v == n then
					exist = true

					break
				end
			end

			toRemoveIds[#toRemoveIds + 1] = v
		end

		for i, v in pairs(toRemoveIds) do
			local cfgEvent = CfgTownEventTable[v]
			local areaData, key = TownModule.GetTownAreaData(cfgEvent.AreaId)

			if areaData ~= nil then
				local key

				for k, j in pairs(areaData.townFunDic) do
					if v == j.cfgID then
						key = k

						break
					end
				end

				table.remove(areaData.townFunDic, key)
			end
		end
	end

	TownModule.shoppingEventIds = ids

	TownModule.RefreshTownRandomShopping()
	EventDispatcher.Dispatch(EventID.UpdateTownAreaEvent)
end

function TownModule.NotifyTownFunctionOpen(townPOD)
	TownModule.ReloadData(townPOD)
end
