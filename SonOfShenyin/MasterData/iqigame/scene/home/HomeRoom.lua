-- chunkname: @IQIGame\\Scene\\Home\\HomeRoom.lua

local HomeSceneUtility = require("IQIGame/Scene/Home/HomeSceneUtility")
local StoryCharacterMoveConfigManager = require("IQIGame.Module.Story.StoryCharacterMoveConfigManager")
local HomeRoom = {
	sceneCid = 0,
	isReady = false,
	parts = {},
	workerPoints = {},
	workerActors = {},
	ornamentActors = {}
}

HomeRoom.MainVirtualCameraID = 0

function HomeRoom.New(sceneCid, callback)
	local scene = Clone(HomeRoom)

	scene:__OnInit(sceneCid, callback)

	return scene
end

function HomeRoom:__OnInit(sceneCid, callback)
	self.sceneCid = sceneCid
	self.callback = callback

	local sceneCfg = CfgUtil.GetCfgWorldRoomSceneDataWithID(sceneCid)
	local serverTime = PlayerModule.GetServerTime()
	local hour = tonumber(os.date("%H", serverTime))

	self.roomRoot = GameObject.New("RoomRoot")
	self.ornamentsRoot = GameObject.New("OrnamentsRoot")

	self.ornamentsRoot.transform:SetParent(self.roomRoot.transform)

	self.componentsRoot = GameObject.New("ComponentsRoot")

	self.componentsRoot.transform:SetParent(self.roomRoot.transform)

	self.AStartRoot = GameObject.New("AStartRoot")

	self.AStartRoot.transform:SetParent(self.roomRoot.transform)

	self.isInitComponents = false
	self.changeTimeReady = true

	if HomeLandApi:InNight(hour) then
		self:__LoadScene(sceneCfg.SceneFileNight, sceneCfg.RenderConfigNight)
		self:__LoadMountPoint(sceneCfg.MountPointPrefabNight)
		self:__LoadVirtualCamera(sceneCfg.CameraPrefabNight)
		self:__ChangeBGM(sceneCfg.BGMNight)
		self:PlayEnvironmentSound(sceneCfg.EnvironmentalSoundNight)
	else
		self:__LoadScene(sceneCfg.SceneFile, sceneCfg.RenderConfig)
		self:__LoadMountPoint(sceneCfg.MountPointPrefab)
		self:__LoadVirtualCamera(sceneCfg.CameraPrefab)
		self:__ChangeBGM(sceneCfg.BGM)
		self:PlayEnvironmentSound(sceneCfg.EnvironmentalSound)
	end

	self:LoadAStartPrefab(sceneCfg)
end

function HomeRoom:OnFrameUpdate()
	if not self.isReady then
		self:__CheckReady()

		return
	end

	if not self.changeTimeReady then
		self:CheckSwitchTimeReady()

		return
	end

	if self.isComponentRefresh and self:ValidateComCreateComplete() then
		self.isComponentRefresh = false

		self:StartComponentAI()
	end

	ForPairs(self.workerActors, function(_actorCid, _workerActor)
		_workerActor:OnFrameUpdate()
	end)
	self:RefreshDirect()
end

function HomeRoom:Dispose()
	if self.environmentSoundId then
		LuaUtility.StopSoundWithSerialId(self.environmentSoundId)
	end

	self.environmentSoundId = nil

	ForPairs(self.parts, function(_cid, _part)
		_part:Dispose()
	end)

	self.workerPoints = nil

	ForPairs(self.workerActors, function(_actorCid, _workerActor)
		_workerActor:Dispose()
	end)

	if self.virtualCameraManager ~= nil then
		self:__DestroyGameObject(self.virtualCameraManager.gameObject)

		self.virtualCameraManager = nil
	end

	for i, v in pairs(self.componentsList) do
		v:Dispose()

		self.componentsList[i] = nil
	end

	self.componentsList = {}

	if self.moveCfgManager then
		self.moveCfgManager:Dispose()

		self.moveCfgManager = nil
	end

	if self.AStartRoot then
		GameObject.Destroy(self.AStartPrefab)

		self.AStartRoot = nil
	end

	self.AStartPrefab = nil

	if self.roomRoot then
		GameObject.Destroy(self.roomRoot)

		self.roomRoot = nil
		self.componentsRoot = nil
		self.AStartRoot = nil
	end

	self:__DestroyGameObject(self.sceneObj)
	self:__DestroyGameObject(self.mountPointsRoot)
	EventDispatcher.Dispatch(EventID.MainUI_HideHudDirectEvent)
	EventDispatcher.Dispatch(EventID.MainUI_ClearTagEvent)
	EventDispatcher.Dispatch(EventID.MainUI_HideRoomSelectEvent)
	EventDispatcher.Dispatch(EventID.CommonDialogControl_ClearEvent)
end

function HomeRoom:__DestroyGameObject(gameObject)
	if gameObject == nil then
		return
	end

	GameObject.Destroy(gameObject)
end

function HomeRoom:__LoadScene(sceneFile, renderConfig)
	local scenePath = AssetPath.Get(GlobalKey.ScenePrefabPath, sceneFile)
	local renderConfigPath = BattleApi:GetSceneRenderConfigPath(renderConfig)

	AssetUtil.LoadAsset(self, scenePath, function(_, _assetUrl, _asset, _duration, _userData)
		log("【Home】加载家园场景成功，{0}", _assetUrl)
		self:__OnSceneLoadSuccess(_asset, renderConfigPath)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("【Home】家园系统加载场景失败 {0} -> {1}", sceneCfgID, scenePath)
	end)
end

function HomeRoom:__OnSceneLoadSuccess(asset, renderConfigPath)
	self.sceneObj = GameObject.Instantiate(asset)

	self:__InitOrnamentPutGridRoot()
	AssetUtil.LoadAsset(self, renderConfigPath, function(_, _assetUrl, _asset, _duration, _userData)
		log("【Home】加载家园系统场景配置成功，{0}", _assetUrl)
		SceneRenderConfigManager.ApplyConfig(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("【Home】家园系统加载场景配置失败 {0}", renderConfigPath)
	end)
end

function HomeRoom:__LoadVirtualCamera(virtualCameraPath)
	AssetUtil.LoadAsset(self, virtualCameraPath, function(_, _assetUrl, _asset, _duration, _userData)
		log("【Home】加载家园场景虚拟镜头成功，{0}", _assetUrl)
		self:__OnVirtualCameraLoadSuccess(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("【Home】家园系统加载场景镜头失败 {0} -> {1}", self.sceneCid, virtualCameraPath)
	end)
end

function HomeRoom:__OnVirtualCameraLoadSuccess(asset)
	local virtualCameraManagerObj = GameObject.Instantiate(asset)

	virtualCameraManagerObj.name = "HomeVirtualCameraManager"
	self.virtualCameraManager = virtualCameraManagerObj:GetComponent("StoryVirtualCameraManager")

	if UnityEngine.Camera.main.gameObject:GetComponent(typeof(Cinemachine.CinemachineBrain)) == nil then
		UnityEngine.Camera.main.gameObject:AddComponent(typeof(Cinemachine.CinemachineBrain))
	end

	self.virtualCameraManager:SetCinemachineBrain(UnityEngine.Camera.main)
	self.virtualCameraManager:Init()
	EventDispatcher.DispatchSingleEvent(EventID.WorldMapRpg_SetPlayerCameraFollowEvent)
end

function HomeRoom:__BindPlayer(playerTrans, playerBornPos)
	if playerBornPos then
		playerTrans.localPosition = playerBornPos
	else
		playerTrans.localPosition = self.playerBornPoint
	end

	self.virtualCameraManager:SetCameraFollowWithID(self.MainVirtualCameraID, playerTrans)
end

function HomeRoom:__LoadMountPoint(mountPointPath)
	AssetUtil.LoadAsset(self, mountPointPath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnLoadMountPointSuccess(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("家园系统加载场景挂点失败 {0} -> {1}", self.sceneCid, mountPointPath)
	end)
end

function HomeRoom:__OnLoadMountPointSuccess(asset)
	self.mountPointsRoot = GameObject.Instantiate(asset)

	self:__OnInitPartMountPoints()
end

function HomeRoom:__OnInitPartMountPoints()
	local mountRoot = self.mountPointsRoot.transform:Find("PartRoot")

	for i = 0, mountRoot.transform.childCount - 1 do
		local childTrans = mountRoot.transform:GetChild(i)
		local partCid = tonumber(childTrans.gameObject.name)

		self:__CreatePart(partCid, childTrans, nil)
	end

	local bornPointTrans = self.mountPointsRoot.transform:Find("PlayerBornPoint")

	self.playerBornPoint = bornPointTrans.localPosition

	local workRoot = self.mountPointsRoot.transform:Find("WorkerRoot")

	if workRoot then
		for i = 0, workRoot.transform.childCount - 1 do
			local childTrans = workRoot.transform:GetChild(i)

			for j = 0, childTrans.childCount - 1 do
				local childTrans2 = childTrans:GetChild(j)

				childTrans2.gameObject:SetActive(false)
			end

			table.insert(self.workerPoints, childTrans)
		end
	end

	self:__CreateWorkHero()
end

function HomeRoom:__CreatePart(partCid, parentTrans, readCall)
	local partCfg = CfgUtil.GetCfgWorldRoomPartDataWithID(partCid)
	local isLegal = true

	if partCfg.UnlockCondition ~= nil then
		isLegal = ConditionModule.Check(partCfg.UnlockCondition)
	end

	if not isLegal then
		return nil
	end

	local partActor = HomeSceneUtility.CreateHomeRoomPartActor(partCid, parentTrans, readCall)

	self.parts[partCid] = partActor
end

function HomeRoom:GetPartByCid(partCid)
	return self.parts[partCid]
end

function HomeRoom:RefreshWorkHero()
	local roomCid = HomeModule.GetCurrentRoomCid()
	local workHeroList = HomeModule.GetRoomWorkHeroList(roomCid)
	local needRemoveActor = {}

	ForPairs(self.workerActors, function(_heroCid, _actor)
		local isIn, _ = ValueInArray(workHeroList, _heroCid)

		if isIn then
			return
		end

		table.insert(needRemoveActor, _heroCid)
	end)
	ForArray(needRemoveActor, function(_index, _actorCid)
		self:__RemoveWorkHero(_actorCid)
	end)
	ForArray(workHeroList, function(_, _heroCid)
		if self.workerActors[_heroCid] ~= nil then
			return
		end

		local workerPoint = self:__GetFreeWorkerPoint()

		if workerPoint == 0 then
			logError("家园添加工作NPC失败，没有可用的工作挂点")

			return
		end

		self:__AddWorkHero(_heroCid, workerPoint)
	end)
end

function HomeRoom:__GetFreeWorkerPoint()
	local index = 0

	ForArray(self.workerPoints, function(_index, v)
		local used = false

		ForPairs(self.workerActors, function(_heroCid, _actor)
			used = _actor.workPointIndex == _index

			return used
		end)

		if used then
			return
		end

		index = _index

		return true
	end)

	return index
end

function HomeRoom:__CreateWorkHero()
	local roomCid = HomeModule.GetCurrentRoomCid()
	local workHeroList = HomeModule.GetRoomWorkHeroList(roomCid)

	ForArray(workHeroList, function(_index, _heroCid)
		self:__AddWorkHero(_heroCid, _index)
	end)
end

function HomeRoom:__AddWorkHero(heroCid, workPoint)
	local parentTrans = self.workerPoints[workPoint]

	if parentTrans == nil then
		logError("场景 {0} 找不到对应的工作挂点 {1} ", self.sceneCid, _index)

		return
	end

	local actor = HomeSceneUtility.CreateHomeRoomWorkActor(heroCid, parentTrans, function(_actor)
		EventDispatcher.Dispatch(EventID.HomeWorkActorJoinRoom, heroCid, _actor.UIMountTrans)
	end)

	actor:SetWorkPointIndex(workPoint)

	self.workerActors[heroCid] = actor
end

function HomeRoom:__RemoveWorkHero(heroCid)
	local actor = self.workerActors[heroCid]

	if actor == nil then
		return
	end

	actor:Dispose()

	self.workerActors[heroCid] = nil
end

function HomeRoom:__InitOrnamentPutGridRoot()
	self.__ornamentPutGridControllers = {}

	local ornamentPutGridControllers = self.sceneObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.Home.OrnamentPutGridController), true)

	ForArrayByCount(0, ornamentPutGridControllers.Length - 1, 1, function(index)
		local controller = ornamentPutGridControllers[index]

		self.__ornamentPutGridControllers[controller.PutGridID] = controller

		controller.gameObject:SetActive(false)
	end)
end

function HomeRoom:EnterOrnamentEditorMode()
	self.componentsRoot.gameObject:SetActive(false)
	self.AStartRoot.gameObject:SetActive(false)
	self:__ChangeOrnamentShowType(1)
end

function HomeRoom:ExitOrnamentEditorMode()
	self.virtualCameraManager:SetCurrentEnableCameraWithIDImmediately(0)
	self.componentsRoot.gameObject:SetActive(true)
	self.AStartRoot.gameObject:SetActive(true)
	self:__ChangeOrnamentShowType(-1)
end

function HomeRoom:__ChangeOrnamentShowType(id)
	ForPairs(self.__ornamentPutGridControllers, function(putGridID, controller)
		local active = putGridID == id

		controller.gameObject:SetActive(active)

		if not active then
			return
		end

		self.virtualCameraManager:SetCurrentEnableCameraWithID(1)
	end)
end

function HomeRoom:__AddOrnament(ornamentCid)
	return
end

function HomeRoom:__RemoveOrnament(ornamentId)
	return
end

function HomeRoom:UpdateOrnamentPoint(ornamentId, col, row)
	local result = true
	local cellOffsets = {
		0,
		-1,
		0,
		-2,
		0,
		0,
		0,
		1
	}
	local control = self.__ornamentPutGridControllers[1]

	control:ResetAllGridColor()
	ForArrayByCount(1, #cellOffsets, 2, function(k)
		local _col = cellOffsets[k] + col
		local _row = cellOffsets[k + 1] + row
		local gridItem = control:GetPutGridItem(_col, _row)

		logError("{0}-->{1}", _col, _row)

		if gridItem == nil then
			result = false

			return
		end

		local isLegal = gridItem.State == IQIGame.Onigao.Game.Home.OrnamentPutGridItem.GridState.Enable

		if isLegal then
			gridItem:ChangeTempColor(Color.green)
		else
			gridItem:ChangeTempColor(Color.red)

			result = false
		end
	end)

	return result
end

function HomeRoom:__ChangeBGM(bgmCid)
	if not bgmCid or bgmCid == 0 then
		return
	end

	if self.bgmSerialID == nil then
		self.bgmSerialID = LuaUtility.PlayBGMWithID(bgmCid)
	else
		LuaUtility.ReplaceBGM(self.bgmSerialID, bgmCid)
	end

	self.currentBgmId = bgmCid
end

function HomeRoom:PlayEnvironmentSound(soundId)
	self.EnvironmentSound = soundId

	if self.environmentSoundId then
		LuaUtility.StopSoundWithSerialId(self.environmentSoundId)
	end

	self.environmentSoundId = LuaUtility.PlaySoundWithID(soundId)
end

function HomeRoom:PauseEnvironmentSound()
	if self.environmentSoundId == nil then
		return
	end

	LuaUtility.StopSoundWithSerialId(self.environmentSoundId)

	self.environmentSoundId = nil
end

function HomeRoom:ResumeEnvironmentSound()
	if self.EnvironmentSound == nil then
		return
	end

	if self.environmentSoundId ~= nil then
		return
	end

	self:PlayEnvironmentSound(self.EnvironmentSound)
end

function HomeRoom:LoadSceneComponents(sceneCfg)
	self.componentsList = {}
	self.componentsData = WorldMapModule.GetComponentsWithRoomId(sceneCfg.RoomId)

	if not self.componentsData or getTableLength(self.componentsData) == 0 then
		return
	end

	for _, v in pairs(self.componentsData) do
		self.componentsList[v.cid] = HomeSceneUtility.CreateSceneComponent(v.cid, self.componentsRoot.transform)
	end
end

function HomeRoom:GetComponentWithId(componentId)
	if componentId == 0 then
		return HomeModule.homeScene.playerActor
	end

	if not self.componentsList then
		return
	end

	return self.componentsList[componentId]
end

function HomeRoom:RefreshComponentWithId(componentId)
	local componentData = WorldMapModule.GetComponentDataWithId(componentId)

	if not componentData then
		return
	end

	if self.componentsList[componentId] then
		if not componentData:GetActive() then
			self.componentsList[componentId]:Dispose()

			self.componentsList[componentId] = nil
		else
			self.componentsList[componentId].controller:InitAction()
		end
	elseif componentData:GetActive() then
		self.componentsList[componentId] = HomeSceneUtility.CreateSceneComponent(componentId, self.componentsRoot.transform)
	end
end

function HomeRoom:CreateTempComponent(componentId)
	if self.componentsList[componentId] then
		self.componentsList[componentId]:Show()

		return false
	end

	self.componentsList[componentId] = HomeSceneUtility.CreateSceneComponent(componentId, self.componentsRoot.transform)

	return true
end

function HomeRoom:RefreshAllComponent()
	local sceneCfg = CfgUtil.GetCfgWorldRoomSceneDataWithID(self.sceneCid)

	self.componentsData = WorldMapModule.GetComponentsWithRoomId(sceneCfg.RoomId)

	for componentId, v in pairs(self.componentsList) do
		local hide = true

		for _, cData in pairs(self.componentsData) do
			if cData.cid == v:GetComponentId() then
				hide = false

				break
			end
		end

		if hide then
			self.componentsList[componentId]:Dispose()

			self.componentsList[componentId] = nil
		end
	end

	for _, v in pairs(self.componentsData) do
		if self.componentsList[v.cid] then
			self.componentsList[v.cid]:Show()
		else
			self.componentsList[v.cid] = HomeSceneUtility.CreateSceneComponent(v.cid, self.componentsRoot.transform)
		end
	end

	self.isComponentRefresh = true
end

function HomeRoom:RefreshComponentByRegular()
	for _, v in pairs(self.componentsList) do
		local componentData = WorldMapModule.GetComponentDataWithId(v:GetComponentId())
		local len = #componentData:GetCfg().UnlockCondition

		for i = 1, len do
			if componentData:GetCfg().UnlockCondition[i] == Constant.ConditionConstant.Check_RegularState and not ConditionModule.Check(componentData:GetCfg().UnlockCondition[i]) and v:GetActive() then
				v:Hide()
			end
		end
	end
end

function HomeRoom:StartComponentAI()
	for _, v in pairs(self.componentsList) do
		if v:GetActive() then
			local cfgComponent = CfgUtil.GetCfgWorldRoomCompDataWithID(v.componentId)

			if cfgComponent.AiGroupId ~= 0 then
				v.controller:RandomStartAI()
			end
		end
	end
end

function HomeRoom:ChangeRole(componentId, skinId)
	local component = self.componentsList[componentId]

	if not component then
		return
	end

	component:ChangeModel(skinId)
end

function HomeRoom:HideAllNpcName()
	if not self.componentsList then
		return
	end

	for _, v in pairs(self.componentsList) do
		EventDispatcher.Dispatch(EventID.MainUI_HideNpcNameEvent, v:GetNameMountPoint())
	end
end

function HomeRoom:LoadAStartPrefab(sceneCfg)
	local path = sceneCfg.MovePrefab

	if LuaUtility.StrIsNullOrEmpty(path) then
		logError("【RPG】场景 id = " .. sceneCfg.Id .. "没有A*寻路配置，请检查")

		return
	end

	LuaUtility.LoadAsset(self, path, self._OnAStartPrefabLoadSuccess)
end

function HomeRoom:_OnAStartPrefabLoadSuccess(assetName, asset, duration, userData)
	self.AStartPrefab = GameObject.Instantiate(asset, self.AStartRoot.transform)
	self.moveCfgManager = StoryCharacterMoveConfigManager.New(self.AStartPrefab)

	if AstarPath.active then
		AstarPath.active:Scan()
	else
		logError("not find AstarPath.active")
	end
end

function HomeRoom:InitMovePos()
	local movePointRoot = self.sceneObj.transform:Find("movePointRoot")

	if not movePointRoot then
		return
	end

	self.movePointArray = {}

	local len = LuaUtility.GetChildCount(movePointRoot)

	for i = 1, len do
		local trans = LuaUtility.GetChild(movePointRoot, i - 1)

		table.insert(self.movePointArray, trans)
	end
end

function HomeRoom:RefreshByTime()
	self.changeTimeReady = false

	BehaviorTreeUtility.PlayStoryCutToEffect()

	local sceneCfg = CfgUtil.GetCfgWorldRoomSceneDataWithID(self.sceneCid)

	EventDispatcher.Dispatch(EventID.CommonDialogControl_ClearEvent)

	for _, v in pairs(self.componentsList) do
		v:Hide()
	end

	ForPairs(self.parts, function(_, _part)
		_part:Dispose()
	end)

	self.parts = {}

	self:__DestroyGameObject(self.sceneObj)

	if self.virtualCameraManager ~= nil then
		self:__DestroyGameObject(self.virtualCameraManager.gameObject)

		self.virtualCameraManager = nil
	end

	self:__DestroyGameObject(self.mountPointsRoot)
	EventDispatcher.AddSingleEventListener(EventID.WorldMapRpg_SetPlayerCameraFollowEvent, function()
		if not self.virtualCameraManager then
			return
		end

		self.virtualCameraManager:SetCameraFollowWithID(self.MainVirtualCameraID, HomeModule.GetPlayer().transform)
	end)

	if HomeLandApi:InNight() then
		self:__LoadScene(sceneCfg.SceneFileNight, sceneCfg.RenderConfigNight)
		self:__LoadMountPoint(sceneCfg.MountPointPrefabNight)
		self:__LoadVirtualCamera(sceneCfg.CameraPrefabNight)
		self:__ChangeBGM(sceneCfg.BGMNight)
		self:PlayEnvironmentSound(sceneCfg.EnvironmentalSoundNight)
	else
		self:__LoadScene(sceneCfg.SceneFile, sceneCfg.RenderConfig)
		self:__LoadMountPoint(sceneCfg.MountPointPrefab)
		self:__LoadVirtualCamera(sceneCfg.CameraPrefab)
		self:__ChangeBGM(sceneCfg.BGM)
		self:PlayEnvironmentSound(sceneCfg.EnvironmentalSound)
	end

	self.componentsData = WorldMapModule.GetComponentsWithRoomId(sceneCfg.RoomId)

	for _, v in pairs(self.componentsData) do
		if self.componentsList[v.cid] then
			self.componentsList[v.cid]:Show()
		else
			self.componentsList[v.cid] = HomeSceneUtility.CreateSceneComponent(v.cid, self.componentsRoot.transform)
		end
	end
end

function HomeRoom:RefreshDirect()
	local player = HomeModule.GetPlayer()

	if not player then
		return
	end

	if not player.transform then
		return
	end

	if self.dUpdateTime and Time.time - self.dUpdateTime < Constant.DirectRefreshDuration then
		return
	end

	local mainLeft, mainRight, branchLeft, branchRight, branchRpgLeft, branchRpgRight, saunterLeft, saunterRight

	for _, v in pairs(self.componentsList) do
		if v.controller.haveTag then
			local viewPortPoint = UnityEngine.Camera.main:WorldToViewportPoint(v.transform.position)
			local isInXRange = viewPortPoint.x >= 0 and viewPortPoint.x <= 1
			local playerPosX = player.transform.position.x
			local targetX = v.transform.position.x
			local isLeft = targetX < playerPosX

			if v.controller.tagType == Constant.RPGTagType.MainTag then
				if not isInXRange then
					mainLeft = isLeft
					mainRight = not isLeft
				end
			elseif v.controller.tagType == Constant.RPGTagType.BranchTag then
				if not isInXRange then
					branchLeft = isLeft
					branchRight = not isLeft
				end
			elseif v.controller.tagType == Constant.RPGTagType.BranchTag_RPG then
				if not isInXRange then
					branchRpgLeft = isLeft
					branchRpgRight = not isLeft
				end
			elseif v.controller.tagType == Constant.RPGTagType.SaunterEvent and not isInXRange then
				saunterLeft = isLeft
				saunterRight = not isLeft
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MainUI_ShowHudDirectEvent, 1, mainLeft and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_ShowHudDirectEvent, 2, mainRight and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudBranchShowEvent, 1, branchLeft and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudBranchShowEvent, 2, branchRight and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudBranch_RpgShowEvent, 1, branchRpgLeft and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudBranch_RpgShowEvent, 2, branchRpgRight and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudSaunterShowEvent, 1, saunterLeft and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudSaunterShowEvent, 2, saunterRight and true or false)

	self.dUpdateTime = Time.time
end

function HomeRoom:__CheckReady()
	if self.virtualCameraManager == nil then
		return
	end

	if self.sceneObj == nil then
		return
	end

	if self.mountPointsRoot == nil then
		return
	end

	if not AstarPath.active or AstarPath.active.isScanning then
		return
	end

	if not self.isInitComponents then
		local sceneCfg = CfgUtil.GetCfgWorldRoomSceneDataWithID(self.sceneCid)

		self:LoadSceneComponents(sceneCfg)

		self.isInitComponents = true
	end

	if not self:ValidateComCreateComplete() then
		return
	end

	self.isReady = true

	self:InitMovePos()
	self:StartComponentAI()

	if self.callback ~= nil then
		self.callback()
	end

	EventDispatcher.Dispatch(EventID.WorldMapRGP_EnterRoomCompleteEvent)
end

function HomeRoom:ValidateComCreateComplete()
	for _, v in pairs(self.componentsData) do
		if not self.componentsList[v.cid] or not self.componentsList[v.cid].isReadyToShow then
			return false
		end
	end

	return true
end

function HomeRoom:CheckSwitchTimeReady()
	if self.virtualCameraManager == nil then
		return
	end

	if self.sceneObj == nil then
		return
	end

	if self.mountPointsRoot == nil then
		return
	end

	if not AstarPath.active or AstarPath.active.isScanning then
		return
	end

	for _, v in pairs(self.componentsData) do
		if not self.componentsList[v.cid] or not self.componentsList[v.cid].isReadyToShow then
			return
		end
	end

	self.changeTimeReady = true

	self:InitMovePos()
	self:StartComponentAI()
end

return HomeRoom
