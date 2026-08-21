-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/icegoddesssceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local IceGoddessSceneRef = class("IceGoddessSceneRef", NewBattleSceneRef)
IceGoddessSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : IceGoddessSceneRef, TransformStaticFunctions, TimelineManager
  ((IceGoddessSceneRef.super).Init)(self)
  self._iceBsr_object = (TransformStaticFunctions.GetChild)(self._rootGameObject, "GameObject")
  self._sceneParticlesObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SceneParticles")
  local rootTransform = (self._rootGameObject).transform
  self._timeLine1Transform = rootTransform:Find("W2_Battle_boss_01")
  self._timeLine1 = (TimelineManager.GetPlayableDirector)((self._timeLine1Transform).gameObject)
  self._battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._storyObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story_1")
end

IceGoddessSceneRef.GetBattleObject = function(self)
  -- function num : 0_1
  return self._iceBsr_object
end

IceGoddessSceneRef.GetTimeLine1 = function(self)
  -- function num : 0_2
  return self._timeLine1
end

IceGoddessSceneRef.GetTimeLine1Object = function(self)
  -- function num : 0_3
  return (self._timeLine1Transform).gameObject
end

IceGoddessSceneRef.GetBattleMainCamera = function(self)
  -- function num : 0_4
  return self._battleCamera
end

IceGoddessSceneRef.GetStoryObject = function(self)
  -- function num : 0_5
  return self._storyObj
end

IceGoddessSceneRef.GetSceneParticlesObject = function(self)
  -- function num : 0_6
  return self._sceneParticlesObj
end

return IceGoddessSceneRef

