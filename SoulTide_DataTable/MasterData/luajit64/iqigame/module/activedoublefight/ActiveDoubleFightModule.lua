-- chunkname: @IQIGame\\Module\\ActiveDoubleFight\\ActiveDoubleFightModule.lua

local m = {
	lastScore = 0
}
local ActiveDoubleFightRewardData = require("IQIGame.Module.ActiveDoubleFight.ActiveDoubleFightRewardData")

function m.Reload()
	return
end

function m.CheckChallengeLevelUnlock(eventCfgId, fightListCfgId)
	local data = m.GetDoubleFightStepPOD(eventCfgId, fightListCfgId)

	if data then
		return true
	end

	return false
end

function m.GetDoubleFightStepPOD(eventCfgId, fightListCfgId)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(eventCfgId)

	if operationEventDataPOD then
		m.doubleFightDataPOD = operationEventDataPOD.doubleFightDataPOD

		if m.doubleFightDataPOD and m.doubleFightDataPOD.doubleFightSteps then
			local cfgFightGlobal = CfgDoubleFightGlobalTable[operationEventDataPOD.dataCfgId]
			local index = table.indexOf(cfgFightGlobal.FightList, fightListCfgId)

			for i, v in pairs(m.doubleFightDataPOD.doubleFightSteps) do
				if v.step == index then
					return v
				end
			end
		end
	end

	return nil
end

function m.GetDoubleFightLastScore(eventCfgId, fightListCfgId, index)
	local lastScore = 0
	local doubleFightStepPOD = m.GetDoubleFightStepPOD(eventCfgId, fightListCfgId)

	if doubleFightStepPOD and doubleFightStepPOD.records then
		for i, v in pairs(doubleFightStepPOD.records) do
			if v.index == index then
				lastScore = v.hurtScore + v.roundScore

				break
			end
		end
	end

	return lastScore
end

function m.GetRewardBoxState(eventCfgId, fightListCfgId, index)
	local state = 3
	local data = m.GetDoubleFightStepPOD(eventCfgId, fightListCfgId)

	if data then
		if data.getAwardsIndex and table.indexOf(data.getAwardsIndex, index) ~= -1 then
			state = 1
		end

		if state ~= 1 then
			local cfgDoubleFightList = CfgDoubleFightListTable[fightListCfgId]
			local needScore = cfgDoubleFightList.ScoreList[index]

			if needScore <= data.maxScore then
				state = 2
			end
		end
	end

	return state
end

function m.CheckAllDoubleFightRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_AlienInvasion then
				local top = m.CheckDoubleFightRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckDoubleFightRedPoint(operateEventID)
	local isCanGetReward = false
	local isOpen = false
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		local cfgFightGlobal = CfgDoubleFightGlobalTable[operationEventDataPOD.dataCfgId]

		for i, v in pairs(cfgFightGlobal.FightList) do
			local top = m.CheckDoubleFightListRedPoint(operateEventID, v)

			if top then
				isCanGetReward = true

				break
			end
		end

		local key = PlayerModule.PlayerInfo.baseInfo.pid .. operationEventDataPOD.dataCfgId
		local openState = PlayerPrefsUtil.GetInt(key, Constant.PlayerPrefsConst.Open_DoubleFight)

		if openState == 0 then
			isOpen = true
		end
	end

	return isCanGetReward or isOpen
end

function m.CheckDoubleFightListRedPoint(operateEventID, fightListCid)
	local cfgDoubleFightList = CfgDoubleFightListTable[fightListCid]

	for i = 1, #cfgDoubleFightList.ScoreList do
		local state = m.GetRewardBoxState(operateEventID, fightListCid, i)

		if state == 2 then
			return true
		end
	end

	return false
end

function m.SaveOpenDoubleFightPrefs(operateEventID)
	if ActiveOperationEventModule.CheckIsOpen(operateEventID) then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

		if operationEventDataPOD then
			local key = PlayerModule.PlayerInfo.baseInfo.pid .. operationEventDataPOD.dataCfgId

			PlayerPrefsUtil.SetInt(key, Constant.PlayerPrefsConst.Open_DoubleFight, 1)
			EventDispatcher.Dispatch(EventID.UpdateDoubleFightRedPoint)
		end
	end
end

function m.Shutdown()
	m.doubleFightDataPOD = nil
	m.fightListCfgId = nil
	m.index = nil
	m.lastScore = 0
end

function m.GetRewards(operateEventID, fightListCid, list)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)
	local cfgFightGlobal = CfgDoubleFightGlobalTable[operationEventDataPOD.dataCfgId]
	local index = table.indexOf(cfgFightGlobal.FightList, fightListCid)

	net_operationsDoubleFight.getRewards(operateEventID, index, list)
end

function m.Fight(operateEventID, step, index, formationId, fightListCfgId)
	m.fightListCfgId = fightListCfgId
	m.index = index
	m.lastScore = m.GetDoubleFightLastScore(operateEventID, fightListCfgId, index)

	net_operationsDoubleFight.fight(operateEventID, step, index, formationId)
end

function m.FightResult(code)
	return
end

function m.GetRewardsResult(items, eventId, step, indexs)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	local OperationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(eventId)

	if OperationEventDataPOD and OperationEventDataPOD.doubleFightDataPOD then
		for i, v in pairs(OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps) do
			if v.step == step then
				for j, k in pairs(indexs) do
					if table.indexOf(OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps[i].getAwardsIndex, k) == -1 then
						table.insert(OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps[i].getAwardsIndex, k)
					end
				end
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.NotifyFightComplete(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
	MainCityBattleModule.Instance:QuitBattle()

	local newScore = hurtScore + roundScore
	local isUp = newScore > m.lastScore
	local rewardData = ActiveDoubleFightRewardData.New(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round, m.fightListCfgId, m.index, isUp)

	UIModule.Open(Constant.UIControllerName.DoubleFightRewardUI, Constant.UILayer.UI, rewardData)

	m.fightListCfgId = nil
	m.index = nil
	m.lastScore = 0
end

function m.NotifyUpdateDoubleFightStepPOD(eventId, doubleFightStepPOD)
	local OperationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(eventId)

	if OperationEventDataPOD and OperationEventDataPOD.doubleFightDataPOD then
		local isNew = true

		for i, v in pairs(OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps) do
			if v.step == doubleFightStepPOD.step then
				OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps[i] = doubleFightStepPOD
				isNew = false
			end
		end

		if isNew then
			table.insert(OperationEventDataPOD.doubleFightDataPOD.doubleFightSteps, doubleFightStepPOD)
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

ActiveDoubleFightModule = m
