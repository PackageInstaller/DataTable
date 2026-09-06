local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local DestinyHellSceneRef = class("DestinyHellSceneRef", NewBattleSceneRef)

function DestinyHellSceneRef:Init()
  DestinyHellSceneRef.super.Init(self)
  local rootTransform = self._rootGameObject.transform
  self._boss_change1boss_timelineTransform = rootTransform:Find("Base_Fragment_05_ForBuild_Boss_PhaseChange")
  self._boss_change1boss_timeline = TimelineManager.GetPlayableDirector(self._boss_change1boss_timelineTransform.gameObject)
end

function DestinyHellSceneRef:GetChange1BossTimeLine()
  return self._boss_change1boss_timeline
end

function DestinyHellSceneRef:GetChange1BossTimeLineObject()
  return self._boss_change1boss_timelineTransform.gameObject
end

return DestinyHellSceneRef
