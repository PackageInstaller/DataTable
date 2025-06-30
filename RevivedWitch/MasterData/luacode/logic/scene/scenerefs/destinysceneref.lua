-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/destinysceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local DestinySceneRef = class("DestinySceneRef", NewBattleSceneRef)
DestinySceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : DestinySceneRef, TransformStaticFunctions, TimelineManager
  ((DestinySceneRef.super).Init)(self)
  self._sceneParticlesObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SceneParticles")
  local rootTransform = (self._rootGameObject).transform
  self._boss_start_timelineTransform = rootTransform:Find("Base_Fragment_05_Boss_BattleBefore")
  self._boss_change1_timelineTransform = rootTransform:Find("Base_Fragment_05_Boss_PhaseChange")
  self._boss_start_timeline = (TimelineManager.GetPlayableDirector)((self._boss_start_timelineTransform).gameObject)
  self._boss_change1_timeline = (TimelineManager.GetPlayableDirector)((self._boss_change1_timelineTransform).gameObject)
  self._battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._step1Obj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Step1")
  self._storyObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BeforeBattle")
end

DestinySceneRef.GetStartTimeLine = function(self)
  -- function num : 0_1
  return self._boss_start_timeline
end

DestinySceneRef.GetChange1TimeLine = function(self)
  -- function num : 0_2
  return self._boss_change1_timeline
end

DestinySceneRef.GetStartTimeLineObject = function(self)
  -- function num : 0_3
  return (self._boss_start_timelineTransform).gameObject
end

DestinySceneRef.GetChange1TimeLineObject = function(self)
  -- function num : 0_4
  return (self._boss_change1_timelineTransform).gameObject
end

DestinySceneRef.GetBattleMainCamera = function(self)
  -- function num : 0_5
  return self._battleCamera
end

DestinySceneRef.GetStep1Object = function(self)
  -- function num : 0_6
  return self._step1Obj
end

DestinySceneRef.GetStoryObject = function(self)
  -- function num : 0_7
  return self._storyObj
end

DestinySceneRef.GetSceneParticlesObject = function(self)
  -- function num : 0_8
  return self._sceneParticlesObj
end

return DestinySceneRef

