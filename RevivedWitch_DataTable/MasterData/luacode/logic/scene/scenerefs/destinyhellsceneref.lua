-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/destinyhellsceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local DestinyHellSceneRef = class("DestinyHellSceneRef", NewBattleSceneRef)
DestinyHellSceneRef.Init = function(self)
  -- function num : 0_0 , upvalues : DestinyHellSceneRef, TimelineManager
  ((DestinyHellSceneRef.super).Init)(self)
  local rootTransform = (self._rootGameObject).transform
  self._boss_change1boss_timelineTransform = rootTransform:Find("Base_Fragment_05_ForBuild_Boss_PhaseChange")
  self._boss_change1boss_timeline = (TimelineManager.GetPlayableDirector)((self._boss_change1boss_timelineTransform).gameObject)
end

DestinyHellSceneRef.GetChange1BossTimeLine = function(self)
  -- function num : 0_1
  return self._boss_change1boss_timeline
end

DestinyHellSceneRef.GetChange1BossTimeLineObject = function(self)
  -- function num : 0_2
  return (self._boss_change1boss_timelineTransform).gameObject
end

return DestinyHellSceneRef

