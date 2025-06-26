-- chunkname: @IQIGame\\Module\\Maze\\MazeEventModule.lua

MazeEventModule = {
	eventChainQueue = Queue.New()
}

function MazeEventModule.Initialize()
	MazeEventModule.AddEventListeners()
end

function MazeEventModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.TriggerMazeBattleNPC, MazeEventModule.TriggerNpc)
	EventDispatcher.AddEventListener(EventID.StartEnterMazeRoom, MazeEventModule.OnStartEnterMazeRoom)
	EventDispatcher.AddEventListener(EventID.EnterMazeRoomFinish, MazeEventModule.OnEnterMazeRoomFinish)
	EventDispatcher.AddEventListener(EventID.OnStageEventLinkEnd, MazeEventModule.OnStageEventLinkEnd)
end

function MazeEventModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.TriggerMazeBattleNPC, MazeEventModule.TriggerNpc)
	EventDispatcher.RemoveEventListener(EventID.StartEnterMazeRoom, MazeEventModule.OnStartEnterMazeRoom)
	EventDispatcher.RemoveEventListener(EventID.EnterMazeRoomFinish, MazeEventModule.OnEnterMazeRoomFinish)
	EventDispatcher.RemoveEventListener(EventID.OnStageEventLinkEnd, MazeEventModule.OnStageEventLinkEnd)
end

function MazeEventModule.NpcTriggerExecuteEvent()
	if MazeEventModule.curStageEventPOD == nil then
		return
	end

	EventDispatcher.Dispatch(EventID.MazeSetNpcClickStateEvent, false)
	MazeEventModule.__DistributeEvent(MazeEventModule.curStageEventPOD)
end

function MazeEventModule.ExecuteEvent(stageEventPOD)
	local eventCfg = CfgLabyrinthEventTable[stageEventPOD.eventId]
	local stagePod = MazeModule.GetCurStagePOD()
	local stageRoomPod = MazeModule.GetRoomStageMapData(stagePod.curRoomId)
	local eventLinkTable = CfgLabyrinthEventLinkTable[stageRoomPod.eventLinkPod.eventLinkId]

	EventDispatcher.Dispatch(EventID.MazeStartExecuteEvent, stageRoomPod.eventLinkPod.stageEvents)
	MazeEventModule.ShowEventLinkPerformanceStep(stageRoomPod.eventLinkPod.eventLinkId, stageEventPOD.eventId)

	if eventCfg.EventTrigType ~= 1 then
		MazeEventModule.curStageEventPOD = stageEventPOD

		if eventLinkTable.EventShow == 0 then
			logError("当前事件链{0}配置了手动触发 但未配置Npc", eventLinkTable.Id)
		end

		EventDispatcher.Dispatch(EventID.OnEnterManualTriggerEventNode)

		return
	end

	MazeEventModule.__DistributeEvent(stageEventPOD)
end

function MazeEventModule.__DistributeEvent(stageEventPOD)
	local stageMapPod = MazeModule.GetRoomStageMapData(MazeModule.GetCurStagePOD().curRoomId)

	stageEventPOD = stageMapPod.eventLinkPod.stageEvents[stageEventPOD.eventId]

	local eventCfg = CfgLabyrinthEventTable[stageEventPOD.eventId]

	MazeModule.log("事件链ID: {0}事件类型：{1} 事件ID：{2} 子ID:{3} ", stageMapPod.eventLinkPod.eventLinkId, eventCfg.Type, eventCfg.Id, eventCfg.SubTypeID)

	if eventCfg.Type == Constant.MazeEventType.Battle then
		MazeEventModule.__ExecuteBattleEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.TreasureChest then
		MazeEventModule.__ExecuteTreasureChestEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.SelectBuff then
		MazeEventModule.__ExecuteSelectBuffEvent(eventCfg, stageEventPOD, stageMapPod)
	elseif eventCfg.Type == Constant.MazeEventType.Businessman then
		MazeEventModule.__ExecuteBusinessmanEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.DialogueInteractive then
		MazeEventModule.__ExecuteDialogueInteractiveEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.MazeInteractive then
		MazeEventModule.__ExecuteMazeInteractiveEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.Video then
		MazeEventModule.__ExecuteMazeVideoEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.Portal then
		MazeEventModule.__ExecuteMazePortalEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.Behavior then
		MazeEventModule.__ExecuteBehaviorEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.Performance then
		MazeEventModule.__ExecutePerformanceEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.ChangeNpc then
		MazeEventModule.__ExecuteChangeNpcEvent(eventCfg, stageEventPOD)
	elseif eventCfg.Type == Constant.MazeEventType.ChangeScene then
		MazeEventModule.__ExecuteChangeSceneEvent(eventCfg, stageEventPOD, stageMapPod)
	else
		MazeModule.log("未实现的事件类型：{0}", eventCfg.Type)
	end
end

function MazeEventModule.__ExecuteBattleEvent(eventCfg, stageEventPOD)
	MazeModule.ExecuteBattleEvent(stageEventPOD.storyBattleId)
end

function MazeEventModule.__ExecuteTreasureChestEvent(eventCfg, stageEventPOD)
	EventDispatcher.Dispatch(EventID.OpenMazeChooseTreasureChestUI, stageEventPOD, eventCfg.SubTypeID)
end

function MazeEventModule.__ExecuteSelectBuffEvent(eventCfg, stageEventPOD, stageMapPod)
	EventDispatcher.Dispatch(EventID.MazeSelectBuff, stageEventPOD, stageMapPod)
end

function MazeEventModule.__ExecuteBusinessmanEvent(eventCfg, stageEventPOD)
	EventDispatcher.Dispatch(EventID.OpenMazeBusinessmanShop, stageEventPOD)
end

function MazeEventModule.__ExecuteDialogueInteractiveEvent(eventCfg, stageEventPOD)
	MazeModule.log("执行立绘对话事件")

	local subEventCfg = CfgLabyrinthEventNpcTable[eventCfg.SubTypeID]
	local userData = {
		DialogType = Constant.CommonDialogPanelType.LRDialog,
		DialogCid = subEventCfg.DialogueID,
		Callback = function(args)
			MazeModule.OnSubmitEvent(stageEventPOD.eventId)
		end
	}

	UIModule.Open(Constant.UIControllerName.CommonDialogPanel, Constant.UILayer.UI, userData)
end

function MazeEventModule.__ExecuteMazeInteractiveEvent(eventCfg, stageEventPOD)
	EventDispatcher.Dispatch(EventID.OpenMazeInteractiveUI, stageEventPOD, eventCfg.SubTypeID)
end

function MazeEventModule.__ExecuteMazeVideoEvent(eventCfg, stageEventPOD)
	local storyCfg = CfgLabyrinthEventStoryTable[eventCfg.SubTypeID]

	if stageEventPOD.eventState then
		NoticeModule.ShowNoticeByType(5, MazeApi:GetPlayVideoTips(storyCfg.Name), function()
			EventDispatcher.Dispatch(EventID.OpenMazeVideoUI, storyCfg.StoryData)
		end)
	else
		EventDispatcher.Dispatch(EventID.OpenMazeVideoUI, storyCfg.StoryData, function()
			MazeModule.OnSubmitEvent(stageEventPOD.eventId)
		end)
	end

	EventDispatcher.Dispatch(EventID.MazeSetNpcClickStateEvent, true)
end

function MazeEventModule.__ExecuteMazePortalEvent(eventCfg, stageEventPOD)
	MazeModule.OnSubmitEvent(stageEventPOD.eventId)
end

function MazeEventModule.__ExecuteBehaviorEvent(eventCfg, stageEventPOD)
	MazeModule.OnSubmitEvent(stageEventPOD.eventId)
end

function MazeEventModule.__ExecutePerformanceEvent(eventCfg, stageEventPOD)
	local labyrinthEventShowStepGroupTable = CfgLabyrinthEventShowStepGroupTable[eventCfg.SubTypeID]

	MazeBattleStepModule.InitMazeData(labyrinthEventShowStepGroupTable.StepGroup, function()
		MazeModule.OnSubmitEvent(stageEventPOD.eventId)
	end)
end

function MazeEventModule.__ExecuteChangeNpcEvent(eventCfg, stageEventPOD)
	EventDispatcher.Dispatch(EventID.MazeChangeNpcEvent, eventCfg.NpcChangeID, function(npcIdList)
		MazeModule.OnSubmitEvent(stageEventPOD.eventId, 0, 0, 0, {
			[Constant.MazeClientDataType.Npc] = {
				clientData = npcIdList
			}
		})
	end)
end

function MazeEventModule.__ExecuteChangeSceneEvent(eventCfg, stageEventPOD, stageMapPod)
	EventDispatcher.Dispatch(EventID.MazeChangeSceneEvent, eventCfg.SceneChangeID, function()
		MazeModule.OnSubmitEvent(stageEventPOD.eventId)
	end)
end

function MazeEventModule.ShowEventLinkPerformanceStep(eventLinkId, curEventId)
	local stageMapPOD = MazeModule.GetRoomStageMapData(MazeModule.GetCurStagePOD().curRoomId)
	local clientData = MazeModule.GetMazeClientDataByType(stageMapPOD.eventLinkPod, Constant.MazeClientDataType.Performance)
	local stepTable = {}
	local eventLinkTable = CfgLabyrinthEventLinkTable[eventLinkId]

	for i = 2, #eventLinkTable.EventLinkShow, 2 do
		if eventLinkTable.EventLinkShow[i] == curEventId then
			table.insert(stepTable, eventLinkTable.EventLinkShow[i - 1])
			table.insert(clientData, eventLinkTable.EventLinkShow[i - 1])
		end
	end

	local removeDatas = MazeBattleStepModule.GetEventLinkRemoveEffect(stepTable, curEventId)

	for _, stepId in pairs(removeDatas) do
		local index = table.indexOf(clientData, stepId)

		if index ~= -1 then
			clientData[index] = nil
		end
	end

	for i = 1, #stepTable do
		MazeBattleStepModule.InitMazeData({
			stepTable[i]
		})
	end

	MazeModule.PerformanceClientData = clientData
end

function MazeEventModule.TriggerNpc()
	MazeModule.log("触发NPC点击")
	MazeEventModule.NpcTriggerExecuteEvent()
end

function MazeEventModule.OnStartEnterMazeRoom(roomCid)
	MazeEventModule.curStageEventPOD = nil
end

function MazeEventModule.OnEnterMazeRoomFinish(roomCid)
	local stageMapPOD = MazeModule.GetRoomStageMapData(roomCid)
	local clientData = MazeModule.GetMazeClientDataByType(stageMapPOD.eventLinkPod, Constant.MazeClientDataType.Performance)

	for k, v in pairs(clientData) do
		MazeBattleStepModule.InitMazeData({
			v
		})
	end
end

function MazeEventModule.OnStageEventLinkEnd(eventLinkPod)
	local isVideoEvent, eventID = MazeModule.GetIsVideoEvent(eventLinkPod)

	if isVideoEvent then
		MazeEventModule.curStageEventPOD = eventLinkPod.stageEvents[eventID]
	end
end

function MazeEventModule.Shutdown()
	MazeEventModule.RemoveEventListeners()
end
