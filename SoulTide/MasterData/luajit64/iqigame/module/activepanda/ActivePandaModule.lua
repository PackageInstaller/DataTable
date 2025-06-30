-- chunkname: @IQIGame\\Module\\ActivePanda\\ActivePandaModule.lua

local m = {
	isSendingAction = false,
	sceneEvents = {}
}
local PandaScene = require("IQIGame.Scene.Panda.PandaScene")

function m.Reload()
	return
end

function m.AddListeners()
	EventDispatcher.AddEventListener(EventID.LoadSceneSuccess, m.OnLoadSceneSuccess)
end

function m.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LoadSceneSuccess, m.OnLoadSceneSuccess)
end

function m.GetCostCidTab(operateEventID)
	local costCidTab = {}
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

	if eventPOD then
		local cfgFPandaData = CfgPandaActivityGlobalTable[eventPOD.dataCfgId]
		local id

		if #cfgFPandaData.FeedingNeeds > 0 then
			id = cfgFPandaData.FeedingNeeds[1]

			table.insert(costCidTab, id)
		end

		if #cfgFPandaData.BathingNeeds > 0 then
			id = cfgFPandaData.BathingNeeds[1]

			if table.indexOf(costCidTab, id) == -1 then
				table.insert(costCidTab, id)
			end
		end

		if #cfgFPandaData.PlayNeeds > 0 then
			id = cfgFPandaData.PlayNeeds[1]

			if table.indexOf(costCidTab, id) == -1 then
				table.insert(costCidTab, id)
			end
		end
	end

	return costCidTab
end

function m.GetPandaPOD(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		return operationEventDataPOD.pandaDataPOD
	end

	return nil
end

function m.UpdatePandaDataPOD(pandaDataPOD)
	if m.currentOperateEventID == nil then
		return
	end

	if ActiveOperationEventModule.opEventsDates then
		for i, v in pairs(ActiveOperationEventModule.opEventsDates) do
			if v.eventCfgId == m.currentOperateEventID and ActiveOperationEventModule.opEventsDates[i] and ActiveOperationEventModule.opEventsDates[i].pandaDataPOD then
				ActiveOperationEventModule.opEventsDates[i].pandaDataPOD = pandaDataPOD
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.GetPandaRewardBoxState(eventCfgId, cfgGiftListID)
	local state = 3
	local data = m.GetPandaPOD(eventCfgId)

	if data then
		if data.getGifts and table.indexOf(data.getGifts, cfgGiftListID) ~= -1 then
			state = 1
		end

		if state ~= 1 then
			local cfgPandaGiftListData = CfgPandaGiftListTable[cfgGiftListID]
			local needFavor = cfgPandaGiftListData.FavorNum

			if needFavor <= data.favorNum then
				state = 2
			end
		end
	end

	return state
end

function m.CheckAllPandaRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_Panda then
				local top = m.CheckPandaRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckPandaRedPoint(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		for i, v in pairsCfg(CfgPandaGiftListTable) do
			if v.Team == operationEventDataPOD.dataCfgId then
				local state = m.GetPandaRewardBoxState(operateEventID, v.Id)

				if state == 2 then
					return true
				end
			end
		end
	end

	return false
end

function m.EnterPandaScene()
	m.AddListeners()
	SceneManager.ChangeScene(SceneID.Panda)
end

function m.ExitPandaScene()
	if m.currentOperateEventID and ActiveOperationEventModule.CheckIsOpen(m.currentOperateEventID) then
		JumpModule.Jump(10201014)
	else
		SceneManager.ChangeScene(SceneID.MainCity)
	end

	m.Shutdown()
end

function m.OnLoadSceneSuccess(sceneID)
	if sceneID == SceneID.Panda then
		m.pandaScene = PandaScene.New(m.pandaGlobalID, m.extraOperateEventID)
	end
end

function m.CheckResumeDialog()
	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		m.currDialog = nil
	end
end

function m.Shutdown()
	PandaBattleModule.Instance:Shutdown()

	m.isSendingAction = false
	m.actionCallBack = nil

	m.RemoveListeners()

	if m.pandaScene then
		m.pandaScene:Dispose()
	end

	m.pandaScene = nil
	m.extraOperateEventID = nil
	m.currentOperateEventID = nil
	m.currDialog = nil
end

function m.Action(actionType, callBack)
	if m.isSendingAction then
		return
	end

	m.actionCallBack = callBack

	net_operationsPanda.action(actionType)

	m.isSendingAction = true
end

function m.GetGift(giftId)
	net_operationsPanda.getGift(giftId)
end

function m.EnterBambooForest(data, operateEventID)
	m.pandaGlobalID = data
	m.extraOperateEventID = operateEventID

	net_operationsPanda.enterBambooForest()
end

function m.Explore()
	net_operationsPanda.explore()
end

function m.DoEvent(eventId, params)
	net_operationsPanda.doEvent(eventId, params)
end

function m.ActionResult(actionType, addFavor, favorNum, maxFavorNum, getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end

	local pandaDataPOD = m.GetPandaPOD(m.currentOperateEventID)

	pandaDataPOD.favorNum = favorNum
	pandaDataPOD.maxFavorNum = maxFavorNum

	m.UpdatePandaDataPOD(pandaDataPOD)

	if m.actionCallBack then
		m.actionCallBack(actionType, addFavor)
	end

	m.actionCallBack = nil
	m.isSendingAction = false
end

function m.GetGiftResult(giftId, itemShows)
	if #itemShows > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end

	local pandaDataPOD = m.GetPandaPOD(m.currentOperateEventID)

	if table.indexOf(pandaDataPOD.getGifts) == -1 then
		table.insert(pandaDataPOD.getGifts, giftId)
	end

	m.UpdatePandaDataPOD(pandaDataPOD)
	EventDispatcher.Dispatch(EventID.UpdatePandaActionEvent)
end

function m.EnterBambooForestResult(events, currDialog)
	m.sceneEvents = events
	m.currDialog = currDialog

	m.EnterPandaScene()
end

function m.ExploreResult(events)
	m.sceneEvents = events

	m.pandaScene:RefreshAllEventEntry()

	local pandaDataPOD = m.GetPandaPOD(m.currentOperateEventID)

	if pandaDataPOD.exploreCount >= 1 then
		pandaDataPOD.exploreCount = pandaDataPOD.exploreCount - 1

		m.UpdatePandaDataPOD(pandaDataPOD)
	end
end

function m.DoEventResult(eventId, params)
	local cfgPandaEvenListData = CfgPandaEventListTable[eventId]

	if cfgPandaEvenListData.Type ~= 2 then
		local index = table.indexOf(m.sceneEvents, eventId)

		if index ~= -1 then
			table.remove(m.sceneEvents, index)
		end

		m.pandaScene:RemoveNpc(eventId)
	end
end

function m.NotifyCompleteEvent(eventId, itemShows)
	local cfgPandaEvenListData = CfgPandaEventListTable[eventId]

	if cfgPandaEvenListData.Type ~= 2 then
		if #itemShows > 0 then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
		end

		local index = table.indexOf(m.sceneEvents, eventId)

		if index ~= -1 then
			table.remove(m.sceneEvents, index)
		end

		m.pandaScene:RemoveNpc(eventId)
	end
end

function m.NotifyFightComplete(eventId, win, itemShows)
	local cfgPandaEvenListData = CfgPandaEventListTable[eventId]

	if cfgPandaEvenListData.Type == 2 then
		PandaBattleModule.Instance:QuitBattle()

		local rewardData = ChallengeRewardData.New(1, win, itemShows, nil, nil)

		rewardData.battleType = 1

		UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

		if win then
			UIModule.Close(Constant.UIControllerName.PandaChallengeDetailInfoUI)

			local index = table.indexOf(m.sceneEvents, eventId)

			if index ~= -1 then
				table.remove(m.sceneEvents, index)
			end

			m.pandaScene:RemoveNpc(eventId)
		end
	end
end

ActivePandaModule = m
