-- chunkname: @IQIGame\\Module\\Active\\DollBingo\\DollBingoModule.lua

DollBingoModule = {
	PER_REQ_RECORD_NUM = 20,
	eventID2BingoDataDic = {}
}

local BingoData = require("IQIGame.Module.Active.DollBingo.BingoData")

function DollBingoModule.Reload()
	for i, v in pairsCfg(CfgOperateEventsControlTable) do
		if v.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			local eventID = v.Id

			if not ActiveOperationEventModule.CheckIsOpen(eventID) then
				return
			end

			local bingoData = DollBingoModule.eventID2BingoDataDic[eventID]

			if bingoData == nil then
				bingoData = BingoData.New()
				DollBingoModule.eventID2BingoDataDic[eventID] = bingoData
			end

			local pod = ActiveOperationEventModule.GetEventDataPOD(eventID)

			if pod ~= nil then
				bingoData:Update(pod)
			else
				DollBingoModule.eventID2BingoDataDic[eventID] = nil
			end
		end
	end
end

function DollBingoModule.Shutdown()
	DollBingoModule.operateEventID = nil
end

function DollBingoModule.GetBingoData(eventID)
	return DollBingoModule.eventID2BingoDataDic[eventID]
end

function DollBingoModule.CheckRedPoint(eventID)
	local data = DollBingoModule.GetBingoData(eventID)

	if data == nil then
		return false
	end

	local costCard = data.cfgNewActivityData.CardCost[1]

	return costCard <= WarehouseModule.GetItemNumByCfgID(data.cfgNewActivityData.CardID)
end

function DollBingoModule.ReqLottery(eventID, type)
	local index

	if type == 1 then
		index = 1
	elseif type == 2 then
		index = 2
	end

	local data = DollBingoModule.GetBingoData(eventID)
	local costCard = data.cfgNewActivityData.CardCost[index]

	if costCard > WarehouseModule.GetItemNumByCfgID(data.cfgNewActivityData.CardID) then
		NoticeModule.ShowNoticeNoCallback(21041013)

		return
	end

	DollBingoModule.lastLotteryType = type

	net_operationsNewCharacter.newCharacterUnlock(eventID, type)
end

function DollBingoModule.OnReqLottery(cardList, bingoIdList, showList)
	DollBingoModule.lastNumCids = cardList
	DollBingoModule.lastBingoCids = bingoIdList
	DollBingoModule.lastShowList = showList

	EventDispatcher.Dispatch(EventID.BingoLotterySuccess)
end

function DollBingoModule.ReqRecord(eventID, startIndex)
	local endIndex = startIndex + DollBingoModule.PER_REQ_RECORD_NUM - 1

	if endIndex <= #DollBingoModule.recordDatum then
		EventDispatcher.Dispatch(EventID.BingoUpdateRecordSuccess)
	else
		net_operationsNewCharacter.bingoLog(eventID, startIndex - 1)
	end
end

function DollBingoModule.OnReqRecord(code, podList)
	NetCommController.Responded()

	if code == 0 then
		for i, v in ipairs(podList) do
			if DollBingoModule.id2RecordDic[v.idx] == nil then
				local rewardDatum = {}

				for m, n in ipairs(v.rewards) do
					rewardDatum[#rewardDatum + 1] = {
						n.cid,
						n.num
					}
				end

				DollBingoModule.recordDatum[#DollBingoModule.recordDatum + 1] = {
					type = v.type,
					id = v.id,
					idx = v.idx,
					time = v.time,
					rewardDatum = rewardDatum
				}
				DollBingoModule.id2RecordDic[v.idx] = v.idx
			end
		end

		table.sort(DollBingoModule.recordDatum, function(a, b)
			if a.time == b.time then
				return a.idx > b.idx
			end

			return a.time > b.time
		end)
	end

	EventDispatcher.Dispatch(EventID.BingoUpdateRecordSuccess)
end

function DollBingoModule.OnNotifyUpdate()
	DollBingoModule.Reload()
end
