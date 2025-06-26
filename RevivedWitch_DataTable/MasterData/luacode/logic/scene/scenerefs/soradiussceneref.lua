-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/soradiussceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local SoradiusSceneRef = class("SoradiusSceneRef", NewBattleSceneRef)
SoradiusSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : SoradiusSceneRef, TransformStaticFunctions, TimelineManager
  ((SoradiusSceneRef.super).Init)(self)
  self._sceneParticlesObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SceneParticles")
  local rootTransform = (self._rootGameObject).transform
  self._boss_start_timelineTransform = rootTransform:Find("W3_Boss_Start")
  self._boss_change1_timelineTransform = rootTransform:Find("W3_Boss_Change1")
  self._boss_change2_timelineTransform = rootTransform:Find("W3_Boss_Change2")
  self._boss_death_timelineTransform = rootTransform:Find("W3_Boss_Death")
  self._boss_start_timeline = (TimelineManager.GetPlayableDirector)((self._boss_start_timelineTransform).gameObject)
  self._boss_change1_timeline = (TimelineManager.GetPlayableDirector)((self._boss_change1_timelineTransform).gameObject)
  self._boss_change2_timeline = (TimelineManager.GetPlayableDirector)((self._boss_change2_timelineTransform).gameObject)
  self._boss_death_timeline = (TimelineManager.GetPlayableDirector)((self._boss_death_timelineTransform).gameObject)
  self._battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._step1Obj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step1")
  self._step2Obj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step2")
  self._step3Obj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step3")
  self._storyObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story_1")
  self._storyObjBoss = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story_1/boss_w3_01")
  self._step2ObjBoss = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step2/boss_w3_02")
  self._step3ObjBoss = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step3/boss_w3_03")
end

SoradiusSceneRef.GetStartTimeLine = function(self)
  -- function num : 0_1
  return self._boss_start_timeline
end

SoradiusSceneRef.GetChange1TimeLine = function(self)
  -- function num : 0_2
  return self._boss_change1_timeline
end

SoradiusSceneRef.GetChange2TimeLine = function(self)
  -- function num : 0_3
  return self._boss_change2_timeline
end

SoradiusSceneRef.GetDeathTimeLine = function(self)
  -- function num : 0_4
  return self._boss_death_timeline
end

SoradiusSceneRef.GetStartTimeLineObject = function(self)
  -- function num : 0_5
  return (self._boss_start_timelineTransform).gameObject
end

SoradiusSceneRef.GetChange1TimeLineObject = function(self)
  -- function num : 0_6
  return (self._boss_change1_timelineTransform).gameObject
end

SoradiusSceneRef.GetChange2TimeLineObject = function(self)
  -- function num : 0_7
  return (self._boss_change2_timelineTransform).gameObject
end

SoradiusSceneRef.GetDeathTimeLineObject = function(self)
  -- function num : 0_8
  return (self._boss_death_timelineTransform).gameObject
end

SoradiusSceneRef.GetBattleMainCamera = function(self)
  -- function num : 0_9
  return self._battleCamera
end

SoradiusSceneRef.GetStep1Object = function(self)
  -- function num : 0_10
  return self._step1Obj
end

SoradiusSceneRef.GetStep2Object = function(self)
  -- function num : 0_11
  return self._step2Obj
end

SoradiusSceneRef.GetStep3Object = function(self)
  -- function num : 0_12
  return self._step3Obj
end

SoradiusSceneRef.GetStoryObject = function(self)
  -- function num : 0_13
  return self._storyObj
end

SoradiusSceneRef.GetStoryObjectBoss = function(self)
  -- function num : 0_14
  return self._storyObjBoss
end

SoradiusSceneRef.GetStep2ObjectBoss = function(self)
  -- function num : 0_15
  return self._step2ObjBoss
end

SoradiusSceneRef.GetStep3ObjectBoss = function(self)
  -- function num : 0_16
  return self._step3ObjBoss
end

SoradiusSceneRef.GetSceneParticlesObject = function(self)
  -- function num : 0_17
  return self._sceneParticlesObj
end

return SoradiusSceneRef

