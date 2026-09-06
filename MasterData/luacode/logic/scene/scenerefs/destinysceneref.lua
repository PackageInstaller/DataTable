local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local DestinySceneRef = class("DestinySceneRef", NewBattleSceneRef)

function DestinySceneRef:Init()
  DestinySceneRef.super.Init(self)
  self._sceneParticlesObj = TransformStaticFunctions.GetChild(self._rootGameObject, "SceneParticles")
  local rootTransform = self._rootGameObject.transform
  self._boss_start_timelineTransform = rootTransform:Find("Base_Fragment_05_Boss_BattleBefore")
  self._boss_change1_timelineTransform = rootTransform:Find("Base_Fragment_05_Boss_PhaseChange")
  self._boss_start_timeline = TimelineManager.GetPlayableDirector(self._boss_start_timelineTransform.gameObject)
  self._boss_change1_timeline = TimelineManager.GetPlayableDirector(self._boss_change1_timelineTransform.gameObject)
  self._battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._step1Obj = TransformStaticFunctions.GetChild(self._rootGameObject, "Step1")
  self._storyObj = TransformStaticFunctions.GetChild(self._rootGameObject, "BeforeBattle")
end

function DestinySceneRef:GetStartTimeLine()
  return self._boss_start_timeline
end

function DestinySceneRef:GetChange1TimeLine()
  return self._boss_change1_timeline
end

function DestinySceneRef:GetStartTimeLineObject()
  return self._boss_start_timelineTransform.gameObject
end

function DestinySceneRef:GetChange1TimeLineObject()
  return self._boss_change1_timelineTransform.gameObject
end

function DestinySceneRef:GetBattleMainCamera()
  return self._battleCamera
end

function DestinySceneRef:GetStep1Object()
  return self._step1Obj
end

function DestinySceneRef:GetStoryObject()
  return self._storyObj
end

function DestinySceneRef:GetSceneParticlesObject()
  return self._sceneParticlesObj
end

return DestinySceneRef
