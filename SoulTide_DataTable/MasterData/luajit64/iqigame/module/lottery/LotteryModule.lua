-- chunkname: @IQIGame\\Module\\Lottery\\LotteryModule.lua

LotteryModule = {
	UpdateSoulMsgsWhenDrawing = {},
	UpdateTaskMsgsWhenDrawing = {},
	OnGetHistoryCallbacks = {}
}

function LotteryModule.Reload(lotteryShows)
	LotteryModule.lotteryShows = lotteryShows
end

function LotteryModule.SendDraw(showId, lotteryCid, upCidList)
	net_lottery.lottery(showId, lotteryCid, upCidList)
end

function LotteryModule.LotteryResult(lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
	for cid, time in pairs(lotteryRecords) do
		PlayerModule.PlayerInfo.lotteryRecords[cid] = time
	end

	local found = false

	for i = 1, #LotteryModule.lotteryShows do
		local oldPOD = LotteryModule.lotteryShows[i]

		if oldPOD.showCid == lotteryShowPOD.showCid then
			for key, value in pairs(oldPOD) do
				oldPOD[key] = lotteryShowPOD[key]
			end

			found = true

			break
		end
	end

	if not found then
		table.insert(LotteryModule.lotteryShows, lotteryShowPOD)
	end

	xpcall(function()
		local cfgLotteryData = CfgLotteryTable[lotteryCid]

		LotteryModule.AddDailyDrawCount(cfgLotteryData.Type == Constant.Lottery.PoolTypeTen and 10 or 1)
	end, function(msg)
		logError(tostring(msg))
	end)
	EventDispatcher.Dispatch(EventID.LotteryResult, baseShowItems, showItems, lotteryShowPOD.showCid, lotteryCid)
end

function LotteryModule.GetHistory(onGetHistory)
	table.insert(LotteryModule.OnGetHistoryCallbacks, onGetHistory)
	net_lottery.getLotteryHistory()
end

function LotteryModule.OnGetHistory(historyList)
	local callback = table.remove(LotteryModule.OnGetHistoryCallbacks, 1)

	callback(historyList)
end

function LotteryModule.AddDailyDrawCount(addCount)
	local maxCount = CfgDiscreteDataTable[6520073].Data[1]

	if maxCount == 0 then
		return
	end

	local todayCount = LotteryModule.GetTodayDrawCount()
	local data = {}

	data.dayFormat = getDateText(PlayerModule.GetServerTime())
	data.count = todayCount + addCount

	SaveDataModule.SaveTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.LotteryDailyDawCount, data)
end

function LotteryModule.GetTodayDrawCount()
	local data = SaveDataModule.GetTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.LotteryDailyDawCount)

	if data == nil then
		return 0
	end

	local todayFormat = getDateText(PlayerModule.GetServerTime())

	if data.dayFormat ~= todayFormat then
		return 0
	end

	return data.count
end

function LotteryModule.GetTodayLeftDrawCount()
	local maxCount = CfgDiscreteDataTable[6520073].Data[1]
	local haveNum = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ACTIVE_POINT)
	local condition = ConditionModule.Check(26043008)
	local payPoint = PlayerModule.PlayerInfo.baseInfo.sumPay >= 99

	if maxCount == 0 or haveNum >= 50 or condition or payPoint or SettingModule.openDrawCard == 1 then
		return Constant.Number.IntMaxValue, maxCount
	end

	local todayDrawCount = LotteryModule.GetTodayDrawCount()

	return maxCount - todayDrawCount, maxCount
end

function LotteryModule.Draw(cfgLotteryShowData, cfgLotteryData, ignoreNotice)
	local leftCount, maxCount = LotteryModule.GetTodayLeftDrawCount()
	local drawCount = cfgLotteryData.Type == Constant.Lottery.PoolTypeTen and 10 or 1

	if leftCount < drawCount then
		NoticeModule.ShowNotice(21049004)

		return
	end

	local availablePickUps = LotteryModule.GetAvailablePickUps(cfgLotteryShowData)

	if #cfgLotteryShowData.UpGroupRotation > 0 and not cfgLotteryShowData.IsRotation and #availablePickUps == 0 then
		NoticeModule.ShowNotice(21049003)

		return
	end

	local upCidList = {}

	if #cfgLotteryShowData.UpGroupRotation > 0 then
		local selectedPickUps = LotteryModule.GetSelectedPickUps(cfgLotteryShowData, availablePickUps)

		if #selectedPickUps > 0 then
			for i = 1, #selectedPickUps do
				table.insert(upCidList, selectedPickUps[i].Id)
			end
		end
	end

	local leftFreeTime, haveFreeFunc = LotteryModule.CanFreeDraw(cfgLotteryData)

	if leftFreeTime > 0 then
		local costItemCid, costItemNum, isPayPoint = LotteryModule.GetCostItem(cfgLotteryData)
		local hasCostItemNum

		if isPayPoint then
			hasCostItemNum = PlayerModule.PlayerInfo.baseInfo.payPoint

			if hasCostItemNum < costItemNum then
				NoticeModule.MoneyDeficitTip(2, costItemNum - hasCostItemNum)

				return
			end
		else
			hasCostItemNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

			if hasCostItemNum < costItemNum then
				if cfgLotteryData.AutoBuy ~= 0 or costItemCid == Constant.ItemID.TREASURE then
					EventDispatcher.Dispatch(EventID.LotteryAutoBuyItem, cfgLotteryShowData.Id, cfgLotteryData.Id, cfgLotteryData.AutoBuy)

					if cfgLotteryData.AutoBuy ~= 0 then
						UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
							type = 1,
							mallCid = cfgLotteryData.AutoBuy,
							num = costItemNum - hasCostItemNum
						})
					elseif costItemCid == Constant.ItemID.TREASURE then
						NoticeModule.MoneyDeficitTip(1, costItemNum - hasCostItemNum)
					end
				else
					local cfgItemData = CfgItemTable[costItemCid]

					NoticeModule.ShowNoticeByType(1, getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, cfgItemData.Name))
				end

				return
			end
		end

		if ignoreNotice then
			LotteryModule.SendDraw(cfgLotteryShowData.Id, cfgLotteryData.Id, upCidList)
		else
			NoticeModule.ShowNoticeBuyConfirm(21049001, function()
				LotteryModule.SendDraw(cfgLotteryShowData.Id, cfgLotteryData.Id, upCidList)
			end, nil, nil, {
				costItemCid
			}, {
				costItemNum
			})
		end
	else
		LotteryModule.SendDraw(cfgLotteryShowData.Id, cfgLotteryData.Id, upCidList)
	end

	LotteryModule.IsDrawing = true
end

function LotteryModule.CanFreeDraw(cfgLotteryData)
	if cfgLotteryData.FreeType == 0 then
		return Constant.Number.IntMaxValue, false
	else
		local lastDrawTime = 0

		if PlayerModule.PlayerInfo.lotteryRecords ~= nil then
			lastDrawTime = PlayerModule.PlayerInfo.lotteryRecords[cfgLotteryData.Id] or 0
		end

		local serverTime = PlayerModule.GetServerTime()
		local fourHourSec = 14400

		if cfgLotteryData.FreeType == 1 then
			local timePassed = serverTime - lastDrawTime
			local leftSec = cfgLotteryData.FreeIntervalTime - timePassed

			if leftSec < 0 then
				leftSec = 0
			end

			return leftSec, true
		elseif cfgLotteryData.FreeType == 2 then
			if lastDrawTime == 0 then
				return 0, true
			end

			local lastTimeTable = getDateTimeTable(lastDrawTime - fourHourSec)
			local curTimeTable = getDateTimeTable(serverTime - fourHourSec)
			local isSameDay = lastTimeTable.year == curTimeTable.year and lastTimeTable.month == curTimeTable.month and lastTimeTable.day == curTimeTable.day

			if not isSameDay then
				return 0, true
			end

			local nextRefreshTimeTable = table.clone(curTimeTable)

			nextRefreshTimeTable.hour = 0
			nextRefreshTimeTable.min = 0
			nextRefreshTimeTable.sec = 0

			local todayZeroSec = dateTimeToTimeStamp(nextRefreshTimeTable, PlayerModule.TimeZone)
			local tomorrowZeroSec = todayZeroSec + 86400

			return tomorrowZeroSec - (serverTime - fourHourSec), true
		end

		logError("计算免费祈愿时间出错。FreeType：" .. tostring(cfgLotteryData.FreeType))
	end
end

function LotteryModule.DrawComplete()
	LotteryModule.IsDrawing = false

	if #LotteryModule.UpdateSoulMsgsWhenDrawing > 0 then
		for i = 1, #LotteryModule.UpdateSoulMsgsWhenDrawing do
			local soulPOD = LotteryModule.UpdateSoulMsgsWhenDrawing[i]

			SoulModule.OnUpdateSoul(soulPOD)
		end

		LotteryModule.UpdateSoulMsgsWhenDrawing = {}
	end

	if #LotteryModule.UpdateTaskMsgsWhenDrawing > 0 then
		for i = 1, #LotteryModule.UpdateTaskMsgsWhenDrawing do
			local data = LotteryModule.UpdateTaskMsgsWhenDrawing[i]

			TaskModule.ResponseUpdateTaskMsg(data.updateQuest, data.isRemove)
		end

		LotteryModule.UpdateTaskMsgsWhenDrawing = {}
	end
end

function LotteryModule.ShowOneSoulComplete()
	if #LotteryModule.UpdateSoulMsgsWhenDrawing > 0 then
		local soulPOD = LotteryModule.UpdateSoulMsgsWhenDrawing[1]

		table.remove(LotteryModule.UpdateSoulMsgsWhenDrawing, 1)
		SoulModule.OnUpdateSoul(soulPOD)
	end
end

function LotteryModule.PushUpdateSoulMsgWhenDrawing(soulPOD)
	if not LotteryModule.IsDrawing then
		return false
	end

	table.insert(LotteryModule.UpdateSoulMsgsWhenDrawing, soulPOD)

	return true
end

function LotteryModule.PushUpdateTaskMsgWhenDrawing(updateQuest, isRemove)
	if not LotteryModule.IsDrawing then
		return false
	end

	table.insert(LotteryModule.UpdateTaskMsgsWhenDrawing, {
		updateQuest = updateQuest,
		isRemove = isRemove
	})

	return true
end

function LotteryModule.GetCostItem(cfgLotteryData)
	if cfgLotteryData.payPoint > 0 then
		return Constant.ItemID.ID_PAYPOINT_SHOW, cfgLotteryData.payPoint, true
	end

	return cfgLotteryData.ItemCost[1], cfgLotteryData.ItemCost[2], false
end

function LotteryModule.GetLotteryShowPOD(cid)
	for i = 1, #LotteryModule.lotteryShows do
		local lotteryShowPOD = LotteryModule.lotteryShows[i]

		if lotteryShowPOD.showCid == cid then
			return lotteryShowPOD
		end
	end

	logError("找不到lotteryShowPOD. LotteryShowCid" .. cid)

	return nil
end

function LotteryModule.GetAvailablePickUps(cfgLotteryShowData)
	local upGroupRotationLen = #cfgLotteryShowData.UpGroupRotation

	if upGroupRotationLen == 0 then
		return {}
	end

	local elapsedSecFromStart = PlayerModule.GetServerTime() - cfgDateTimeToTimeStamp(cfgLotteryShowData.UpStartDate, PlayerModule.TimeZone)
	local index = math.floor(elapsedSecFromStart / 604800)

	if cfgLotteryShowData.IsRotation then
		index = index % upGroupRotationLen
	end

	local luaIndex = index + 1
	local groupId = cfgLotteryShowData.UpGroupRotation[luaIndex]
	local pickUpCfgDataList = {}

	if groupId ~= nil then
		for id, cfgLotteryPackUpData in pairsCfg(CfgLotteryPackUpTable) do
			if cfgLotteryPackUpData.Group == groupId then
				table.insert(pickUpCfgDataList, cfgLotteryPackUpData)
			end
		end
	end

	if cfgLotteryShowData.IsRotation and #pickUpCfgDataList == 0 then
		logError("找不到对应的PackUp数据。LotteryShow.Id " .. cfgLotteryShowData.Id .. " index of LotteryShow.UpGroupRotation: " .. tostring(luaIndex) .. " Group id: " .. tostring(groupId))

		return {}
	end

	table.sort(pickUpCfgDataList, function(cfg1, cfg2)
		return cfg1.Id < cfg2.Id
	end)

	return pickUpCfgDataList
end

function LotteryModule.GetSelectedPickUps(cfgLotteryShowData, allDataList)
	if #cfgLotteryShowData.UpGroupRotation == 0 then
		return {}
	end

	local resultList = {}
	local savedPUMap = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.LotteryPackUpCids)
	local packUpCidList

	if savedPUMap ~= nil then
		packUpCidList = savedPUMap[tostring(cfgLotteryShowData.Id)]
	end

	if packUpCidList ~= nil and (type(packUpCidList) == "string" or type(packUpCidList) == "number") then
		packUpCidList = {
			packUpCidList
		}
	end

	if packUpCidList ~= nil then
		local cidIndexMap = {}

		for key, cidStr in pairs(packUpCidList) do
			local index = tonumber(key)
			local cid = tonumber(cidStr)

			cidIndexMap[cid] = index

			local cfgLotteryPackUpData = CfgLotteryPackUpTable[cid]

			if cfgLotteryPackUpData ~= nil then
				table.insert(resultList, cfgLotteryPackUpData)
			end
		end

		table.sort(resultList, function(cfgData1, cfgData2)
			local index1 = cidIndexMap[cfgData1.Id]
			local index2 = cidIndexMap[cfgData2.Id]

			return index1 < index2
		end)

		if #resultList > 0 then
			return resultList
		end
	end

	if allDataList == nil then
		allDataList = LotteryModule.GetAvailablePickUps(cfgLotteryShowData)
	end

	for i = 1, #allDataList do
		table.insert(resultList, allDataList[i])

		if i >= cfgLotteryShowData.ChoiceNum then
			break
		end
	end

	return resultList
end

function LotteryModule.CheckInOpenTime(cfgLotteryShowData)
	local leftTimeSec
	local beginTimeSec = 0

	if cfgLotteryShowData.BeginType == 1 and cfgLotteryShowData.BeginTime ~= "" then
		beginTimeSec = cfgDateTimeToTimeStamp(cfgLotteryShowData.BeginTime, PlayerModule.TimeZone)
	elseif cfgLotteryShowData.BeginType == 2 then
		beginTimeSec = PlayerModule.PlayerInfo.baseInfo.createTime
	else
		return true, nil
	end

	if beginTimeSec > PlayerModule.GetServerTime() then
		return false, 0
	end

	leftTimeSec = beginTimeSec + cfgLotteryShowData.EndTime - PlayerModule.GetServerTime()

	return leftTimeSec > 0, leftTimeSec
end
