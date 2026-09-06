local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local NewBattleSceneRef = require("logic.scene.scenerefs.newbattlesceneref")
local TunelSceneRef = class("TunelSceneRef", NewBattleSceneRef)
local UVAnimation = CS.PixelNeko.P1.Render.ShaderCommon.UVAnimation
local ParticleSystemStaticFunctions = CS.PixelNeko.Lua.ParticleSystemStaticFunctions
local TunnelSceneTimeController = CS.PixelNeko.P1.TunnelScene.TunnelSceneTimeController
local cTunnelSceneSpeed = BeanManager.GetTableByName("scene.ctunnelscenespeed")
local cTunnelSceneRotation = BeanManager.GetTableByName("scene.ctunnelscenerotation")

function TunelSceneRef:Init()
  TunelSceneRef.super.Init(self)
  local rootTransform = self._rootGameObject.transform
  self._roadInfo = cTunnelSceneSpeed:GetRecorder(1)
  self._tunnelInfo = cTunnelSceneSpeed:GetRecorder(2)
  self._actorInfo = cTunnelSceneSpeed:GetRecorder(3)
  self._tunnelSceneqInfo = cTunnelSceneRotation:GetRecorder(1)
  self._maskRotationInfo = cTunnelSceneRotation:GetRecorder(2)
  self._actorRotationInfo = cTunnelSceneRotation:GetRecorder(3)
  self._actorTransform = rootTransform:Find(self._actorInfo.sceneObject)
  self._actorAnimator = AnimatorStaticFunctions.Get(self._actorTransform.gameObject)
  self._tunnelTransform = rootTransform:Find(self._tunnelInfo.sceneObject)
  self._roadTransform = rootTransform:Find(self._roadInfo.sceneObject)
  self._tunnelSceneTransform = rootTransform:Find(self._tunnelSceneqInfo.sceneObject)
  self._maskTransform = rootTransform:Find(self._maskRotationInfo.sceneObject)
  self._timeLine1Transform = rootTransform:Find("T1_Battle_03_01")
  self._timeLine2Transform = rootTransform:Find("T1_Battle_03_02")
  self._bossDeadEffect = TransformStaticFunctions.GetChild(self._rootGameObject, "BOSS_TX_t1_02_Death_TimeLine")
  self._battleTunnelTransform = rootTransform:Find("Tunnel/YiShiJie_TX_zhandou")
  self._timeControllerTransform = rootTransform:Find("TimeController")
  self._timeLine1 = TimelineManager.GetPlayableDirector(self._timeLine1Transform.gameObject)
  self._timeLine2 = TimelineManager.GetPlayableDirector(self._timeLine2Transform.gameObject)
  self._triggerTimeLine2 = TransformStaticFunctions.GetChild(self._rootGameObject, "T1_Battle_03_02")
  self._tunnelUVAnimation = UVAnimation.GetUVAnimation(self._tunnelTransform.gameObject)
  self._tunnelSceneTimeController = TunnelSceneTimeController.GetTunnelSceneTimeController(self._timeControllerTransform)
  self._tunnelSceneTimeController:AddNeedPause(self._battleTunnelTransform)
  self._battleCamera = TransformStaticFunctions.GetChild(self._rootGameObject, "Camera/Battle")
end

function TunelSceneRef:GetActorAnimator()
  return self._actorAnimator
end

function TunelSceneRef:BSR_GetBattleCamera()
  return self._battleCamera
end

return TunelSceneRef
