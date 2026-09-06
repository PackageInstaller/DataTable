local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local cSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local cSceneJump = BeanManager.GetTableByName("scene.cscenejump")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local Utility = CS.PixelNeko.P1.Common.Utility
local SceneManager = {}
SceneManager.LoadType = {
  Base = 0,
  CommonDungeon = 1,
  CommonDungeonBattle = 2,
  BossBattle = 3,
  InGame = 4,
  FirstScene = 5,
  HandBook = 6,
  SwimSuit = 7,
  SwimSuitEchoes = 8
}
local _sceneControllerLoadedTable = {}
local _sceneControllerTable = {}
local _loadHandlerIDMapTable = {}
local _currentActiveSceneController

local function LoadHandlerToID(handler)
  return _loadHandlerIDMapTable[handler]
end

local function MapLoadHanlderID(handler, id)
  _loadHandlerIDMapTable[handler] = id
end

local function UnloadLoadHandler(handler)
  _loadHandlerIDMapTable[handler] = nil
end

local function UnloadByLoadSingle()
  for k, v in pairs(_sceneControllerLoadedTable) do
    _sceneControllerTable[k] = nil
    UnloadLoadHandler(v:GetLoadHandler())
    v:OnDestroy()
  end
  _sceneControllerLoadedTable = {}
  for k, v in pairs(_sceneControllerTable) do
    v:SetSceneDestroyed()
  end
end

local function AddSceneController(sceneController)
  _sceneControllerTable[sceneController:GetSceneID()] = sceneController
end

local function AddSceneControllerLoaded(sceneController)
  _sceneControllerLoadedTable[sceneController:GetSceneID()] = sceneController
end

local function RemoveSceneController(id)
  _sceneControllerTable[id] = nil
  _sceneControllerLoadedTable[id] = nil
end

function SceneManager.IsBattleScene(id)
  local sceneInfo = cSceneInfoStatic:GetRecorder(id)
  if sceneInfo == nil then
    LogError("SceneManager", "IsBattleScene id error : " .. id)
  end
  local loadType = sceneInfo.loadType
  if loadType == SceneManager.LoadType.CommonDungeonBattle or loadType == SceneManager.LoadType.BossBattle then
    return true
  end
  return false
end

function SceneManager.GetNeedLoadScenes(sceneID)
  local sceneInfoRecord = cSceneInfoStatic:GetRecorder(sceneID)
  local scenes = {}
  if sceneInfoRecord == nil then
    LogError("SceneManager", "scene " .. sceneID .. "not found")
    return nil
  end
  if SceneManager.IsInDay() then
    if sceneInfoRecord.dayBattleScene ~= 0 then
      table.insert(scenes, sceneInfoRecord.dayBattleScene)
    end
  elseif sceneInfoRecord.nightBattleScene ~= 0 then
    table.insert(scenes, sceneInfoRecord.nightBattleScene)
  end
  if #scenes ~= 0 then
    return scenes
  end
  return sceneInfoRecord.needLoad
end

function SceneManager.LoadScene(id, isSingle, doPostProcess, isSceneActiveAfterLoaded, isRootGameObjectActiveAfterLoaded)
  local sceneInfoRecord = cSceneInfoStatic:GetRecorder(id)
  local controllerObject
  if sceneInfoRecord == nil then
    LogError("SceneManager", "id error")
    return
  end
  local loadHandler
  if isSingle then
    UnloadByLoadSingle()
    loadHandler = GameSceneManager.LoadSingleScene("scenes/" .. string.lower(sceneInfoRecord.asset) .. ".unityassetbundle", sceneInfoRecord.asset)
  else
    loadHandler = GameSceneManager.LoadAdditiveScene("scenes/" .. string.lower(sceneInfoRecord.asset) .. ".unityassetbundle", sceneInfoRecord.asset)
  end
  local refClass = require("logic.scene.scenerefs." .. sceneInfoRecord.sceneRef)
  local controllerClass = require("logic.scene.scenecontrollers." .. sceneInfoRecord.sceneController)
  local refObject = refClass.Create()
  refObject:SetCtorParams(loadHandler, sceneInfoRecord)
  controllerObject = controllerClass.Create()
  controllerObject:SetCtorParams(refObject, sceneInfoRecord, isSingle or isSceneActiveAfterLoaded, isSingle or isRootGameObjectActiveAfterLoaded)
  MapLoadHanlderID(loadHandler, id)
  AddSceneController(controllerObject)
  return controllerObject
end

function SceneManager.UnloadScene(id)
  local loadedSceneController = _sceneControllerLoadedTable[id]
  if loadedSceneController then
    loadedSceneController:OnDestroy()
  end
  local sceneController = _sceneControllerTable[id]
  if sceneController then
    _sceneControllerTable[id] = nil
    _sceneControllerLoadedTable[id] = nil
    local handler = sceneController:GetLoadHandler()
    UnloadLoadHandler(handler)
    sceneController:SetSceneDestroyed()
    GameSceneManager.ReleaseScene(handler)
  end
end

function SceneManager.Update(deltaTime, unscaleDeltaTime)
  for k, v in pairs(_sceneControllerLoadedTable) do
    v:Update(deltaTime, unscaleDeltaTime)
  end
end

function SceneManager.GetSceneControllerByLoadType(loadType)
  for k, v in pairs(_sceneControllerTable) do
    if v:GetLoadType() == loadType then
      return v
    end
  end
  return nil
end

function SceneManager.GetSceneControllerListByLoadType(loadType)
  local list = {}
  for k, v in pairs(_sceneControllerTable) do
    if v:GetLoadType() == loadType then
      table.insert(list, v)
    end
  end
  return list
end

function SceneManager.GetSceneControllerByID(id)
  return _sceneControllerTable[id]
end

function SceneManager.SetSceneActive(sceneController)
  if _currentActiveSceneController then
    _currentActiveSceneController:OnDisable()
  end
  GameSceneManager.SetSceneActive(sceneController:GetSceneName())
  _currentActiveSceneController = sceneController
  _currentActiveSceneController:OnEnable()
end

local _forceDayNight

function SceneManager.SetForceDay(value)
  _forceDayNight = value
end

function SceneManager.IsInDay()
  if _forceDayNight == 1 then
    return true
  elseif _forceDayNight == 0 then
    return false
  end
  local dayTimeRecord = CVarConfig:GetRecorder(24)
  local nightTimeRecord = CVarConfig:GetRecorder(25)
  if dayTimeRecord == nil or nightTimeRecord == nil then
    return false
  end
  local dayTime = tonumber(dayTimeRecord.Value)
  local nightTime = tonumber(nightTimeRecord.Value)
  if dayTime == nil or nightTime == nil then
    return false
  end
  local hour = tonumber(os.date("%H"))
  return dayTime <= hour and nightTime > hour
end

local function SceneSingleLoadCallBack(sceneName, isDone, progress, handler)
  local id = LoadHandlerToID(handler)
  local sceneController = _sceneControllerTable[id]
  if sceneController == nil then
    return
  end
  if sceneController:IsSceneHasDestroyed() then
    sceneController:OnDestroyNotLoaded()
    return
  end
  if isDone then
    AddSceneControllerLoaded(sceneController)
    _currentActiveSceneController = sceneController
    LuaNotificationCenter.PostNotification(Common.n_EndLoadScene, sceneController, sceneController)
  else
    LuaNotificationCenter.PostNotification(Common.n_LoadSceneProgress, sceneController, {progress = progress})
  end
end

local function SceneAdditiveLoadCallBack(sceneName, isDone, progress, handler)
  local id = LoadHandlerToID(handler)
  local sceneController = _sceneControllerTable[id]
  if sceneController == nil then
    return
  end
  if sceneController:IsSceneHasDestroyed() then
    sceneController:OnDestroyNotLoaded()
    return
  end
  if isDone then
    GameSceneManager.SetSceneActive(sceneController:GetSceneName())
    AddSceneControllerLoaded(sceneController)
    LuaNotificationCenter.PostNotification(Common.n_EndLoadScene, sceneController, sceneController)
    if sceneController:IsSceneActiveAfterLoaded() then
      _currentActiveSceneController = sceneController
      GameSceneManager.SetSceneActive(sceneController:GetSceneName())
    elseif _currentActiveSceneController then
      GameSceneManager.SetSceneActive(_currentActiveSceneController:GetSceneName())
    end
  else
    LuaNotificationCenter.PostNotification(Common.n_LoadSceneProgress, sceneController, {progress = progress})
  end
end

GameSceneManager.SetLuaLoadSingleSceneCallBack(SceneSingleLoadCallBack)
GameSceneManager.SetLuaLoadAdditiveSceneCallBack(SceneAdditiveLoadCallBack)
return SceneManager
