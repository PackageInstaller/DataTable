-- chunkname: @IQIGame\\Module\\Maze\\MazeBattleStepModule.lua

MazeBattleStepModule = {
	isClickNpc = false
}

local this = MazeBattleStepModule

this.PlayEffectTypeEnum = {
	SceneEffect = 1,
	CameraEffect = 2
}

function this.Initialize()
	MazeEffectModule.Initialize()
	MazeSoundModule.Initialize()
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_OnBubbleShowComplete, this.onDialogShowOverEvent)
	EventDispatcher.AddEventListener(EventID.TriggerMazeBattleNPC, this.OnTriggrtMazeBattleNPC)
	EventDispatcher.AddEventListener(EventID.StartEnterMazeRoom, this.OnStartEnterMazeRoomEvent)
	EventDispatcher.AddEventListener(EventID.OnStageEventLinkEnd, this.OnStageEventLinkEnd)
	EventDispatcher.AddEventListener(EventID.MazeStartExecuteEvent, this.OnStartExecuteEvent)
end

function this.Shutdown()
	MazeEffectModule.Shutdown()
	MazeSoundModule.Shutdown()
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_OnBubbleShowComplete, this.onDialogShowOverEvent)
	EventDispatcher.RemoveEventListener(EventID.TriggerMazeBattleNPC, this.OnTriggrtMazeBattleNPC)
	EventDispatcher.RemoveEventListener(EventID.StartEnterMazeRoom, this.OnStartEnterMazeRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.OnStageEventLinkEnd, this.OnStageEventLinkEnd)
	EventDispatcher.RemoveEventListener(EventID.MazeStartExecuteEvent, this.OnStartExecuteEvent)
end

function this.InitMountPoint(room, sortOrder)
	this.room = room
	this.uiSortOrder = sortOrder
end

function this.InitMazeData(stepTable, callback)
	this.stepQueue = Queue.New()
	this.setpTable = stepTable
	this.heroEntityList = MazeModule.heroEntity
	this.playerEntity = MazeModule.playerEntity
	this.storyEndCallBack = callback
	this.isClickNpc = false

	this.LoadStep()
	this.StartStep()
end

function this.LoadStep()
	ForArray(this.setpTable, function(index, stepID)
		local stepCfg = CfgLabyrinthEventShowStepTable[stepID]

		this.stepQueue:Enqueue(stepCfg)
	end)
end

function this.StartStep()
	local stepCfg = this.GetStep()

	if stepCfg ~= nil then
		MazeEffectModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.ByStep, stepCfg.Id)
		MazeSoundModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.ByStep, stepCfg.Id)
	end

	if stepCfg == nil then
		if this.storyEndCallBack then
			this.storyEndCallBack()

			this.storyEndCallBack = nil
		end

		MazeEffectModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.StepEnd)
		MazeSoundModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.StepEnd)
		this.ClearDialogue()
		MazeModule.log("表现结束")

		return
	end

	MazeModule.log("当前表现步骤--->{0}", stepCfg.Id)
	this.TriggerStepEvent(stepCfg)
end

function this.GetStep()
	if this.stepQueue.Size <= 0 then
		return nil
	end

	local setpCfg = this.stepQueue:Dequeue()

	return setpCfg
end

function this.TriggerStepEvent(stepCfg)
	this.SkipStep(stepCfg)
	this.TriggerDialogStep(stepCfg)
	this.TriggerEntityAnimStep(stepCfg)
	this.TriggerEffectStep(stepCfg)
	this.TriggerSceneEffectStep(stepCfg)
	this.TriggerCameraEffectStep(stepCfg)
	this.PlaySound(stepCfg)
end

function this.TriggerDialogStep(stepCfg)
	if stepCfg.DialogueID <= 0 then
		return
	end

	if stepCfg.DialogueID > 0 and stepCfg.DialoguePoint == 0 or stepCfg.DialogueID == 0 and stepCfg.DialoguePoint ~= 0 then
		logError("步骤{0}对话配置不正确 查看对话和对话挂点是否匹配", stepCfg.Id)
	end

	local userData = {}

	if stepCfg.IsLHRDialogue == false then
		local dialogueCfg = CfgLabyrinthEventDialogueTable[stepCfg.DialogueID]

		userData.DialogType = Constant.CommonDialogPanelType.Bubble
		userData.mountPoint = this.GetDialogueMountPoint(stepCfg.DialoguePoint)
		userData.name = dialogueCfg.TextName
		userData.text = this.GetTextWithSex(dialogueCfg)
		userData.duration = 2
		userData.uiPoint = true
		userData.notUseAuto = true
	else
		userData.DialogType = Constant.CommonDialogPanelType.LRDialog
		userData.DialogCid = stepCfg.DialogueID

		function userData.Callback()
			this.StartStep()
		end
	end

	if not UIModule.HasUI(Constant.UIControllerName.CommonDialogPanel) then
		UIModule.Open(Constant.UIControllerName.CommonDialogPanel, Constant.UILayer.UI, userData)

		return
	end

	EventDispatcher.Dispatch(EventID.CommonDialogPanel_RefreshShowEvent, userData)
end

function this.GetDialogueMountPoint(pointType)
	if pointType[1] == 1 then
		local heroPos

		ForArray(this.heroEntityList, function(pos, heroEntity)
			if heroEntity ~= nil then
				heroPos = pos

				return true
			end
		end)

		return this.heroEntityList[heroPos].dialogueRoot
	elseif pointType[1] == 2 then
		local npc = this.room.npcEntityList[pointType[2]]

		if npc ~= nil then
			return npc.dialogueRoot
		else
			warning("当前配置的点位{0}未找到Npc", pointType[2])

			local npcPos

			ForPairs(this.room.npcEntityList, function(pos, npc)
				if npc ~= nil then
					npcPos = pos

					return true
				end
			end)

			return this.room.npcEntityList[npcPos].dialogueRoot
		end
	elseif pointType[1] == 3 then
		return this.playerEntity.dialogueRoot
	end
end

function this.TriggerEntityAnimStep(stepCfg)
	for pos, v in ipairs(stepCfg.RoleAnimation) do
		local hero = this.heroEntityList[pos]

		if hero then
			this.PlayAnimation(hero, v)
		end
	end

	for pos, v in pairs(stepCfg.EventShowAnimation) do
		local npc = this.room.npcEntityList[pos]

		if npc then
			this.PlayAnimation(npc, v)
		end
	end

	this.PlayAnimation(this.playerEntity, stepCfg.PlayerAnimation)
end

function this.PlayAnimation(entity, animConfig)
	if animConfig and table.len(animConfig) > 0 then
		entity:_PlayAnim(animConfig[1], animConfig[2] == "1")
	end
end

function this.TriggerEffectStep(stepCfg)
	for pos, effectConfig in ipairs(stepCfg.RoleEffect) do
		local hero = this.heroEntityList[pos]

		if hero then
			this.PlayEntityEffect(stepCfg, effectConfig, hero.spineEntityGo)
		end
	end

	for pos, effectConfig in ipairs(stepCfg.EventEffect) do
		local npc = this.room.npcEntityList[pos]

		if npc then
			this.PlayEntityEffect(stepCfg, effectConfig, npc.spineEntityGo)
		end
	end

	this.PlayEntityEffect(stepCfg, stepCfg.PlayerEffect, this.playerEntity.spineEntityGo)
end

function this.PlayEntityEffect(stepCfg, effectConfig, entityGo)
	if effectConfig and table.len(effectConfig) > 0 then
		this.PlayCommonEffect(effectConfig[1], effectConfig[2], entityGo, this.uiSortOrder + 5, stepCfg.EntityEffectDestroyType[1], stepCfg.EntityEffectDestroyType[2])
	end
end

function this.TriggerCommonEffectStep(stepCfg, type)
	local effectId, mountPoint, destroyType1, destroyType2

	if type == this.PlayEffectTypeEnum.SceneEffect then
		destroyType1 = stepCfg.SceneDestroyType[1]
		destroyType2 = stepCfg.SceneDestroyType[2]

		if this.room.isFlip then
			effectId = stepCfg.SceneEffectL[1]
			mountPoint = stepCfg.SceneEffectL[2]
		else
			effectId = stepCfg.SceneEffectR[1]
			mountPoint = stepCfg.SceneEffectR[2]
		end
	elseif type == this.PlayEffectTypeEnum.CameraEffect and table.len(stepCfg.CameraEffect) > 0 then
		effectId = stepCfg.CameraEffect[1]
		mountPoint = stepCfg.CameraEffect[2]
		destroyType1 = stepCfg.DestroyType[1]
		destroyType2 = stepCfg.DestroyType[2]
	end

	if effectId == nil then
		return
	end

	this.PlayCommonEffect(effectId, mountPoint, this.room.mountPoint, this.uiSortOrder + 7, destroyType1, destroyType2)
end

function this.TriggerSceneEffectStep(stepCfg)
	local sceneEffect = this.room.isFlip and stepCfg.SceneEffectL or stepCfg.SceneEffectR

	if sceneEffect == nil or table.len(sceneEffect) == 0 then
		return
	end

	this.TriggerCommonEffectStep(stepCfg, this.PlayEffectTypeEnum.SceneEffect)
end

function this.TriggerCameraEffectStep(stepCfg, type)
	if table.len(stepCfg.CameraEffect) > 0 then
		this.TriggerCommonEffectStep(stepCfg, this.PlayEffectTypeEnum.CameraEffect)
	end
end

function this.TriggerEnd(stepCfg)
	if stepCfg.DialogueID == 0 then
		this.StartStep()
	end
end

function this.SkipStep(stepCfg)
	if stepCfg.StepTime == 0 then
		return
	end

	MazeModule.log("步骤{0}配置了跳过时间 当前对话ID{1}", stepCfg.Id, stepCfg.DialogueID)
	MazeModule.GetTimeController():AddSecondDelayCall(stepCfg.StepTime, function()
		this.StartStep()
	end, nil, 1)
end

function this.onDialogShowOverEvent(mountPoint)
	this.StartStep()
end

function this.OnTriggrtMazeBattleNPC()
	this.isClickNpc = true
end

function this.PlayCommonEffect(effectId, mountPoint, mountPointParent, order, destroyType1, destroyType2)
	if mountPoint == nil then
		logError(string.format("特效%s挂载点为空", effectId))

		return
	end

	MazeModule.log("步骤播放特效ID{0},销毁类型{1},销毁参数{2}", effectId, destroyType1, destroyType2)

	if destroyType1 == Constant.MazeEffectOrSoundDestoryType.ByStep then
		destroyType2 = {
			step = destroyType2
		}
	elseif destroyType1 == Constant.MazeEffectOrSoundDestoryType.ByEventID then
		destroyType2 = {
			eventID = destroyType2
		}
	end

	MazeEffectModule.PlayEffect(effectId, mountPoint, mountPointParent, order, destroyType1, destroyType2)
end

function this.PlaySound(stepCfg)
	local soundIds = stepCfg.SceneSound

	if table.len(soundIds) == 0 then
		return
	end

	ForPairs(soundIds, function(index, soundId)
		local params

		if stepCfg.SoundOffType[index] == Constant.MazeEffectOrSoundDestoryType.ByStep then
			params = {
				step = stepCfg.SoundOffType[index + 1]
			}
		elseif stepCfg.SoundOffType[index] == Constant.MazeEffectOrSoundDestoryType.ByEventID then
			params = {
				eventID = stepCfg.SoundOffType[index + 1]
			}
		end

		MazeSoundModule.PlaySound(soundId, stepCfg.SoundOffType[index], params)
	end)
end

function this.ClearDialogue()
	UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
end

function this.ClearOther()
	if this.stepQueue == nil then
		return
	end

	this.stepQueue:Clear()
end

function this.OnStartEnterMazeRoomEvent()
	MazeEffectModule.Clear()
	MazeSoundModule.Clear()
end

function this.OnStageEventLinkEnd()
	MazeEffectModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.EventLinkEnd)
	MazeSoundModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.EventLinkEnd)
end

function this.OnStartExecuteEvent(stageEvents)
	for _, v in pairs(stageEvents) do
		if v.eventState == true then
			MazeEffectModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.ByEventID, v.eventId)
			MazeSoundModule.CheckAndDestroy(Constant.MazeEffectOrSoundDestoryType.ByEventID, v.eventId)
		end
	end
end

this.firstStepQueue = nil
this.firstStepEndCallback = nil

function this.FirstEnterMaze(seasonId, callback)
	this.firstStepEndCallback = callback

	this.InitFirstEnterData(seasonId)
end

function this.InitFirstEnterData(seasonId)
	this.firstStepQueue = Queue.New()

	local cfgs = this.GetFirstStepCfgBySeasonID(seasonId, 1)

	ForArray(cfgs, function(_, cfg)
		this.firstStepQueue:Enqueue(cfg)
	end)
	this.StartFirstStep()
end

function this.StartFirstStep()
	local stepCfg = this.GetFirstStep()

	if stepCfg == nil then
		if this.firstStepEndCallback ~= nil then
			this.firstStepEndCallback()

			this.firstStepEndCallback = nil
		end

		return
	end

	this.TriggerFirstVideoStep(stepCfg)
	this.TriggerFirstDialogStep(stepCfg)
end

function this.GetFirstStep()
	if this.firstStepQueue.Size == 0 then
		return nil
	end

	return this.firstStepQueue:Dequeue()
end

function this.TriggerFirstVideoStep(stepCfg)
	if stepCfg.StoryDataID == 0 then
		return
	end

	local storyCfg = CfgLabyrinthEventStoryTable[stepCfg.StoryDataID]

	EventDispatcher.Dispatch(EventID.OpenMazeVideoUI, storyCfg.StoryData, function()
		this.StartFirstStep()
	end)
end

function this.TriggerFirstDialogStep(stepCfg)
	if stepCfg.DialogueID == 0 then
		return
	end

	local eventCfg = CfgLabyrinthEventNpcTable[stepCfg.DialogueID]

	UIModule.Open(Constant.UIControllerName.CommonDialogPanel, Constant.UILayer.UI, {
		DialogType = Constant.CommonDialogPanelType.LRDialog,
		DialogCid = eventCfg.DialogueID,
		Callback = function()
			this.StartFirstStep()
		end
	})
end

function this.GetFirstStepCfgBySeasonID(seasonId, showType)
	local tempTable = {}

	for k, v in pairsCfg(CfgLabyrinthFirstShowTable) do
		if v.SeasonID == seasonId and v.ShowType == showType then
			table.insert(tempTable, v)
		end
	end

	table.sort(tempTable, function(cfgA, cfgB)
		return cfgA.Id < cfgB.Id
	end)

	return tempTable
end

function this.MazeOver(callback)
	this.InitMazeOverData(callback)
end

function this.InitMazeOverData(callback)
	local curStagePod = MazeModule.GetCurStagePOD()
	local mazeOverConditionID = CfgLabyrinthBarrierPoolTable[curStagePod.poolId].FinishCondition[1]

	this.mazeOverSettlementType = CfgConditionTable[mazeOverConditionID].Params[1][1]

	local seasonId = MazeModule.GetMazeSeason()
	local cfg = this.GetMazeOverStepCfgBySeasonID(seasonId, 2, this.mazeOverSettlementType)

	this.InitMazeData(cfg.StepShow, callback)
end

function this.GetMazeOverStepCfgBySeasonID(seasonId, showType, showSubType)
	for k, v in pairsCfg(CfgLabyrinthFirstShowTable) do
		if v.SeasonID == seasonId and showType == v.ShowType and showSubType == v.ShowSubType then
			return v
		end
	end

	logError(string.format("未找到赛季:%s 显示类型:%s 子类型:%s 的配置文件", seasonId, showType, showSubType))

	return nil
end

function this.GetTextWithSex(cfgDialogue)
	return cfgDialogue.TextMan
end

function this.GetEventLinkRemoveEffect(stepTable, eventID)
	local removeStepIdTable = {}
	local stepCfg

	ForPairs(stepTable, function(_, stepId)
		stepCfg = CfgLabyrinthEventShowStepTable[stepId]

		local tempStepId

		if stepCfg.SceneDestroyType[1] == Constant.MazeEffectOrSoundDestoryType.ByEventID and stepCfg.SceneDestroyType[2] == eventID then
			tempStepId = stepCfg.SceneDestroyType[2]
		end

		if stepCfg.DestroyType[1] == Constant.MazeEffectOrSoundDestoryType.ByEventID and stepCfg.DestroyType[2] == eventID then
			tempStepId = stepCfg.DestroyType[2]
		end

		if stepCfg.SoundOffType[1] == Constant.MazeEffectOrSoundDestoryType.ByEventID and stepCfg.SoundOffType[2] == eventID then
			tempStepId = stepCfg.SoundOffType[2]
		end

		if table.indexOf(removeStepIdTable, tempStepId) == -1 then
			table.insert(removeStepIdTable, tempStepId)
		end
	end)

	return removeStepIdTable
end
