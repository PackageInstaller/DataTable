-- chunkname: @IQIGame\\Module\\HomeLand\\HLWork\\HLWorkModule.lua

HLWorkModule = {
	RECORD_LIMIT_NUM = 20
}

function HLWorkModule.Reload(todayHomeWorkCount)
	HLWorkModule.todayHomeWorkCount = todayHomeWorkCount

	HLWorkModule.ResetWorkCount(1)
end

function HLWorkModule.GetWorkData(buildingCid)
	return HomeLandLuaModule.GetBuildingDataByID(buildingCid).workData
end

function HLWorkModule.ResetWorkCount(type)
	if HLWorkModule.todayHomeWorkCount == nil then
		HLWorkModule.todayHomeWorkCount = 0

		error("服务器打工次数错误: " .. tostring(type))
	end
end

function HLWorkModule.EnterWorkRoom(affairData)
	HLWorkModule.affairDataOnEnterRoom = affairData

	GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
	GameEntry.LuaEvent:Fire(nil, HomelandEnterRoomEventArgs():Fill(affairData.cfgAffairData.RoomId, affairData.cid))
	UIModule.Close(Constant.UIControllerName.HomeLandWorkListUI)
end

function HLWorkModule.QuiteWorkRoom()
	if HomeLandLuaModule.currentEnterRoomID > 0 then
		GameEntry.LuaEvent:Fire(nil, HomelandQuitRoomEventArgs():Fill(HomeLandLuaModule.currentEnterRoomID))
	end
end

function HLWorkModule.GetWorkLimitTimes()
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildWork)
	local cfgLvUpData = buildingData:GetCfgBuildLevelUpByLv(buildingData.buildingPOD.lv)

	for i, v in ipairs(cfgLvUpData.Type) do
		if v == 16 then
			return cfgLvUpData.Params[i][1]
		end
	end

	return 0
end

function HLWorkModule.CheckWorkTimesOk()
	return HLWorkModule.todayHomeWorkCount < HLWorkModule.GetWorkLimitTimes()
end

function HLWorkModule.SaveRecordData(affairData, rewardDataList, isPerfect)
	if affairData == nil then
		return
	end

	local eventDataList = {}

	for i, v in ipairs(affairData.events) do
		eventDataList[#eventDataList + 1] = {
			v.cid,
			v.time,
			v.soulCid
		}
	end

	if HLWorkModule.recordDataList == nil then
		HLWorkModule.recordDataList = {}
	end

	if #HLWorkModule.recordDataList == HLWorkModule.RECORD_LIMIT_NUM then
		table.remove(HLWorkModule.recordDataList, 1)
	end

	HLWorkModule.recordDataList[#HLWorkModule.recordDataList + 1] = {
		affairData.cid,
		eventDataList,
		rewardDataList,
		isPerfect,
		affairData.id
	}

	PlayerPrefsUtil.SetLuaTable("HLWorkModule" .. PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.WorkRecord, HLWorkModule.recordDataList)
end

function HLWorkModule.GetRecordDataList()
	local tempTable = PlayerPrefsUtil.GetLuaTable("HLWorkModule" .. PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.WorkRecord)

	if tempTable == nil then
		HLWorkModule.recordDataList = {}
	else
		HLWorkModule.recordDataList = HLWorkModule.Parse2LuaTable(tempTable)
	end

	for i, v in pairs(HLWorkModule.recordDataList) do
		if v[3] == nil then
			HLWorkModule.recordDataList[i][3] = {}
		end
	end

	return HLWorkModule.recordDataList
end

function HLWorkModule.DeleteAllRecord()
	HLWorkModule.recordDataList = {}

	PlayerPrefsUtil.SetLuaTable("HLWorkModule" .. PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.WorkRecord, HLWorkModule.recordDataList)
end

function HLWorkModule.DeleteRecord(id)
	local pos = 1

	for i, v in ipairs(HLWorkModule.recordDataList) do
		if v[5] == id then
			pos = i

			break
		end
	end

	table.remove(HLWorkModule.recordDataList, pos)
	PlayerPrefsUtil.SetLuaTable("HLWorkModule" .. PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.WorkRecord, HLWorkModule.recordDataList)
	EventDispatcher.Dispatch(EventID.HLDeleteRecordSuccess)
end

function HLWorkModule.Parse2LuaTable(prefsTable)
	local ret = {}

	for i, v in pairs(prefsTable) do
		local key = tonumber(i)

		if key then
			if type(v) == "table" then
				ret[key] = HLWorkModule.Parse2LuaTable(v)
			else
				ret[key] = v
			end
		elseif type(v) == "table" then
			ret[i] = HLWorkModule.Parse2LuaTable(v)
		else
			ret[i] = v
		end
	end

	return ret
end

function HLWorkModule.ReqStartWork(buildingCid, soulCids, affairData)
	if soulCids and affairData then
		net_home.startWork(buildingCid, affairData.id, soulCids)
	else
		net_home.startWork(buildingCid, 0, nil)
	end

	HLWorkModule.affairDataOnEnterRoom = affairData
end

function HLWorkModule.OnReqStartWorkResult(buildingPOD, count)
	if count == 0 then
		NoticeModule.ShowNotice(21042045)
	end

	HLWorkModule.todayHomeWorkCount = HLWorkModule.todayHomeWorkCount + count

	HomeLandLuaModule.UpdateBuilding(buildingPOD)
	EventDispatcher.Dispatch(EventID.HLWorkSuccess)

	if HLWorkModule.affairDataOnEnterRoom == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.HomeLandWorkEffectUI, Constant.UILayer.Mid, HLWorkModule.affairDataOnEnterRoom)
	UIModule.Close(Constant.UIControllerName.HomeLandWorkListUI)
	UIModule.Close(Constant.UIControllerName.HomeLandWorkSoulUI)
end

function HLWorkModule.ReqGiveUpWork(affairId, buildingCid)
	net_home.undoAffair(affairId, buildingCid)
end

function HLWorkModule.OnReqGiveUpWorkResult()
	return
end

function HLWorkModule.ReqGetReward(buildingCid, affairId)
	HLWorkModule.lastRewardAffairDic = {}

	local workData = HLWorkModule.GetWorkData(buildingCid)

	for i, v in pairs(workData.affairDatum) do
		if v.status == 2 then
			HLWorkModule.lastRewardAffairDic[v.id] = {
				cid = v.cid,
				events = v.events,
				id = v.id
			}
		end
	end

	net_home.rewardWork(buildingCid, affairId)
end

function HLWorkModule.OnReqGetRewardResult(building, rewardPODs)
	HomeLandLuaModule.UpdateBuilding(building)

	if #rewardPODs > 1 then
		local id2DataDic = {}

		for i, v in ipairs(rewardPODs) do
			if v.itemAward ~= nil then
				for m, n in ipairs(v.itemAward) do
					if id2DataDic[n.cid] == nil then
						id2DataDic[n.cid] = {
							cid = n.cid,
							num = n.num,
							tag = n.tag
						}
					else
						id2DataDic[n.cid].num = id2DataDic[n.cid].num + n.num
					end
				end
			end
		end

		local itemAward = {}

		for i, v in pairs(id2DataDic) do
			itemAward[#itemAward + 1] = v
		end

		if #itemAward > 0 then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAward)
		end

		for i, v in ipairs(rewardPODs) do
			local rewardList = {}

			if v.itemAward ~= nil then
				for m, n in pairs(v.itemAward) do
					rewardList[#rewardList + 1] = {
						n.cid,
						n.num
					}
				end
			end

			table.sort(rewardList, function(a, b)
				return a[1] < b[1]
			end)
			HLWorkModule.SaveRecordData(HLWorkModule.lastRewardAffairDic[v.affairId], rewardList, v.superSuc)
		end
	else
		local WorkRewardResultPOD = rewardPODs[1]
		local itemAward = WorkRewardResultPOD.itemAward

		if WorkRewardResultPOD.superSuc then
			UIModule.Open(Constant.UIControllerName.HomeLandWorkPerfectFinishUI, Constant.UILayer.UI, itemAward)
		elseif itemAward ~= nil then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAward)
		end

		local rewardList = {}

		if itemAward ~= nil then
			for i, v in pairs(itemAward) do
				rewardList[#rewardList + 1] = {
					v.cid,
					v.num
				}
			end
		end

		table.sort(rewardList, function(a, b)
			return a[1] < b[1]
		end)
		HLWorkModule.SaveRecordData(HLWorkModule.lastRewardAffairDic[WorkRewardResultPOD.affairId], rewardList, WorkRewardResultPOD.superSuc)
	end

	EventDispatcher.Dispatch(EventID.HomeLandUpdateBuildWork, building.cid)
end

function HLWorkModule.ReqRefreshAffair(affairId, buildingId, isFree)
	local cid = CfgDiscreteDataTable[6520058].Data[1]
	local count = CfgDiscreteDataTable[6520058].Data[2]

	if not isFree then
		if cid == Constant.ItemID.ID_PAYPOINT_SHOW then
			if count > PlayerModule.PlayerInfo.baseInfo.payPoint then
				NoticeModule.ShowNoticeNoCallback(21041006)

				return
			end
		elseif count > WarehouseModule.GetItemNumByCfgID(cid) then
			NoticeModule.ShowNoticeNoCallback(21041006)

			return
		end
	end

	net_home.resetAffair(affairId, buildingId, isFree)
end

function HLWorkModule.OnReqRefreshAffair()
	return
end

function HLWorkModule.OnNotifyDailyReset(dailyWorkCount)
	HLWorkModule.todayHomeWorkCount = dailyWorkCount

	HLWorkModule.ResetWorkCount(2)
end
