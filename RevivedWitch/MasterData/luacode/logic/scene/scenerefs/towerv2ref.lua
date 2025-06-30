-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/towerv2ref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TowerV2Ref = class("TowerRef", SceneRef)
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
TowerV2Ref.Init = function(self)
  -- function num : 0_0 , upvalues : TowerV2Ref, TransformStaticFunctions, GlobalCameras, _ENV
  ((TowerV2Ref.super).Init)(self)
  self.actor = {object = (TransformStaticFunctions.GetChild)(self._rootGameObject, "ActorTower")}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).animator = ((self.actor).object):GetComponent("Animator")
  self.spawnPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SpawnPoint")
  self.startPoint = (TransformStaticFunctions.GetChild)(self._rootGameObject, "StartPoint")
  self.mainCamera = (GlobalCameras.GetCamera)("DormMain")
  self.clicktimeline = {object = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SelectionTimelineBefore")}
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.clicktimeline).director = ((self.clicktimeline).object):GetComponent("PlayableDirector")
  self.approachtimeline = {object = (TransformStaticFunctions.GetChild)(self._rootGameObject, "SelectionTimelineAfter")}
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.approachtimeline).director = ((self.approachtimeline).object):GetComponent("PlayableDirector")
  self.worldtimeline = {
object = {(TransformStaticFunctions.GetChild)(self._rootGameObject, "TimeTowerTimeline"), (TransformStaticFunctions.GetChild)(self._rootGameObject, "ForestTimeline"), (TransformStaticFunctions.GetChild)(self._rootGameObject, "IceTimeline")}
, 
director = {}
}
  for i,v in ipairs((self.worldtimeline).object) do
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R6 in 'UnsetPending'

    ((self.worldtimeline).director)[i] = v:GetComponent("PlayableDirector")
  end
  self.background = {object = (TransformStaticFunctions.GetChild)(self._rootGameObject, "Background"), 
node = {}
}
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.background).director = ((self.background).object):GetComponent("PlayableDirector")
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC121: Confused about usage of register: R5 in 'UnsetPending'

    ((self.background).node)[i] = (TransformStaticFunctions.GetChild)((self.background).object, "Bg" .. 4 - i)
  end
end

return TowerV2Ref

