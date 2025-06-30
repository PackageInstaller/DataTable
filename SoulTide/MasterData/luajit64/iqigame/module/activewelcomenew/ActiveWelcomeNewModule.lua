-- chunkname: @IQIGame\\Module\\ActiveWelcomeNew\\ActiveWelcomeNewModule.lua

local m = {
	friendList = {}
}

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetHelpNewbiesDataPOD()
	m.helpNewbiesDataPOD = nil

	local openActiveID = m.GetOpenWelcomeNewActive()

	if openActiveID ~= nil then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(openActiveID)

		if operationEventDataPOD then
			m.helpNewbiesDataPOD = operationEventDataPOD.helpNewbiesDataPOD
		end
	end

	return m.helpNewbiesDataPOD
end

function m.GetOpenWelcomeNewActive()
	local openActiveID
	local openOperationEvent = ActiveOperationEventModule.GetOpenOperationEvent()

	if #openOperationEvent then
		for i = 1, #openOperationEvent do
			local eventID = openOperationEvent[i]

			if CfgOperateEventsControlTable[eventID].Type == Constant.Activity_Operation_Type.Activity_WelcomeNew then
				openActiveID = eventID

				break
			end
		end
	end

	return openActiveID
end

function m.CheckAllWelcomeNewRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_WelcomeNew then
				local top = m.CheckWelcomeNewRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckWelcomeNewRedPoint(operateEventID)
	if ActiveOperationEventModule.CheckIsOpen(operateEventID) then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

		if operationEventDataPOD and operationEventDataPOD.dataCfgId > 0 then
			for i, v in pairsCfg(CfgWelcomeTaskListTable) do
				if v.Team == operationEventDataPOD.dataCfgId then
					local completeNum, state = m.GetTaskSate(v.Id)

					if state == 1 then
						return true
					end
				end
			end
		end
	end

	return false
end

function m.GetTaskSate(taskID)
	local completeNum = 0
	local state = 0
	local cfg = CfgWelcomeTaskListTable[taskID]

	m.helpNewbiesDataPOD = m.GetHelpNewbiesDataPOD()

	if m.helpNewbiesDataPOD and m.helpNewbiesDataPOD.senior then
		if m.helpNewbiesDataPOD.senior.eventTask then
			completeNum = m.helpNewbiesDataPOD.senior.eventTask[taskID]

			if completeNum == nil then
				completeNum = 0
			end
		end

		if m.helpNewbiesDataPOD.senior.finishedTask and table.indexOf(m.helpNewbiesDataPOD.senior.finishedTask, taskID) ~= -1 then
			state = 2
		end

		if state ~= 2 and completeNum >= cfg.NeedNum then
			state = 1
		end
	end

	return completeNum, state
end

function m.Shutdown()
	m.RemoveListeners()
end

function m.SubmitInviteCode(operateEventID, inviteCode)
	net_operationsHelpNewbies.submitInviteCode(operateEventID, inviteCode)
end

function m.ConfirmTask(operateEventID, eventTaskId)
	net_operationsHelpNewbies.confirmTask(operateEventID, eventTaskId)
end

function m.GetFollowers(eventID)
	net_centerEventHelpNewbies.getFollowers(eventID)
end

function m.SubmitInviteCodeResult()
	NoticeModule.ShowNotice(21045043)
end

function m.ConfirmTaskResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.GetFollowersResult(retList)
	m.friendList = retList

	UIModule.Open(Constant.UIControllerName.WelcomeInvitedHistoryUI, Constant.UILayer.UI)
end

ActiveWelcomeNewModule = m
