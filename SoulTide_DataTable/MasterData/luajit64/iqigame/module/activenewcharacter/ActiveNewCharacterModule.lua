-- chunkname: @IQIGame\\Module\\ActiveNewCharacter\\ActiveNewCharacterModule.lua

local m = {
	isSendStory = false
}

function m.Reload()
	return
end

function m.GetNewCharacterStoryComplete(eventCfgId, storyCfgId)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(eventCfgId)

	if operationEventDataPOD then
		m.ncData = operationEventDataPOD.ncData

		if m.ncData and m.ncData.finishStories and table.indexOf(m.ncData.finishStories, storyCfgId) ~= -1 then
			return true
		end
	end

	return false
end

function m.CheckNewCharacterStoryState(eventCfgId, storyCfgId)
	local state = 2
	local com = m.GetNewCharacterStoryComplete(eventCfgId, storyCfgId)

	if com then
		state = 1
	else
		local cfgNewCharacter = CfgNewCharacterStoryTable[storyCfgId]

		if cfgNewCharacter.PreStory > 0 then
			local comPreStory = m.GetNewCharacterStoryComplete(eventCfgId, cfgNewCharacter.PreStory)

			if comPreStory == false then
				state = 4
			end
		end

		local haveScore = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.NEW_CHARACTER_SCORE)

		if haveScore < cfgNewCharacter.UnlockNeedScore then
			state = 3
		end
	end

	return state
end

function m.CheckAllNewCharacterRedPoint()
	for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
		local cfg = CfgOperateEventsControlTable[v.eventCfgId]

		if cfg.Type == Constant.Activity_Operation_Type.Activity_NewCharacter then
			local top = m.CheckNewCharacterRedPoint(v.eventCfgId)

			if top then
				return true
			end
		end
	end

	return false
end

function m.CheckNewCharacterRedPoint(operateEventID)
	local storyRed = m.CheckStoryRedPoint(operateEventID)
	local bingoRed = DollBingoModule.CheckRedPoint(operateEventID)
	local taskRed = ActivityDollMissionModule.CheckRedPoint()

	return storyRed or bingoRed or taskRed
end

function m.CheckStoryRedPoint(operateEventID)
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)
	local cfgStoryTab = {}

	if eventPOD then
		local cfgNewCharacterActivity = CfgNewCharacterActivityTable[eventPOD.dataCfgId]

		for i, v in pairsCfg(CfgNewCharacterStoryTable) do
			if v.GroupNum == cfgNewCharacterActivity.Id then
				table.insert(cfgStoryTab, v)
			end
		end
	end

	for i, v in pairs(cfgStoryTab) do
		local state = m.CheckNewCharacterStoryState(operateEventID, v.Id)

		if state == 2 then
			return true
		end
	end

	return false
end

function m.Shutdown()
	m.isSendStory = false
end

function m.NewCharacterStory(eventId, storyId)
	if m.isSendStory then
		return
	end

	net_operationsNewCharacter.newCharacterStory(eventId, storyId)

	m.isSendStory = true
end

function m.NewCharacterStoryResult()
	m.isSendStory = false
end

function m.NotifyNewCharacterStoryFinished(eventId, storyId, list)
	if list and #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end
end

ActiveNewCharacterModule = m
