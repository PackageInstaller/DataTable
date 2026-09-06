local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local IceGoddessSceneRef = class("IceGoddessSceneRef", NewBattleSceneRef)

function IceGoddessSceneRef:Init()
  IceGoddessSceneRef.super.Init(self)
  self._iceBsr_object = TransformStaticFunctions.GetChild(self._rootGameObject, "GameObject")
  self._sceneParticlesObj = TransformStaticFunctions.GetChild(self._rootGameObject, "SceneParticles")
  local rootTransform = self._rootGameObject.transform
  self._timeLine1Transform = rootTransform:Find("W2_Battle_boss_01")
  self._timeLine1 = TimelineManager.GetPlayableDirector(self._timeLine1Transform.gameObject)
  self._battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._storyObj = TransformStaticFunctions.GetChild(self._rootGameObject, "Story_1")
end

function IceGoddessSceneRef:GetBattleObject()
  return self._iceBsr_object
end

function IceGoddessSceneRef:GetTimeLine1()
  return self._timeLine1
end

function IceGoddessSceneRef:GetTimeLine1Object()
  return self._timeLine1Transform.gameObject
end

function IceGoddessSceneRef:GetBattleMainCamera()
  return self._battleCamera
end

function IceGoddessSceneRef:GetStoryObject()
  return self._storyObj
end

function IceGoddessSceneRef:GetSceneParticlesObject()
  return self._sceneParticlesObj
end

return IceGoddessSceneRef
