-- chunkname: @IQIGame\\Scene\\GhostGame\\GhostGameScene.lua

local ghostGameEnemy = require("IQIGame.Scene.GhostGame.GhostGameEnemy")
local ghostGamePlayer = require("IQIGame.Module.GhostGame.GhostGamePlayer")
local ghostGameCharacter = require("IQIGame.Module.GhostGame.GhostGameCharacter")
local m = {
	totalTime = 0,
	clickInterval = 0,
	refreshMonsterIndex = 1
}

function m.New(sceneId)
	local obj = Clone(m)

	obj:Init(sceneId)

	return obj
end

function m:Init(sceneId)
	self.fixedUpdateHandler = FixedUpdateBeat:CreateListener(self.FixedUpdate, self)
	self.ghostGameCharacterList = {}
	self.pointsTransformList = {}
	self.refreshMonsterIndex = 1
	self.totalTime = GhostGameModule.GameTime
	self.sceneCamera = UnityEngine.Camera.main

	self:InitDelegates()
	self:AddListeners()
	self:CreatePlayer()
	self:LoadScene(sceneId)
	self:LoadBirthPoints()
	self:LoadVirtualCamera()
end

function m:InitDelegates()
	function self.OnDelegateOnTapGesture(tapGesture)
		self:__OnTapGesture(tapGesture)
	end
end

function m:AddListeners()
	FixedUpdateBeat:AddListener(self.fixedUpdateHandler)
	EventDispatcher.AddEventListener(EventID.OnTapGesture, self.OnDelegateOnTapGesture)
end

function m:RemoveListeners()
	FixedUpdateBeat:RemoveListener(self.fixedUpdateHandler)
	EventDispatcher.RemoveEventListener(EventID.OnTapGesture, self.OnDelegateOnTapGesture)
end

function m:FixedUpdate()
	if table.len(self.ghostGameCharacterList) > 0 then
		for k, v in pairs(self.ghostGameCharacterList) do
			v:Update()
		end
	end

	if self.ghostGamePlayer then
		self.ghostGamePlayer:Update()
	end

	if not GhostGameModule.IsStart or GhostGameModule.IsPause then
		return
	end

	if GhostGameModule.GetCanRefreshEnemy() then
		self.totalTime = self.totalTime + Time.deltaTime
	end

	if self.totalTime >= GhostGameModule.MonsterRefreshTime then
		self:RefreshEnemy()

		self.totalTime = 0
	end

	self.clickInterval = self.clickInterval + Time.deltaTime
end

function m:LoadScene(sceneId)
	self.sceneCfg = CfgSceneListTable[sceneId]

	local scenePath = AssetPath.Get(GlobalKey.ScenePrefabPath, self.sceneCfg.SceneFile)
	local renderConfigPath = BattleApi:GetSceneRenderConfigPath(self.sceneCfg.RenderConfig)

	AssetUtil.LoadAsset(self, scenePath, function(_, assetUrl, asset, duration, userData)
		self:OnSceneLoadSuccess(asset, renderConfigPath)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("鬼节场景加载失败{0}", sceneCfgID, scenePath)
	end)
end

function m:OnSceneLoadSuccess(asset, renderConfigPath)
	self.sceneObj = GameObject.Instantiate(asset)

	AssetUtil.LoadAsset(self, renderConfigPath, function(_, _assetUrl, _asset, _duration, _userData)
		SceneRenderConfigManager.ApplyConfig(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("鬼节场景加载场景配置失败 {0}", renderConfigPath)
	end)
end

function m:LoadBirthPoints()
	AssetUtil.LoadAsset(self, GhostGameApi:GetGhostGameBirthPointPrefabPath(), function(_, _assetUrl, _asset, _duration, _userData)
		self:OnBirthPointsLoadSuccess(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载场景出生点失败")
	end)
end

function m:OnBirthPointsLoadSuccess(asset)
	self.BirthPointsObj = GameObject.Instantiate(asset)

	for i = 1, 3 do
		table.insert(self.pointsTransformList, i, self.BirthPointsObj.transform:Find("Point" .. i))
	end

	GhostGameModule.IsSceneReady = true
end

function m:LoadVirtualCamera(virtualCameraPath)
	AssetUtil.LoadAsset(self, GhostGameApi:GetGhostGameVirtualCameraPrefabPath(), function(_, _assetUrl, _asset, _duration, _userData)
		self:OnVirtualCameraLoadSuccess(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载场景镜头失败 {0}", virtualCameraPath)
	end)
end

function m:OnVirtualCameraLoadSuccess(asset)
	self.virtualCameraManagerObj = GameObject.Instantiate(asset)
	self.virtualCameraManagerObj.name = "GhostGameVirtualCameraManager"
	self.virtualCameraManagerObj.transform.localPosition = Vector3.New(0, 1.5, -6)
	self.virtualCameraManager = self.virtualCameraManagerObj:GetComponent("StoryVirtualCameraManager")

	if UnityEngine.Camera.main.gameObject:GetComponent(typeof(Cinemachine.CinemachineBrain)) == nil then
		UnityEngine.Camera.main.gameObject:AddComponent(typeof(Cinemachine.CinemachineBrain))
	end

	self.virtualCameraManager:SetCinemachineBrain(self.sceneCamera)
	self.virtualCameraManager:Init()
end

function m:CreatePlayer()
	self.ghostGamePlayer = ghostGamePlayer.New()
end

function m:RefreshEnemy()
	local ghostEnemyData = GhostGameModule.GetEnemyCfg(self.refreshMonsterIndex)

	if ghostEnemyData == nil then
		logError("怪物刷新已达上限")

		return
	end

	local parent = self.pointsTransformList[math.random(1, 3)]
	local serverTime = PlayerModule.GetServerTimeByMs() + math.random(1, 10)
	local ghostGameEnemyView = ghostGameCharacter.New(ghostGameEnemy, ghostEnemyData, parent)

	ghostGameEnemyView:SaveServerTime(serverTime)
	self:AddEnemy(serverTime, ghostGameEnemyView)

	self.refreshMonsterIndex = self.refreshMonsterIndex + 1
end

function m:AddEnemy(serverTime, ghostEnemy)
	self.ghostGameCharacterList[serverTime] = ghostEnemy
end

function m:RemoveEnemy(serverTime)
	for k, v in pairs(self.ghostGameCharacterList) do
		if v.serverTime == serverTime then
			local ghostEnemyInstance = self.ghostGameCharacterList[k]

			ghostEnemyInstance:Dispose()

			self.ghostGameCharacterList[k] = nil

			return
		end
	end
end

function m:__OnTapGesture(tapGesture)
	if tapGesture and tapGesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
		return
	end

	if self.clickInterval < self.ghostGamePlayer.attackInterval then
		return
	end

	self.clickInterval = 0

	if not GhostGameModule.IsStart or GhostGameModule.IsPause then
		return
	end

	local transform = LuaCodeInterface.Raycast3D(self.sceneCamera, "Default")

	self:ClickEnemy(transform)
end

function m:ClickEnemy(transform)
	if transform == nil then
		return
	end

	local buttonTrigger = transform:GetComponent("ButtonTrigger")

	if buttonTrigger == nil then
		return
	end

	local targetEnemy = self:FindEnemyByInstanceID(buttonTrigger.valueString)

	if targetEnemy.ghostEnemyData:IsDead() or not targetEnemy then
		return
	end

	targetEnemy:UpdateHP(self.ghostGamePlayer.attackPower)
	self.ghostGamePlayer:UpdateAttackNum(-1)
end

function m:FindEnemyByInstanceID(serverTime)
	for k, v in pairs(self.ghostGameCharacterList) do
		if tonumber(serverTime) == v.serverTime then
			return v
		end
	end

	return nil
end

function m:Dispose()
	if self.sceneObj == nil then
		return
	end

	GameObject.Destroy(self.sceneObj)
	GameObject.Destroy(self.virtualCameraManagerObj)
	GameObject.Destroy(self.BirthPointsObj)

	self.pointsTransformList = nil

	for k, v in pairs(self.ghostGameCharacterList) do
		v:Dispose()
	end

	self.ghostGameCharacterList = nil
	self.refreshMonsterIndex = nil

	self.ghostGamePlayer:Dispose()
	self:RemoveListeners()
end

return m
