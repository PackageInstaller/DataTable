-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/tunnelscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local BattleWorld = require("logic.newbattle.battleworld")
local TunnelSceneController = class("TunnelSceneController", NewBattleSceneController)
local Vector3 = (CS.UnityEngine).Vector3
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local UVAnimation = ((((CS.PixelNeko).P1).Render).ShaderCommon).UVAnimation
local ParticleSystemStaticFunctions = ((CS.PixelNeko).Lua).ParticleSystemStaticFunctions
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CVarConfig = (BeanManager.GetTableByName)("var/cvarconfig")
local SRoleCreate = (BattleClientProtocolManager.GetProtocolDef)("action.srolecreate")
local SetUVSpeed = function(self, isMaxSpeed)
  -- function num : 0_0
  local tunnelInfo = (self._sceneRef)._tunnelInfo
  local roadInfo = (self._sceneRef)._roadInfo
  if isMaxSpeed then
    ((self._sceneRef)._tunnelUVAnimation):SetUVSpeed(tunnelInfo.maxUVSpeedX, tunnelInfo.maxUVSpeedY)
  else
    ;
    ((self._sceneRef)._tunnelUVAnimation):SetUVSpeed(tunnelInfo.normalUVSpeedX, tunnelInfo.normalUVSpeedY)
  end
end

local SetActorSpeed = function(self, x, y, speed)
  -- function num : 0_1
  ((self._sceneRef)._actorAnimator):SetFloat("dirx", x)
  ;
  ((self._sceneRef)._actorAnimator):SetFloat("diry", y)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._sceneRef)._actorAnimator).speed = speed
end

local SetTunnelScene = function(self, direction, length)
  -- function num : 0_2 , upvalues : _ENV
  local targetTunnelSceneRotationY, targetActorPosX, targetActorPosZ = nil, nil, nil
  local tunnelSceneInfo = (self._sceneRef)._tunnelSceneqInfo
  local tunnelActorInfo = (self._sceneRef)._actorRotationInfo
  if direction == 1 then
    targetTunnelSceneRotationY = tunnelSceneInfo.normalRotationY + (tunnelSceneInfo.maxRotationY - tunnelSceneInfo.normalRotationY) * length
    targetActorPosX = tunnelActorInfo.normalPosX + (tunnelActorInfo.maxPosX - tunnelActorInfo.normalPosX) * length
    targetActorPosZ = tunnelActorInfo.normalPosZ - (tunnelActorInfo.maxPosZ - tunnelActorInfo.normalPosZ) * length
  else
    if direction == -1 then
      targetTunnelSceneRotationY = tunnelSceneInfo.normalRotationY - (tunnelSceneInfo.normalRotationY - tunnelSceneInfo.minRotationY) * length
      targetActorPosX = tunnelActorInfo.normalPosX - (tunnelActorInfo.normalPosX - tunnelActorInfo.minPosX) * length
      targetActorPosZ = tunnelActorInfo.normalPosZ + (tunnelActorInfo.normalPosZ - tunnelActorInfo.minPosZ) * length
    else
      targetTunnelSceneRotationY = tunnelSceneInfo.normalRotationY
      targetActorPosX = tunnelActorInfo.normalPosX
      targetActorPosZ = tunnelActorInfo.normalPosZ
    end
  end
  local currentTunnelSceneRotationY = (((self._sceneRef)._tunnelSceneTransform).localEulerAngles).y
  local currentActorPosX = (((self._sceneRef)._actorTransform).localPosition).x
  local currentActorPosZ = (((self._sceneRef)._actorTransform).localPosition).z
  if self._tween == nil or ((self._tween).target).tunnelSceneRotationY ~= targetTunnelSceneRotationY then
    self._tween = (Tween.new)(2, {tunnelSceneRotationY = currentTunnelSceneRotationY, actorPosZ = currentActorPosZ}, {tunnelSceneRotationY = targetTunnelSceneRotationY, actorPosZ = targetActorPosZ}, "linear")
  end
end

local HandleRockerMove = function(self, notification)
  -- function num : 0_3 , upvalues : SetUVSpeed, _ENV, SetActorSpeed, SetTunnelScene
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  SetUVSpeed(self, true)
  local x = (userInfo.axisVector).x
  local absX = (math.abs)(x)
  if absX < 0.2 then
    x = 0
  else
    x = x / absX
  end
  SetActorSpeed(self, x, 1, ((self._sceneRef)._actorInfo).maxAniSpeed)
  SetTunnelScene(self, ((userInfo.axisVector).x > 0 and 1) or ((userInfo.axisVector).x < 0 and -1) or 0, userInfo.axisOffset)
end

local HandleRockerStop = function(self, notification)
  -- function num : 0_4 , upvalues : SetUVSpeed, SetActorSpeed, SetTunnelScene
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  SetUVSpeed(self, false)
  SetActorSpeed(self, 0, 1, ((self._sceneRef)._actorInfo).normalAniSpeed)
  SetTunnelScene(self, 0, 1)
end

local HandleTimeLineStop = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, SetActorSpeed, SetUVSpeed, SetTunnelScene
  local userInfo = notification.userInfo
  if userInfo == (self._sceneRef)._timeLine1 then
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
    local rockerDialog = (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
    SetActorSpeed(self, 0, 1, ((self._sceneRef)._actorInfo).normalAniSpeed)
    SetUVSpeed(self, false)
    SetTunnelScene(self, 0, 0)
    self._isStartMove = true
    return 
  end
end

local UpdateMove = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_6 , upvalues : _ENV
  if self._isStartMove == false then
    return 
  end
  self._moveTimer = self._moveTimer + deltaTime
  if self._moveTotalTime <= self._moveTimer then
    self._isStartMove = false
    ;
    ((self._sceneRef)._timeLine2):Play()
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  end
end

TunnelSceneController.Init = function(self)
  -- function num : 0_7 , upvalues : TunnelSceneController, CVarConfig, _ENV, HandleRockerMove, HandleRockerStop, HandleTimeLineStop, StateEventTriggerHelper
  ((TunnelSceneController.super).Init)(self)
  self._moveTotalTime = 10
  self._moveTimer = 0
  self._isStartMove = false
  self._tween = nil
  self._deadEffectTimer = nil
  self._canJumpTo30003 = true
  self._needJumpTo30003 = false
  self._actorPostion = ((self._sceneRef)._actorTransform).localPosition
  self._buff20014MusicState = ""
  self._buff20014MusicNum = 0
  self._tunnelSceneRotaion = ((self._sceneRef)._tunnelSceneTransform).localEulerAngles
  local totalTimeRecord = CVarConfig:GetRecorder(21)
  do
    if totalTimeRecord ~= nil then
      local totalTime = tonumber(totalTimeRecord.Value)
      if totalTime ~= nil then
        self._moveTotalTime = totalTime
      end
    end
    ;
    (LuaNotificationCenter.AddObserver)(self, HandleRockerMove, Common.n_RockerMove, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, HandleRockerStop, Common.n_RockerEnd, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, HandleTimeLineStop, Common.n_TimelineStop, nil)
    ;
    (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef)._triggerTimeLine2, self.OnTriggerBehaviourPlay, self)
    ;
    (StateEventTriggerHelper.AddStateEnterListener)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, self.BSR_OnBattleCameraStateEnter, self)
  end
end

TunnelSceneController.OnEnable = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)(61)
end

TunnelSceneController.OnTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_9 , upvalues : _ENV, TunnelSceneController
  if stringValue == "BattleStart" then
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    ;
    ((TunnelSceneController.super).OnSBattleStart)(self, protocol)
  end
end

TunnelSceneController.OnDestroy = function(self)
  -- function num : 0_10 , upvalues : TunnelSceneController, _ENV
  ((TunnelSceneController.super).OnDestroy)(self)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._deadEffectTimer then
    (GameTimer.RemoveTask)(self._deadEffectTimer)
    self._deadEffectTimer = nil
  end
end

TunnelSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_11 , upvalues : TunnelSceneController, UpdateMove, Vector3
  ((TunnelSceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if not self._bsc_battleReconnectState then
    ((self._sceneRef)._maskTransform).position = ((self._sceneRef)._actorTransform).position
    UpdateMove(self, deltaTime, unscaleDeltaTime)
    if self._tween == nil then
      return 
    end
    ;
    (self._tween):update(deltaTime)
    local eulerAngles = self._tunnelSceneRotaion
    local postion = self._actorPostion
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._sceneRef)._tunnelSceneTransform).localEulerAngles = Vector3(eulerAngles.x, ((self._tween).subject).tunnelSceneRotationY, eulerAngles.z)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._sceneRef)._actorTransform).localPosition = Vector3(postion.x, postion.y, ((self._tween).subject).actorPosZ)
  end
end

TunnelSceneController.BSC_UpdateBattleLogicOneStep = function(self)
  -- function num : 0_12 , upvalues : TunnelSceneController, _ENV
  ((TunnelSceneController.super).BSC_UpdateBattleLogicOneStep)(self)
  if self._buff20014MusicState == "up" then
    self._buff20014MusicNum = (math.min)(1, self._buff20014MusicNum + 0.083)
  else
    if self._buff20014MusicState == "down" then
      self._buff20014MusicNum = (math.max)(0, self._buff20014MusicNum - 0.083)
    end
  end
  ;
  (LuaAudioManager.PlayBGM)(60)
  ;
  ((((CS.PixelNeko).Audio).AudioManager).SetAisac)(60, 0, self._buff20014MusicNum)
end

TunnelSceneController.OnSRoleCreate = function(self, protocol)
  -- function num : 0_13 , upvalues : TunnelSceneController, _ENV
  ((TunnelSceneController.super).OnSRoleCreate)(self, protocol)
  if (protocol.attribute).id == 20007 or (protocol.attribute).id == 20008 then
    local bossNeedPauseEffectTransform = (((self._sceneRef)._rootGameObject).transform):Find("GameObject/Right/boss_t1_02(Clone)/HitPoint_Body/BOSS_TX_t1_02_Stand")
    if bossNeedPauseEffectTransform then
      ((self._sceneRef)._tunnelSceneTimeController):AddNeedPause(bossNeedPauseEffectTransform)
    else
      LogError("TunnelSceneController", "no boss need pause effect")
    end
  end
end

TunnelSceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV, TunnelSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if battler and (battler:GetConfigId() == 20007 or battler:GetConfigId() == 20008) then
    self._canJumpTo30003 = false
    ;
    ((self._sceneRef)._bossDeadEffect):SetActive(true)
    self._deadEffectTimer = (GameTimer.AddTask)(8, 0, function(self)
    -- function num : 0_14_0 , upvalues : TunnelSceneController
    self._deadEffectTimer = nil
    self._canJumpTo30003 = true
    if self._needJumpTo30003 then
      ((TunnelSceneController.super).BSC_BattleEnd)(self)
    end
  end
, self)
  end
  ;
  ((TunnelSceneController.super).OnSRoleDead)(self, protocol)
end

TunnelSceneController.OnSSkillStart = function(self, skillID)
  -- function num : 0_15 , upvalues : TunnelSceneController
  ((TunnelSceneController.super).OnSSkillStart)(self, skillID)
  if skillID == 201013 then
    self._buff20014MusicState = "up"
    ;
    ((self._sceneRef)._tunnelSceneTimeController):Pause()
  end
end

TunnelSceneController.OnSSkillEnd = function(self, skillID)
  -- function num : 0_16 , upvalues : TunnelSceneController
  ((TunnelSceneController.super).OnSSkillEnd)(self, skillID)
  if skillID == 201013 then
    self._buff20014MusicState = "down"
    ;
    ((self._sceneRef)._tunnelSceneTimeController):Resume()
  end
end

TunnelSceneController.BSC_BattleEnd = function(self)
  -- function num : 0_17 , upvalues : TunnelSceneController, _ENV
  if self._bsc_battleEndProtocol and ((self._bsc_battleEndProtocol).battleResult).result == 1 then
    if self._canJumpTo30003 then
      ((TunnelSceneController.super).BSC_BattleEnd)(self)
    else
      self._needJumpTo30003 = true
    end
  else
    if self._deadEffectTimer then
      (GameTimer.RemoveTask)(self._deadEffectTimer)
      self._deadEffectTimer = nil
    end
    ;
    ((TunnelSceneController.super).BSC_BattleEnd)(self)
  end
end

TunnelSceneController.OnSBattleStart = function(self, protocol)
  -- function num : 0_18 , upvalues : _ENV, TunnelSceneController
  if ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(protocol) then
    self._bsc_battleReconnectState = true
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  if self._bsc_battleReconnectState then
    ((self._sceneRef)._timeLine1).time = ((self._sceneRef)._timeLine1).duration
    ;
    ((self._sceneRef)._timeLine1):Play()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._sceneRef)._timeLine2).time = ((self._sceneRef)._timeLine2).duration
    ;
    ((self._sceneRef)._timeLine2):Play()
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    ;
    ((TunnelSceneController.super).OnSBattleStart)(self, protocol)
  else
    do
      ;
      ((self._sceneRef)._timeLine1):Play()
    end
  end
end

return TunnelSceneController

