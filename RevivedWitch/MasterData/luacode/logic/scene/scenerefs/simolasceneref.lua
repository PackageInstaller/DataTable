-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/simolasceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local SimolaSceneRef = class("SimolaSceneRef", NewBattleSceneRef)
SimolaSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : SimolaSceneRef, TransformStaticFunctions, TimelineManager
  ((SimolaSceneRef.super).Init)(self)
  self._sceneParticlesObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SceneParticles")
  local rootTransform = (self._rootGameObject).transform
  self._timeLine1Transform = rootTransform:Find("W4_Battle_boss_01")
  self._timeLine1 = (TimelineManager.GetPlayableDirector)((self._timeLine1Transform).gameObject)
  self._battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleSceneCameraGroup/Main Camera")
  self._storyObj = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Story_1")
end

SimolaSceneRef.GetTimeLine1 = function(self)
  -- function num : 0_1
  return self._timeLine1
end

SimolaSceneRef.GetTimeLine1Object = function(self)
  -- function num : 0_2
  return (self._timeLine1Transform).gameObject
end

SimolaSceneRef.GetBattleMainCamera = function(self)
  -- function num : 0_3
  return self._battleCamera
end

SimolaSceneRef.GetStoryObject = function(self)
  -- function num : 0_4
  return self._storyObj
end

SimolaSceneRef.GetSceneParticlesObject = function(self)
  -- function num : 0_5
  return self._sceneParticlesObj
end

return SimolaSceneRef

