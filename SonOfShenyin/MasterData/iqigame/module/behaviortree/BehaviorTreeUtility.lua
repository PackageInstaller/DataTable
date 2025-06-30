-- chunkname: @IQIGame\\Module\\BehaviorTree\\BehaviorTreeUtility.lua

BehaviorTreeUtility = {}

local this = BehaviorTreeUtility
local JoystickControlClass = require("IQIGame.Components.JoystickControl")

function BehaviorTreeUtility.DebugStory(luaTable)
	StoryModule.DebugStory(luaTable)
end

function BehaviorTreeUtility.DebugMaze(mazeRoomID, firstStoryDataID, isPlayerShowOnAwake, playerName, playerEntityID, playerPosition)
	CoroutineUtility.StartCoroutine(function()
		StoryModule.isDebugMod = true

		StoryModule.InitForDebug()

		local storyParam = {}

		storyParam.StoryDataID = firstStoryDataID
		storyParam.IsPlayerShowOnAwake = isPlayerShowOnAwake
		storyParam.PlayerName = playerName
		storyParam.PlayerEntityID = playerEntityID
		storyParam.PlayerPosition = playerPosition
		storyParam.NpcVariables = nil
		storyParam.StoryType = Constant.StoryType.Maze

		StoryModule.LoadStory(storyParam)
		StoryModule.AllNPCsTriggerStart()
	end)
	MazeStageModule.DebugFakeData(mazeRoomID)
end

function BehaviorTreeUtility.StartFight(storyBattleID, task)
	if StoryModule.StoryManager.noFight then
		task:Complete(true)

		return
	end

	StoryModule.StopSkip()

	if StoryModule.isDebugMod then
		task:Complete(true)

		return
	end

	if StoryModule.isReview then
		task:Complete(true)

		return
	end

	local function callback(fightResult)
		if not fightResult then
			WorldMapModule.ExitStoryOrLevel()

			return
		end

		task:Complete(fightResult)
	end

	StoryModule.StartFight(storyBattleID, callback)
end

function BehaviorTreeUtility.StartFightNoFormation(storyBattleID, task)
	StoryModule.StopSkip()

	if StoryModule.isDebugMod then
		task:SetComplete(true)

		return
	end

	function StoryModule.fightOverCallback(result)
		task:SetComplete(result)
	end

	net_plotStage.enterStaticFight(storyBattleID)

	StoryModule.IsHideBattleButton = true
end

function BehaviorTreeUtility.CompleteLevel(isLevelComplete)
	coroutine.start(function()
		if isLevelComplete then
			StoryModule.Save(true)
			coroutine.wait(0.01)
		end

		StoryModule.CompleteLevel(isLevelComplete and Constant.FightResult.ATTACKER_WIN or Constant.FightResult.NOT_END)
	end)
end

function BehaviorTreeUtility.SaveLevel(isWaitComplete, StorySaveTask)
	StoryModule.Save(false)

	if isWaitComplete then
		EventDispatcher.AddSingleEventListener(EventID.StorySaveTaskCompleteEvent, function()
			StorySaveTask:SetComplete()
		end)
	end
end

function BehaviorTreeUtility.ConversationStageOverFlag()
	StoryModule.StopSkip()
	EventDispatcher.Dispatch(EventID.StopMultipleSpeedEvent)
end

function BehaviorTreeUtility.DebugStartFight()
	local fightID = CfgWorldMapItemTable[StoryModule.plotStageDupPOD.stageId].ShowStoryBattleID

	if not fightID or fightID == 0 then
		logError(string.format("【GM战斗】直接开启战斗失败，当前关卡 id = %s 没有战斗", StoryModule.plotStageDupPOD.stageId))

		return
	end

	for _, v in pairs(StoryModule.npcs) do
		v.npcController:StopAllBehaviorTree()
	end

	StoryModule.isDebugFight = true

	StoryModule.StartFight(fightID, function(result)
		BehaviorTreeUtility.StopStoryBlackScreenEffect()
		net_plotStage.completeLevel(result)
	end)
end

function BehaviorTreeUtility.SetNPCFacing(npcID, isFacingToNPC, otherNPCID, isFacingRight, isBackFacing)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if npc == nil then
		logError("找不到npcID=" .. tostring(npcID) .. "的NPC")

		return
	end

	if isFacingToNPC then
		local otherNPC = BehaviorTreeUtility.GetNPCByNPCID(otherNPCID)

		isFacingRight = otherNPC.transform.position.x > npc.transform.position.x
	end

	if isBackFacing then
		isFacingRight = not isFacingRight
	end

	npc:SetFlipX(isFacingRight)
end

function BehaviorTreeUtility.SetNPCActivation(npcID, isActive)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if npc then
		if isActive then
			npc:ShowGameObject()
		else
			npc:HideGameObject()
		end
	end
end

function BehaviorTreeUtility.GetNPCByNPCID(npcID)
	return StoryModule.GetCharacterByNPCID(npcID)
end

function BehaviorTreeUtility.GetCharacterTransformByID(npcID)
	return StoryModule.GetCharacterByNPCID(npcID).transform
end

function BehaviorTreeUtility.SetNPCPosition(npcID, posX, posY, posZ)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if npc then
		LuaUtility.SetPositionWithGameObject(npc.gameObject, posX, posY, posZ)
	end
end

function BehaviorTreeUtility.SwitchScene(storyDataID, teleportPosition, isSwitchRoom, switchSceneTask, callBack)
	CoroutineUtility.StartCoroutine(BehaviorTreeUtility.SwitchSceneCoroutine, storyDataID, teleportPosition, isSwitchRoom, function()
		switchSceneTask:Complete()

		if callBack then
			callBack()
		end
	end)
end

function BehaviorTreeUtility.SwitchSceneCoroutine(storyDataID, teleportPosition, isSwitchRoom, callback)
	BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0)
	StoryModule.UnloadSceneAndNPCs()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	LuaCodeInterface.OnBaseSceneStateExit()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	GameEntry.Entity:ReleaseEntities()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	GameEntry.Resource:ForceUnloadUnusedAssets(true)
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield()
	CoroutineUtility.Yield(StoryModule.LoadSceneAndNPCs, storyDataID, StoryModule.plotStageDupPOD and StoryModule.plotStageDupPOD.storySaveData.npcVariables or nil, isSwitchRoom)

	StoryModule.player.transform.position = teleportPosition

	StoryModule.AllNPCsTriggerStart()
	StoryModule.StopSkip()

	if callback then
		callback()
	end
end

function BehaviorTreeUtility.LoadSceneByPrefab(sceneID, task)
	local function callback(sceneObj)
		task:Complete(sceneObj)
	end

	StoryModule.LoadSceneByPrefab(sceneID, callback)
end

function BehaviorTreeUtility.NPCOnTriggerEnter(npcID)
	StoryModule.CloseToNPC(npcID)
end

function BehaviorTreeUtility.NPCOnTriggerExit(npcID)
	StoryModule.AwayFromNPC(npcID)
end

function BehaviorTreeUtility.PlayTimeline(playableDirectorPrefab, nameToTracks, playTimelineTask)
	local function onPlayTimelineCompleted()
		playTimelineTask:Complete()
	end

	StoryModule.PlayTimeline(playableDirectorPrefab, nameToTracks, onPlayTimelineCompleted)
end

function BehaviorTreeUtility.PlayTimeLineTask(cfgID, nameToTracks, effectInfo, playTimeLineTask)
	StoryModule.playingTimelineTask = playTimeLineTask

	AssetUtil.LoadAsset(StoryModule, CfgUtil.GetStoryResourceWithID(cfgID), function(self, assetName, asset, duration, userData)
		StoryModule.timelineGameObject = GameObject.Instantiate(asset)

		local playableDirector = StoryModule.timelineGameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
		local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableDirector.playableAsset)

		for i = 0, outputs.Length - 1 do
			local playableBinding = outputs[i]
			local streamName = TimelineUtility.GetPlayableBindingStreamName(playableBinding)

			if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Cinemachine.CinemachineBrain)) then
				playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), StoryModule.cinemachineBrain)
			end

			if streamName and nameToTracks[streamName] then
				local npc = StoryModule.GetCharacterByNPCID(nameToTracks[streamName].Value)

				if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Spine.Unity.SkeletonAnimation)) then
					TimelineUtility.BindSpineAnimationClipData(playableDirector, npc.skeletonAnimation, TimelineUtility.GetPlayableBindingsourceObject(playableBinding))
				end

				if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(UnityEngine.Animator)) then
					playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), npc:GetGameObject():GetComponent(typeof(UnityEngine.Animator)))
				end

				if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(GameObject)) then
					playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), npc:GetGameObject())
				end
			end
		end

		if effectInfo then
			local effectRoot = StoryModule.timelineGameObject.transform:FindChildByName("EffectFollow")

			if effectRoot then
				for _, v in pairs(effectInfo) do
					local npc = StoryModule.GetCharacterByNPCID(v.NpcID)

					if npc then
						local effectTrans = effectRoot:Find(v.EffectName)
						local follower = LuaUtility.GameObjectGetOrAddComponent(effectTrans.gameObject, typeof(TransformFollower))

						follower:Init(effectTrans, npc.transform, Vector3.New(v.Offset.x, v.Offset.y, v.Offset.z), false)
					end
				end
			end
		end

		local screen = StoryModule.timelineGameObject.transform:FindChildByName("Screen")

		if not LuaUtility.GameObjectIsNullOrEmpty(screen) then
			screen:SetParent(StoryModule.mainCamera.gameObject.transform)
			LuaUtility.SetLocalPositionWithGameObject(screen.gameObject, 0, 0, 0)
		end

		if BehaviorTreeUtility.SkipTimeLine(playableDirector) then
			coroutine.start(function()
				coroutine.wait(0.1)

				playableDirector.time = playableDirector.duration - 0.01

				coroutine.wait(0.01)

				if StoryModule.timelineGameObject then
					GameObject.Destroy(StoryModule.timelineGameObject)

					StoryModule.timelineGameObject = nil
				end

				if StoryModule.playTimelineCoroutine then
					StoryModule.playTimelineCoroutine:Stop()

					StoryModule.playTimelineCoroutine = nil
				end

				if screen and not LuaUtility.GameObjectIsNullOrEmpty(screen.gameObject) then
					GameObject.Destroy(screen.gameObject)
				end

				playTimeLineTask:Complete()

				StoryModule.playingTimelineTask = nil
			end)

			return
		end

		playableDirector:Play()

		StoryModule.playTimelineCoroutine = CoroutineUtility.CreateCoroutine(function()
			if not playableDirector then
				StoryModule.playTimelineCoroutine:Stop()

				StoryModule.playTimelineCoroutine = nil

				return
			end

			while playableDirector.state == UnityEngine.Playables.PlayState.Playing do
				CoroutineUtility.Yield()
			end

			if StoryModule.timelineGameObject then
				GameObject.Destroy(StoryModule.timelineGameObject)

				StoryModule.timelineGameObject = nil
			end

			if StoryModule.playTimelineCoroutine then
				StoryModule.playTimelineCoroutine:Stop()

				StoryModule.playTimelineCoroutine = nil
			end

			if screen and not LuaUtility.GameObjectIsNullOrEmpty(screen.gameObject) then
				GameObject.Destroy(screen.gameObject)
			end

			playTimeLineTask:Complete()

			StoryModule.playingTimelineTask = nil
		end)

		StoryModule.playTimelineCoroutine:Start()
	end)
end

function BehaviorTreeUtility.PlayLoopTimeLine(cfgId)
	AssetUtil.LoadAsset(StoryModule, CfgUtil.GetStoryResourceWithID(cfgId), function(self, assetName, asset, duration, userData)
		local timeLineObj = GameObject.Instantiate(asset)
		local playableDirector = timeLineObj:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		playableDirector:Play()
		StoryModule.AddInTimeLineList(timeLineObj)
	end)

	return StoryModule.GetTimeLineListIndex()
end

function BehaviorTreeUtility.StopLoopTimeLine(id)
	StoryModule.RemoveInTimeLineList(id)
end

function BehaviorTreeUtility.PlayAnimationGroup(characterID, animationID, totalAnimationDuration, playAnimationGroup)
	if playAnimationGroup == nil then
		logError("BehaviorTreeUtility.PlayAnimationGroup：playAnimationGroup is nil. characterID={0}", characterID)

		return false
	end

	local character = BehaviorTreeUtility.GetNPCByNPCID(characterID)

	if character == nil then
		logError("BehaviorTreeUtility.PlayAnimationGroup：无法找到 characterID={0} 的角色.", characterID)

		return false
	end

	if type(animationID) ~= "number" then
		logError("BehaviorTreeUtility.PlayAnimationGroup：animationID 必须为整数类型")

		return false
	end

	local animationGroupConfig = CfgAnimationTable[animationID]

	if animationGroupConfig == nil then
		logError("BehaviorTreeUtility.PlayAnimationGroup：无法在Animation.csv表内找到 ID={0} 的数据.", animationID)

		return false
	end

	local lastAnimationGroupConfig

	if character.lastPlayingAnimationGroupID ~= nil and character.lastPlayingAnimationGroupID > 0 then
		lastAnimationGroupConfig = CfgAnimationTable[character.lastPlayingAnimationGroupID]

		if lastAnimationGroupConfig == nil then
			logError("BehaviorTreeUtility.PlayAnimationGroup：无法在Animation.csv表内找到上一次的 ID={0} 的数据.", character.lastPlayingAnimationGroupID)

			return false
		end
	end

	local animName_Start = animationGroupConfig.Start
	local animName_Loop = animationGroupConfig.Loop
	local animName_End = lastAnimationGroupConfig ~= nil and lastAnimationGroupConfig.End or ""
	local animData_Start = animName_Start ~= "" and character.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animName_Start) or nil
	local animData_Loop = animName_Loop ~= "" and character.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animName_Loop) or nil
	local animData_End = animName_End ~= "" and character.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animName_End) or nil

	if animData_Start == nil and animData_Loop == nil and animData_End == nil then
		logError("BehaviorTreeUtility.PlayAnimationGroup：无法获取到ID={0} 角色的Spine动画数据, animationID= {1} , animName_Start = {2} ,animName_Loop = {3} ,animName_End = {4} ", characterID, animationID, animName_Start, animName_Loop, animName_End)

		return false
	end

	if character.playAnimationGroupCoroutine ~= nil then
		character.playAnimationGroupInstance:Complete()
		character.playAnimationGroupCoroutine:Stop()

		character.playAnimationGroupCoroutine = nil
		character.playAnimationGroupInstance = nil
	end

	local totalAnimDuration = totalAnimationDuration
	local animDuration_Start = animData_Start ~= nil and animData_Start.Duration or 0
	local animDuration_End = animData_End ~= nil and animData_End.Duration or 0
	local animDuration_Loop = animData_Loop ~= nil and totalAnimDuration or 0

	character.playAnimationGroupCoroutine = CoroutineUtility.CreateCoroutine(function()
		character.lastPlayingAnimationGroupID = animationID
		character.playAnimationGroupInstance = playAnimationGroup

		if animData_End ~= nil and animDuration_End > 0 then
			character:PlayAnimation(animName_End, false)
			CoroutineUtility.Yield(CustomWaitForSeconds(animDuration_End))
		end

		if animData_Start ~= nil and animDuration_Start > 0 then
			character:PlayAnimation(animName_Start, false)
			CoroutineUtility.Yield(CustomWaitForSeconds(animDuration_Start))
		end

		if animData_Loop ~= nil and animDuration_Loop > 0 then
			character:PlayAnimation(animName_Loop, true)
			CoroutineUtility.Yield(CustomWaitForSeconds(animDuration_Loop))
		end

		character.playAnimationGroupInstance:Complete()

		character.playAnimationGroupCoroutine = nil
	end)

	character.playAnimationGroupCoroutine:Start()

	return true
end

function BehaviorTreeUtility.StopPlayAnimationGroup(characterID)
	local character = BehaviorTreeUtility.GetNPCByNPCID(characterID)

	if character == nil then
		logError("BehaviorTreeUtility.StopPlayAnimationGroup：无法找到 characterID={0} 的角色.", characterID)

		return false
	end

	if character.playAnimationGroupCoroutine ~= nil then
		character.playAnimationGroupInstance:Complete()
		character.playAnimationGroupCoroutine:Stop()

		character.playAnimationGroupCoroutine = nil
		character.playAnimationGroupInstance = nil
	end

	character.lastPlayingAnimationGroupID = nil
end

function BehaviorTreeUtility.SetAutoMoveAnimation(npcID, animationName)
	local storyChar = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if storyChar then
		storyChar:SetAutoMoveAnimation(animationName)
	end
end

function BehaviorTreeUtility.SetIdleAnimation(npcID, animationName)
	local storyChar = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if storyChar then
		storyChar:SetIdleAnimationName(animationName)

		if storyChar:GetCurrentStateName() == StoryIdleState.Name then
			storyChar:PlayAnimation(StoryIdleState.Name, true)
		end
	end
end

function BehaviorTreeUtility.GetCharacterPosition(npcID)
	local storyChar = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if storyChar then
		return storyChar.gameObject.transform.position
	end
end

function BehaviorTreeUtility.GetCharacterGameObject(npcID)
	local storyChar = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if storyChar then
		return storyChar.gameObject
	end
end

function BehaviorTreeUtility.ChangeSpineSkeletonDataAsset(npcID, elementEntityID, ChangeSpineSkeletonDataAsset)
	local storyChar = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if storyChar then
		CoroutineUtility.StartCoroutine(function()
			local url = EntityUtility.GetStoryEntityPath(elementEntityID)
			local spinePrefab = CoroutineUtility.Yield(WaitLoadAsset(StoryModule, url, function(assetName, asset, duration, userData)
				return
			end)).customWait.result

			storyChar:ChangeSkeletonDataAsset(spinePrefab:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true).skeletonDataAsset)
			ChangeSpineSkeletonDataAsset:SetComplete()
		end)
	end
end

function BehaviorTreeUtility.TriggerBehaviorWithNPCID(npcID)
	EventDispatcher.Dispatch(EventID.BehaviorTreeOnInteract, npcID)
end

function BehaviorTreeUtility.GetSceneGameObject(path)
	local obj = StoryModule.currentSceneByPrefab.transform:Find(path)

	if not obj then
		logError("没有找到场景物体 路径 = " .. StoryModule.currentSceneByPrefab.name .. "/" .. path)
	end

	return obj
end

function BehaviorTreeUtility.GetStoryUIPictureGameObject()
	local o = UIModule.GetUIGameObjectByName(Constant.UIControllerName.MainUI)

	if LuaUtility.GameObjectIsNullOrEmpty(o) then
		logError("【剧情】试图获取插画物体，但是剧情UI不存在或者未开启")

		return
	end

	local mainObj = o:GetComponent("UIController")
	local mainUI = mainObj:GetUILuaTable()

	return mainUI.storyPanel.PicturePanel.CurrentShow.gameObject
end

function BehaviorTreeUtility.ChangeNpcName(npcID, npcNameID)
	local npc = StoryModule.GetCharacterByNPCID(npcID)

	if not npc then
		return
	end

	npc:SetName(npcNameID)
end

function BehaviorTreeUtility.FindCharacterObject(npcID, path)
	local npc = StoryModule.GetCharacterByNPCID(npcID)

	if not npc then
		return
	end

	if LuaUtility.StrIsNullOrEmpty(path) then
		return npc.gameObject
	end

	local t = npc.transform:Find(path)

	if not t then
		logError("【剧情】没有找到角色 ID = %s 身上的物体 path = %s", npcID, path)

		return
	end

	return t.gameObject
end

function BehaviorTreeUtility.TriggerNpcEventTree(npcID, args)
	local npc = StoryModule.GetCharacterByNPCID(npcID)

	if not npc then
		logError(string.format("【剧情】触发npc事件行为树失败，没有找到 npcID = %s", npcID))

		return
	end

	npc.npcController:TriggerEventTree(args)
end

function this.StopNpcSpine(isAll, idArray)
	StoryModule.StopNpcSpine(isAll, idArray)
end

function this.RecoveryNpcSpine(isAll, idArray)
	StoryModule.RecoveryNpcSpine(isAll, idArray)
end

function this.GetPlayerSex()
	return PlayerModule.GetSex()
end

function this.ChangeNpcSpineTimeScale(isAll, idArray, timeScale)
	StoryModule.ChangeNpcSpineTimeScale(isAll, idArray, timeScale)
end

function BehaviorTreeUtility.StartNewConversation(dialogueStartID, isActiveConfirmButton, startConversationTask)
	if BehaviorTreeUtility.SkipConversation(dialogueStartID, startConversationTask) then
		return
	end

	local info = {}

	info.dialogueStartID = dialogueStartID
	info.isActiveConfirmButton = isActiveConfirmButton
	info.startConversationTask = startConversationTask

	ConversationModule.StartNewConversation(info)
end

function BehaviorTreeUtility.SetDialogueModule(autoDialogueCharacterSpeed)
	ConversationModule.SetAutoCharacterSpeed(autoDialogueCharacterSpeed)
end

function this.SetAutoCharacterSpeed(isReset, autoDialogueCharacterSpeed)
	if isReset then
		ConversationModule.SetAutoCharacterSpeed(0.11)
	else
		ConversationModule.SetAutoCharacterSpeed(autoDialogueCharacterSpeed)
	end
end

function this.SetTextShowSpeed(isReset, speed)
	if isReset then
		ConversationModule.SetTextShowSpeed(CfgUtil.GetPublicParametersData().TextShowSpeed)
	else
		ConversationModule.SetTextShowSpeed(speed)
	end
end

function this.SetDialogueSpeed(index)
	ConversationModule.autoDialogueStateIndex = index

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.autoDialogueStateIndex, index)
	EventDispatcher.Dispatch(EventID.StoryUIRefreshEvent)
end

function BehaviorTreeUtility.InitStoryCinemachineManager(StoryVirtualCameraManagerObj)
	StoryVirtualCameraManagerObj.name = "StoryVirtualCameraManager"
	StoryModule.virtualCameraManager = LuaUtility.GetComponent(StoryVirtualCameraManagerObj, "StoryVirtualCameraManager")

	StoryModule.virtualCameraManager:SetCinemachineBrain(UnityEngine.Camera.main)
	StoryModule.virtualCameraManager:Init()
end

function BehaviorTreeUtility.DestroyStoryCinemachineManager()
	if not StoryModule.virtualCameraManager then
		return
	end

	if not LuaUtility.GameObjectIsNullOrEmpty(StoryModule.virtualCameraManager) then
		GameObject.Destroy(StoryModule.virtualCameraManager.gameObject)
	end

	StoryModule.virtualCameraManager = nil
end

function BehaviorTreeUtility.SetCurrentVirtualCameraFollow(targetTransform)
	StoryModule.virtualCameraManager:SetCurrentCameraFollow(targetTransform)
end

function BehaviorTreeUtility.ChangeVirtualCameraWithID(cameraID)
	StoryModule.virtualCameraManager:SetCurrentEnableCameraWithID(cameraID)
end

function BehaviorTreeUtility.SetVirtualCameraFollowWithID(cameraID, npcID)
	if npcID == 0 then
		StoryModule.virtualCameraManager:SetCameraFollowWithID(cameraID, StoryModule.player.transform)
	else
		local character = BehaviorTreeUtility.GetNPCByNPCID(npcID)

		StoryModule.virtualCameraManager:SetCameraFollowWithID(cameraID, character.transform)
	end
end

function BehaviorTreeUtility.StartDollyCartWithID(cartID, StartDollyCart)
	StoryModule.virtualCameraManager:StartDollyCartWithID(cartID)

	local spanTime = 0.1

	if BehaviorTreeUtility.DollyCartTimer == nil then
		BehaviorTreeUtility.DollyCartTimer = Timer.New(function()
			if StoryModule.virtualCameraManager:CheckDollyCartIsCompleted(cartID) then
				StartDollyCart:SetIsCompleted()
				BehaviorTreeUtility.DollyCartTimer:Stop()

				BehaviorTreeUtility.DollyCartTimer = nil
			end
		end, spanTime, -1)

		BehaviorTreeUtility.DollyCartTimer:Start()
	end
end

function BehaviorTreeUtility.SetCinemachineBlend(style, time)
	LuaUtility.SetCinemachineBlend(style, time)
end

function BehaviorTreeUtility.SetCinemachineManagerInactive()
	StoryModule.virtualCameraManager:SetInactive()
end

function BehaviorTreeUtility.SetCinemachineManagerActive()
	StoryModule.virtualCameraManager:SetActive()
end

function BehaviorTreeUtility.HasNPCVariable(npcID, variableName)
	return StoryModule.HasNPCVariable(npcID, variableName)
end

function BehaviorTreeUtility.GetNPCVariable(npcID, variableName)
	return StoryModule.GetNPCVariable(npcID, variableName)
end

function BehaviorTreeUtility.GetNpcParamList(npcID, nameList)
	local t = {}

	for i = 1, #nameList do
		table.insert(t, StoryModule.GetNPCVariable(npcID, nameList[i]))
	end

	return t
end

function BehaviorTreeUtility.SetNpcParamList(npcIDList, variableType, nameList, valueList)
	for i = 1, #npcIDList do
		StoryModule.SetNpcVariableWithoutServer(npcIDList[i], variableType, nameList[i], valueList[i])
	end
end

function BehaviorTreeUtility.SetNPCVariable(npcID, variableName, variableType, variableValue, isStoreInServer)
	StoryModule.SetNPCVariable(npcID, variableName, variableType, variableValue, isStoreInServer)
end

function BehaviorTreeUtility.PrintAllVariables()
	for npcID, npcVariable in pairs(StoryModule.npcVariables) do
		local result = string.format("npc名称：%s 变量如下：\n", StoryModule.GetCharacterByNPCID(npcID):GetName())

		for name, variable in pairs(npcVariable) do
			result = result .. string.format("%s = %s type = %s \n", name, tostring(variable.value), type(variable.value))
		end

		log(result)
	end
end

function BehaviorTreeUtility.TriggerRegularShowBehaviorTree()
	local p = BehaviorTreeUtility.GetNPCByNPCID(999)

	p.npcController:TriggerRegularShow()
end

function BehaviorTreeUtility.TriggerRegularCloseBehaviorTree()
	local p = BehaviorTreeUtility.GetNPCByNPCID(999)

	p.npcController:TriggerRegularHide()
end

function BehaviorTreeUtility.GetExtensionParam(paramList)
	local t = {}

	for i = 1, #paramList do
		table.insert(t, StoryModule.GetExtensionParam(paramList[i]).value)
	end

	return t
end

function BehaviorTreeUtility.SetNpcInterActShow(npcID, isInteract)
	StoryModule.SetNPCVariable(npcID, Constant.StoryNameIconShow, IQIGame.Onigao.Game.VariableSetting.VariableType.Bool, isInteract, true)
end

function BehaviorTreeUtility.SetPuzzleUIShow(buttonPuzzleShow)
	if StoryModule.storyType == Constant.StoryType.Normal then
		EventDispatcher.Dispatch(EventID.StoryUIButtonPuzzleShowEvent, buttonPuzzleShow)
	else
		EventDispatcher.Dispatch(EventID.SetMazePuzzleShowEvent, buttonPuzzleShow)
	end
end

function BehaviorTreeUtility.ShowStoryUI(isShow)
	if isShow then
		UIModule.Open(Constant.UIControllerName.MainUI, Constant.UILayer.UI, {
			loadStory = true
		})
	else
		UIModule.Close(Constant.UIControllerName.MainUI)
	end
end

function BehaviorTreeUtility.SetJoystickEnable(isEnable)
	if isEnable then
		EventDispatcher.Dispatch(EventID.Story_OpenJoystickPanel)
	else
		EventDispatcher.Dispatch(EventID.Story_CloseJoystickPanel)
	end

	StoryModule.storyState = isEnable and Constant.StoryState.Normal or Constant.StoryState.Interact

	if isEnable then
		StoryModule.StopSkip()
	end
end

function BehaviorTreeUtility.ShowThreadPuzzleUI(cluePuzzleID, ActionStartCluesPuzzle)
	UIModule.Open(Constant.UIControllerName.ThreadPuzzleUI, Constant.UILayer.UI, {
		cluePuzzleID = cluePuzzleID,
		ActionStartCluesPuzzle = ActionStartCluesPuzzle
	})

	local storyInfo = {
		step = ThreadPuzzleUIApi:GetStartCluePuzzleText(),
		cluePuzzleID = cluePuzzleID
	}
end

function BehaviorTreeUtility.ShowImagePuzzleUI(imagePuzzleID)
	StoryModule.StopSkip()
	UIModule.Open(Constant.UIControllerName.ImagePuzzleUI, Constant.UILayer.UI, {
		imagePuzzleID = imagePuzzleID
	})
	EventDispatcher.Dispatch(EventID.MainUI_SetShowImagePuzzleState)
end

function BehaviorTreeUtility.CloseImagePuzzleUI()
	UIModule.Close(Constant.UIControllerName.ImagePuzzleUI)
	EventDispatcher.Dispatch(EventID.MainUI_SetHideImagePuzzleState)
end

function BehaviorTreeUtility.ImagePuzzleSuccess()
	EventDispatcher.Dispatch(EventID.ImagePuzzleSuccessEvent)
end

function BehaviorTreeUtility.SetNPCNameShow(isShow)
	if isShow then
		StoryModule.showName = true

		StoryModule.NPCNamesRefresh()
		StoryModule.ShowALLCloseOutLine()
	else
		EventDispatcher.Dispatch(EventID.StoryUIHideNPCNameEvent)

		StoryModule.showName = false

		StoryModule.HideAllCloseOutLine()
	end
end

function BehaviorTreeUtility.SetNPCNameCanShow(npcID, show)
	local storyNPC = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	storyNPC.canShowName = show

	StoryModule.NPCNamesRefresh()
end

function BehaviorTreeUtility.SetStoryUISurveyTargetShow(show)
	EventDispatcher.Dispatch(EventID.MainUI_RPGInfoPanel_SetStoryInfoShowEvent, show)
end

function BehaviorTreeUtility.SetStorySurveyTargetText(CfgTextID)
	EventDispatcher.Dispatch(EventID.MainUI_RPGInfoPanel_SetStoryInfoEvent, CfgTextID)
end

function BehaviorTreeUtility.SetStorySurveyProgress(numProgress, playAnimate)
	EventDispatcher.Dispatch(EventID.MainUI_RPGInfoPanel_SetStoryInfoEvent, nil, numProgress)
end

function BehaviorTreeUtility.SetStoryUIRegular(show)
	EventDispatcher.Dispatch(EventID.SetRegularShowEvent, show)
end

function BehaviorTreeUtility.LoadImageList(imageList, resourceList)
	for i = 1, #imageList do
		if resourceList[i] == -1 then
			imageList[i].enabled = false
		else
			local index = i

			imageList[i].enabled = true

			LuaUtility.LoadImage(BehaviorTreeUtility, CfgUtil.GetStoryResourceWithID(resourceList[i]), imageList[i], function()
				imageList[index]:SetNativeSize()
			end)
		end
	end
end

function BehaviorTreeUtility.SetTextList(textList, textIDList)
	for i = 1, #textList do
		if textIDList[i] == -1 then
			textList[i].text = ""
		else
			textList[i].text = CfgUtil.GetCfgStoryTextDataWithID(textIDList[i])
		end
	end
end

function BehaviorTreeUtility.SetStoryUIReturnButtonShow(show)
	EventDispatcher.Dispatch(EventID.SetReturnButtonShowEvent, show)
end

function BehaviorTreeUtility.SetStorySiteShow(isShow, timeID, mainSiteID, branchSiteID, duration, SetStorySiteShow)
	EventDispatcher.Dispatch(EventID.SetStoryDescriptionEvent, isShow, timeID, mainSiteID, branchSiteID, duration, SetStorySiteShow)
end

function BehaviorTreeUtility.OpenPuzzleUI()
	UIModule.Open(Constant.UIControllerName.PuzzleUI, Constant.UILayer.UI)
end

function BehaviorTreeUtility.SetMythButtonShow(isShow)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.MythButton, isShow)
end

function BehaviorTreeUtility.SetDeviceButtonShow(isShow)
	EventDispatcher.Dispatch(EventID.SetMazeDeviceShowEvent, isShow)
end

function BehaviorTreeUtility.SetStoryUIShow(show)
	EventDispatcher.Dispatch(EventID.SetStoryUIShowEvent, show)
end

function BehaviorTreeUtility.OpenMainFakeUI(isOpen)
	if isOpen then
		UIModule.Open(Constant.UIControllerName.MainFakeUI, Constant.UILayer.UI)
	else
		UIModule.Close(Constant.UIControllerName.MainFakeUI)
	end
end

function BehaviorTreeUtility.StartNPCAutoMove(autoMoveTargetType, moverCharacterID, moveTargetInfo, autoMoveNPCInstance, moveInfo)
	if not StoryModule.isInitializedMoveConfig then
		logError("BehaviorTreeUtility.StartNpcAutoOnceMove：此剧情场景未设置 \"单位移动配置数据项\" , 无法进行寻路移动相关操作, 请在剧情配置页面进行设置.")

		return false
	end

	local character = BehaviorTreeUtility.GetNPCByNPCID(moverCharacterID)

	if character == nil then
		logError("BehaviorTreeUtility.StartNpcAutoOnceMove：无法找到 characterID={0} 的角色.", moverCharacterID)

		return false
	end

	if moverCharacterID == StoryModule.playerNPCID and StoryModule.player ~= nil then
		StoryModule.player.lastAutoMoveTargetNPCIDByClickNPC = -1
	end

	return character.autoMoveController:StartAutoMove(autoMoveTargetType, moveTargetInfo, autoMoveNPCInstance, moveInfo)
end

function BehaviorTreeUtility.StopNPCAutoMove(characterID)
	if not StoryModule.isInitializedMoveConfig then
		logError("BehaviorTreeUtility.StopNPCAutoMove：此剧情场景未设置 \"单位移动配置数据项\" ,无法进行寻路移动相关操作, 请在剧情配置页面进行设置.")

		return false
	end

	local character = BehaviorTreeUtility.GetNPCByNPCID(characterID)

	if character == nil then
		logError("BehaviorTreeUtility.StopNPCMove：无法找到 characterID={0} 的角色.", characterID)

		return false
	end

	character.autoMoveController:StopAutoMove()

	return true
end

function BehaviorTreeUtility.SetStoryPlayerObstacleEnable(obstacleName, isEnable)
	if StoryModule.characterMoveConfigManager ~= nil then
		return StoryModule.characterMoveConfigManager:SetObstacleForPlayerEnable(obstacleName, isEnable)
	else
		logError("BehaviorTreeUtility.SetStoryPlayerObstacleEnable: characterMoveConfigManager is nil.")
	end

	return false
end

function BehaviorTreeUtility.SetPlayerClickNPCAutoMoveConfig(moveInfo)
	if StoryModule.player ~= nil then
		StoryModule.player:SetClickNPCAutoMoveConfig(moveInfo)
	else
		logError("BehaviorTreeUtility.SetPlayerClickNPCAutoMoveConfig: StoryModule.player is nil.")
	end
end

function BehaviorTreeUtility.SetPlayerAutoMoveByClickNPC(canMove)
	if StoryModule.player ~= nil then
		StoryModule.player.canAutoMoveByClickNPC = canMove
	end
end

function BehaviorTreeUtility.SetPlayerInteractionWithNPC(canInteraction)
	if StoryModule.player ~= nil then
		StoryModule.player.canInteractionWithNPC = canInteraction
	end
end

function BehaviorTreeUtility.MoveTowards(moveObject, moverNPCID, position)
	return BehaviorTreeUtility.SkipMoveTowards(moveObject, moverNPCID, position)
end

function BehaviorTreeUtility.GetCluesItems(clueID, needTip)
	PuzzleModule.AddClueInCurrentStoryClueList(clueID, needTip)
end

function BehaviorTreeUtility.ExchangeClues(originClue, targetClue)
	PuzzleModule.AddClueInExchangeClueList(originClue, targetClue)
end

function BehaviorTreeUtility.SetJoystickInfo(idleAnimationName, walkAnimationName, runAnimationName)
	if StoryModule.player then
		if not LuaUtility.StrIsNullOrEmpty(idleAnimationName) then
			StoryModule.player:SetIdleAnimationName(idleAnimationName)
		end

		if not LuaUtility.StrIsNullOrEmpty(walkAnimationName) then
			StoryModule.player:SetWalkAnimationName(walkAnimationName)
		end

		if not LuaUtility.StrIsNullOrEmpty(runAnimationName) then
			StoryModule.player:SetRunAnimationName(runAnimationName)
		end
	end
end

function BehaviorTreeUtility.SetJoystickDragSpeed(value)
	if StoryModule.player then
		StoryModule.player.joyStickDragSpeed = value
	end
end

function BehaviorTreeUtility.SetJoystickDragSpeedRatio(value)
	if StoryModule.player then
		StoryModule.player.joystickControl.JoyStickDragSpeedRatio = value
	end
end

function BehaviorTreeUtility.SetMoveToRunThreshold(value)
	if StoryModule.player then
		StoryModule.player.moveToRunThreshold = value
	end
end

function BehaviorTreeUtility.SetJoystickUniformSpeedState(value)
	if StoryModule.player then
		StoryModule.player.joystickControl.IsUniformSpeed = value
	end
end

function BehaviorTreeUtility.AddJoystickControl(storyCharacter, useRigdbody)
	storyCharacter.joystickControl = JoystickControlClass.New(storyCharacter, useRigdbody)
end

function BehaviorTreeUtility.SetMapMoveState(NpcId, enabled, mapShaderValueList)
	local npc = StoryModule.GetCharacterByNPCID(NpcId)

	if not npc.joystickControl then
		logError(string.format("【剧情】试图将 npc = %s设置为地图移动模式,但是Npc没有添加摇杆控制器", NpcId))

		return
	end

	if StoryModule.MapMoveControl and enabled then
		StoryModule.MapMoveControl:SetMapMoveState(false)
	end

	npc.joystickControl:SetMapMoveState(enabled, mapShaderValueList)
end

function BehaviorTreeUtility.AddOrSetJoystickControl(npcId, IsReverseOption, controlAnimation, enterAnimation, endAnimation, isUniformSpeed, dragSpeedRatio, enableRoleFlip, ignoreX, ignoreY)
	local storyNpc = StoryModule.GetCharacterByNPCID(npcId)
	local joyStick = storyNpc.joystickControl

	if not joyStick then
		BehaviorTreeUtility.AddJoystickControl(storyNpc, false)

		joyStick = storyNpc.joystickControl
	end

	if IsReverseOption ~= nil then
		joyStick.IsReverseControl = IsReverseOption
	end

	if controlAnimation ~= nil then
		joyStick.ControlAnimation = controlAnimation
	end

	if enterAnimation ~= nil then
		joyStick.EnterAnimation = enterAnimation
	end

	if endAnimation ~= nil then
		joyStick.EndAnimation = endAnimation
	end

	if isUniformSpeed ~= nil then
		joyStick.IsUniformSpeed = isUniformSpeed
	end

	if dragSpeedRatio ~= nil then
		joyStick.JoyStickDragSpeedRatio = dragSpeedRatio
	end

	if enableRoleFlip ~= nil then
		joyStick.EnableRoleFlip = enableRoleFlip
	end

	if ignoreX ~= nil then
		joyStick.IsIgnoreX = ignoreX
	end

	if ignoreY ~= nil then
		joyStick.IsIgnoreY = ignoreY
	end
end

function BehaviorTreeUtility.RemoveJoystickControl(npcId)
	local storyNpc = StoryModule.GetCharacterByNPCID(npcId)

	storyNpc.joystickControl = nil
end

function BehaviorTreeUtility.SetJoyStickLimited(npcId, LimitX_Left, LimitX_Right, LimitZ_Left, LimitZ_Right)
	local storyNpc = StoryModule.GetCharacterByNPCID(npcId)
	local joyStick = storyNpc.joystickControl

	if not joyStick then
		BehaviorTreeUtility.AddJoystickControl(storyNpc, false)

		joyStick = storyNpc.joystickControl
	end

	joyStick.LimitX_Left = LimitX_Left
	joyStick.LimitX_Right = LimitX_Right
	joyStick.LimitZ_Left = LimitZ_Left
	joyStick.LimitZ_Right = LimitZ_Right
end

function BehaviorTreeUtility.SetMapDistanceValue(npcId, value)
	local storyNpc = StoryModule.GetCharacterByNPCID(npcId)
	local joyStick = storyNpc.joystickControl

	if not joyStick then
		logError("【剧情】试图修改地图循环移动的值,但是 npc = %s 没有摇杆操控器", npcId)

		return
	end

	if not joyStick.IsMapMoveState then
		logError("【剧情】试图修改地图循环移动的值,但是 npc = %s 的摇杆操控器不是地图操控模式", npcId)
	end

	joyStick:SetMapMoveDistance(value)
end

function BehaviorTreeUtility.StartCountOfJoystickMove(npcID, isOpen)
	local storyNpc = StoryModule.GetCharacterByNPCID(npcID)
	local joyStick = storyNpc.joystickControl

	if not joyStick then
		logError("【剧情】试图获取角色摇杆移动值,但是 npc = %s 没有摇杆操控器", npcID)

		return
	end

	if isOpen and StoryModule.JoystickCountOfHolder then
		StoryModule.JoystickCountOfHolder.isCountOfMove = false
	end

	joyStick.isCountOfMove = isOpen
	joyStick.absMoveX = 0
	joyStick.absMoveZ = 0
	StoryModule.JoystickCountOfHolder = isOpen and joyStick or nil
end

function BehaviorTreeUtility.PlayStorySound(soundID)
	return LuaUtility.PlaySoundWithID(soundID)
end

function BehaviorTreeUtility.StopSound(serialID)
	LuaUtility.StopSoundWithSerialId(serialID)
end

function BehaviorTreeUtility.PlayStoryBGM(soundID)
	StoryModule.StoryCurrentBGMID = soundID

	return StoryModule.PlayBGM(soundID)
end

function BehaviorTreeUtility.StopBGM(fadeOutSeconds)
	return StoryModule.PlayBGM(Constant.BGMSoundID.EMPTY)
end

function BehaviorTreeUtility.PlayMovie(resourceID, PlayMovieTask)
	StoryModule.StopSkip()
	EventDispatcher.Dispatch(EventID.StoryUIPlayMovie, resourceID, PlayMovieTask)
end

function BehaviorTreeUtility.ShowPictures(resourceID, posParam, ShowPictureTask)
	EventDispatcher.Dispatch(EventID.StoryUIShowPicture, resourceID, posParam, ShowPictureTask)
end

function BehaviorTreeUtility.ClosePictures()
	EventDispatcher.Dispatch(EventID.StoryUIClosePicture)
end

function BehaviorTreeUtility.ShowCluesTrigger(npcID, selectCfgID, ShowCluesTask)
	StoryModule.StopSkip()
	EventDispatcher.Dispatch(EventID.StopMultipleSpeedEvent)
	EventDispatcher.Dispatch(EventID.StoryUIShowCluesTrigger, npcID, selectCfgID, ShowCluesTask)
end

function BehaviorTreeUtility.ClearCluesTriggerData()
	StoryModule.ClearClueTriggerData()
end

function BehaviorTreeUtility.ClearDialogueOptionData()
	StoryModule.ClearDialogueOptionData()
end

function BehaviorTreeUtility.SetOptionDisplay(isShow, optionCfgID, options)
	StoryModule.SetOptionDisplay(isShow, optionCfgID, options)
end

function BehaviorTreeUtility.ShowDialogueSelect(npcID, selectCfgID, ShowCluesTask)
	StoryModule.StopSkip()
	EventDispatcher.Dispatch(EventID.StopMultipleSpeedEvent)
	EventDispatcher.Dispatch(EventID.StoryUIShowDialogueSelect, npcID, selectCfgID, ShowCluesTask)
end

function BehaviorTreeUtility.StartCommunication(selectGroupID, StartCommunicationTask)
	UIModule.Open(Constant.UIControllerName.StoryChatUI, Constant.UILayer.UI, {
		isPerformance = true,
		selectGroupID = selectGroupID,
		StartCommunicationTask = StartCommunicationTask
	})
	EventDispatcher.AddEventListener(EventID.StoryChatUIOpenEvent, BehaviorTreeUtility.SetStoryChatUIIsOpenEvent)
end

function BehaviorTreeUtility.SetStoryChatUIIsOpenEvent(StartCommunicationTask)
	StartCommunicationTask:SetIsOpen()
	EventDispatcher.RemoveEventListener(EventID.StoryChatUIOpenEvent, BehaviorTreeUtility.SetStoryChatUIIsOpenEvent)
end

function BehaviorTreeUtility.OverCommunication()
	UIModule.Close(Constant.UIControllerName.StoryChatUI)
end

function BehaviorTreeUtility.CreateCommunicationChatGroup(nameID, iconPath)
	return StoryModule.CreateCommunicationChatGroup(nameID, iconPath)
end

function BehaviorTreeUtility.RemoveCommunicationChatGroup(groupID)
	StoryModule.RemoveCommunicationChatGroup(groupID)
end

function BehaviorTreeUtility.AddCommunicationChatPerformance(GroupID, StartDialogueID, AddCommunicationChatPerformanceTask)
	StoryModule.AddShowCommunicationData(GroupID, Constant.StoryCommunicationType.Chat, StartDialogueID)
	EventDispatcher.Dispatch(EventID.StoryChatPerformanceStart, AddCommunicationChatPerformanceTask)
end

function BehaviorTreeUtility.AddCommunicationOptionPerformance(GroupID, optionID, AddCommunicationOptionTask)
	StoryModule.AddShowCommunicationData(GroupID, Constant.StoryCommunicationType.Option, optionID)
	EventDispatcher.Dispatch(EventID.StoryChatUIOptionEvent, AddCommunicationOptionTask)
end

function BehaviorTreeUtility.AddAddCommunicationChatData(GroupID, StartDialogueID)
	StoryModule.AddCommunicationChatData(GroupID, Constant.StoryCommunicationType.Chat, StartDialogueID)
end

function BehaviorTreeUtility.AddCommunicationHistoryLine(GroupID)
	StoryModule.AddCommunicationHistoryLine(GroupID)
	EventDispatcher.Dispatch(EventID.StoryChatUIRefreshSelect)
end

function BehaviorTreeUtility.TriggerAction(actionID)
	net_plotStage.triggerAction(actionID)
end

function BehaviorTreeUtility.SetExtensionParam(add, extension)
	if StoryModule.isDebugMod then
		GameEntry.LuaEvent:Fire(nil, SetExtensionResultEventArgs():Fill())

		return
	end

	StoryModule.SetExtensionParam(add, extension)
end

function BehaviorTreeUtility.RemoveExtension(keys)
	StoryModule.RemoveExtension(keys)
end

function BehaviorTreeUtility.GetTaskInfo(taskID)
	local taskData = TaskSystemModule.GetTaskByConfig(taskID)

	if not taskData then
		return nil
	end

	local t = {}

	t.cid = taskData.cid
	t.status = taskData.status
	t.schedule = taskData.schedule
	t.needSchedule = taskData.needSchedule

	return t
end

function BehaviorTreeUtility.GetPlayerLevel()
	return PlayerModule.PlayerInfo.baseInfo.pLv
end

function BehaviorTreeUtility.GetItemListCount(cidList)
	local t = {}

	for i = 1, #cidList do
		table.insert(t, WarehouseModule.GetItemNumByCfgID(cidList[i]))
	end

	return t
end

function BehaviorTreeUtility.GetHeroCount()
	return #WarlockModule.WarlockDataDic
end

function BehaviorTreeUtility.GetHeroData(heroCid)
	local heroData = WarlockModule.GetHeroData(heroCid)

	if not heroData then
		return nil
	end

	local t = {}

	t.level = heroData.lv

	return t
end

function BehaviorTreeUtility.ShowGuide(subID, ShowGuideTask)
	StoryModule.StopSkip()

	local subCfg = GuideModule.GetSubGuide(subID)

	if not subCfg then
		return
	end

	UIModule.Open(Constant.UIControllerName.GuideUI, Constant.UILayer.Top, {
		subCfg,
		[3] = function()
			UIModule.Close(Constant.UIControllerName.GuideUI)
			ShowGuideTask:SetComplete()
		end
	}, nil, true)
end

function BehaviorTreeUtility.ShowCreateNameUI(ShowCreateNameUITask)
	if StoryModule.isDebugMod then
		ShowCreateNameUITask:SetComplete()

		return
	end

	StoryModule.StopSkip()

	local alreadyName = StoryModule.GetExtensionParam("Already_Named")

	if alreadyName and alreadyName == 1 then
		EventDispatcher.Dispatch(EventID.StoryChangePlayer)
		ShowCreateNameUITask:SetComplete()

		return
	end

	UIModule.Open(Constant.UIControllerName.InputPlayerNameTextUI, Constant.UILayer.UI)
	EventDispatcher.AddSingleEventListener(EventID.CreateNameSuccessEvent, function()
		ShowCreateNameUITask:SetComplete()
	end)
end

function BehaviorTreeUtility.MazeGoNextRoom(LinkIndex, teleportPos, MazeGoNextRoomTask)
	MazeStageModule.MazeGoNextRoom(LinkIndex, teleportPos, MazeGoNextRoomTask)
end

function BehaviorTreeUtility.GetRoomEventParam(roomID, index)
	local variable = MazeStageModule.GetRoomVariableData(roomID)

	if not variable.param[index] then
		logError("【迷宫】没有找到指定房间 roomID = %s,索引为 index = %s 的房间事件参数", roomID, index)

		return -1
	end

	return variable.param[index]
end

function BehaviorTreeUtility.SetMazeEventExtensionData(type, id)
	StoryModule.AddExtensionMazeEvent(type, id)
end

function BehaviorTreeUtility.AddEventData(eventIDArray)
	StoryModule.AddEventData(eventIDArray)
end

function BehaviorTreeUtility.ChangeEventData(oldID, newID)
	StoryModule.ChangeEventData(oldID, newID)
end

function BehaviorTreeUtility.AddMythData(resourceIDArray)
	StoryModule.AddMythData(resourceIDArray)
end

function BehaviorTreeUtility.ChangeMythData(oldID, newID)
	StoryModule.ChangeMythData(oldID, newID)
end

function BehaviorTreeUtility.StartLoopMap(cfgId, startLoopMapTask)
	UIModule.Open(Constant.UIControllerName.LoopMapUI, Constant.UILayer.UI, {
		cfgId = cfgId,
		startLoopMapTask = startLoopMapTask
	})
end

function BehaviorTreeUtility.StartJudgmentCheckers(resourceId, playerIndex, StartJudgmentCheckersTask)
	EventDispatcher.Dispatch(EventID.StoryUI_JudgmentCheckersOpen, resourceId, playerIndex, StartJudgmentCheckersTask)
end

function BehaviorTreeUtility.ShowJudgmentCheckersProblem(indexDic, ShowCheckersProblemTask)
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_ShowProblemEvent, indexDic, ShowCheckersProblemTask)
end

function BehaviorTreeUtility.SetCheckersPlayerPos(posIndex)
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_SetPlayerPosEvent, posIndex)
end

function BehaviorTreeUtility.ShowCheckersCluesPanel(index, textId, ShowCheckersCluePanelTask)
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_ShowCluesEvent, index, textId, ShowCheckersCluePanelTask)
end

function BehaviorTreeUtility.SetCheckersClue(index, clueId)
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_SetClueEvent, index, clueId)
end

function BehaviorTreeUtility.CloseJudgmentCheckers()
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_CloseEvent)
end

function BehaviorTreeUtility.HideCheckersCluePanel()
	EventDispatcher.Dispatch(EventID.JudgmentCheckersPanel_HideCluePanelEvent)
end

function BehaviorTreeUtility.SetCustomText(args)
	local textCom, content

	ForArrayByCount(1, 10, 1, function(_index)
		local textGo = args["TextGo_" .. _index]

		if textGo == nil then
			return
		end

		textCom = textGo:GetComponent("Text")
		content = args["TextContent_" .. _index]

		return true
	end)

	if textCom == nil then
		return
	end

	textCom.text = content
end
