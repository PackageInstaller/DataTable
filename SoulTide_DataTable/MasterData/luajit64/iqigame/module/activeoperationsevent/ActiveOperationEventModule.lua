-- chunkname: @IQIGame\\Module\\ActiveOperationsEvent\\ActiveOperationEventModule.lua

local m = {
	opEventsStatus = {},
	opEventsDates = {}
}

function m.Reload(opEventsStatus, opEventsDates)
	m.opEventsStatus = {}

	if opEventsStatus then
		for i, v in pairs(opEventsStatus) do
			if v.status ~= Constant.Activity_Operation_Sate.STATUS_CLOSED then
				table.insert(m.opEventsStatus, v)
			end
		end
	end

	m.opEventsDates = opEventsDates

	ActiveGroupBuyModule.Reload()
	ActivePicturePuzzleModule.Reload()
	ActiveMagicWaxMuseumModule.Reload()
	ActiveNewCharacterModule.Reload()
	ActiveGachaModule.Reload()
	DollBingoModule.Reload()
	PaidChallengeModule.Reload()
	ActiveDoubleFightModule.Reload()
	ActiveSpaceTreasureModule.Reload()
	FurnitureGashaponModule.Reload()
	ActiveLuckyTurnTableModule.Reload()
	ActivePandaModule.Reload()
	ActiveVoteModule.Reload()
	ReplacementPassModule.Reload()
	ActiveNewYearGiftModule.Reload()
	ActiveWelcomeNewModule.Reload()
	ActiveDropExchangeModule.Reload()
	ActivityTurnModule.Reload()
	ActiveLimitedTurnModule.Reload()
	ActiveCupVotingModule.Reload()
end

function m.GetEventDataPOD(eventCfgId)
	for i, v in pairs(m.opEventsDates) do
		if v.eventCfgId == eventCfgId then
			return v
		end
	end

	return nil
end

function m.GetOpenOperationEvent()
	local tab = {}

	if m.opEventsStatus then
		for i, v in pairs(m.opEventsStatus) do
			if v then
				local top = m.CheckIsOpen(v.eventCfgId)

				if top then
					table.insert(tab, v.eventCfgId)
				end
			end
		end
	end

	table.sort(tab, function(a, b)
		return a < b
	end)

	return tab
end

function m.CheckIsOpen(activeID)
	local cfg = CfgOperateEventsControlTable[activeID]
	local isCondition = UnlockFunctionModule.IsUnlock(cfg.FunctionType)

	if isCondition then
		local operationEventPOD = m.GetActiveOperationData(activeID)

		if operationEventPOD and (operationEventPOD.status == Constant.Activity_Operation_Sate.STATUS_STARTED or operationEventPOD.status == Constant.Activity_Operation_Sate.STATUS_END) then
			return true
		end
	end

	return false
end

function m.UpdateOperationEventData(pod)
	if pod then
		local isNew = true

		if m.opEventsDates == nil then
			m.opEventsDates = {}
		end

		for i, v in pairs(m.opEventsDates) do
			if v.eventCfgId == pod.eventCfgId then
				local oldPOD = m.opEventsDates[i]

				for key, value in pairs(pod) do
					oldPOD[key] = value
				end

				isNew = false

				break
			end
		end

		if isNew then
			table.insert(m.opEventsDates, pod)
		end
	end
end

function m.GetActiveOperationData(cfgID)
	if m.opEventsStatus then
		for i, v in pairs(m.opEventsStatus) do
			if v.eventCfgId == cfgID then
				return v
			end
		end
	end

	return nil
end

function m.CheckOperationRedPoint()
	local red = ActivePicturePuzzleModule.CheckAllRedPoint() or ActiveNewCharacterModule.CheckAllNewCharacterRedPoint() or ActiveMagicWaxMuseumModule.CheckAllMagicWaxMuseumRedPoint() or ActivitySignModule.CheckRedPointByType() or FurnitureGashaponModule.CheckRedPointByType() or ActiveModule.CheckRedPointOnMoon() or ActiveModule.CheckRedPointOnNationalDay() or ActiveSpaceTreasureModule.CheckAllSpaceTreasureRedPoint() or ActiveDoubleFightModule.CheckAllDoubleFightRedPoint() or ActivePandaModule.CheckAllPandaRedPoint() or PaidChallengeModule.CheckRedPoint() or ReplacementPassModule.CheckReplacementPassRedPoint() or ActiveNewYearGiftModule.CheckAllNewYearGiftRedPoint() or ActivityTurnModule.CheckAllTurnRedPoint() or ActiveLimitedTurnModule.CheckAllLimitedTurnRedPoint() or ActiveCupVotingModule.CheckAllCupVotingRedPoint()

	return red
end

function m.NotifyAllEventStatus(list)
	local tab = {}

	for i, v in pairs(list) do
		local top = false

		for i1, v1 in pairs(m.opEventsStatus) do
			if v.eventCfgId == v1.eventCfgId then
				local oldData = m.opEventsStatus[i1]

				for key, value in pairs(v) do
					oldData[key] = value
				end

				top = true
			end
		end

		if top == false then
			table.insert(m.opEventsStatus, v)
		end
	end

	for i, v in pairs(m.opEventsStatus) do
		if v.status ~= Constant.Activity_Operation_Sate.STATUS_CLOSED then
			table.insert(tab, v)
		end
	end

	m.opEventsStatus = tab

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.NotifyOperationEventData(pod)
	m.UpdateOperationEventData(pod)
	DollBingoModule.OnNotifyUpdate()
	PaidChallengeModule.OnNotifyUpdate()
	FurnitureGashaponModule.OnNotifyUpdate()
	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.Shutdown()
	m.opEventsStatus = {}

	ActiveGroupBuyModule.Shutdown()
	ActivePicturePuzzleModule.Shutdown()
	ActiveMagicWaxMuseumModule.Shutdown()
	ActiveNewCharacterModule.Shutdown()
	ActiveGachaModule.Shutdown()
	ActiveDoubleFightModule.Shutdown()
	ActiveSpaceTreasureModule.Shutdown()
	FurnitureGashaponModule.Shutdown()
	DollBingoModule.Shutdown()
	PaidChallengeModule.Shutdown()
	ActiveLuckyTurnTableModule.Shutdown()
	ActivePandaModule.Shutdown()
	ActiveVoteModule.Shutdown()
	ReplacementPassModule.Shutdown()
	ActiveNewYearGiftModule.Shutdown()
	ActiveWelcomeNewModule.Shutdown()
	ActiveDropExchangeModule.Shutdown()
	ActivityTurnModule.Shutdown()
	ActiveLimitedTurnModule.Shutdown()
	ActiveCupVotingModule.Shutdown()
end

ActiveOperationEventModule = m
