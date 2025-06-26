-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/scenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local SerializedLightMapData = (((CS.PixelNeko).P1).Scene).SerializedLightMapData
local Utility = (((CS.PixelNeko).P1).Common).Utility
local GraphicsCommand = (((CS.PixelNeko).P1).Render).GraphicsCommand
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local SwitchLightmap = ((((CS.PixelNeko).P1).Render).DayNightSwitch).SwitchLightmap
local SetDayNightLight = ((((CS.PixelNeko).P1).Render).DayNightSwitch).SetDayNightLight
local CWeatherConfig = (BeanManager.GetTableByName)("scene.cweatherconfig")
local CEffectRes = (BeanManager.GetTableByName)("skill.ceffectres")
local CSceneLightConfig = (BeanManager.GetTableByName)("scene.cscenelightconfig")
local CCinemachineSetting = (BeanManager.GetTableByName)("scene.ccinemachinesetting")
local SceneController = class("SceneController")
local SetProgress = function(self, isDone, process)
  -- function num : 0_0 , upvalues : _ENV
  if isDone then
    self._loadedProcess = 1
  else
    self._loadedProcess = process
  end
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  if loadingDialog == nil then
    return 
  end
  loadingDialog:UpdateSceneProgress(self._id, process)
end

local LoadSceneProgressNotificationHandler = function(self, notification)
  -- function num : 0_1 , upvalues : SetProgress
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  ;
  (self._sceneRef):LoadSceneProgressNotificationHandler(userInfo)
  SetProgress(self, false, userInfo.progress)
end

local EndLoadSceneNotificationHandler = function(self, notification)
  -- function num : 0_2 , upvalues : GraphicsCommand, SetProgress, _ENV, GameSceneManager
  (GraphicsCommand.SetShadowDistance)(15)
  ;
  (self._sceneRef):EndLoadSceneNotificationHandler(self)
  ;
  (self._sceneRef):Init()
  SetProgress(self, true, 1)
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_LoadSceneProgress)
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_EndLoadScene)
  self:Init()
  ;
  (GameSceneManager.SetSceneRootGameObjectActive)(self:GetSceneName(), self._isRootGameObjectActiveAfterLoaded)
  for k,v in pairs(self._cachedCallTable) do
    (v.method)((table.unpack)(v.params))
  end
  self._cachedCallTable = nil
end

local BeginUnLoadSceneNotificationHandler = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  local sceneController = notification.userInfo
  if sceneController == nil then
    return 
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_BeginUnLoadScene)
  self:OnDestroy()
  ;
  (self._sceneRef):OnDestroy()
end

SceneController.Ctor = function(self)
  -- function num : 0_4 , upvalues : _ENV, LoadSceneProgressNotificationHandler, EndLoadSceneNotificationHandler, BeginUnLoadSceneNotificationHandler
  self._cachedCallTable = {}
  self._data = {}
  self._info = nil
  self._id = nil
  self._rootGameObject = nil
  self._loadType = nil
  self._sceneRef = nil
  self._isSceneActiveAfterLoaded = nil
  self._isRootGameObjectActiveAfterLoaded = nil
  self._loadedProcess = 0
  self._sceneHasDestroyed = false
  ;
  (LuaNotificationCenter.AddObserver)(self, LoadSceneProgressNotificationHandler, Common.n_LoadSceneProgress, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, EndLoadSceneNotificationHandler, Common.n_EndLoadScene, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, BeginUnLoadSceneNotificationHandler, Common.n_BeginUnLoadScene, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNavMeshBuildFinish, Common.n_NavMeshBuildFinish, nil)
end

SceneController.OnDestroyNotLoaded = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SceneController.SetCtorParams = function(self, sceneRef, record, isSceneActiveAfterLoaded, isRootGameObjectActiveAfterLoaded)
  -- function num : 0_6
  self._info = record
  self._id = record.id
  self._loadType = record.loadType
  self._sceneRef = sceneRef
  self._isSceneActiveAfterLoaded = isSceneActiveAfterLoaded
  self._isRootGameObjectActiveAfterLoaded = isRootGameObjectActiveAfterLoaded
end

SceneController.IsSceneHasDestroyed = function(self)
  -- function num : 0_7
  return self._sceneHasDestroyed
end

SceneController.SetSceneDestroyed = function(self)
  -- function num : 0_8
  self._sceneHasDestroyed = true
end

SceneController.SetData = function(self, key, value)
  -- function num : 0_9
  if self._data == nil then
    self._data = {}
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data)[key] = value
end

SceneController.GetData = function(self, key)
  -- function num : 0_10
  return (self._data)[key]
end

SceneController.GetSceneID = function(self)
  -- function num : 0_11
  return self._id
end

SceneController.GetLoadType = function(self)
  -- function num : 0_12
  return self._loadType
end

SceneController.IsSceneActiveAfterLoaded = function(self)
  -- function num : 0_13
  return self._isSceneActiveAfterLoaded
end

SceneController.IsRootGameObjectActiveAfterLoaded = function(self)
  -- function num : 0_14
  return self._isRootGameObjectActiveAfterLoaded
end

SceneController.GetSceneXMLAssetBundleAndAssetName = function(self)
  -- function num : 0_15
  return (self._info).mapAssetBundle, (self._info).mapAsset
end

SceneController.GetSceneName = function(self)
  -- function num : 0_16
  return (self._sceneRef):GetSceneName()
end

SceneController.GetSceneShowName = function(self)
  -- function num : 0_17
  return (self._sceneRef):GetSceneShowName()
end

SceneController.GetLoadHandler = function(self)
  -- function num : 0_18
  return (self._sceneRef):GetLoadHandler()
end

SceneController.SetRootGameObjectActive = function(self, isActive)
  -- function num : 0_19 , upvalues : GameSceneManager
  (GameSceneManager.SetSceneRootGameObjectActive)(self:GetSceneName(), isActive)
  if self.OnSceneRootGameObjectActiveChange then
    self:OnSceneRootGameObjectActiveChange(isActive)
  end
end

SceneController.IsSceneLoaded = function(self)
  -- function num : 0_20
  do return self._loadedProcess >= 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local LoadWeatherEffect = function(self, camera)
  -- function num : 0_21 , upvalues : TransformStaticFunctions, CWeatherConfig, CEffectRes, PrefabLoader, _ENV
  if camera == nil then
    return 
  end
  local weatherEffectGO = (TransformStaticFunctions.GetChild)(camera.gameObject, "Effect")
  if weatherEffectGO == nil then
    return 
  end
  local weatherInfo = CWeatherConfig:GetRecorder(self:GetSceneID())
  if weatherInfo == nil then
    return 
  end
  local weatherEffectRecord = CEffectRes:GetRecorder(weatherInfo.weatherEffect)
  if weatherEffectRecord == nil then
    return 
  end
  local effect = (PrefabLoader.LoadAndInstantiatePrefab)((EffectUtil.GetAssetBundleNameAndAssetName)(weatherInfo.weatherEffect))
  ;
  (TransformStaticFunctions.SetParent)(effect.transform, weatherEffectGO.transform, false)
end

local LoadDayNightLight = function(self)
  -- function num : 0_22 , upvalues : SwitchLightmap, SetDayNightLight, _ENV, CSceneLightConfig
  local root = (self._sceneRef):GetRootGameObject()
  local switchLightmap = (SwitchLightmap.GetSwitchLightmap)(root)
  local setDayNightLight = (SetDayNightLight.GetSetDayNightLight)(root)
  local isDay = ((SceneManager.IsInDay)())
  local isSwitchSuccess = nil
  self._isDay = isDay
  if switchLightmap ~= nil then
    if isDay then
      isSwitchSuccess = switchLightmap:SwitchToDay()
    else
      isSwitchSuccess = switchLightmap:SwitchToNight()
    end
    if setDayNightLight ~= nil then
      if setDayNightLight.DayLightRoot ~= nil then
        (setDayNightLight.DayLightRoot):SetActive(false)
      end
      if setDayNightLight.NightLightRoot ~= nil then
        (setDayNightLight.NightLightRoot):SetActive(false)
      end
    end
  end
  local sceneLightColor = CSceneLightConfig:GetRecorder(self:GetSceneID())
  if sceneLightColor ~= nil then
    if isDay then
      (SetDayNightLight.SetAmbientLight)(sceneLightColor.colorDay)
      if sceneLightColor.fogDay ~= "0" then
        (SetDayNightLight.SetFogColor)(sceneLightColor.fogDay)
      end
    else
      ;
      (SetDayNightLight.SetAmbientLight)(sceneLightColor.colorNight)
      if sceneLightColor.fogNight ~= "0" then
        (SetDayNightLight.SetFogColor)(sceneLightColor.fogNight)
      end
    end
  end
  if setDayNightLight then
    if isDay then
      setDayNightLight:SwitchToDay()
    else
      setDayNightLight:SwitchToNight()
    end
  end
end

local InitCinemachineSetting = function(self)
  -- function num : 0_23 , upvalues : CCinemachineSetting, _ENV
  local record = CCinemachineSetting:GetRecorder(self._id)
  if record == nil then
    return 
  end
  local cinemachinePath = record.cmName
  local cinemachineObject = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, cinemachinePath)
  ;
  (((((CS.PixelNeko).Lua).Cinemachine).CinemachineStateDrivenCameraStaticFunctions).SetBlendDuration)(cinemachineObject, record.time)
end

SceneController.Init = function(self)
  -- function num : 0_24 , upvalues : _ENV, GlobalCameras, LoadWeatherEffect, LoadDayNightLight, InitCinemachineSetting
  self._rootGameObject = (self._sceneRef):GetRootGameObject()
  local mainCamera = nil
  if (SceneManager.IsBattleScene)(self:GetSceneID()) then
    mainCamera = (GlobalCameras.GetCamera)("BattleMain")
  else
    mainCamera = (GlobalCameras.GetCamera)("Main")
  end
  self._isDay = true
  LoadWeatherEffect(self, mainCamera)
  LoadDayNightLight(self)
  InitCinemachineSetting(self)
end

SceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_25
end

SceneController.CallMethodAsync = function(self, method, ...)
  -- function num : 0_26 , upvalues : _ENV
  if self:IsSceneLoaded() then
    method(self, ...)
  else
    ;
    (table.insert)(self._cachedCallTable, {method = method, 
params = {self, ...}
})
  end
end

SceneController.OnDestroy = function(self)
  -- function num : 0_27 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SceneController.OnDisable = function(self)
  -- function num : 0_28
end

SceneController.OnEnable = function(self)
  -- function num : 0_29
end

SceneController.OnNavMeshBuildFinish = function(self)
  -- function num : 0_30
  self._navMeshReady = true
end

SceneController.IsNavMeshReady = function(self)
  -- function num : 0_31
  return self._navMeshReady
end

SceneController.PlayTimeline = function(self, id)
  -- function num : 0_32 , upvalues : _ENV
  local director = ((self._sceneRef).timelineObjects)[id]
  assert(director, "timeline " .. id .. " not found")
  director:Play()
end

SceneController.PlayTimelineBindObjectDynamically = function(self, timelineName, args)
  -- function num : 0_33 , upvalues : _ENV
  local root = (self._sceneRef):GetRootGameObject()
  ;
  (((((CS.PixelNeko).P1).TimeLine).TimelineManager).PlayTimelineBindObjectDynamically)(root, timelineName, args)
end

SceneController.GetPathResolver = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if not self._resolver then
    self._resolver = ((require("logic.scene.pathresolver")).Create)(self, self._sceneRef)
    return self._resolver
  end
end

return SceneController

