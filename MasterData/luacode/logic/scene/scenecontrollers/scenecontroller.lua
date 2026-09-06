local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local SerializedLightMapData = CS.PixelNeko.P1.Scene.SerializedLightMapData
local Utility = CS.PixelNeko.P1.Common.Utility
local GraphicsCommand = CS.PixelNeko.P1.Render.GraphicsCommand
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local SwitchLightmap = CS.PixelNeko.P1.Render.DayNightSwitch.SwitchLightmap
local SetDayNightLight = CS.PixelNeko.P1.Render.DayNightSwitch.SetDayNightLight
local CWeatherConfig = BeanManager.GetTableByName("scene.cweatherconfig")
local CEffectRes = BeanManager.GetTableByName("skill.ceffectres")
local CSceneLightConfig = BeanManager.GetTableByName("scene.cscenelightconfig")
local CCinemachineSetting = BeanManager.GetTableByName("scene.ccinemachinesetting")
local SceneController = class("SceneController")

local function SetProgress(self, isDone, process)
  if isDone then
    self._loadedProcess = 1
  else
    self._loadedProcess = process
  end
  local loadingDialog = DialogManager.GetDialog("loadingdialog")
  if loadingDialog == nil then
    return
  end
  loadingDialog:UpdateSceneProgress(self._id, process)
end

local function LoadSceneProgressNotificationHandler(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  self._sceneRef:LoadSceneProgressNotificationHandler(userInfo)
  SetProgress(self, false, userInfo.progress)
end

local function EndLoadSceneNotificationHandler(self, notification)
  GraphicsCommand.SetShadowDistance(15)
  self._sceneRef:EndLoadSceneNotificationHandler(self)
  self._sceneRef:Init()
  SetProgress(self, true, 1)
  LuaNotificationCenter.RemoveObserver(self, Common.n_LoadSceneProgress)
  LuaNotificationCenter.RemoveObserver(self, Common.n_EndLoadScene)
  self:Init()
  GameSceneManager.SetSceneRootGameObjectActive(self:GetSceneName(), self._isRootGameObjectActiveAfterLoaded)
  for k, v in pairs(self._cachedCallTable) do
    v.method(table.unpack(v.params))
  end
  self._cachedCallTable = nil
end

local function BeginUnLoadSceneNotificationHandler(self, notification)
  local sceneController = notification.userInfo
  if sceneController == nil then
    return
  end
  LuaNotificationCenter.RemoveObserver(self, Common.n_BeginUnLoadScene)
  self:OnDestroy()
  self._sceneRef:OnDestroy()
end

function SceneController:Ctor()
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
  LuaNotificationCenter.AddObserver(self, LoadSceneProgressNotificationHandler, Common.n_LoadSceneProgress, self)
  LuaNotificationCenter.AddObserver(self, EndLoadSceneNotificationHandler, Common.n_EndLoadScene, self)
  LuaNotificationCenter.AddObserver(self, BeginUnLoadSceneNotificationHandler, Common.n_BeginUnLoadScene, self)
  LuaNotificationCenter.AddObserver(self, self.OnNavMeshBuildFinish, Common.n_NavMeshBuildFinish, nil)
end

function SceneController:OnDestroyNotLoaded()
  LuaNotificationCenter.RemoveObserver(self)
end

function SceneController:SetCtorParams(sceneRef, record, isSceneActiveAfterLoaded, isRootGameObjectActiveAfterLoaded)
  self._info = record
  self._id = record.id
  self._loadType = record.loadType
  self._sceneRef = sceneRef
  self._isSceneActiveAfterLoaded = isSceneActiveAfterLoaded
  self._isRootGameObjectActiveAfterLoaded = isRootGameObjectActiveAfterLoaded
end

function SceneController:IsSceneHasDestroyed()
  return self._sceneHasDestroyed
end

function SceneController:SetSceneDestroyed()
  self._sceneHasDestroyed = true
end

function SceneController:SetData(key, value)
  if self._data == nil then
    self._data = {}
  end
  self._data[key] = value
end

function SceneController:GetData(key)
  return self._data[key]
end

function SceneController:GetSceneID()
  return self._id
end

function SceneController:GetLoadType()
  return self._loadType
end

function SceneController:IsSceneActiveAfterLoaded()
  return self._isSceneActiveAfterLoaded
end

function SceneController:IsRootGameObjectActiveAfterLoaded()
  return self._isRootGameObjectActiveAfterLoaded
end

function SceneController:GetSceneXMLAssetBundleAndAssetName()
  return self._info.mapAssetBundle, self._info.mapAsset
end

function SceneController:GetSceneName()
  return self._sceneRef:GetSceneName()
end

function SceneController:GetSceneShowName()
  return self._sceneRef:GetSceneShowName()
end

function SceneController:GetLoadHandler()
  return self._sceneRef:GetLoadHandler()
end

function SceneController:SetRootGameObjectActive(isActive)
  GameSceneManager.SetSceneRootGameObjectActive(self:GetSceneName(), isActive)
  if self.OnSceneRootGameObjectActiveChange then
    self:OnSceneRootGameObjectActiveChange(isActive)
  end
end

function SceneController:IsSceneLoaded()
  return self._loadedProcess >= 1
end

local function LoadWeatherEffect(self, camera)
  if camera == nil then
    return
  end
  local weatherEffectGO = TransformStaticFunctions.GetChild(camera.gameObject, "Effect")
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
  local effect = PrefabLoader.LoadAndInstantiatePrefab(EffectUtil.GetAssetBundleNameAndAssetName(weatherInfo.weatherEffect))
  TransformStaticFunctions.SetParent(effect.transform, weatherEffectGO.transform, false)
end

local function LoadDayNightLight(self)
  local root = self._sceneRef:GetRootGameObject()
  local switchLightmap = SwitchLightmap.GetSwitchLightmap(root)
  local setDayNightLight = SetDayNightLight.GetSetDayNightLight(root)
  local isDay = SceneManager.IsInDay()
  local isSwitchSuccess
  self._isDay = isDay
  if switchLightmap ~= nil then
    if isDay then
      isSwitchSuccess = switchLightmap:SwitchToDay()
    else
      isSwitchSuccess = switchLightmap:SwitchToNight()
    end
    if setDayNightLight ~= nil then
      if setDayNightLight.DayLightRoot ~= nil then
        setDayNightLight.DayLightRoot:SetActive(false)
      end
      if setDayNightLight.NightLightRoot ~= nil then
        setDayNightLight.NightLightRoot:SetActive(false)
      end
    end
  end
  local sceneLightColor = CSceneLightConfig:GetRecorder(self:GetSceneID())
  if sceneLightColor ~= nil then
    if isDay then
      SetDayNightLight.SetAmbientLight(sceneLightColor.colorDay)
      if sceneLightColor.fogDay ~= "0" then
        SetDayNightLight.SetFogColor(sceneLightColor.fogDay)
      end
    else
      SetDayNightLight.SetAmbientLight(sceneLightColor.colorNight)
      if sceneLightColor.fogNight ~= "0" then
        SetDayNightLight.SetFogColor(sceneLightColor.fogNight)
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

local function InitCinemachineSetting(self)
  local record = CCinemachineSetting:GetRecorder(self._id)
  if record == nil then
    return
  end
  local cinemachinePath = record.cmName
  local cinemachineObject = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, cinemachinePath)
  CS.PixelNeko.Lua.Cinemachine.CinemachineStateDrivenCameraStaticFunctions.SetBlendDuration(cinemachineObject, record.time)
end

function SceneController:Init()
  self._rootGameObject = self._sceneRef:GetRootGameObject()
  local mainCamera
  if SceneManager.IsBattleScene(self:GetSceneID()) then
    mainCamera = GlobalCameras.GetCamera("BattleMain")
  else
    mainCamera = GlobalCameras.GetCamera("Main")
  end
  self._isDay = true
  LoadWeatherEffect(self, mainCamera)
  LoadDayNightLight(self)
  InitCinemachineSetting(self)
end

function SceneController:Update(deltaTime, unscaleDeltaTime)
end

function SceneController:CallMethodAsync(method, ...)
  if self:IsSceneLoaded() then
    method(self, ...)
  else
    table.insert(self._cachedCallTable, {
      method = method,
      params = {
        self,
        ...
      }
    })
  end
end

function SceneController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SceneController:OnDisable()
end

function SceneController:OnEnable()
end

function SceneController:OnNavMeshBuildFinish()
  self._navMeshReady = true
end

function SceneController:IsNavMeshReady()
  return self._navMeshReady
end

function SceneController:PlayTimeline(id)
  local director = self._sceneRef.timelineObjects[id]
  assert(director, "timeline " .. id .. " not found")
  director:Play()
end

function SceneController:PlayTimelineBindObjectDynamically(timelineName, args)
  local root = self._sceneRef:GetRootGameObject()
  CS.PixelNeko.P1.TimeLine.TimelineManager.PlayTimelineBindObjectDynamically(root, timelineName, args)
end

function SceneController:GetPathResolver()
  self._resolver = self._resolver or require("logic.scene.pathresolver").Create(self, self._sceneRef)
  return self._resolver
end

return SceneController
