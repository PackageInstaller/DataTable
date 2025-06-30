-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/newscenemanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local Utility = (((CS.PixelNeko).P1).Common).Utility
local SceneManager = {}
SceneManager.LoadType = {Base = 0, CommonDungeon = 1, CommonDungeonBattle = 2, BossBattle = 3, InGame = 4, FirstScene = 5, HandBook = 6, SwimSuit = 7, SwimSuitEchoes = 8}
local _sceneControllerLoadedTable = {}
local _sceneControllerTable = {}
local _loadHandlerIDMapTable = {}
local _currentActiveSceneController = nil
local LoadHandlerToID = function(handler)
  -- function num : 0_0 , upvalues : _loadHandlerIDMapTable
  return _loadHandlerIDMapTable[handler]
end

local MapLoadHanlderID = function(handler, id)
  -- function num : 0_1 , upvalues : _loadHandlerIDMapTable
  _loadHandlerIDMapTable[handler] = id
end

local UnloadLoadHandler = function(handler)
  -- function num : 0_2 , upvalues : _loadHandlerIDMapTable
  _loadHandlerIDMapTable[handler] = nil
end

local UnloadByLoadSingle = function()
  -- function num : 0_3 , upvalues : _ENV, _sceneControllerLoadedTable, _sceneControllerTable, UnloadLoadHandler
  for k,v in pairs(_sceneControllerLoadedTable) do
    _sceneControllerTable[k] = nil
    UnloadLoadHandler(v:GetLoadHandler())
    v:OnDestroy()
  end
  _sceneControllerLoadedTable = {}
  for k,v in pairs(_sceneControllerTable) do
    v:SetSceneDestroyed()
  end
end

local AddSceneController = function(sceneController)
  -- function num : 0_4 , upvalues : _sceneControllerTable
  _sceneControllerTable[sceneController:GetSceneID()] = sceneController
end

local AddSceneControllerLoaded = function(sceneController)
  -- function num : 0_5 , upvalues : _sceneControllerLoadedTable
  _sceneControllerLoadedTable[sceneController:GetSceneID()] = sceneController
end

local RemoveSceneController = function(id)
  -- function num : 0_6 , upvalues : _sceneControllerTable, _sceneControllerLoadedTable
  _sceneControllerTable[id] = nil
  _sceneControllerLoadedTable[id] = nil
end

SceneManager.IsBattleScene = function(id)
  -- function num : 0_7 , upvalues : cSceneInfoStatic, _ENV, SceneManager
  local sceneInfo = cSceneInfoStatic:GetRecorder(id)
  if sceneInfo == nil then
    LogError("SceneManager", "IsBattleScene id error : " .. id)
  end
  local loadType = sceneInfo.loadType
  if loadType == (SceneManager.LoadType).CommonDungeonBattle or loadType == (SceneManager.LoadType).BossBattle then
    return true
  end
  return false
end

SceneManager.GetNeedLoadScenes = function(sceneID)
  -- function num : 0_8 , upvalues : cSceneInfoStatic, _ENV, SceneManager
  local sceneInfoRecord = cSceneInfoStatic:GetRecorder(sceneID)
  local scenes = {}
  if sceneInfoRecord == nil then
    LogError("SceneManager", "scene " .. sceneID .. "not found")
    return nil
  end
  -- DECOMPILER ERROR at PC27: Unhandled construct in 'MakeBoolean' P1

  if (SceneManager.IsInDay)() and sceneInfoRecord.dayBattleScene ~= 0 then
    (table.insert)(scenes, sceneInfoRecord.dayBattleScene)
  end
  if sceneInfoRecord.nightBattleScene ~= 0 then
    (table.insert)(scenes, sceneInfoRecord.nightBattleScene)
  end
  if #scenes ~= 0 then
    return scenes
  end
  return sceneInfoRecord.needLoad
end

SceneManager.LoadScene = function(id, isSingle, doPostProcess, isSceneActiveAfterLoaded, isRootGameObjectActiveAfterLoaded)
  -- function num : 0_9 , upvalues : cSceneInfoStatic, _ENV, UnloadByLoadSingle, GameSceneManager, MapLoadHanlderID, AddSceneController
  local sceneInfoRecord = (cSceneInfoStatic:GetRecorder(id))
  local controllerObject = nil
  if sceneInfoRecord == nil then
    LogError("SceneManager", "id error")
    return 
  end
  local loadHandler = nil
  if isSingle then
    UnloadByLoadSingle()
    loadHandler = (GameSceneManager.LoadSingleScene)("scenes/" .. (string.lower)(sceneInfoRecord.asset) .. ".unityassetbundle", sceneInfoRecord.asset)
  else
    loadHandler = (GameSceneManager.LoadAdditiveScene)("scenes/" .. (string.lower)(sceneInfoRecord.asset) .. ".unityassetbundle", sceneInfoRecord.asset)
  end
  local refClass = require("logic.scene.scenerefs." .. sceneInfoRecord.sceneRef)
  local controllerClass = require("logic.scene.scenecontrollers." .. sceneInfoRecord.sceneController)
  local refObject = (refClass.Create)()
  refObject:SetCtorParams(loadHandler, sceneInfoRecord)
  controllerObject = (controllerClass.Create)()
  controllerObject:SetCtorParams(refObject, sceneInfoRecord, isSingle or isSceneActiveAfterLoaded, isSingle or isRootGameObjectActiveAfterLoaded)
  MapLoadHanlderID(loadHandler, id)
  AddSceneController(controllerObject)
  return controllerObject
end

SceneManager.UnloadScene = function(id)
  -- function num : 0_10 , upvalues : _sceneControllerLoadedTable, _sceneControllerTable, UnloadLoadHandler, GameSceneManager
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
    ;
    (GameSceneManager.ReleaseScene)(handler)
  end
end

SceneManager.Update = function(deltaTime, unscaleDeltaTime)
  -- function num : 0_11 , upvalues : _ENV, _sceneControllerLoadedTable
  for k,v in pairs(_sceneControllerLoadedTable) do
    v:Update(deltaTime, unscaleDeltaTime)
  end
end

SceneManager.GetSceneControllerByLoadType = function(loadType)
  -- function num : 0_12 , upvalues : _ENV, _sceneControllerTable
  for k,v in pairs(_sceneControllerTable) do
    if v:GetLoadType() == loadType then
      return v
    end
  end
  return nil
end

SceneManager.GetSceneControllerListByLoadType = function(loadType)
  -- function num : 0_13 , upvalues : _ENV, _sceneControllerTable
  local list = {}
  for k,v in pairs(_sceneControllerTable) do
    if v:GetLoadType() == loadType then
      (table.insert)(list, v)
    end
  end
  return list
end

SceneManager.GetSceneControllerByID = function(id)
  -- function num : 0_14 , upvalues : _sceneControllerTable
  return _sceneControllerTable[id]
end

SceneManager.SetSceneActive = function(sceneController)
  -- function num : 0_15 , upvalues : _currentActiveSceneController, GameSceneManager
  if _currentActiveSceneController then
    _currentActiveSceneController:OnDisable()
  end
  ;
  (GameSceneManager.SetSceneActive)(sceneController:GetSceneName())
  _currentActiveSceneController = sceneController
  _currentActiveSceneController:OnEnable()
end

local _forceDayNight = nil
SceneManager.SetForceDay = function(value)
  -- function num : 0_16 , upvalues : _forceDayNight
  _forceDayNight = value
end

SceneManager.IsInDay = function()
  -- function num : 0_17 , upvalues : _forceDayNight, CVarConfig, _ENV
  if _forceDayNight == 1 then
    return true
  else
    if _forceDayNight == 0 then
      return false
    end
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
  local hour = tonumber((os.date)("%H"))
  do return dayTime <= hour and hour < nightTime end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local SceneSingleLoadCallBack = function(sceneName, isDone, progress, handler)
  -- function num : 0_18 , upvalues : LoadHandlerToID, _sceneControllerTable, AddSceneControllerLoaded, _currentActiveSceneController, _ENV
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
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_EndLoadScene, sceneController, sceneController)
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LoadSceneProgress, sceneController, {progress = progress})
  end
end

local SceneAdditiveLoadCallBack = function(sceneName, isDone, progress, handler)
  -- function num : 0_19 , upvalues : LoadHandlerToID, _sceneControllerTable, GameSceneManager, AddSceneControllerLoaded, _ENV, _currentActiveSceneController
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
    (GameSceneManager.SetSceneActive)(sceneController:GetSceneName())
    AddSceneControllerLoaded(sceneController)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_EndLoadScene, sceneController, sceneController)
    if sceneController:IsSceneActiveAfterLoaded() then
      _currentActiveSceneController = sceneController
      ;
      (GameSceneManager.SetSceneActive)(sceneController:GetSceneName())
    else
      if _currentActiveSceneController then
        (GameSceneManager.SetSceneActive)(_currentActiveSceneController:GetSceneName())
      end
    end
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LoadSceneProgress, sceneController, {progress = progress})
  end
end

;
(GameSceneManager.SetLuaLoadSingleSceneCallBack)(SceneSingleLoadCallBack)
;
(GameSceneManager.SetLuaLoadAdditiveSceneCallBack)(SceneAdditiveLoadCallBack)
return SceneManager

