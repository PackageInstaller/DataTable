-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/newbattlesceneref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local SceneRef = require("logic.scene.scenerefs.sceneref")
local NewBattleSceneRef = class("NewBattleSceneRef", SceneRef)
NewBattleSceneRef.Init = function(self, ...)
  -- function num : 0_0 , upvalues : NewBattleSceneRef
  ((NewBattleSceneRef.super).Init)(self, ...)
  self:BSR_Init()
end

NewBattleSceneRef.BSR_Init = function(self)
  -- function num : 0_1 , upvalues : TransformStaticFunctions, GlobalCameras, TimelineManager
  self._bsr_leftObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "GameObject/Left")
  self._bsr_leftEffectObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "GameObject/LeftEffect")
  self._bsr_rightObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "GameObject/Right")
  self._bsr_rightEffectObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "GameObject/RightEffect")
  self._bsr_startCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleCamera/Normal")
  self._bsr_victoryCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleCamera/Victory")
  self._bsr_battleCamera = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattleCamera")
  self._bsr_battleMainCamera = (GlobalCameras.GetCamera)("BattleMain")
  self._bsr_startBattleTimelineTransform = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattlePhase_Enter")
  self._bsr_endBattleTimelineTransform = (TransformStaticFunctions.GetChild)(self._rootGameObject, "BattlePhase_Kill")
  if self._bsr_startBattleTimelineTransform then
    self._bsr_startBattleTimeline = (TimelineManager.GetPlayableDirector)((self._bsr_startBattleTimelineTransform).gameObject)
  end
  if self._bsr_endBattleTimelineTransform then
    self._bsr_endBattleTimeline = (TimelineManager.GetPlayableDirector)((self._bsr_endBattleTimelineTransform).gameObject)
  end
  self._bsr_eMengAnimatorGameObject = (TransformStaticFunctions.GetChild)(self._rootGameObject, "NightmareControler")
end

NewBattleSceneRef.BSR_GetLeftEffectObject = function(self)
  -- function num : 0_2
  return self._bsr_leftEffectObject
end

NewBattleSceneRef.BSR_GetLeftObject = function(self)
  -- function num : 0_3
  return self._bsr_leftObject
end

NewBattleSceneRef.BSR_GetRightEffectObject = function(self)
  -- function num : 0_4
  return self._bsr_rightEffectObject
end

NewBattleSceneRef.BSR_GetRightObject = function(self)
  -- function num : 0_5
  return self._bsr_rightObject
end

NewBattleSceneRef.BSR_GetStartTimeLine = function(self)
  -- function num : 0_6
  return self._bsr_startBattleTimeline
end

NewBattleSceneRef.BSR_GetEndTimeLine = function(self)
  -- function num : 0_7
  return self._bsr_endBattleTimeline
end

NewBattleSceneRef.BSR_GetStartTimeLineTransform = function(self)
  -- function num : 0_8
  return self._bsr_startBattleTimelineTransform
end

NewBattleSceneRef.BSR_GetEndTimeLineTransform = function(self)
  -- function num : 0_9
  return self._bsr_endBattleTimelineTransform
end

NewBattleSceneRef.BSR_GetBattleCamera = function(self)
  -- function num : 0_10
  return self._bsr_battleCamera
end

NewBattleSceneRef.BSR_GetBattleMainCamera = function(self)
  -- function num : 0_11
  return self._bsr_battleMainCamera
end

NewBattleSceneRef.BSR_GetEMengAnimatorGameObject = function(self)
  -- function num : 0_12
  return self._bsr_eMengAnimatorGameObject
end

return NewBattleSceneRef

