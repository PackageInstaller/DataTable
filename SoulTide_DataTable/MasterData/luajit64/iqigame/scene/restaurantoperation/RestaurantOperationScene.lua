-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationScene.lua

local m = {
	sceneType = 1,
	isLockInput = false,
	sceneAreas = {},
	npcPool = {},
	npcInstancePool = {}
}
local RestaurantOperationScenePosData = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationScenePosData")
local RestaurantOperationSceneAreaData = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationSceneAreaData")
local RestaurantOperationNPCWalkAreaData = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationNPCWalkAreaData")
local RestaurantOperationInputManager = require("IQIGame.Scene.RestaurantOperation.Input.RestaurantOperationInputManager")
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local RestaurantOperationNPC = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationNPC")
local RestaurantOperationOutPutView = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationOutPutView")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("RestaurantOperation").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	self:ChangeSceneArea(RestaurantOperationConstant.SceneType.Scene_Inside, false)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = RestaurantOperationInputManager.New()
	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	function self.cameraCtrl.cameraChangePosCallBack()
		self:OnCameraChangePos()
	end
end

function m:ChangeSceneArea(type, playEffect)
	local path

	if type == RestaurantOperationConstant.SceneType.Scene_Inside then
		path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/RestaurantOperation/RestaurantOperation_BG.prefab")
	else
		path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/RestaurantOperation/RestaurantOperation_Outside.prefab")
	end

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail, {
		Type = type,
		ShowEffect = playEffect
	})
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	self.sceneType = innerUserData.Type

	local showEff = innerUserData.ShowEffect

	self.View = UnityEngine.Object.Instantiate(asset)

	self.View.transform:SetParent(self.MapRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	if self.sceneType == RestaurantOperationConstant.SceneType.Scene_Inside then
		self.outPutView = RestaurantOperationOutPutView.New(self.Output)
	end

	self:ShowScene(false)

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	function self.DelegateUpdateScenePlayer(positionInformationPOD, lastPost, lastLocation)
		self:OnUpdateScenePlayer(positionInformationPOD, lastPost, lastLocation)
	end

	function self.DelegateUpdateFinishedTaskOver(cid)
		self:OnUpdateFinishedTaskOver(cid)
	end

	self:InitAreaPos()
	self:Refresh()
	EventDispatcher.Dispatch(EventID.ROCameraChangePosEvent)

	if self.sceneType == RestaurantOperationConstant.SceneType.Scene_Inside then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationMainUI, Constant.UILayer.UI, {
			PlayEffect = showEff
		})
	else
		UIModule.Open(Constant.UIControllerName.RestaurantOperationOutSideUI, Constant.UILayer.UI, {
			PlayEffect = showEff
		})
	end

	if not showEff then
		RestaurantOperationModule.CheckResumeDialog()
	end

	self.gameFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.RestaurantOperationGame, function()
		self:FrameUpdate()
	end, -1, -1)

	self.gameFrameTimer:Start()
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:FrameUpdate()
	if self.outPutView then
		self.outPutView:FrameUpdate()
	end
end

function m:ShowScene(top)
	self.View:SetActive(top)
end

function m:InitAreaPos()
	self.sceneAreas = {}

	for k, v in pairs(RestaurantOperationConstant.WalkAreaType) do
		local areaTypeNode = self["WalkArea" .. v]
		local jobPositions = {}
		local walkAreas = {}

		if areaTypeNode then
			if v == RestaurantOperationConstant.WalkAreaType.WalkArea_NPC then
				for j = 1, areaTypeNode.transform.childCount do
					local trans = areaTypeNode.transform:Find("WalkArea_" .. j)

					if trans then
						local walkAreaData = RestaurantOperationNPCWalkAreaData.New(v, trans)

						table.insert(walkAreas, walkAreaData)
					end
				end
			elseif v == RestaurantOperationConstant.WalkAreaType.Restaurant_Dining_Table then
				for j = 0, areaTypeNode.transform.childCount - 1 do
					local trans = areaTypeNode.transform:GetChild(j)
					local nodeName = trans.gameObject.name

					if string.find(nodeName, "Diners") then
						local posData = RestaurantOperationScenePosData.New(trans:Find("role"), #jobPositions + 1, nil)

						table.insert(jobPositions, posData)
					end
				end
			else
				for j = 1, areaTypeNode.transform.childCount do
					local trans = areaTypeNode.transform:Find("pos" .. j)

					if trans then
						local posData = RestaurantOperationScenePosData.New(trans, #jobPositions + 1, nil)

						table.insert(jobPositions, posData)
					end
				end
			end
		end

		local sceneAreaData = RestaurantOperationSceneAreaData.New(v, jobPositions, walkAreas)

		self.sceneAreas[v] = sceneAreaData
	end
end

function m:Refresh()
	self:RefreshBGM()
	self:AddListeners()
	self:RefreshCamera()
	self:RefreshScenePlayers()
end

function m:RefreshBGM()
	local package = SoundPackageData.New(448, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.cameraCtrl:Refresh(0, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.MainCamera, 3.75)
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
	EventDispatcher.AddEventListener(EventID.ROUpdateScenePlayerEvent, self.DelegateUpdateScenePlayer)
	EventDispatcher.AddEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateScenePlayerEvent, self.DelegateUpdateScenePlayer)
	EventDispatcher.RemoveEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
end

function m:OnMoveTargetOver()
	self.cameraCtrl:SetDragEnable(false)
end

function m:OnCameraChangePos()
	EventDispatcher.Dispatch(EventID.ROCameraChangePosEvent)
end

function m:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end

	for i, v in pairs(self.npcPool) do
		v:OnUpdate()
	end
end

function m:RefreshScenePlayers()
	self.npcInstancePool = {}

	for i, v in pairs(RestaurantOperationModule.ROPlayers) do
		local areaType = v:GetAreaType()

		if areaType > 0 then
			local scenePosData = self:AddNpc(v)

			if scenePosData and areaType ~= RestaurantOperationConstant.WalkAreaType.WalkArea_NPC then
				local sceneAreaData = self.sceneAreas[areaType]

				sceneAreaData:AddRoleInPos(scenePosData.pos, v.cid)
			end
		end
	end
end

function m:OnUpdateScenePlayer(positionInformationPOD, lastPost, lastLocation)
	local roData = RestaurantOperationModule.GetROPlayerData(positionInformationPOD.id)

	if positionInformationPOD.location > 0 then
		self:AddNpc(roData)
	else
		local cfgPostControlData = CfgRestaurantOperationPostControlTable[lastPost]

		self:RemoveNpc(positionInformationPOD.id, cfgPostControlData.WalkArea)
	end
end

function m:RemoveNpc(cid, areaType)
	for i, v in pairs(self.npcPool) do
		if v.roPlayerData.cid == cid then
			v:OnDestroy()

			self.npcPool[i] = nil

			if areaType ~= RestaurantOperationConstant.WalkAreaType.WalkArea_NPC then
				local sceneAreaData = self.sceneAreas[areaType]

				sceneAreaData:RemoveRoleFromPos(cid)
			end
		end
	end
end

function m:AddNpc(roData)
	local randomPos = Vector3.New(0, 0, 0)
	local randomArea, parent, scenePosData

	if roData:IsWorker() then
		local cfgData = roData:GetCfgPostControlData()

		if cfgData.IsInTheRoom ~= self.sceneType then
			return nil
		end
	end

	if roData:GetCfgData().Type == RestaurantOperationConstant.RoleType.npc and roData:GetCfgData().IsInTheRoom ~= self.sceneType then
		return nil
	end

	local areaType = roData:GetAreaType()

	if areaType == RestaurantOperationConstant.WalkAreaType.WalkArea_NPC then
		randomPos, randomArea = self:GetRandomData(areaType)
		parent = randomArea.trans
	elseif areaType == RestaurantOperationConstant.WalkAreaType.Restaurant_Dining_Table then
		scenePosData = self:GetRandomDiningTable()

		if scenePosData then
			parent = scenePosData.transform
		end
	else
		local sceneAreaData = self.sceneAreas[areaType]

		scenePosData = sceneAreaData.jobPositions[roData.posInfo.location]

		if scenePosData then
			parent = scenePosData.transform
		end
	end

	if parent then
		local npc = self:GetIdleNpc()

		npc:Refresh(roData, randomPos, randomArea, parent)

		self.npcInstancePool[npc.View:GetInstanceID()] = roData.cid
	end

	return scenePosData
end

function m:GetRandomDiningTable()
	local emptyAreas = {}
	local sceneAreaData = self.sceneAreas[RestaurantOperationConstant.WalkAreaType.Restaurant_Dining_Table]

	for i, v in pairs(sceneAreaData.jobPositions) do
		if v.roleID == nil then
			table.insert(emptyAreas, v)
		end
	end

	local scenePosData = emptyAreas[math.random(1, #emptyAreas)]

	return scenePosData
end

function m:GetRandomData(areaType)
	local sceneAreaData = self.sceneAreas[areaType]
	local randomArea = sceneAreaData.walkAreas[math.random(1, #sceneAreaData.walkAreas)]
	local randomPos = Vector3.New(math.Random(randomArea.leftPos.x, randomArea.rightPos.x), randomArea.leftPos.y, randomArea.leftPos.z)

	return randomPos, randomArea
end

function m:GetIdleNpc()
	local npc

	for i, v in pairs(self.npcPool) do
		if not v.isWorking then
			npc = v

			break
		end
	end

	if npc == nil then
		local go = UnityEngine.Object.Instantiate(self.goNpc)

		npc = RestaurantOperationNPC.New(go)
		self.npcPool[#self.npcPool + 1] = npc
	end

	return npc
end

function m:OnTapObject(gameObject)
	if self.isLockInput then
		return
	end

	if gameObject.name == "BtnUpStair" then
		EventDispatcher.Dispatch(EventID.ROSceneChangeInRoomEvent)

		return
	end

	local instanceID = gameObject:GetInstanceID()
	local roPlayerCid = self.npcInstancePool[instanceID]
	local cfgRoleData = CfgRestaurantOperationPlayerTable[roPlayerCid]

	UIModule.Open(Constant.UIControllerName.RestaurantOperationFunctionUI, Constant.UILayer.UI, {
		RoleID = roPlayerCid,
		WorldPos = gameObject.transform.position
	})
end

function m:OnUpdateFinishedTaskOver(cid)
	local cfgMainQuest = CfgMainQuestTable[cid]

	if cfgMainQuest.Type ~= TaskModule.TaskType.RESTAURANT_OPERATION_TASK then
		return
	end

	UIModule.Open(Constant.UIControllerName.RestaurantOperationAchievementTipUI, Constant.UILayer.UI, cid)
end

function m:SetActive(value)
	if self.MainCamera == nil then
		logError("self.MainCamera is nil. PlayerModule.InMaze: " .. tostring(PlayerModule.InMaze))

		return
	end

	self.MainCamera.enabled = value

	for j, v in pairs(self.npcPool) do
		local colliders = v.View:GetComponentsInChildren(typeof(UnityEngine.Collider2D))

		for i = 0, colliders.Length - 1 do
			colliders[i].enabled = value
		end

		local canvases = v.View:GetComponentsInChildren(typeof(UnityEngine.Canvas))

		for i = 0, canvases.Length - 1 do
			canvases[i].enabled = value
		end

		local renderers = v.View:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = value
		end
	end

	self.isLockInput = not value
end

function m:ClearScene()
	self:RemoveListeners()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.RestaurantOperationGame)

	if self.SoundPackageId > 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)

		self.SoundPackageId = 0
	end

	if self.outPutView then
		self.outPutView:Dispose()
	end

	self.outPutView = nil

	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	self.npcPool = {}
	self.sceneAreas = {}

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.InputMgr:Dispose()
	self.cameraCtrl:OnDestroy()

	self.cameraCtrl = nil

	self:ClearScene()
end

return m
