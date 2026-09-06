local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local SimolaSceneRef = class("SimolaSceneRef", NewBattleSceneRef)

function SimolaSceneRef:Init()
  SimolaSceneRef.super.Init(self)
  self._sceneParticlesObj = TransformStaticFunctions.GetChild(self._rootGameObject, "SceneParticles")
  local rootTransform = self._rootGameObject.transform
  self._timeLine1Transform = rootTransform:Find("W3_Battle_day2_boss")
  self._timeLine1 = TimelineManager.GetPlayableDirector(self._timeLine1Transform.gameObject)
  self._battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._storyObj = TransformStaticFunctions.GetChild(self._rootGameObject, "Story")
end

function SimolaSceneRef:GetTimeLine1()
  return self._timeLine1
end

function SimolaSceneRef:GetTimeLine1Object()
  return self._timeLine1Transform.gameObject
end

function SimolaSceneRef:GetBattleMainCamera()
  return self._battleCamera
end

function SimolaSceneRef:GetStoryObject()
  return self._storyObj
end

function SimolaSceneRef:GetSceneParticlesObject()
  return self._sceneParticlesObj
end

return SimolaSceneRef
