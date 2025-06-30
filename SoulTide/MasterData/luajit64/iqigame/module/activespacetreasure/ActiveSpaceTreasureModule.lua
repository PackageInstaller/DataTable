-- chunkname: @IQIGame\\Module\\ActiveSpaceTreasure\\ActiveSpaceTreasureModule.lua

local m = {}

function m.Reload()
	return
end

function m.GetSpaceListData(operateEventID)
	local tab = {}
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

	if eventPOD then
		for i, v in pairsCfg(CfgSpaceTreasureListTable) do
			if v.Team == eventPOD.dataCfgId then
				table.insert(tab, v)
			end
		end
	end

	table.sort(tab, function(a, b)
		return a.Id < b.Id
	end)

	return tab
end

function m.GetItemNum(operateEventID, cfgID)
	local OperationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if OperationEventDataPOD and OperationEventDataPOD.spaceTreasureDataPOD and OperationEventDataPOD.spaceTreasureDataPOD.getTickets then
		return OperationEventDataPOD.spaceTreasureDataPOD.getTickets[cfgID]
	end

	return 0
end

function m.GetSpendPower(operateEventID)
	local OperationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if OperationEventDataPOD and OperationEventDataPOD.spaceTreasureDataPOD then
		return OperationEventDataPOD.spaceTreasureDataPOD.totalEnergy
	end

	return 0
end

function m.GetSelectSpace(operateEventID)
	local spaceListCid
	local spaceListTab = m.GetSpaceListData(operateEventID)

	for i = 1, #spaceListTab do
		local cfgData = spaceListTab[i]
		local cfgSpaceList = CfgSpaceTreasureListTable[cfgData.Id]
		local costItemCid = cfgSpaceList.Cost[1]
		local needItemNum = cfgSpaceList.Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

		if needItemNum <= haveNum then
			spaceListCid = cfgData.Id

			break
		end
	end

	if spaceListCid == nil then
		spaceListCid = spaceListTab[1].Id
	end

	return spaceListCid
end

function m.CheckAllSpaceTreasureRedPoint()
	for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
		local cfg = CfgOperateEventsControlTable[v.eventCfgId]

		if cfg.Type == Constant.Activity_Operation_Type.Activity_SpaceTreasure then
			local top = m.CheckSpaceTreasureRedPoint(v.eventCfgId)

			if top then
				return true
			end
		end
	end

	return false
end

function m.CheckSpaceTreasureRedPoint(operateEventID)
	local spaceListTab = m.GetSpaceListData(operateEventID)

	for i = 1, #spaceListTab do
		local cfgData = spaceListTab[i]
		local cfgSpaceList = CfgSpaceTreasureListTable[cfgData.Id]
		local costItemCid = cfgSpaceList.Cost[1]
		local needItemNum = cfgSpaceList.Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

		if needItemNum <= haveNum then
			return true
		end
	end

	return false
end

function m.Shutdown()
	return
end

function m.Explore(eventId, cid, count)
	net_operationsSpaceTreasure.explore(eventId, cid, count)
end

function m.ExploreResult(eventId, cid, num, list)
	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end
end

ActiveSpaceTreasureModule = m
