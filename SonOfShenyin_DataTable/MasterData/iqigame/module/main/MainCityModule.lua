-- chunkname: @IQIGame\\Module\\Main\\MainCityModule.lua

local mainCityCharacter = require("IQIGame.Module.Main.MainCityCharacter")
local mainCityWorldSpaceView = require("IQIGame.UI.Main.MainCityWorldSpaceUI")

MainCityModule = {
	isLoadingSpecialEntity = false,
	bgmSerialID = 0,
	randomCharacterList = {},
	exitSceneDestoryObjList = {}
}

local InteractiveStrs = {
	Default = "Default_",
	Special = "Special_"
}

function MainCityModule.Init()
	MainCityModule.randomCharacterList = {}
	MainCityModule.isLoadingSpecialEntity = false

	MainCityModule.AddListeners()

	if GameObject.Find("UIDText_New") ~= nil then
		UGUIUtil.SetText(GameObject.Find("UIDText_New").gameObject, "UID：" .. PlayerModule.PlayerInfo.baseInfo.guid)
	end
end

function MainCityModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.JoystickMove, MainCityModule.SetJoystickMoveDirection)
	EventDispatcher.AddEventListener(EventID.JoystickMoveStart, MainCityModule.JoystickMoveStart)
	EventDispatcher.AddEventListener(EventID.JoystickMoveEnd, MainCityModule.JoystickMoveEnd)
	EventDispatcher.AddEventListener(EventID.OnTapGesture, MainCityModule.OnTapGesture)
	EventDispatcher.AddEventListener(EventID.NotifyPlayerDataChange, MainCityModule.OnPlayerDataChange)
	EventDispatcher.AddEventListener(EventID.GetSpecialEventAwardsEvent, MainCityModule.RemoveSpecialEnetityByEventId)
end

function MainCityModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, MainCityModule.SetJoystickMoveDirection)
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveStart, MainCityModule.JoystickMoveStart)
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveEnd, MainCityModule.JoystickMoveEnd)
	EventDispatcher.RemoveEventListener(EventID.OnTapGesture, MainCityModule.OnTapGesture)
	EventDispatcher.RemoveEventListener(EventID.NotifyPlayerDataChange, MainCityModule.OnPlayerDataChange)
	EventDispatcher.RemoveEventListener(EventID.GetSpecialEventAwardsEvent, MainCityModule.RemoveSpecialEnetityByEventId)
end

function MainCityModule.LoadScene()
	MainCityModule.Init()

	local sceneID = 5
	local sceneObj = CoroutineUtility.Yield(WaitLoadSceneByPrefab(MainCityModule, sceneID)).customWait.result

	MainCityModule.RecordLoadPrefab(sceneObj)
	CoroutineUtility.Yield(WaitLoadAsset(MainCityModule, BattleApi:GetSceneRenderConfigUrl(sceneID), function(assetName, asset, duration, userData)
		SceneRenderConfigManager.ApplyConfig(asset)
	end))

	local sceneListConfig = CfgSceneListTable[sceneID]
	local bgmCid = sceneListConfig == nil and 100 or sceneListConfig.BGM

	MainCityModule.bgmSerialID = LuaUtility.StartNewBGMGroup(bgmCid)
	MainCityModule.mainCamera = UnityEngine.Camera.main

	MainCityModule.LoadPlayerInstance()
	MainCityModule.LoadSpecialEntity()

	if MainCityModule.mainCamera:GetComponent(typeof(Cinemachine.CinemachineBrain)) == nil then
		MainCityModule.mainCamera.gameObject:AddComponent(typeof(Cinemachine.CinemachineBrain))
	end

	CoroutineUtility.Yield(MainCityModule.LoadVirtualCamera())
	LuaUtility.SetCinemachineBlend(Constant.CinemachineBlendDefinitionStyle.Cut, 0)

	MainCityModule.CurSelectSkinCid = MainCityModule.GetCurSkinCid()

	local mainCityWorldSpaceUIObj = GameObject.Find("mainCityWorldSpaceUI")

	if mainCityWorldSpaceUIObj == nil then
		logError("检查当前场景中的3DUI是否存在!")
	else
		MainCityModule.mainCityWorldSpaceUI = mainCityWorldSpaceView.New(mainCityWorldSpaceUIObj)

		MainCityModule.mainCityWorldSpaceUI:Show()
	end

	UIModule.Open(Constant.UIControllerName.MainUI, Constant.UILayer.DefaultUI)
end

function MainCityModule.LoadPlayerInstance()
	local playerEntityId = 8001

	if PlayerModule.PlayerInfo.baseInfo.sex == 1 then
		playerEntityId = 8003
	end

	MainCityModule.showPlayer = MainCityModule.CreatePlayerEntityInstance(playerEntityId)

	MainCityModule.showPlayer:InitPlayerInfo(PlayerModule.PlayerInfo.baseInfo.showHeroCid, Vector3.New(4.5, -0.05, -1), true)
	MainCityModule.UpdatePlayerInfomation()
end

function MainCityModule.CreateEntityInstance(heroCid)
	local entityID = SkinModule.GetSmallSpineElementEntityIDByHeroCid(heroCid, true)
	local path = EntityUtility.GetBattleEntityPath(entityID)
	local entity

	CoroutineUtility.Yield(WaitLoadAsset(MainCityModule, path, function(assetUrl, asset, duration, userData)
		local obj = UnityEngine.GameObject.Instantiate(asset)

		entity = mainCityCharacter.New(obj)
	end))

	return entity
end

function MainCityModule.CreatePlayerEntityInstance(playerEntityId)
	local path = UIGlobalApi.GetPrefabRoot(MainUIAPI:GetPlayerSpinePath(playerEntityId))
	local entity

	CoroutineUtility.Yield(WaitLoadAsset(MainCityModule, path, function(assetUrl, asset, duration, userData)
		local obj = UnityEngine.GameObject.Instantiate(asset)

		entity = mainCityCharacter.New(obj)
	end))

	return entity
end

function MainCityModule.LoadPlayerEntity(heroCid)
	local entityConfig = CfgElementEntityTable[SkinModule.GetSmallSpineElementEntityIDByHeroCid(heroCid, true)]
	local path = BattleApi:GetSpinePrefabUrl(entityConfig.PrefabName)

	return WaitLoadAsset(MainCityModule, path, nil)
end

function MainCityModule.LoadVirtualCamera()
	local path = UIGlobalApi.GetArtPath(MainUIAPI:GetVirtualCameraPath())

	return WaitLoadAsset(MainCityModule, path, function(assetName, asset, duration, userData)
		local cameraGameObject = GameObject.Instantiate(asset)

		GameObject.DontDestroyOnLoad(cameraGameObject)

		cameraGameObject.transform.localScale = Vector3.New(1, 1, 1)
		cameraGameObject.transform.localPosition = Vector3.New(4.65, 1.5, -5)

		BehaviorTreeUtility.InitStoryCinemachineManager(cameraGameObject)
		BehaviorTreeUtility.SetCurrentVirtualCameraFollow(MainCityModule.showPlayer.gameObject.transform)

		local storyVirtualManager = cameraGameObject:GetComponent("StoryVirtualCameraManager")

		MainCityModule.virtualCamera = storyVirtualManager.CVCameraList[0]
		MainCityModule.virtualCameraFOV = LuaUtility.GetCinemachineFOV(MainCityModule.virtualCamera)

		MainCityModule.RecordLoadPrefab(cameraGameObject)
	end)
end

function MainCityModule.LoadSpecialEntity()
	if MainCityModule.isLoadingSpecialEntity == true then
		return
	end

	MainCityModule.isLoadingSpecialEntity = true

	for k, v in pairs(PlayerModule.PlayerInfo.baseInfo.specialEvents) do
		if v.position == nil then
			logError("服务器推送的位置信息为空!")
		end

		if GameObject.Find("Point" .. v.position) == nil then
			warning(string.format("服务器推送的位置Point[%s] 在场景中未找到!", v.position))
		elseif v.state == false and MainCityModule.randomCharacterList[v.hcid] == nil then
			local randomCharacter = MainCityModule.CreateEntityInstance(v.hcid)

			randomCharacter:InitPlayerInfo(v.hcid, GameObject.Find("Point" .. v.position).transform.position, false)

			MainCityModule.randomCharacterList[v.hcid] = randomCharacter
		end
	end

	MainCityModule.isLoadingSpecialEntity = false
end

function MainCityModule.JoystickMoveStart()
	if MainCityModule.showPlayer ~= nil then
		MainCityModule.showPlayer:PlayWalkAnimation()
	end
end

function MainCityModule.SetJoystickMoveDirection(direction)
	if MainCityModule.showPlayer then
		MainCityModule.showPlayer:SetPlayerState(direction)
	end
end

function MainCityModule.JoystickMoveEnd()
	if MainCityModule.showPlayer ~= nil then
		MainCityModule.showPlayer:PlayIdleAnimation()
	end
end

function MainCityModule.OnTapGesture(tapGesture)
	if tapGesture and tapGesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
		return
	end

	local clickTargetObj = LuaCodeInterface.TryRaycastAnyGameobjet(MainCityModule.mainCamera)

	if clickTargetObj ~= nil then
		if clickTargetObj.layer == Constant.GamoObjectLayer.StoryNpc then
			MainCityModule.ClickTarget(clickTargetObj)
		elseif clickTargetObj.layer == Constant.GamoObjectLayer.MainCityInteraction then
			MainCityModule.ClickInteracterGameObject(clickTargetObj)
		end
	end
end

function MainCityModule.ClickTarget(gameObject)
	if not gameObject.transform.parent or not gameObject.transform.parent.parent then
		return
	end

	local objName = gameObject.transform.parent.parent.gameObject.name

	if string.find(objName, InteractiveStrs.Special) == nil then
		return
	end

	LuaUtility.PlaySoundWithID(11200005)

	local heroCid = string.gsub(objName, InteractiveStrs.Special, "")

	logColorInfo("交互的HeroCid：" .. heroCid, colorCode.Violet)

	local eventId = PlayerModule.GetSpecialEventDataByHeroCid(tonumber(heroCid)).eventId

	logColorInfo("事件ID：" .. eventId, colorCode.Violet)
	MainCityModule.UpdateCharacterDir(MainCityModule.showPlayer, MainCityModule.randomCharacterList[tonumber(heroCid)])
	EventDispatcher.Dispatch(EventID.MainCitySpecialEvent, eventId, MainCityModule.randomCharacterList[tonumber(heroCid)])
end

function MainCityModule.UpdateCharacterDir(selfCharacterView, targetCharacterView)
	local selfPos = selfCharacterView.gameObject.transform.position
	local targetPos = targetCharacterView.gameObject.transform.position
	local dotRightResult = Vector3.Dot(selfPos.right, selfPos - targetPos)
	local isRight = dotRightResult < 0

	selfCharacterView:SetFlipX(isRight)
	targetCharacterView:SetFlipX(not isRight)
end

function MainCityModule.PlayCameraAnim(callback, isPullin)
	local startValue = isPullin == true and MainCityModule.virtualCameraFOV or MainCityModule.virtualCameraFOV - 5
	local endValue = isPullin == true and MainCityModule.virtualCameraFOV - 5 or MainCityModule.virtualCameraFOV

	UGUIUtil.DoGetValue(startValue, endValue, 1, DoTweenEase.Linear, function(runNumber)
		LuaUtility.SetCinemachineFOV(MainCityModule.virtualCamera, runNumber)
	end, function()
		if callback then
			callback()
		end
	end)
end

function MainCityModule.ClickInteracterGameObject(clickTargetObj)
	local mainCityInteractComponent = clickTargetObj:GetComponent("MainCityInteractComponent")

	if mainCityInteractComponent == nil then
		return
	end

	if mainCityInteractComponent.SoundConfigID ~= 0 then
		LuaUtility.PlaySoundWithID(mainCityInteractComponent.SoundConfigID)
	end

	CoroutineUtility.StartCoroutine(function()
		MainCityModule.ShowModelOutLine(clickTargetObj, true)
		CoroutineUtility.Yield(CustomWaitForSeconds(0.3))

		if mainCityInteractComponent.InteractConfigID == 1001 then
			if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DRAW) then
				UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
			else
				NoticeModule.ShowNotice(19001)
			end
		elseif mainCityInteractComponent.InteractConfigID == 1002 then
			UIModule.Open(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI)
		elseif mainCityInteractComponent.InteractConfigID == 1003 then
			if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_TASK) then
				UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
			else
				NoticeModule.ShowNotice(19001)
			end
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.1))
		MainCityModule.ShowModelOutLine(clickTargetObj, false)
	end)
end

function MainCityModule.ShowModelOutLine(obj, isOn)
	local meshRender = obj:GetComponent("MeshRenderer")

	meshRender.renderingLayerMask = isOn and LayerConstant.Layer11 or LayerConstant.Layer0
end

function MainCityModule.GetCurSkinCid()
	local skinPod = WarlockModule.WarlockDataDic[PlayerModule.PlayerInfo.baseInfo.showHeroCid]:GetCurSkinPODBySkinType(Constant.SkinType.SpineElementEntity)

	return skinPod.skinCid
end

function MainCityModule.OnPlayerDataChange()
	MainCityModule.RefreshSpecialEnetity()
end

function MainCityModule.RefreshSpecialEnetity()
	CoroutineUtility.StartCoroutine(function()
		MainCityModule.LoadSpecialEntity()
	end)
end

function MainCityModule.RemoveSpecialEnetityByEventId(eventID)
	local heroCid = PlayerModule.GetSpecialEventDataByEvnetID(eventID).hcid

	MainCityModule.randomCharacterList[heroCid]:Dispose()

	MainCityModule.randomCharacterList[heroCid] = nil
end

function MainCityModule.UpdatePlayerInfomation()
	local serverPlayerPOD = PlayerModule.PlayerInfo.baseInfo.littleInformationPOD

	if serverPlayerPOD == nil then
		MainCityModule.showPlayer:InitPlayPos(Vector3.New(4.5, -0.05, -1))
	else
		MainCityModule.showPlayer:InitPlayPos(Vector3.New(serverPlayerPOD.x, serverPlayerPOD.y < 0 and 0 or serverPlayerPOD.y, serverPlayerPOD.z))
	end
end

function MainCityModule.RecordLoadPrefab(obj)
	table.insert(MainCityModule.exitSceneDestoryObjList, obj)
end

function MainCityModule.Shutdown()
	HomeModule.ExitHomeScene()
end
