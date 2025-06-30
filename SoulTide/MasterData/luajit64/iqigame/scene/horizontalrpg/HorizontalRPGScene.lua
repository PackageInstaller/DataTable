-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGScene.lua

local m = {
	IsShowNextObservation = false,
	RoleLimitDownY = 0,
	IsBGLoaded = false,
	RoleMovieLimitLeftX = 0,
	IsLockInput = false,
	RoleMovieLimitRightX = 0,
	RoleLimitUpY = 0,
	SceneAreaCells = {},
	ObservationPositions = {},
	PutBoxElement = {}
}
local HorizontalRPGCameraCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGCameraCtrl")
local HorizontalRPGInputManager = require("IQIGame.Scene.HorizontalRPG.Input.HorizontalRPGInputManager")
local HorizontalRPGPlayer = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGPlayer")
local HorizontalRPGSceneAreaCell = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGSceneAreaCell")
local HorizontalRPGObjManager = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGObjManager")
local HorizontalRPGRollingBGView = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGRollingBGView")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	self.MainCamera = mainCameraGo:GetComponent("Camera")

	local rootTrans = UnityEngine.GameObject.Find("HorizontalRPG").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local path = UIGlobalApi.GetArtPath(HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().ScenePrefab)

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail, {
		type = "LoadScene"
	})
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	if not self.handle_fixedUpdate then
		self.handle_fixedUpdate = FixedUpdateBeat:CreateListener(self.FixedUpdate, self)
	end

	self.InputMgr = HorizontalRPGInputManager.New()
	self.CameraCtrl = HorizontalRPGCameraCtrl.New(self.MainCamera)
	self.IsBGLoaded = false
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local type = innerUserData.type

	if type == "LoadScene" then
		self.View = UnityEngine.Object.Instantiate(asset)
		self.View.name = HorizontalRPGModule.currentHorizontalRPGMapData.cid

		self.View.transform:SetParent(self.MapRoot, false)
		LuaCodeInterface.BindOutlet(self.View, self)

		self.HorizontalSceneObjManager = HorizontalRPGObjManager.New(self.PrefabRoot, self)
		self.SceneAreaCells = {}

		for i, v in pairs(HorizontalRPGModule.currentHorizontalRPGMapData.mapAreas) do
			local parent = self.AreaNode.transform:Find("pos" .. v.pos)
			local sceneAreaCell = HorizontalRPGSceneAreaCell.New(parent)

			sceneAreaCell:SetData(v)

			function sceneAreaCell.showCallBack(pos)
				self:GetPlayerBirthPoint(pos)
			end

			self.SceneAreaCells[v.pos] = sceneAreaCell
		end

		self.RoleMovieLimitLeftX = self.View.transform:Find("Root/RoleLimitLeft").transform.position.x
		self.RoleMovieLimitRightX = self.View.transform:Find("Root/RoleLimitRight").transform.position.x
		self.RoleLimitUpY = self.View.transform:Find("Root/RoleLimitTop").transform.position.y
		self.RoleLimitDownY = self.View.transform:Find("Root/Floor").transform.position.y
		self.LimitLeftCollider = self.View.transform:Find("Root/RoleLimitLeft").gameObject:GetComponent(typeof(UnityEngine.Collider2D))
		self.LimitRightCollider = self.View.transform:Find("Root/RoleLimitRight").gameObject:GetComponent(typeof(UnityEngine.Collider2D))

		function self.DelegateTimer()
			self:FrameUpdate()
		end

		function self.DelegateUpdateFinishedTaskOver(cid)
			self:OnUpdateFinishedTaskOver(cid)
		end

		function self.DelegateOnHorizontalRPGLockInput(top)
			self:OnHorizontalRPGLockInput(top)
		end

		self:LoadRollingBG()
		self:Refresh()

		self.HorizontalGamePaler = HorizontalRPGPlayer.New(self.goPlayer, self)

		self.HorizontalGamePaler:Refresh(HorizontalRPGModule.horizontalRPGPlayerData)
		UIModule.Open(Constant.UIControllerName.HorizontalRPGGameMainUI, Constant.UILayer.UI)
		self:ShowScene(false)
	elseif type == "LoadRollingBG" then
		if self.RollingBGView then
			self.RollingBGView:Dispose()

			self.RollingBGView = nil
		end

		local rollingObj = UnityEngine.Object.Instantiate(asset)

		rollingObj.transform:SetParent(self.View.transform:Find("Bg/Mid"), false)

		local cameraMinY, cameraMaxY = self.CameraCtrl:GetCameraLimitY()

		self.RollingBGView = HorizontalRPGRollingBGView.New(rollingObj, self.RoleLimitUpY, self.RoleLimitDownY, cameraMaxY, cameraMinY)
		self.IsBGLoaded = true

		self:GetPlayerBirthPoint()
	end
end

function m:LoadRollingBG()
	local path = UIGlobalApi.GetArtPath(HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBg)

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail, {
		type = "LoadRollingBG"
	})
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:GetPlayerBirthPoint()
	local patStr = HorizontalRPGModule.currentHorizontalRPGMapData:GetMapBirthPath()
	local node = self.View.transform:Find(patStr)

	if node and self.IsBGLoaded then
		self.HorizontalGamePaler:Birth(node.position)

		self.CameraCtrl.camera.transform.position = node.position

		self.RollingBGView:LookAt(node.position)
		self:RefreshWeather()
		HorizontalRPGModule.CheckResumeDialog()
		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)

		local timer = Timer.New(function()
			self:ShowScene(true)
			self.RollingBGView.View:SetActive(true)
		end, 0.5)

		timer:Start()
	end
end

function m:Refresh()
	self:RefreshBGM()
	self:AddListeners()
	self:RefreshCamera()
	self:RefreshShowAreas()
end

function m:RefreshShowAreas()
	if HorizontalRPGModule.currentHorizontalRPGMapData then
		local showAreas = HorizontalRPGModule.currentHorizontalRPGMapData:GetShowAreas()

		for i, v in pairs(self.SceneAreaCells) do
			local isShow = table.indexOf(showAreas, i) ~= -1

			if isShow then
				v:ShowAreaElement()
			else
				v:CleanAreaElement()
			end
		end
	end
end

function m:PlaceTheBoxInScene(elementData)
	if elementData then
		local element = self.HorizontalSceneObjManager:GetHorizontalRPGElement(elementData.areaID, elementData:GetCfgData().FirstPosition)

		element.View.transform:SetParent(self.BoxNode.transform, false)

		element.View.transform.position = self.HorizontalGamePaler:GetPutBoxPoint()

		element:SetData(elementData)
		self:AddBoxElement(element)
		GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.PutOnBox, Constant.SoundGroup.ENVIRONMENT)

		if GameEntry.Base.DevMode then
			log("播放放箱子音效 " .. HorizontalRPGConstant.Sound.PutOnBox)
		end
	end
end

function m:AddBoxElement(element)
	self.PutBoxElement[element.ElementData.cid] = element
end

function m:RemoveBoxElement(element)
	self.PutBoxElement[element.ElementData.cid] = nil

	self.HorizontalSceneObjManager:RecycleHorizontalRPGElement(element.ElementData.cid)
	element:Reset()
end

function m:OnTapObject(gameObject)
	if self.IsLockInput then
		return
	end
end

function m:RefreshBGM()
	local package = SoundPackageData.New(452, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:RefreshCamera()
	if self.MainCamera == nil or LuaCodeInterface.GameObjIsDestroy(self.MainCamera) then
		return
	end

	self.CameraCtrl:Refresh(self.goLimitLeft.transform.position, self.goLimitRight.transform.position, self.goLimitUp.transform.position, self.goLimitDown.transform.position, 45, Vector3.New(0, 0, 0))
end

function m:ShowNextObservationPosition()
	if not self.IsShowNextObservation then
		local cameraObsData = table.remove(self.ObservationPositions, 1)

		self.CameraCtrl:MoveToPosition(cameraObsData, function(cameraObsData)
			self:MoveToEnd(cameraObsData)
		end)

		self.IsShowNextObservation = true

		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
	end
end

function m:MoveToEnd(cameraObsData)
	log(tableToString(cameraObsData))

	self.IsShowNextObservation = false

	if #self.ObservationPositions == 0 then
		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
	end
end

function m:FixedUpdate()
	if self.HorizontalGamePaler ~= nil then
		self.HorizontalGamePaler:FixedUpdate()
	end

	if self.HorizontalSceneObjManager then
		self.HorizontalSceneObjManager:FixedUpdate()
	end

	if self.HorizontalGamePaler and not self.HorizontalGamePaler.isOnMovePlatform then
		self:UpdateRefreshCamera()
	end
end

function m:FrameUpdate()
	if self.HorizontalGamePaler ~= nil then
		self.HorizontalGamePaler:FrameUpdate()
	end

	if self.HorizontalSceneObjManager then
		self.HorizontalSceneObjManager:FrameUpdate()
	end

	if self.RollingBGView then
		local pos = self.CameraCtrl.camera.transform.position

		pos.z = 0

		self.RollingBGView:LookAt(pos)
		self.RollingBGView:RefreshSpeed(self.CameraCtrl.horizontalX, self.CameraCtrl.horizontalY, self.CameraCtrl.camera.transform.position.y, self.HorizontalGamePaler.horizontalX, self.isOnMovePlatform)
		self.RollingBGView:FixedUpdate()
	end

	if self.RollingBGView then
		self.RollingBGView:FrameUpdate()
	end

	if self.HorizontalGamePaler and self.HorizontalGamePaler.isOnMovePlatform then
		self:UpdateRefreshCamera()
	end
end

function m:UpdateRefreshCamera()
	if self.CameraCtrl ~= nil then
		if #self.ObservationPositions > 0 or self.IsShowNextObservation then
			self:ShowNextObservationPosition()
		elseif self.SpeakerPos ~= nil then
			self.CameraCtrl:LookAt(self.SpeakerPos, 1)
		elseif self.HorizontalGamePaler and self.HorizontalGamePaler.rigidBody2D then
			self.CameraCtrl:LookAt(self.HorizontalGamePaler.rigidBody2D.transform.position, 0.1)
		end

		self.CameraCtrl:Update()
	end
end

function m:ShowScene(top)
	self.View:SetActive(top)
end

function m:RefreshWeather()
	local isDay = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.weather == 0

	if self.RollingBGView then
		self.RollingBGView:RefreshWeather(isDay)
	end

	for i, v in pairs(self.SceneAreaCells) do
		v:RefreshWeather()
	end
end

function m:AddListeners()
	GameEntry.Timer:AddFrameRender(1, self.DelegateTimer, true)
	FixedUpdateBeat:AddListener(self.handle_fixedUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGLockInputEvent, self.DelegateOnHorizontalRPGLockInput)
end

function m:RemoveListeners()
	GameEntry.Timer:RemoveRender(self.DelegateTimer)
	FixedUpdateBeat:RemoveListener(self.handle_fixedUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateFinishedTaskOver, self.DelegateUpdateFinishedTaskOver)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGLockInputEvent, self.DelegateOnHorizontalRPGLockInput)
end

function m:OnHorizontalRPGLockInput(top)
	self.IsLockInput = top
end

function m:OnUpdateFinishedTaskOver(cid)
	local cfgMainQuest = CfgMainQuestTable[cid]

	if cfgMainQuest.Type ~= TaskModule.TaskType.AMUSEMENT_PARK_TASK then
		return
	end

	UIModule.Open(Constant.UIControllerName.AmusementParkAchievementTipUI, Constant.UILayer.UI, cid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i, v in pairs(self.PutBoxElement) do
		self:RemoveBoxElement(v)
	end

	for i, v in pairs(self.SceneAreaCells) do
		v:Dispose()
	end

	self.HorizontalSceneObjManager:Dispose()
	self.HorizontalGamePaler:Dispose()

	self.HorizontalGamePaler = nil

	self.InputMgr:Dispose()
	self.CameraCtrl:Dispose()

	self.CameraCtrl = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
