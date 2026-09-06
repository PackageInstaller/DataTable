local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local SoradiusSceneRef = class("SoradiusSceneRef", NewBattleSceneRef)

function SoradiusSceneRef:Init()
  SoradiusSceneRef.super.Init(self)
  self._sceneParticlesObj = TransformStaticFunctions.GetChild(self._rootGameObject, "SceneParticles")
  local rootTransform = self._rootGameObject.transform
  self._boss_start_timelineTransform = rootTransform:Find("W3_Boss_Start")
  self._boss_change1_timelineTransform = rootTransform:Find("W3_Boss_Change1")
  self._boss_change2_timelineTransform = rootTransform:Find("W3_Boss_Change2")
  self._boss_death_timelineTransform = rootTransform:Find("W3_Boss_Death")
  self._boss_start_timeline = TimelineManager.GetPlayableDirector(self._boss_start_timelineTransform.gameObject)
  self._boss_change1_timeline = TimelineManager.GetPlayableDirector(self._boss_change1_timelineTransform.gameObject)
  self._boss_change2_timeline = TimelineManager.GetPlayableDirector(self._boss_change2_timelineTransform.gameObject)
  self._boss_death_timeline = TimelineManager.GetPlayableDirector(self._boss_death_timelineTransform.gameObject)
  self._battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._step1Obj = TransformStaticFunctions.GetChild(self._rootGameObject, "Step1")
  self._step2Obj = TransformStaticFunctions.GetChild(self._rootGameObject, "Step2")
  self._step3Obj = TransformStaticFunctions.GetChild(self._rootGameObject, "Step3")
  self._storyObj = TransformStaticFunctions.GetChild(self._rootGameObject, "Story_1")
  self._storyObjBoss = TransformStaticFunctions.GetChild(self._rootGameObject, "Story_1/boss_w3_01")
  self._step2ObjBoss = TransformStaticFunctions.GetChild(self._rootGameObject, "Step2/boss_w3_02")
  self._step3ObjBoss = TransformStaticFunctions.GetChild(self._rootGameObject, "Step3/boss_w3_03")
end

function SoradiusSceneRef:GetStartTimeLine()
  return self._boss_start_timeline
end

function SoradiusSceneRef:GetChange1TimeLine()
  return self._boss_change1_timeline
end

function SoradiusSceneRef:GetChange2TimeLine()
  return self._boss_change2_timeline
end

function SoradiusSceneRef:GetDeathTimeLine()
  return self._boss_death_timeline
end

function SoradiusSceneRef:GetStartTimeLineObject()
  return self._boss_start_timelineTransform.gameObject
end

function SoradiusSceneRef:GetChange1TimeLineObject()
  return self._boss_change1_timelineTransform.gameObject
end

function SoradiusSceneRef:GetChange2TimeLineObject()
  return self._boss_change2_timelineTransform.gameObject
end

function SoradiusSceneRef:GetDeathTimeLineObject()
  return self._boss_death_timelineTransform.gameObject
end

function SoradiusSceneRef:GetBattleMainCamera()
  return self._battleCamera
end

function SoradiusSceneRef:GetStep1Object()
  return self._step1Obj
end

function SoradiusSceneRef:GetStep2Object()
  return self._step2Obj
end

function SoradiusSceneRef:GetStep3Object()
  return self._step3Obj
end

function SoradiusSceneRef:GetStoryObject()
  return self._storyObj
end

function SoradiusSceneRef:GetStoryObjectBoss()
  return self._storyObjBoss
end

function SoradiusSceneRef:GetStep2ObjectBoss()
  return self._step2ObjBoss
end

function SoradiusSceneRef:GetStep3ObjectBoss()
  return self._step3ObjBoss
end

function SoradiusSceneRef:GetSceneParticlesObject()
  return self._sceneParticlesObj
end

return SoradiusSceneRef
