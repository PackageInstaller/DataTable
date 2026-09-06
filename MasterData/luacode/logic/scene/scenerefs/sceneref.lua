local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local Utility = CS.PixelNeko.P1.Common.Utility
local SceneRef = class("SceneRef")

function SceneRef:Ctor(loadHandler, record)
  self._info = nil
  self._loadHandler = nil
  self._rootGameObject = nil
end

function SceneRef:SetCtorParams(loadHandler, record)
  self._info = record
  self._sceneAssetBundleName = "scenes.unityassetbundle"
  self._loadHandler = loadHandler
end

function SceneRef:Init()
end

function SceneRef:GetSceneID()
  return self._info.id
end

function SceneRef:GetSceneControllerName()
  return "logic.scene.scenecontroller"
end

function SceneRef:GetSceneAssetBundleName()
  return self._sceneAssetBundleName
end

function SceneRef:GetSceneName()
  return self._info.asset
end

function SceneRef:GetSceneShowName()
  return TextManager.GetText(self._info.nameTextID)
end

function SceneRef:GetRootGameObject()
  return self._rootGameObject
end

function SceneRef:GetObject(name)
  return self[name]
end

function SceneRef:GetLoadHandler()
  return self._loadHandler
end

function SceneRef:OnDestroy()
  self._loadHandler = 0
end

function SceneRef:LoadSceneProgressNotificationHandler(userInfo)
end

function SceneRef:EndLoadSceneNotificationHandler(userInfo)
  self._rootGameObject = GameSceneManager.GetSceneRootGameObject(self:GetSceneName())
  GameSceneManager.AddBaseRootBehavior(self._rootGameObject)
  self:GetTimelineObjects()
end

function SceneRef:GetTimelineObjects()
  self.timelineObjects = {}
  local recorder = BeanManager.GetTableByName("timeline.ctimelineconfig")
  for _, i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.Name == self:GetSceneID() then
      local object = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, record.Path)
      if not object then
        LogError("timeline", "timeline not found: " .. i .. " @ " .. record.Name)
      end
      self.timelineObjects[i] = object:GetComponent("PlayableDirector")
    end
  end
  recorder = BeanManager.GetTableByName("timeline.ctimelinedynamic")
  for _, i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.Name == self:GetSceneID() then
      local object = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, record.Path)
      if not object then
        LogError("timeline", "dynamic timeline not found: " .. i .. " @ " .. record.Name)
      end
      self.timelineObjects[i] = object:GetComponent("PlayableDirector")
    end
  end
end

return SceneRef
