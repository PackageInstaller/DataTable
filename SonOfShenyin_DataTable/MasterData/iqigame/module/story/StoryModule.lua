-- chunkname: @IQIGame\\Module\\Story\\StoryModule.lua

StoryModule = {}

local this = StoryModule
local pairs = pairs
local StoryCharacterMoveConfigManager = require("IQIGame.Module.Story.StoryCharacterMoveConfigManager")
local CachePoolClass = require("IQIGame.Common.CachePool")
local json = require("Util.json")

function StoryModule.Initialize()
	StoryModule.InitMembers()
	StoryModule._AddListenerOnInitialize()
	StoryModule.StopAllFilterEffect()

	this.CachePool = CachePoolClass.New()
end

function StoryModule.InitMembers()
	StoryModule.DefaultIdleAnimationName = "S_stay"
	StoryModule.DefaultWalkAnimationName = "S_move"
	StoryModule.DefaultRunAnimationName = "S_run"
	StoryModule.playerNPCID = 0
	StoryModule.SavedCommunicationData = {}
	StoryModule.needShowCommunicationData = {}
	StoryModule.StoryEffectList = {}
	StoryModule.StoryEffectIndex = 1
	StoryModule.communicationDataIndex = 1
	StoryModule.hasTriggerOption = {}
	StoryModule.uiStateDic = {}
	StoryModule.storyData = nil
	StoryModule.IsStoring = false
	this.timeLineList = {}
end

function StoryModule._AddListenerOnInitialize()
	EventDispatcher.AddEventListener(EventID.StartStageLevel, StoryModule.StartStageLevel)
end

function StoryModule._RemoveListenerOnShutDown()
	EventDispatcher.RemoveEventListener(EventID.StartStageLevel, StoryModule.StartStageLevel)
end

function StoryModule.Destroy()
	StoryModule._RemoveListenerOnShutDown()
end

function StoryModule.StartStageLevel(plotStageDupPOD)
	local storyParam, isRestart = StoryModule.InitStartStoryParam(plotStageDupPOD)

	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.Story then
		SceneTransferModule.StoryToStory(storyParam)
	else
		SceneTransferModule.MainCityToStory(storyParam)
	end

	if isRestart then
		StoryModule.SaveEmpty()

		StoryModule.IsRestart = false
	end
end

function StoryModule.InitStartStoryParam(plotStageDupPOD)
	StoryModule.plotStageDupPOD = plotStageDupPOD

	local isRestart = plotStageDupPOD.storySaveData.currentSceneID == 0 or StoryModule.GetStoryIsRestart()
	local cfgPlot = CfgUtil.GetPlotCfgDataWithID(plotStageDupPOD.plotCid)
	local isPlayerShowOnAwake = true
	local storyDataID = not isRestart and plotStageDupPOD.storySaveData.currentSceneID or cfgPlot.BattleTypeID
	local playerName = PlayerModule.PlayerInfo.baseInfo.pName
	local playerEntityID = this.GetPlayerEntityID()
	local storyDataConfig = CfgStoryDataTable[storyDataID]

	if storyDataConfig == nil then
		logError("【剧情】开始剧情失败,StoryData表找不到id={0}的项", storyDataID)

		return
	end

	local playerPosition = not isRestart and plotStageDupPOD.storySaveData.position or Vector3.New(storyDataConfig.PlayerInitPosition[1], storyDataConfig.PlayerInitPosition[2], storyDataConfig.PlayerInitPosition[3])
	local npcVariables = not isRestart and plotStageDupPOD.storySaveData.npcVariables or nil

	if cfgPlot.Type == Constant.ChapterPassType.TYPE_StoryGuide or cfgPlot.Type == Constant.ChapterPassType.TYPE_BattleActivity then
		GameChapterModule.SetupCurChapterType(cfgPlot.Type)
	else
		GameChapterModule.CurSelectChapterCfg = this.isReview == false and CfgWorldMapItemTable[plotStageDupPOD.stageId] or nil
	end

	local storyParam = {}

	storyParam.StoryDataID = storyDataID
	storyParam.IsPlayerShowOnAwake = isPlayerShowOnAwake
	storyParam.PlayerName = playerName
	storyParam.PlayerEntityID = playerEntityID
	storyParam.PlayerPosition = playerPosition
	storyParam.NpcVariables = npcVariables
	storyParam.StoryType = Constant.StoryType.Normal

	return storyParam, isRestart
end

function StoryModule.DebugStory(luaTable)
	CoroutineUtility.StartCoroutine(function()
		StoryModule.isDebugMod = true

		StoryModule.InitForDebug()

		local storyParam = {}

		storyParam.StoryDataID = luaTable.firstStoryDataID
		storyParam.IsPlayerShowOnAwake = luaTable.isPlayerShowOnAwake
		storyParam.PlayerName = luaTable.playerName
		storyParam.PlayerEntityID = luaTable.playerEntityID
		storyParam.PlayerPosition = luaTable.playerPosition
		storyParam.NpcVariables = nil
		storyParam.StoryType = Constant.StoryType.Normal
		PlayerModule.PlayerInfo = {}
		PlayerModule.PlayerInfo.baseInfo = {}
		PlayerModule.PlayerInfo.baseInfo.sex = luaTable.isMan and 0 or 1
		PlayerModule.PlayerInfo.baseInfo.pName = luaTable.playerName
		StoryModule.plotStageDupPOD = {}
		StoryModule.plotStageDupPOD.storySaveData = {}
		StoryModule.plotStageDupPOD.storySaveData.npcVariables = {}
		StoryModule.plotStageDupPOD.storySaveData.tempWarehouse = {}
		StoryModule.plotStageDupPOD.storySaveData.extension = {}
		StoryModule.plotStageDupPOD.storySaveData.clueIds = {}

		StoryModule.LoadStory(storyParam)
		StoryModule.AllNPCsTriggerStart()
	end)
end

function StoryModule.StartStory(startStoryParam)
	StoryModule.isDebugMod = false
	StoryModule.IsStoring = true

	StoryModule.InitForRelease()
	StoryModule.LoadStory(startStoryParam)
end

function StoryModule.InitForDebug()
	GameEntry.Input:InitTapGesture()

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + PlayerModule.OnTapGesture

	StoryModule.Init()

	StoryModule.uiCamera = GameObject.Find("GameFramework(Clone)/Extensions/Rendering/BaseCamera/UICamera"):GetComponent("Camera")

	local originMainCameraObj = UnityEngine.Camera.main.gameObject

	StoryModule.mainCamera = originMainCameraObj:GetComponent("Camera")
	StoryModule.cinemachineBrain = LuaUtility.GameObjectGetOrAddComponent(originMainCameraObj, typeof(Cinemachine.CinemachineBrain))

	local eventSystemObj = GameObject.New("EventSystem")

	eventSystemObj:AddComponent(typeof(UnityEngine.EventSystems.EventSystem))
	eventSystemObj:AddComponent(typeof(UnityEngine.EventSystems.StandaloneInputModule))
	BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0)

	local CriInitialObject = GameObject.New("CriInitial")

	CriInitialObject:AddComponent(typeof(CriWare.CriWareInitializer))
end

function StoryModule.InitForRelease()
	StoryModule.Init()
	BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0)

	StoryModule.mainCamera = GameEntry.RenderingComponent:GetMainCamera()

	local mainCameraObj = StoryModule.mainCamera.gameObject

	StoryModule.cinemachineBrain = LuaUtility.GameObjectGetOrAddComponent(mainCameraObj, typeof(Cinemachine.CinemachineBrain))
	StoryModule.uiCamera = GameObject.Find("UICamera"):GetComponent("Camera")
end

function StoryModule.Init()
	PuzzleModule.Initialize()

	StoryModule.npcs = {}
	StoryModule.npcVariables = {}
	StoryModule.insideRangeNPCs = {}
	StoryModule.outsideRangeNPCs = {}

	if not StoryModule.dialogueReviewData then
		StoryModule.dialogueReviewData = {}
	end

	StoryModule.isFirstShowSurvey = true
	StoryModule.joystickMoveSpeed = 1
	StoryModule.showName = true
	StoryModule.isCanBeSkip = false
	StoryModule.isShowDialogSelectPanel = false

	StoryModule.AddListener()
end

function StoryModule.LoadStory(startStoryParam)
	StoryModule.storyType = startStoryParam.StoryType

	CoroutineUtility.Yield(WaitUntil(function()
		return CfgUtil.publicParametersData ~= nil
	end))
	StoryModule.LoadPublicParameter()

	StoryModule.bgmSerialID = LuaUtility.StartNewBGMGroup(Constant.BGMSoundID.EMPTY)

	local playerGameObject = CoroutineUtility.Yield(StoryModule.WaitCreatePlayer(startStoryParam.PlayerEntityID)).customWait.result
	local player = StoryPlayer(this.playerNPCID, startStoryParam.PlayerName)
	local playerInfo = {}

	playerInfo.gameObject = GameObject.Instantiate(playerGameObject)
	playerInfo.entityConfigID = startStoryParam.PlayerEntityID

	player:InitPlayer(playerInfo)

	StoryModule.player = player

	if StoryModule.player then
		StoryModule.player.playerController.enabled = false

		LuaUtility.SetGameObjectShow(this.player.gameObject, false)

		StoryModule.player.transform.position = startStoryParam.PlayerPosition
	end

	if startStoryParam.StoryType == Constant.StoryType.Maze then
		StoryModule.player.joystickControl:AddMazeMeetEnemyComponent()
	end

	StoryModule.UnloadSceneAndNPCs()

	if StoryModule.isDebugMod then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.StoryUI, Constant.UILayer.UI, {
			StoryType = startStoryParam.StoryType
		}))
	else
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.MainUI, Constant.UILayer.UI, {
			loadStory = true
		}))
	end

	CoroutineUtility.Yield(StoryModule.LoadSceneAndNPCs, startStoryParam.StoryDataID, startStoryParam.NpcVariables)

	if StoryModule.player then
		StoryModule.player.playerController.enabled = true

		StoryModule.player.gameObject:SetActive(true)
	end

	EventDispatcher.Dispatch(EventID.OnStoryLoadOverEvent)
end

function StoryModule.AddListener()
	EventDispatcher.AddEventListener(EventID.BehaviorTreeOnInteract, StoryModule.OnInteracted)
	EventDispatcher.AddEventListener(EventID.BehaviorTreeStartInteract, StoryModule.StartInteract)
	EventDispatcher.AddEventListener(EventID.BehaviorTreeEndInteract, StoryModule.EndInteract)
	EventDispatcher.AddEventListener(EventID.BehaviourTreeNPCClueTriggerEvent, StoryModule.OnBehaviourTreeNPCClueTriggerEvent)
	EventDispatcher.AddEventListener(EventID.StoryBattleNodeComplete, StoryModule.OnFightOver)
	EventDispatcher.AddEventListener(EventID.StoryStartFight, StoryModule.OnStartFight)
	EventDispatcher.AddEventListener(EventID.QuitStageLevel, StoryModule.QuitLevel)
	EventDispatcher.AddEventListener(EventID.OnTapGesture, StoryModule.OnTapGesture)
	EventDispatcher.AddEventListener(EventID.StoryChangePlayer, StoryModule.OnReloadPlayer)
end

function StoryModule.RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeOnInteract, StoryModule.OnInteracted)
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeStartInteract, StoryModule.StartInteract)
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeEndInteract, StoryModule.EndInteract)
	EventDispatcher.RemoveEventListener(EventID.BehaviourTreeNPCClueTriggerEvent, StoryModule.OnBehaviourTreeNPCClueTriggerEvent)
	EventDispatcher.RemoveEventListener(EventID.StoryBattleNodeComplete, StoryModule.OnFightOver)
	EventDispatcher.RemoveEventListener(EventID.StoryStartFight, StoryModule.OnStartFight)
	EventDispatcher.RemoveEventListener(EventID.QuitStageLevel, StoryModule.QuitLevel)
	EventDispatcher.RemoveEventListener(EventID.OnTapGesture, StoryModule.OnTapGesture)
	EventDispatcher.RemoveEventListener(EventID.StoryChangePlayer, StoryModule.OnReloadPlayer)
	EventDispatcher.RemoveEventListenerByType(EventID.StoryUIInitOverEvent)
end

function StoryModule.PauseStory()
	if not StoryModule.IsStoring then
		return
	end

	if StoryModule.npcs then
		for _, v in pairs(StoryModule.npcs) do
			v.npcController:PauseBehaviorTree()
		end
	end

	ConversationModule.PauseConversation()
end

function StoryModule.ContinueStory()
	if not StoryModule.IsStoring then
		return
	end

	if StoryModule.npcs then
		for _, v in pairs(StoryModule.npcs) do
			v.npcController:ContinueBehaviorTree()
		end
	end

	ConversationModule.ContinueConversation()
end

function StoryModule.StopAllBehaviorTree()
	ForPairs(StoryModule.npcs, function(_, npc)
		npc.npcController:StopAllBehaviorTree()
	end)
	ConversationModule.ClearConversation()
end

function StoryModule.Dispose()
	BehaviorTreeUtility.ShowStoryUI(false)
	StoryModule.__RemoveBGM()
	PuzzleModule.Shutdown()

	if StoryModule.updateFrameTimer then
		StoryModule.updateFrameTimer:Stop()

		StoryModule.updateFrameTimer = nil
	end

	StoryModule.RemoveListener()
	StoryModule.player:Dispose()

	StoryModule.player = nil

	StoryModule.UnloadSceneAndNPCs()

	StoryModule.npcs = nil
	StoryModule.npcVariables = nil
	StoryModule.currentStoryID = nil
	StoryModule.uiStateDic = {}

	if StoryModule.storyData ~= nil then
		StoryModule.storyData = nil
	end

	if BehaviorTreeUtility.DollyCartTimer then
		BehaviorTreeUtility.DollyCartTimer:Stop()

		BehaviorTreeUtility.DollyCartTimer = nil
	end

	if StoryModule.StoryManager then
		GameObject.Destroy(StoryModule.StoryManager.gameObject)

		StoryModule.StoryManager = nil
	end

	if StoryModule.EffectRoot then
		GameObject.Destroy(StoryModule.EffectRoot.gameObject)

		StoryModule.EffectRoot = nil
	end

	if StoryModule.StoryNpcRoot then
		GameObject.Destroy(StoryModule.StoryNpcRoot.gameObject)

		StoryModule.StoryNpcRoot = nil
	end

	if StoryModule.timelineGameObject then
		GameObject.Destroy(StoryModule.timelineGameObject)
	end

	StoryModule.timelineGameObject = nil

	if StoryModule.playTimelineCoroutine then
		StoryModule.playTimelineCoroutine:Stop()
	end

	StoryModule.playTimelineCoroutine = nil

	for i = #this.timeLineList, 1, -1 do
		GameObject.Destroy(this.timeLineList[i])
	end

	this.timeLineList = {}

	StoryModule.StopAllFilterEffect()

	StoryModule.screenCamera = nil
	StoryModule.mainCamera = nil
	StoryModule.uiCamera = nil
	StoryModule.fightCallback = nil
	StoryModule.StoryCurrentBGMID = nil

	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.LoadingNormalUI
	})
	AssetUtil.UnloadAsset(this)

	StoryModule.IsStoring = false
	StoryModule.isReview = false
	StoryModule.SavedCommunicationData = {}

	EventDispatcher.RemoveSingleEventListener(EventID.OnGetPanelUICloseEvent)
	MazeStageModule.ShutDown()
end

function StoryModule.Save(isComplete)
	if StoryModule.isDebugMod then
		return
	end

	StoryModule.plotStageDupPOD.complete = isComplete and 1 or 0
	StoryModule.plotStageDupPOD.storySaveData.position = not isComplete and {
		x = StoryModule.player.transform.position.x,
		y = StoryModule.player.transform.position.y,
		z = StoryModule.player.transform.position.z
	} or nil
	StoryModule.plotStageDupPOD.storySaveData.currentSceneID = not isComplete and StoryModule.currentStoryID or 0

	local npcValue = StoryModule.plotStageDupPOD.storySaveData.npcVariables

	for npcID, variables in pairs(StoryModule.npcVariables) do
		if getTableLength(variables) > 0 then
			if not npcValue[npcID] then
				npcValue[npcID] = {}
			end

			if not npcValue[npcID].varibaleValues then
				npcValue[npcID].varibaleValues = {}
			end

			for variableName, variableValue in pairs(variables) do
				if variableValue.isStoreInServer then
					npcValue[npcID].varibaleValues[variableName] = tostring(variableValue.value)
				end
			end
		end
	end

	local stringArr = {}

	for _, v in pairs(npcValue) do
		for j, v2 in pairs(v.varibaleValues) do
			table.insert(stringArr, string.format("剧情-->【客户端请求】保存变量 %s = %s\n", j, tostring(v2)))
		end
	end

	LuaUtility.LogColor(Constant.LogType.Story, table.concat(stringArr), "#E04A37")

	StoryModule.plotStageDupPOD.storySaveData.clueIds = {}

	if not isComplete then
		for _, clueID in pairs(PuzzleModule.currentStoryCluesList) do
			table.insert(StoryModule.plotStageDupPOD.storySaveData.clueIds, clueID)
		end
	end

	StoryModule.saveLevel(StoryModule.plotStageDupPOD)
end

function StoryModule.SaveEmpty()
	StoryModule.plotStageDupPOD.complete = 0
	StoryModule.plotStageDupPOD.storySaveData.position = nil
	StoryModule.plotStageDupPOD.storySaveData.currentSceneID = 0
	StoryModule.plotStageDupPOD.storySaveData.npcVariables = {}
	StoryModule.plotStageDupPOD.storySaveData.clueIds = {}

	StoryModule.saveLevel(StoryModule.plotStageDupPOD)
end

function StoryModule.SetStoryRestartWhenNext()
	StoryModule.IsRestart = true
end

function StoryModule.GetStoryIsRestart()
	return StoryModule.IsRestart
end

function this.AddOrSetStoryUIState(uiName, state)
	this.uiStateDic[uiName] = state
end

function this.GetUiStateDic()
	return this.uiStateDic
end

function StoryModule.StartFight(storyBattleID, callback)
	local userData = {
		OpenType = 2,
		ChapterType = Constant.ChapterPassType.TYPE_MAINLINE,
		StageId = StoryModule.plotStageDupPOD.stageId,
		StoryBattleId = storyBattleID,
		CloseCallback = function()
			NoticeModule.ShowNotice(20040, function()
				WorldMapModule.ExitStoryOrLevel()
			end)
		end,
		backHomeCallBack = function()
			NoticeModule.ShowNotice(20040, function()
				WorldMapModule.ExitStoryOrLevel()
			end)
		end
	}

	StoryModule.fightOverCallback = callback

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function StoryModule.OnStartFight()
	local enabledComponents = {}

	for _, npc in pairs(StoryModule.npcs) do
		local renders = LuaUtility.GetComponentsInChildren(npc.gameObject, typeof(UnityEngine.Renderer))

		for _, renderer in pairs(renders) do
			if renderer and renderer.enabled then
				table.insert(enabledComponents, renderer)
			end
		end

		local colliders = LuaUtility.GetComponentsInChildren(npc.gameObject, typeof(UnityEngine.Collider))

		for _, collider in pairs(colliders) do
			if collider and collider.enabled then
				table.insert(enabledComponents, collider)
			end
		end
	end

	local renders = LuaUtility.GetComponentsInChildren(StoryModule.player.gameObject, typeof(UnityEngine.Renderer))

	for _, renderer in pairs(renders) do
		if renderer and renderer.enabled then
			table.insert(enabledComponents, renderer)
		end
	end

	local colliders = LuaUtility.GetComponentsInChildren(StoryModule.player.gameObject, typeof(UnityEngine.Collider))

	for _, collider in pairs(colliders) do
		if collider and collider.enabled then
			table.insert(enabledComponents, collider)
		end
	end

	StoryModule.PlayBGM(Constant.BGMSoundID.EMPTY)

	function StoryModule.onEnterFight()
		for _, renderer in pairs(enabledComponents) do
			renderer.enabled = false
		end

		this.AddOrSetStoryUIState(Constant.StoryUI.RegularEffect, LuaUtility.GetLvFilterVolumeEnable())
		StoryModule.StopAllFilterEffect()
		StoryModule.HideAllEffect()
		BehaviorTreeUtility.SetCinemachineManagerInactive()
		StoryModule.characterMoveConfigManager:Hide()
		LuaUtility.SetGameObjectShow(StoryModule.currentSceneByPrefab, false)
		LuaUtility.SetGameObjectShow(StoryModule.virtualCameraManager.gameObject, false)
		BehaviorTreeUtility.ShowStoryUI(false)

		StoryModule.onEnterFight = nil
	end

	function StoryModule.onExitFight()
		for i, renderer in pairs(enabledComponents) do
			renderer.enabled = true
			enabledComponents[i] = nil
		end

		BehaviorTreeUtility.SetCinemachineManagerActive()
		StoryModule.characterMoveConfigManager:Show()
		LuaUtility.SetGameObjectShow(StoryModule.currentSceneByPrefab, true)
		LuaUtility.SetGameObjectShow(StoryModule.virtualCameraManager.gameObject, true)

		local storyData = StoryModule.storyData

		if storyData and CfgSceneListTable[storyData.sceneID].RenderConfig then
			AssetUtil.LoadAsset(StoryModule, BattleApi:GetSceneRenderConfigUrl(storyData.sceneID), function(owner, assetName, asset, duration, userData)
				SceneRenderConfigManager.ApplyConfig(asset)

				StoryModule.roleOutLineColor = asset.spineOutlineColor ~= Color.black and asset.spineOutlineColor or CfgUtil.publicParametersData.RoleOutLineColor
			end)
		end

		if StoryModule.StoryCurrentBGMID then
			StoryModule.bgmSerialID = LuaUtility.PlayBGMWithID(StoryModule.StoryCurrentBGMID)
		end

		StoryModule.ShowAllEffect()

		if this.uiStateDic[Constant.StoryUI.RegularEffect] then
			BehaviorTreeUtility.ShowRegularFilter(0)
		end

		StoryModule.ContinueStory()

		StoryModule.onExitFight = nil
	end
end

function StoryModule.OnFightOver(fightOverPOD)
	if fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
		SceneTransferModule.BattleToStory(fightOverPOD)
	else
		local userData = {}

		userData.fightOverPOD = fightOverPOD

		function userData.closeCallBack()
			WorldMapModule.ExitStoryOrLevel()
		end

		UIModule.Open(Constant.UIControllerName.Settlement_BattleUI, Constant.UILayer.UI, userData)
	end
end

function StoryModule.OnCompleteLevel(fightOverPOD, callBackFunc)
	SceneTransferModule.StoryToMainCity(fightOverPOD, {
		revertUI = true,
		callBackFunc = callBackFunc
	})
end

function StoryModule.QuitLevel()
	StoryModule.CompleteLevel(Constant.FightResult.GIVE_UP)
end

function StoryModule.HideAllCloseOutLine()
	for _, v in pairs(StoryModule.insideRangeNPCs) do
		v:SetOutline(false)
	end
end

function StoryModule.ShowALLCloseOutLine()
	for _, v in pairs(StoryModule.insideRangeNPCs) do
		v:SetOutline(true)
	end
end

function StoryModule.NPCNamesRefresh()
	if not StoryModule.showName then
		return
	end

	local showNameList = {}

	for _, v in pairs(StoryModule.insideRangeNPCs) do
		if v.npcController.npcSetting.isCanShowName then
			table.insert(showNameList, v)
		end
	end

	EventDispatcher.Dispatch(EventID.StoryUIShowNPCNameEvent, showNameList)
end

function StoryModule.CloseToNPC(npcID)
	StoryModule.insideRangeNPCs[npcID] = StoryModule.GetCharacterByNPCID(npcID)
	StoryModule.outsideRangeNPCs[npcID] = nil

	StoryModule.insideRangeNPCs[npcID]:SetOutline(true)
	StoryModule.NPCNamesRefresh()
end

function StoryModule.AwayFromNPC(npcID)
	StoryModule.insideRangeNPCs[npcID] = nil
	StoryModule.outsideRangeNPCs[npcID] = StoryModule.GetCharacterByNPCID(npcID)

	StoryModule.outsideRangeNPCs[npcID]:SetOutline(false)
	StoryModule.NPCNamesRefresh()
end

function StoryModule.OnTapGesture(tapGesture)
	if StoryModule.player == nil then
		return
	end

	if not StoryModule.player.canInteractionWithNPC then
		return
	end

	if tapGesture and tapGesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
		return
	end

	local gameObjectInstanceIDs = LuaCodeInterface.LuaRaycastAllEntity(StoryModule.mainCamera)

	for _, instanceID in pairs(gameObjectInstanceIDs) do
		for _, npc in pairs(StoryModule.insideRangeNPCs) do
			if npc.npcController.npcSetting.interactSetting.canInteract and npc.gameObject:GetInstanceID() == instanceID then
				npc:OnStartInteract()

				return
			end
		end
	end
end

function StoryModule.StartInteract()
	StoryModule.player:ChangeStateByName(StoryInteractState.Name)
end

function StoryModule.EndInteract()
	StoryModule.player:ChangeStateByName(StoryIdleState.Name)
end

function StoryModule.OnInteracted(npcID)
	local character = StoryModule.GetCharacterByNPCID(npcID)

	character:OnStartInteract()
end

function StoryModule.OnBehaviourTreeNPCClueTriggerEvent(args)
	for _, npc in pairs(StoryModule.npcs) do
		npc.npcController:TriggerClueEvent(args)
	end
end

function StoryModule.WaitCreatePlayer(entityConfigID)
	local url = EntityUtility.GetStoryEntityPath(entityConfigID)

	if LuaUtility.StrIsNullOrEmpty(url) then
		return
	end

	return WaitLoadAsset(StoryModule, url)
end

function StoryModule.WaitCreateNPC(npcID, npcName, entityConfigID, position, npcSetting, callback)
	return WaitCreateNPC(npcID, npcName, entityConfigID, position, npcSetting, function(character)
		if StoryModule.npcs[npcID] then
			logError(string.format("已经存在npcID=%d npcName=%s 的npc了，但仍试图加载同npcID的NPC", npcID, npcSetting.npcName))
		else
			StoryModule.npcs[npcID] = character

			if callback then
				callback(character)
			end
		end
	end)
end

function StoryModule.GetCharacterByNPCID(npcID)
	if StoryModule.player ~= nil and npcID == StoryModule.player.npcID then
		return StoryModule.player
	end

	if StoryModule.npcs == nil then
		return nil
	end

	if StoryModule.npcs[npcID] == nil then
		logError("找不到npc，npcID=" .. npcID)

		return nil
	end

	return StoryModule.npcs[npcID]
end

function StoryModule.UnloadSceneAndNPCs()
	if StoryModule.currentSceneByPrefab then
		GameObject.Destroy(StoryModule.currentSceneByPrefab)
	end

	StoryModule.currentSceneByPrefab = nil

	for _, npc in pairs(StoryModule.npcs) do
		npc:Dispose()
	end

	StoryModule.npcs = {}
	StoryModule.insideRangeNPCs = {}
	StoryModule.outsideRangeNPCs = {}

	BehaviorTreeUtility.DestroyStoryCinemachineManager()
	LuaUtility.StopAllEffect()
	StoryModule.ClearAllEffect()
	this.CachePool:ClearPool()
	StoryModule.StopAllFilterEffect()

	if StoryModule.player ~= nil and StoryModule.player.autoMoveController ~= nil then
		StoryModule.player.autoMoveController:StopAutoMove()
	end

	if StoryModule.characterMoveConfigManager then
		StoryModule.characterMoveConfigManager:Dispose()

		StoryModule.characterMoveConfigManager = nil
	end

	if StoryModule.MovePosManager then
		GameObject.Destroy(StoryModule.MovePosManager)

		StoryModule.MovePosManager = nil
	end
end

function StoryModule.LoadPublicParameter()
	StoryModule.roleSparkleAnimationCurve = CfgUtil.publicParametersData.RoleSparkleAnimationCurve
	StoryModule.roleOutLineColor = CfgUtil.publicParametersData.RoleOutLineColor
end

function this.GetPlayerEntityID()
	local playerEntityID

	playerEntityID = PlayerModule.GetSex() == Constant.PlayerSex.Man and 8001 or 8003

	return playerEntityID
end

function this.OnReloadPlayer()
	StoryModule.PauseStory()

	local pos = this.player.transform.position
	local isShow = this.player.gameObject.activeSelf
	local enb = StoryModule.player.playerController.enabled

	this.player:Dispose()

	this.player = nil

	CoroutineUtility.StartCoroutine(function()
		local playerGameObject = CoroutineUtility.Yield(StoryModule.WaitCreatePlayer(this.GetPlayerEntityID())).customWait.result
		local player = StoryPlayer(this.playerNPCID, UserInfoModule.GetPlayerInfo().pName)
		local playerInfo = {}

		playerInfo.gameObject = GameObject.Instantiate(playerGameObject)
		playerInfo.entityConfigID = entityID

		player:InitPlayer(playerInfo)

		StoryModule.player = player

		if StoryModule.player then
			StoryModule.player.playerController.enabled = enb

			LuaUtility.SetGameObjectShow(this.player.gameObject, isShow)

			StoryModule.player.transform.position = pos
		end

		StoryModule.ContinueStory()
	end)
end

function StoryModule.LoadPlayer(entityID, playerName, playerPos, isShow, controllerEnable)
	if this.player then
		this.player:Dispose()

		this.player = nil
	end

	CoroutineUtility.StartCoroutine(function()
		local playerGameObject = CoroutineUtility.Yield(StoryModule.WaitCreatePlayer(entityID)).customWait.result
		local player = StoryPlayer(this.playerNPCID, playerName)
		local playerInfo = {}

		playerInfo.gameObject = GameObject.Instantiate(playerGameObject)
		playerInfo.entityConfigID = entityID

		player:InitPlayer(playerInfo)

		StoryModule.player = player

		if StoryModule.player then
			StoryModule.player.playerController.enabled = controllerEnable

			LuaUtility.SetGameObjectShow(this.player.gameObject, isShow)

			StoryModule.player.transform.position = playerPos
		end

		StoryModule.ContinueStory()
	end)
end

function StoryModule.LoadSceneAndNPCs(storyDataID, npcVariables, isSwitchRoom)
	local storyDataPath = string.format(CfgResourceTable[1300004].Url, CfgStoryDataTable[storyDataID].Path)
	local loadStoryDataCoroutine = CoroutineUtility.Yield(WaitLoadAsset(StoryModule, storyDataPath))
	local storyData = loadStoryDataCoroutine.customWait.result

	StoryModule.storyData = storyData

	EventDispatcher.Dispatch(EventID.BehaviourTreeStoryUIRefreshEvent)

	if not StoryModule.StoryManager then
		local StoryManagerObject = GameObject.New("StoryManager")

		StoryModule.StoryManager = StoryManagerObject:AddComponent(typeof(IQIGame.Onigao.Game.StoryComponent))
		StoryModule.EffectRoot = GameObject.New("Effect").transform

		StoryModule.EffectRoot:SetParent(StoryModule.StoryManager.transform)
	end

	local StoryVirtualCameraManagerObj = GameObject.Instantiate(storyData.StoryVirtualCameraManagerPrefab)

	BehaviorTreeUtility.InitStoryCinemachineManager(StoryVirtualCameraManagerObj)
	BehaviorTreeUtility.SetCurrentVirtualCameraFollow(StoryModule.player.transform)

	if not LuaUtility.GameObjectIsNullOrEmpty(storyData.MovePositionManagerPrefab) then
		StoryModule.MovePosManager = GameObject.Instantiate(storyData.MovePositionManagerPrefab, StoryModule.StoryManager.transform)
		StoryModule.MovePosManager.name = storyData.MovePositionManagerPrefab.name
	end

	local cfgSceneList = CfgUtil.GetCfgSceneListDataWithID(storyData.sceneID)

	StoryModule.currentSceneByPrefab = CoroutineUtility.Yield(WaitLoadSceneByPrefab(StoryModule, storyData.sceneID)).customWait.result

	StoryModule.currentSceneByPrefab.transform:SetParent(StoryModule.StoryManager.transform)

	StoryModule.currentStoryID = storyDataID

	if not StoryModule.isDebugMod and isSwitchRoom and cfgSceneList.WorldMapRoomID and cfgSceneList.WorldMapRoomID ~= 0 and cfgSceneList.WorldMapRoomID ~= WorldMapModule.GetCurrentHomeData().cid then
		net_sceneMap.enterRoom(cfgSceneList.WorldMapRoomID, false)
	end

	if cfgSceneList.RenderConfig then
		CoroutineUtility.Yield(WaitLoadAsset(StoryModule, BattleApi:GetSceneRenderConfigUrl(storyData.sceneID), function(assetName, asset, duration, userData)
			SceneRenderConfigManager.ApplyConfig(asset)

			StoryModule.roleOutLineColor = asset.spineOutlineColor ~= Color.black and asset.spineOutlineColor or CfgUtil.publicParametersData.RoleOutLineColor
		end))
	end

	StoryModule.isInitializedMoveConfig = false

	if storyData.CharacterMoveConfigPrefab then
		local moveConfigObj = GameObject.Instantiate(storyData.CharacterMoveConfigPrefab, StoryModule.StoryManager.transform)

		StoryModule.isInitializedMoveConfig = true

		CoroutineUtility.Yield(WaitWhile(function()
			return AstarPath.active == nil or AstarPath.active.isScanning
		end))
		CoroutineUtility.Yield()

		StoryModule.characterMoveConfigManager = StoryCharacterMoveConfigManager.New(moveConfigObj)
	end

	if not StoryModule.StoryNpcRoot then
		StoryModule.StoryNpcRoot = GameObject.New("StoryNpc")
	end

	StoryModule.StoryNpcRoot.transform:SetParent(StoryModule.StoryManager.transform)

	local customWaits = {}

	for i = 0, storyData.npcSettings.Count - 1 do
		local npcSetting = storyData.npcSettings[i]

		if npcSetting.isActiveOnAwake then
			local loadNPCCoroutine = StoryModule.WaitCreateNPC(npcSetting.npcID, CfgUtil.GetCfgStoryTextDataWithID(npcSetting.npcNameID), npcSetting.prefabEntityID, Vector3.New(npcSetting.positionX, npcSetting.positionY, npcSetting.positionZ), npcSetting)

			if loadNPCCoroutine then
				table.insert(customWaits, loadNPCCoroutine)
				CoroutineUtility.Yield(loadNPCCoroutine)
			end
		end
	end

	CoroutineUtility.Yield(WaitAll(customWaits))

	for npcID, npc in pairs(StoryModule.npcs) do
		if npc.npcController then
			local len = npc.npcController.npcSetting.variableSettings.Count - 1

			for i = 0, len do
				local variableSetting = npc.npcController.npcSetting.variableSettings[i]

				if not StoryModule.HasNPCVariable(npcID, variableSetting.name) or variableSetting.isCoverIfExist then
					if variableSetting.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.String then
						StoryModule.SetNPCVariable(npcID, variableSetting.name, IQIGame.Onigao.Game.VariableSetting.VariableType.String, variableSetting.stringValue, variableSetting.isStoreInServer)
					end

					if variableSetting.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Int then
						StoryModule.SetNPCVariable(npcID, variableSetting.name, IQIGame.Onigao.Game.VariableSetting.VariableType.Int, variableSetting.intValue, variableSetting.isStoreInServer)
					end

					if variableSetting.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Float then
						StoryModule.SetNPCVariable(npcID, variableSetting.name, IQIGame.Onigao.Game.VariableSetting.VariableType.Float, variableSetting.floatValue, variableSetting.isStoreInServer)
					end

					if variableSetting.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Bool then
						StoryModule.SetNPCVariable(npcID, variableSetting.name, IQIGame.Onigao.Game.VariableSetting.VariableType.Bool, variableSetting.boolValue, variableSetting.isStoreInServer)
					end
				end
			end
		end
	end

	if npcVariables then
		for i, v in pairs(npcVariables) do
			StoryModule.SetNpcVariableByPOD(i, v)
		end
	end

	if StoryModule.plotStageDupPOD then
		PuzzleModule.currentStoryCluesList = StoryModule.plotStageDupPOD.storySaveData.clueIds
	end

	StoryModule.AmountOfClues = storyData.AmountOfClues

	EventDispatcher.Dispatch(EventID.BehaviourTreeStoryUIRefreshEvent)

	local bgmCid = storyData.BgmId

	if bgmCid == nil or bgmCid == 0 then
		bgmCid = Constant.BGMSoundID.EMPTY
	end

	StoryModule.PlayBGM(bgmCid)
end

function StoryModule.SetNpcVariableByPOD(npcID, npcVariablePOD)
	local strArr = {}

	if StoryModule.npcs[npcID] then
		local npcVariableSetting = StoryModule.npcs[npcID].npcController.npcSetting.variableSettings
		local len = npcVariableSetting.Count - 1

		for i, v in pairs(npcVariablePOD.varibaleValues) do
			for j = 0, len do
				local npcVariableSet = npcVariableSetting[j]

				if npcVariableSet.name == i and npcVariableSet.isStoreInServer == true then
					if npcVariableSet.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.String then
						StoryModule.SetNPCVariable(npcID, i, npcVariableSet.variableType, v, true)
						table.insert(strArr, string.format("剧情-->恢复保存的变量 %s = %s\n", i, v))
					end

					if npcVariableSet.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Int or npcVariableSet.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Float then
						StoryModule.SetNPCVariable(npcID, i, npcVariableSet.variableType, tonumber(v), true)
						table.insert(strArr, string.format("剧情-->恢复保存的变量 %s = %s\n", i, tonumber(v)))
					end

					if npcVariableSet.variableType == IQIGame.Onigao.Game.VariableSetting.VariableType.Bool then
						StoryModule.SetNPCVariable(npcID, i, npcVariableSet.variableType, v == 1, true)

						if v then
							table.insert(strArr, string.format("剧情-->恢复保存的变量 %s = true\n", i))
						else
							table.insert(strArr, string.format("剧情-->恢复保存的变量 %s = false\n", i))
						end
					end
				end
			end
		end
	end

	if #strArr > 0 then
		LuaUtility.LogColor(Constant.LogType.Story, table.concat(strArr), "#83FF21")
	end
end

function StoryModule.PlayBGM(soundID)
	LuaUtility.ReplaceBGM(StoryModule.bgmSerialID, soundID)

	return StoryModule.bgmSerialID
end

function StoryModule.__RemoveBGM()
	if StoryModule.bgmSerialID ~= 0 then
		LuaUtility.RemoveBGM(StoryModule.bgmSerialID)
	end

	StoryModule.bgmSerialID = 0
end

function StoryModule.LoadSceneByPrefab(sceneID, callback)
	CoroutineUtility.StartCoroutine(function()
		local sceneObj = CoroutineUtility.Yield(WaitLoadSceneByPrefab(sceneID)).customWait.result

		if callback then
			callback(sceneObj)
		end
	end)
end

function StoryModule.AllNPCsTriggerStart()
	for _, npc in pairs(StoryModule.npcs) do
		npc.npcController:TriggerStart()
	end
end

function this.StopNpcSpine(isAll, idArray)
	if isAll then
		for _, npc in pairs(StoryModule.npcs) do
			npc:StopSpine()
		end

		StoryModule.player:StopSpine()

		return
	end

	local len = #idArray

	for i = 1, len do
		if idArray[i] == 0 then
			StoryModule.player:StopSpine()
		else
			StoryModule.npcs[idArray[i]]:StopSpine()
		end
	end
end

function this.RecoveryNpcSpine(isAll, idArray)
	if isAll then
		for _, npc in pairs(StoryModule.npcs) do
			npc:RecoverySpine()
		end

		StoryModule.player:RecoverySpine()

		return
	end

	local len = #idArray

	for i = 1, len do
		if idArray[i] == 0 then
			StoryModule.player:RecoverySpine()
		else
			StoryModule.npcs[idArray[i]]:RecoverySpine()
		end
	end
end

function this.ChangeNpcSpineTimeScale(isAll, idArray, timeScale)
	if isAll then
		for _, npc in pairs(StoryModule.npcs) do
			npc:ChangeSpineTimeScale(timeScale)
		end

		return
	end

	local len = #idArray

	for i = 1, len do
		if idArray[i] == 0 then
			StoryModule.player:ChangeSpineTimeScale(timeScale)
		else
			StoryModule.npcs[idArray[i]]:ChangeSpineTimeScale(timeScale)
		end
	end
end

function StoryModule.HasNPCVariable(npcID, variableName)
	return StoryModule.GetNPCVariable(npcID, variableName) ~= nil
end

function StoryModule.GetNPCVariable(npcID, variableName)
	if StoryModule.npcVariables[npcID] == nil or StoryModule.npcVariables[npcID][variableName] == nil then
		return nil
	else
		return StoryModule.npcVariables[npcID][variableName].value
	end
end

function StoryModule.SetNPCVariable(npcID, variableName, variableType, variableValue, isStoreInServer)
	if StoryModule.npcVariables[npcID] == nil then
		StoryModule.npcVariables[npcID] = {}
	end

	local variable = StoryModule.npcVariables[npcID][variableName]

	StoryModule.npcVariables[npcID][variableName] = {
		value = variableValue,
		isStoreInServer = variable ~= nil and variable.isStoreInServer or isStoreInServer
	}

	StoryModule.StoryManager:SetVariable(npcID, variableName, variableType, variableValue)
end

function StoryModule.SetNpcVariableWithoutServer(npcID, variableType, variableName, variableValue)
	if not StoryModule.npcVariables[npcID] then
		StoryModule.npcVariables[npcID] = {}
	end

	if not StoryModule.npcVariables[npcID][variableName] then
		StoryModule.npcVariables[npcID][variableName] = {}
	end

	local variable = StoryModule.npcVariables[npcID][variableName]

	variable.value = variableValue

	StoryModule.StoryManager:SetVariable(npcID, variableName, variableType, variableValue)
end

function StoryModule.GetPODVariable(npcID, name)
	local npcV = StoryModule.plotStageDupPOD.storySaveData.npcVariables

	if not npcV[npcID] or not npcV[npcID].varibaleValues[name] then
		return ""
	end

	return npcV[npcID].varibaleValues[name]
end

function StoryModule.SetPODVariable(npcID, name, type, value)
	local npcV = StoryModule.plotStageDupPOD.storySaveData.npcVariables

	if not npcV[npcID] then
		npcV[npcID] = {}
	end

	if not npcV[npcID].varibaleValues then
		npcV[npcID].varibaleValues = {}
	end

	npcV[npcID].varibaleValues[name] = value

	StoryModule.StoryManager:SetVariable(npcID, name, type, value)
end

function StoryModule.GetExtensionParam(name)
	if not StoryModule.plotStageDupPOD.storySaveData.extension[name] then
		return {
			value = -1
		}
	end

	return StoryModule.plotStageDupPOD.storySaveData.extension[name]
end

function StoryModule.SetCinemachineFollower(follower, offset)
	if not StoryModule.currentVirtualCamera then
		local obj = GameObject.New("VirtualCamera")

		StoryModule.currentVirtualCamera = obj:AddComponent(typeof(Cinemachine.CinemachineVirtualCamera))

		local cinemachineTransposer = StoryModule.currentVirtualCamera:AddCinemachineComponent(typeof(Cinemachine.CinemachineTransposer))

		cinemachineTransposer.m_FollowOffset = offset
	end

	StoryModule.currentVirtualCamera.Follow = follower
end

function StoryModule.PlayTimeline(playableDirectorPrefab, nameToTracks, onPlayTimelineCompleted)
	StoryModule.timelineGameObject = GameObject.Instantiate(playableDirectorPrefab)

	local playableDirector = StoryModule.timelineGameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableDirector.playableAsset)

	for i = 0, outputs.Length - 1 do
		local playableBinding = outputs[i]
		local streamName = TimelineUtility.GetPlayableBindingStreamName(playableBinding)

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Cinemachine.CinemachineBrain)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), StoryModule.cinemachineBrain)
		end

		if streamName and nameToTracks[streamName] then
			local npc = StoryModule.GetCharacterByNPCID(nameToTracks[streamName].npcID)

			if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Spine.Unity.SkeletonAnimation)) then
				playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), npc.skeletonAnimation)
			end

			if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(UnityEngine.Animator)) then
				playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), npc.gameObject:GetComponent(typeof(UnityEngine.Animator)))
			end
		end
	end

	local effectTransform = StoryModule.timelineGameObject.transform:FindChildByName("Screen")

	if effectTransform then
		effectTransform.gameObject.layer = UnityEngine.LayerMask.NameToLayer("Screen")

		local follower = LuaUtility.GetComponent(effectTransform.gameObject, typeof(TransformFollower))

		follower = follower or LuaUtility.AddComponent(effectTransform.gameObject, typeof(TransformFollower))

		follower:Init(follower.transform, StoryModule.screenCamera.transform, effectTransform.localPosition, false)
	end

	playableDirector:Play()
	StoryModule.player:ChangeStateByName(StoryTimeLineState.Name)

	StoryModule.playTimelineCoroutine = CoroutineUtility.CreateCoroutine(function()
		while playableDirector.state == UnityEngine.Playables.PlayState.Playing do
			CoroutineUtility.Yield()
		end

		onPlayTimelineCompleted()

		if StoryModule.player then
			StoryModule.player:ChangeStateByName(StoryIdleState.Name)
		end

		if StoryModule.timelineGameObject then
			GameObject.Destroy(StoryModule.timelineGameObject)
		end

		StoryModule.timelineGameObject = nil
	end)

	StoryModule.playTimelineCoroutine:Start()
end

function this.AddInTimeLineList(o)
	table.insert(this.timeLineList, o)

	return #this.timeLineList
end

function this.RemoveInTimeLineList(id)
	if not this.timeLineList[id] then
		return
	end

	GameObject.Destroy(this.timeLineList[id])
	table.remove(this.timeLineList, id)
end

function this.GetTimeLineListIndex()
	return #this.timeLineList + 1
end

function StoryModule.SetTriggerOption(optionID, clueID)
	if not StoryModule.hasTriggerOption then
		StoryModule.hasTriggerOption = {}
	end

	if StoryModule.hasTriggerOption[optionID] then
		StoryModule.hasTriggerOption[optionID][clueID] = clueID
	else
		StoryModule.hasTriggerOption[optionID] = {}
		StoryModule.hasTriggerOption[optionID][clueID] = clueID
	end
end

function StoryModule.CheckOptionHadTrigger(optionID, clueID)
	if not StoryModule.hasTriggerOption then
		return false
	end

	if not StoryModule.hasTriggerOption[optionID] then
		return false
	end

	if not StoryModule.hasTriggerOption[optionID][clueID] then
		return false
	end

	return true
end

function StoryModule.ClearClueTriggerData()
	if not StoryModule.hasTriggerOption then
		return
	end

	for i, _ in pairs(StoryModule.hasTriggerOption) do
		local cfg = CfgUtil.GetCfgStoryOptionDataWithID(i)

		if cfg.OptionType == Constant.StoryOptionType.ClueTrigger then
			StoryModule.hasTriggerOption[i] = nil
		end
	end
end

function StoryModule.ClearDialogueOptionData()
	if not StoryModule.hasTriggerOption then
		return
	end

	for i, _ in pairs(StoryModule.hasTriggerOption) do
		local cfg = CfgUtil.GetCfgStoryOptionDataWithID(i)

		if cfg.OptionType == Constant.StoryOptionType.Dialogue then
			StoryModule.hasTriggerOption[i] = nil
		end
	end
end

function StoryModule.SetOptionDisplay(isShow, optionCfgID, options)
	if not StoryModule.optionHideTable then
		StoryModule.optionHideTable = {}
	end

	if isShow then
		if not StoryModule.optionHideTable[optionCfgID] then
			logError(string.format("【剧情】试图设置显示选项表,但是该选项之前没有被行为树节点所隐藏 id = %s", optionCfgID))

			return
		end

		for i = 1, #options do
			StoryModule.optionHideTable[optionCfgID][options[i]] = nil
		end
	else
		if not StoryModule.optionHideTable[optionCfgID] then
			StoryModule.optionHideTable[optionCfgID] = {}
		end

		for i = 1, #options do
			StoryModule.optionHideTable[optionCfgID][options[i]] = options[i]
		end
	end
end

function StoryModule.CheckOptionIsShow(optionCfgID, option)
	if not StoryModule.optionHideTable then
		return true
	end

	if not StoryModule.optionHideTable[optionCfgID] then
		return true
	end

	if not StoryModule.optionHideTable[optionCfgID][option] then
		return true
	end

	return false
end

function StoryModule.GetDialogueReviewData()
	return StoryModule.dialogueReviewData
end

function StoryModule.AddDialogueReviewData(type, ID, selectID)
	local tb = {}

	if type == Constant.DialogueReviewType.Option then
		for i = 1, #StoryModule.dialogueReviewData do
			if StoryModule.dialogueReviewData[i].type == type and StoryModule.dialogueReviewData[i].ID == ID and StoryModule.dialogueReviewData[i].selectID == selectID then
				return
			end
		end
	elseif type == Constant.DialogueReviewType.Chat then
		for i = #StoryModule.dialogueReviewData, 1, -1 do
			if StoryModule.dialogueReviewData[i].type == type and StoryModule.dialogueReviewData[i].ID == ID then
				table.remove(StoryModule.dialogueReviewData, i)
			end
		end

		local speakNpcCfg = CfgUtil.GetCfgStorySpeakNpcDataWithID(ID)

		if speakNpcCfg.NPCName ~= "%s" then
			tb.NpcName = speakNpcCfg.NPCName
		elseif speakNpcCfg.SpeakNPC >= 0 then
			tb.NpcName = StoryModule.GetCharacterByNPCID(speakNpcCfg.SpeakNPC):GetName()
		else
			tb.NpcName = StoryModule.player:GetName()
		end
	end

	if #StoryModule.dialogueReviewData > CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.DialogueReviewMaxCount) then
		table.remove(StoryModule.dialogueReviewData, 1)
	end

	tb.type = type
	tb.ID = ID
	tb.selectID = selectID

	table.insert(StoryModule.dialogueReviewData, tb)
end

function StoryModule.GetSavedCommunicationData()
	local t = {}
	local index = 1

	for _, v in pairs(this.SavedCommunicationData) do
		t[index] = v
		index = index + 1
	end

	table.sort(t, function(a, b)
		return a.index < b.index
	end)

	return t
end

function StoryModule.GetNeedShowCommunicationData()
	return StoryModule.needShowCommunicationData
end

function StoryModule.ConvertToChatScrollData(chatData)
	local d = {}

	for i = 1, #chatData do
		if chatData[i].type == Constant.StoryCommunicationType.Chat then
			local cfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(chatData[i].id)

			StoryModule.RecursionCfgDialogue(cfgDialogue, d)
		elseif chatData[i].type == Constant.StoryCommunicationType.Option or chatData[i].type == Constant.StoryCommunicationType.Line then
			table.insert(d, chatData[i])
		end
	end

	if #chatData == 0 then
		if chatData.type == Constant.StoryCommunicationType.Chat then
			local cfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(chatData.id)

			if not cfgDialogue then
				NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxSingleButton, string.format("没有找到 ID = %s 的配置", chatData.id))
			end

			StoryModule.RecursionCfgDialogue(cfgDialogue, d)
		elseif chatData.type == Constant.StoryCommunicationType.Option then
			table.insert(d, chatData)
		end
	end

	return d
end

function StoryModule.RecursionCfgDialogue(cfgDialogue, data)
	local d = {}

	d.type = Constant.StoryCommunicationType.Chat
	d.id = cfgDialogue.Id

	table.insert(data, d)

	if not cfgDialogue.NextID or cfgDialogue.NextID == 0 then
		return
	end

	StoryModule.RecursionCfgDialogue(CfgUtil.GetCfgStoryDialogueDataWithID(cfgDialogue.NextID), data)
end

function StoryModule.AddShowCommunicationData(GroupID, type, id)
	StoryModule.needShowCommunicationData.GroupID = GroupID
	StoryModule.needShowCommunicationData.type = type
	StoryModule.needShowCommunicationData.id = id
end

function StoryModule.CreateCommunicationChatGroup(nameID, iconPath)
	local data = {}

	data.index = StoryModule.communicationDataIndex
	data.nameID = nameID
	data.iconPath = CfgUtil.GetStoryResourceWithID(iconPath)
	data.chatData = {}
	StoryModule.SavedCommunicationData[data.index] = data
	StoryModule.communicationDataIndex = StoryModule.communicationDataIndex + 1

	return data.index
end

function StoryModule.RemoveCommunicationChatGroup(groupID)
	this.SavedCommunicationData[groupID] = nil
end

function StoryModule.AddCommunicationChatData(GroupID, type, id)
	local group = StoryModule.SavedCommunicationData[GroupID]

	if not group then
		logError(string.format("【剧情】试图添加手机通讯对话，但是没有找到该对话组 GroupID = %s", GroupID))

		return
	end

	local data = {}

	data.type = type
	data.id = id

	table.insert(group.chatData, data)
end

function StoryModule.AddCommunicationOptionData(GroupID, id, selectID)
	local group = StoryModule.SavedCommunicationData[GroupID]

	if not group then
		logError(string.format("【剧情】试图添加手机通讯对话，但是没有找到该对话组 GroupID = %s", GroupID))

		return
	end

	local data = {}

	data.type = Constant.StoryCommunicationType.Option
	data.id = id
	data.selectID = selectID

	table.insert(group.chatData, data)
end

function StoryModule.AddCommunicationHistoryLine(GroupID)
	local group = StoryModule.SavedCommunicationData[GroupID]

	if not group then
		logError(string.format("【剧情】试图添加手机通讯对话，但是没有找到该对话组 GroupID = %s", GroupID))

		return
	end

	local data = {}

	data.type = Constant.StoryCommunicationType.Line

	table.insert(group.chatData, data)
end

function StoryModule.StopAllFilterEffect()
	BehaviorTreeUtility.HideThinkingFilter(0)
	BehaviorTreeUtility.HideMemoryFilter(0)
	BehaviorTreeUtility.HideRegularFilter(0)
	BehaviorTreeUtility.StopTimeStopFilter(0, 0)
	LuaUtility.SetRainEffectFilterVolumeControl(false)
end

function StoryModule.AddEffect(effect, npcId, effectId)
	if not StoryModule.StoryEffectList then
		StoryModule.StoryEffectList = {}
	end

	if not StoryModule.StoryEffectIndex then
		StoryModule.StoryEffectIndex = 1
	end

	if not StoryModule.storyEffectIdList then
		StoryModule.storyEffectIdList = {}
	end

	if not StoryModule.storyEffectIdList[effectId] then
		StoryModule.storyEffectIdList[effectId] = {}
	end

	local index = StoryModule.StoryEffectIndex

	StoryModule.StoryEffectList[index] = effect

	local effectData = {}

	effectData.effectId = effectId
	effectData.npcId = npcId
	effectData.effect = effect
	effectData.serialId = index

	table.insert(StoryModule.storyEffectIdList[effectId], effectData)

	StoryModule.StoryEffectIndex = StoryModule.StoryEffectIndex + 1

	return index
end

function StoryModule.StopEffect(effectIndex)
	if not StoryModule.StoryEffectList[effectIndex] then
		return
	end

	GameObject.Destroy(StoryModule.StoryEffectList[effectIndex])

	StoryModule.StoryEffectList[effectIndex] = nil

	table.removeElement(StoryModule.StoryEffectList, StoryModule.StoryEffectList[effectIndex])

	for effectId, effectList in pairs(StoryModule.storyEffectIdList) do
		for i, v in pairs(effectList) do
			if v.serialId == effectIndex then
				StoryModule.storyEffectIdList[effectId][i] = nil

				break
			end
		end
	end
end

function StoryModule.ClearAllEffect()
	if not StoryModule.StoryEffectList then
		return
	end

	for i, v in pairs(StoryModule.StoryEffectList) do
		GameObject.Destroy(v)

		StoryModule.StoryEffectList[i] = nil
	end

	StoryModule.StoryEffectList = {}
	StoryModule.storyEffectIdList = {}
end

function StoryModule.HideAllEffect()
	if not StoryModule.StoryEffectList then
		return
	end

	for _, v in pairs(StoryModule.StoryEffectList) do
		LuaUtility.SetGameObjectShow(v, false)
	end
end

function StoryModule.ShowAllEffect()
	if not StoryModule.StoryEffectList then
		return
	end

	for _, v in pairs(StoryModule.StoryEffectList) do
		LuaUtility.SetGameObjectShow(v, true)
	end
end

function StoryModule.GetEffectArrayByEffectId(effectId)
	if not StoryModule.storyEffectIdList[effectId] then
		return {}
	end

	return StoryModule.storyEffectIdList[effectId]
end

function StoryModule.GetTempWarehouseItemArrayWithItemType(itemType, itemSubTypes)
	local array = {}
	local wareHouse = StoryModule.plotStageDupPOD.storySaveData.tempWarehouse

	for _, v in pairs(wareHouse) do
		local cfg = CfgUtil.GetItemCfgDataWithID(v.cid)

		if cfg and cfg.ItemTypes == itemType and cfg.ItemSubTypes == itemSubTypes then
			table.insert(array, v)
		end
	end

	return array
end

function StoryModule.ItemPODShow(itemShowPod)
	local len = #itemShowPod

	if len > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPod, Constant.GetPanelType.Story)
		StoryModule.PauseStory()
		EventDispatcher.AddSingleEventListener(EventID.OnGetPanelUICloseEvent, function()
			StoryModule.ContinueStory()
		end)
	end
end

function StoryModule.AddEventData(eventIDArray)
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryEventData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	local len = getTableLength(data)

	for i = 1, #eventIDArray do
		data[tostring(len + 1)] = eventIDArray[i]
		len = len + 1
	end

	local js = json.encode(data)

	this.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryEventData, Constant.StoryVariableType.String, js)
end

function StoryModule.ChangeEventData(oldID, newID)
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryEventData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	for _, v in pairs(data) do
		if v == oldID then
			v = newID

			break
		end
	end

	local js = json.encode(data)

	this.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryEventData, Constant.StoryVariableType.String, js)
end

function StoryModule.GetStoryEventData()
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryEventData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	local tb = {}

	for i, v in pairs(data) do
		tb[tonumber(i)] = v
	end

	return tb
end

function this.AddExtensionMazeEvent(type, eventId)
	if not this.plotStageDupPOD then
		return
	end

	if not this.plotStageDupPOD.storySaveData then
		return
	end

	local extension = this.plotStageDupPOD.storySaveData.extension[Constant.extension_maze_event]

	extension = extension or {
		eventIds = {}
	}

	local data = {}

	data.id = #extension.eventIds + 1
	data.type = type
	data.eventId = eventId

	table.insert(extension.eventIds, data)

	local map = {}

	map[Constant.extension_maze_event] = extension
	this.plotStageDupPOD.storySaveData.extension[Constant.extension_maze_event] = extension

	this.SetExtensionParam(true, map)
end

function this.SendTreeEvent(npcID, treeName, eventName)
	if not this.npcs then
		return
	end

	local npc = this.npcs[npcID]

	if not npc then
		return
	end

	npc:SendTreeEvent(treeName, eventName)
end

function this.SkipGM()
	if this.isSkipState == true then
		return
	end

	if this.storyState == Constant.StoryState.Normal then
		return
	end

	Time.timeScale = 20
	this.isSkipState = true

	ConversationModule.SkipCurrentConversation()
	BehaviorTreeUtility.PlayBlackAlphaScreenEffect(1, 0)
end

function this.StartSkip()
	if not this.isCanBeSkip then
		NoticeModule.ShowNotice(11029)

		return
	end

	if this.isSkipState == true then
		return
	end

	if this.storyState == Constant.StoryState.Normal then
		return
	end

	if UIModule.HasUI(Constant.UIControllerName.ImagePuzzleUI) and UIModule.IsUIFormVisible(Constant.UIControllerName.ImagePuzzleUI) then
		NoticeModule.ShowNotice(11029)

		return
	end

	Time.timeScale = 20
	this.isSkipState = true

	coroutine.start(function()
		ConversationModule.SkipCurrentConversation()

		if StoryModule.timelineGameObject then
			local playableDirector = StoryModule.timelineGameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

			coroutine.start(function()
				coroutine.wait(0.1)

				if StoryModule.timelineGameObject then
					local screen = StoryModule.timelineGameObject.transform:FindChildByName("Screen")

					if screen and not LuaUtility.GameObjectIsNullOrEmpty(screen.gameObject) then
						GameObject.Destroy(screen.gameObject)
					end

					if playableDirector then
						playableDirector.time = playableDirector.duration - 0.01
					end
				end

				coroutine.wait(0.01)

				if StoryModule.timelineGameObject then
					GameObject.Destroy(StoryModule.timelineGameObject)

					StoryModule.timelineGameObject = nil
				end

				if StoryModule.playingTimelineTask then
					StoryModule.playingTimelineTask:Complete()

					StoryModule.playingTimelineTask = nil
				end
			end)
		end

		coroutine.Until(function()
			if this.isSkipState and Time.timeScale ~= 20 then
				Time.timeScale = 20
			end

			return not this.isSkipState
		end)
	end)
	BehaviorTreeUtility.PlayBlackAlphaScreenEffect(1, 0)
end

function this.StopSkip()
	Time.timeScale = 1
	this.isSkipState = false

	BehaviorTreeUtility.PlayBlackAlphaScreenEffect(2, 0)
end

function StoryModule.saveLevel(plotStageDupPOD)
	net_plotStage.saveLevel(plotStageDupPOD)
end

function StoryModule.CompleteLevel(result)
	if StoryModule.isDebugMod then
		return
	end

	net_plotStage.completeLevel(result)
end

function StoryModule.TriggerAction(actionID)
	net_plotStage.triggerAction(actionID)
end

function StoryModule.SetExtensionParam(add, extension)
	net_plotStage.setExtension(add, extension)
end

function StoryModule.RemoveExtension(keys)
	net_plotStage.removeExtension(keys)
end

function StoryModule.notifyStartPlot(plotStageDupPODs)
	StoryModule.StartStageLevel(plotStageDupPODs)
end

function StoryModule.saveLevelResult(code, plotStageDupPOD)
	StoryModule.plotStageDupPOD = plotStageDupPOD

	local strArr = {}

	for _, v in pairs(plotStageDupPOD.storySaveData.npcVariables) do
		for i, v2 in pairs(v.varibaleValues) do
			table.insert(strArr, string.format("剧情-->【服务器结果】保存变量 %s = %s\n", i, tostring(v2)))
		end
	end

	LuaUtility.LogColor(Constant.LogType.Story, table.concat(strArr), "00FF00")
	EventDispatcher.DispatchSingleEvent(EventID.StorySaveTaskCompleteEvent)
end

function StoryModule.completeLevelResult(code)
	EventDispatcher.AddEventListener(EventID.CompleteStoryLevel, StoryModule.OnCompleteLevel)
end

function StoryModule.NotifyTempWarehouse(items, notify)
	if not StoryModule.plotStageDupPOD then
		return
	end

	local mWareHouse = StoryModule.plotStageDupPOD.storySaveData.tempWarehouse

	for i, v in pairs(items) do
		mWareHouse[i] = v
	end

	for _, v in pairs(items) do
		log(string.format("【剧情】剧情仓库更新 %s = %s,tag = %s", v.cid, v.num, v.tag))
	end
end

function StoryModule.triggerActionResult(code, items)
	if code == 0 then
		GameEntry.LuaEvent:Fire(nil, StoryTriggerActionEventArgs():Fill(true))
		log("【剧情】行为触发 成功")
	else
		GameEntry.LuaEvent:Fire(nil, StoryTriggerActionEventArgs():Fill(false))
		log("【剧情】行为触发 失败")
	end

	this.ItemPODShow(items)
end

function StoryModule.setExtensionResult(code, add, extension)
	local mExtension = StoryModule.plotStageDupPOD.storySaveData.extension

	for i, v in pairs(extension) do
		mExtension[i] = v
	end

	GameEntry.LuaEvent:Fire(nil, SetExtensionResultEventArgs():Fill())

	for i, v in pairs(extension) do
		log(string.format("【剧情】剧情参数更新 %s = %s", i, v.value))
	end
end

function StoryModule.removeExtensionResult(code, keys)
	for i = 1, #keys do
		StoryModule.plotStageDupPOD.storySaveData.extension[keys[i]] = nil
	end

	GameEntry.LuaEvent:Fire(nil, RemoveExtensionEventArgs():Fill())

	for i, v in pairs(keys) do
		log(string.format("【剧情】剧情参数删除 %s = %s", i, v))
	end
end
