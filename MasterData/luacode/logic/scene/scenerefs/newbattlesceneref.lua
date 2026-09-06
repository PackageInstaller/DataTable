local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local SceneRef = require("logic.scene.scenerefs.sceneref")
local NewBattleSceneRef = class("NewBattleSceneRef", SceneRef)

function NewBattleSceneRef:Init(...)
  NewBattleSceneRef.super.Init(self, ...)
  self:BSR_Init()
end

function NewBattleSceneRef:BSR_Init()
  self._bsr_leftObject = TransformStaticFunctions.GetChild(self._rootGameObject, "GameObject/Left")
  self._bsr_leftEffectObject = TransformStaticFunctions.GetChild(self._rootGameObject, "GameObject/LeftEffect")
  self._bsr_rightObject = TransformStaticFunctions.GetChild(self._rootGameObject, "GameObject/Right")
  self._bsr_rightEffectObject = TransformStaticFunctions.GetChild(self._rootGameObject, "GameObject/RightEffect")
  self._bsr_startCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleCamera/Normal")
  self._bsr_victoryCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleCamera/Victory")
  self._bsr_battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "BattleCamera")
  self._bsr_battleMainCamera = GlobalCameras.GetCamera("BattleMain")
  self._bsr_startBattleTimelineTransform = TransformStaticFunctions.GetChild(self._rootGameObject, "BattlePhase_Enter")
  self._bsr_endBattleTimelineTransform = TransformStaticFunctions.GetChild(self._rootGameObject, "BattlePhase_Kill")
  if self._bsr_startBattleTimelineTransform then
    self._bsr_startBattleTimeline = TimelineManager.GetPlayableDirector(self._bsr_startBattleTimelineTransform.gameObject)
  end
  if self._bsr_endBattleTimelineTransform then
    self._bsr_endBattleTimeline = TimelineManager.GetPlayableDirector(self._bsr_endBattleTimelineTransform.gameObject)
  end
  self._bsr_eMengAnimatorGameObject = TransformStaticFunctions.GetChild(self._rootGameObject, "NightmareControler")
end

function NewBattleSceneRef:BSR_GetLeftEffectObject()
  return self._bsr_leftEffectObject
end

function NewBattleSceneRef:BSR_GetLeftObject()
  return self._bsr_leftObject
end

function NewBattleSceneRef:BSR_GetRightEffectObject()
  return self._bsr_rightEffectObject
end

function NewBattleSceneRef:BSR_GetRightObject()
  return self._bsr_rightObject
end

function NewBattleSceneRef:BSR_GetStartTimeLine()
  return self._bsr_startBattleTimeline
end

function NewBattleSceneRef:BSR_GetEndTimeLine()
  return self._bsr_endBattleTimeline
end

function NewBattleSceneRef:BSR_GetStartTimeLineTransform()
  return self._bsr_startBattleTimelineTransform
end

function NewBattleSceneRef:BSR_GetEndTimeLineTransform()
  return self._bsr_endBattleTimelineTransform
end

function NewBattleSceneRef:BSR_GetBattleCamera()
  return self._bsr_battleCamera
end

function NewBattleSceneRef:BSR_GetBattleMainCamera()
  return self._bsr_battleMainCamera
end

function NewBattleSceneRef:BSR_GetEMengAnimatorGameObject()
  return self._bsr_eMengAnimatorGameObject
end

return NewBattleSceneRef
