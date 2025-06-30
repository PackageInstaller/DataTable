-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/sceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local Utility = (((CS.PixelNeko).P1).Common).Utility
local SceneRef = class("SceneRef")
SceneRef.Ctor = function(self, loadHandler, record)
  -- function num : 0_0
  self._info = nil
  self._loadHandler = nil
  self._rootGameObject = nil
end

SceneRef.SetCtorParams = function(self, loadHandler, record)
  -- function num : 0_1
  self._info = record
  self._sceneAssetBundleName = "scenes.unityassetbundle"
  self._loadHandler = loadHandler
end

SceneRef.Init = function(self)
  -- function num : 0_2
end

SceneRef.GetSceneID = function(self)
  -- function num : 0_3
  return (self._info).id
end

SceneRef.GetSceneControllerName = function(self)
  -- function num : 0_4
  return "logic.scene.scenecontroller"
end

SceneRef.GetSceneAssetBundleName = function(self)
  -- function num : 0_5
  return self._sceneAssetBundleName
end

SceneRef.GetSceneName = function(self)
  -- function num : 0_6
  return (self._info).asset
end

SceneRef.GetSceneShowName = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (TextManager.GetText)((self._info).nameTextID)
end

SceneRef.GetRootGameObject = function(self)
  -- function num : 0_8
  return self._rootGameObject
end

SceneRef.GetObject = function(self, name)
  -- function num : 0_9
  return self[name]
end

SceneRef.GetLoadHandler = function(self)
  -- function num : 0_10
  return self._loadHandler
end

SceneRef.OnDestroy = function(self)
  -- function num : 0_11
  self._loadHandler = 0
end

SceneRef.LoadSceneProgressNotificationHandler = function(self, userInfo)
  -- function num : 0_12
end

SceneRef.EndLoadSceneNotificationHandler = function(self, userInfo)
  -- function num : 0_13 , upvalues : GameSceneManager
  self._rootGameObject = (GameSceneManager.GetSceneRootGameObject)(self:GetSceneName())
  ;
  (GameSceneManager.AddBaseRootBehavior)(self._rootGameObject)
  self:GetTimelineObjects()
end

SceneRef.GetTimelineObjects = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self.timelineObjects = {}
  local recorder = (BeanManager.GetTableByName)("timeline.ctimelineconfig")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.Name == self:GetSceneID() then
      local object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, record.Path)
      if not object then
        LogError("timeline", "timeline not found: " .. i .. " @ " .. record.Name)
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.timelineObjects)[i] = object:GetComponent("PlayableDirector")
    end
  end
  recorder = (BeanManager.GetTableByName)("timeline.ctimelinedynamic")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.Name == self:GetSceneID() then
      local object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, record.Path)
      if not object then
        LogError("timeline", "dynamic timeline not found: " .. i .. " @ " .. record.Name)
      end
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.timelineObjects)[i] = object:GetComponent("PlayableDirector")
    end
  end
end

return SceneRef

