-- chunkname: @IQIGame\\Module\\HomeLandProcess\\HomeLandProcessMould.lua

HomeLandProcessMould = {
	processDates = {}
}

local HomeLandProcessData = require("IQIGame.Module.HomeLandProcess.HomeLandProcessData")

function HomeLandProcessMould.Reload()
	HomeLandProcessMould.processDates = {}

	for i, v in pairsCfg(CfgHomeLandPropsProcessingTable) do
		local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildProcess)
		local isLock = false

		if buildingData then
			isLock = buildingData.buildingPOD.lv >= v.UnlockLevel
		end

		local processData = HomeLandProcessData.New()

		processData:Init(v.Id, isLock)
		table.insert(HomeLandProcessMould.processDates, processData)
	end
end

function HomeLandProcessMould.UpdateProcess()
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildProcess)

	if buildingData and buildingData.buildingPOD then
		for i, v in pairs(HomeLandProcessMould.processDates) do
			local isLock = buildingData.buildingPOD.lv >= v.cfgInfo.UnlockLevel

			v.unlock = isLock
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateHomeLandProcessEvent)
end

function HomeLandProcessMould.GetProcessDataByID(cid)
	for i, v in pairs(HomeLandProcessMould.processDates) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function HomeLandProcessMould.GetProcessDataByProcessingType(ProcessingType)
	local tab = {}

	for i, v in pairs(HomeLandProcessMould.processDates) do
		if v.cfgInfo.ProcessingType == ProcessingType then
			table.insert(tab, v)
		end
	end

	return tab
end

function HomeLandProcessMould.GetProcessData(PropsType, ProcessingType)
	local tab = {}

	for i, v in pairs(HomeLandProcessMould.processDates) do
		if v.cfgInfo.PropsType == PropsType and v.cfgInfo.ProcessingType == ProcessingType then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.cfgInfo.UnlockLevel < b.cfgInfo.UnlockLevel
	end)

	return tab
end

function HomeLandProcessMould.CompoundMaxNum(processData)
	local maxNum = 999

	if processData then
		for i = 1, #processData.cfgInfo.Props, 2 do
			local id = processData.cfgInfo.Props[i]
			local needNum = processData.cfgInfo.Props[i + 1]
			local have = WarehouseModule.GetItemNumByCfgID(id)
			local canNum = math.floor(have / needNum)

			if canNum < maxNum then
				maxNum = canNum
			end
		end
	end

	return maxNum
end

function HomeLandProcessMould.Compound(cid, buildingCid, num)
	net_home.compound(cid, buildingCid, num)
end

function HomeLandProcessMould.Decompose(cid, buildingCid, num)
	net_home.decompose(cid, buildingCid, num)
end

function HomeLandProcessMould.CompoundResult(getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end

function HomeLandProcessMould.DecomposeResult(getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end
