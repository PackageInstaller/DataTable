-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/topdowncontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AudioManager = ((CS.PixelNeko).Audio).AudioManager
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TrapHelper = (((CS.PixelNeko).P1).Scene).TrapHelper
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local TopDownController = class("TopDownController", SceneController)
TopDownController.Init = function(self)
  -- function num : 0_0 , upvalues : TopDownController, _ENV, SceneInfoTable, StateEventTriggerHelper
  ((TopDownController.super).Init)(self)
  self:PlaySceneBGM()
  local dialog = (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
  self._battleEvent = nil
  self._trap = nil
  self._triggeredEvents = {}
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnterDungeon, Common.n_EnterDungeon, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActorGridPosUpdate, Common.n_ActorMoved, nil)
  local record = SceneInfoTable:GetRecorder(self:GetSceneID())
  local assetBundle = record.mapAssetBundle
  local assetName = record.assetGround
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).LoadGroundFile)(assetBundle, assetName)
  ;
  (StateEventTriggerHelper.AddAllAnimationEventListener)(((self._sceneRef).actor).object, self.OnAnimationEvent, self)
end

TopDownController.RemoveEnemy = function(self)
  -- function num : 0_1
  ((self._sceneRef).monster):SetActive(false)
end

TopDownController.OpenDoor = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local x = (((((self._sceneRef).door).object).transform).position).x
  local y = (((((self._sceneRef).door).object).transform).position).z * -1
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).RemoveBlockingPoint)((self._sceneRef).builder, (math.floor)(x / 0.4 + 0.5), (math.floor)(y / 0.56 + 0.5))
end

TopDownController.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  local thawEffect = (EffectFactory.CreateThawEffect)()
  thawEffect:Run()
  ;
  (EventManager.Clear)()
  ;
  (TrapManager.UnInit)()
  self:HideUI()
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).ReleaseGroundFile)()
end

TopDownController.PlaySceneBGM = function(self)
  -- function num : 0_4 , upvalues : SceneInfoTable, _ENV
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    (LuaAudioManager.PlayBGM)(v.bgm)
  else
    ;
    (LuaAudioManager.PlayBGM)(v.bgmNight)
  end
end

TopDownController.PlayCatAnimation = function(self)
  -- function num : 0_5
  (((self._sceneRef).cat).animator):Play("JumpDown")
end

TopDownController.HideUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
end

TopDownController.ShowUI = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
end

TopDownController.OnEnterDungeon = function(self)
  -- function num : 0_8
  self:StopWalking()
end

TopDownController.RestoreTutorial = function(self, step)
  -- function num : 0_9 , upvalues : _ENV
  if step >= 1 then
    (((PixelNeko.Lua).TransformStaticFunctions).SetPosition)((self._sceneRef).actor, 4, 0, -10.64)
    ;
    (EventManager.RemoveEvent)(self._battleEvent)
    self:RemoveEnemy()
  end
  if step >= 2 then
    (((PixelNeko.Lua).TransformStaticFunctions).SetPosition)((self._sceneRef).actor, 4.4, 0, -6.72)
  end
  if step >= 2 then
    (((PixelNeko.Lua).TransformStaticFunctions).SetPosition)((self._sceneRef).actor, 5.6, 0, -5.6)
    ;
    (EventManager.RemoveEvent)(self._doorEvent)
    self:OpenDoor()
  end
end

TopDownController.OnNavMeshBuildFinish = function(self)
  -- function num : 0_10 , upvalues : TopDownController, _ENV
  ((TopDownController.super).OnNavMeshBuildFinish)(self)
  local info = self:GetData("enemies")
  if info then
    self:InitEnemies(info)
  end
  local pos = self:GetData("bornPosition")
  if pos then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).FlyTo)(((self._sceneRef).actor).object, pos.x, pos.y)
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(((self._sceneRef).actor).object, pos.dir)
    self:SetData("bornPosition", nil)
  end
  self:LoadEvents()
  local event_TA = (EventManager.FindByConfigID)(100041)
  if event_TA then
    local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_10_0 , upvalues : _ENV
    local jsonStr = (JSON.encode)({eventName = "2"})
    ;
    (ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA)(jsonStr)
  end
)
    event_TA:AddEffect(effect)
  end
end

local fire_event = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  local event = (EventManager.FindByConfigID)(eventid)
  if not event then
    return 
  end
  if not event:IsRepeateEvent() then
    (EventManager.RemoveByConfigID)(eventid)
  end
  event:Fire()
end

TopDownController.OnEnable = function(self)
  -- function num : 0_12 , upvalues : _ENV, fire_event
  self._enabled = true
  if not self:IsNavMeshReady() then
    return 
  end
  for _,v in ipairs(self._triggeredEvents) do
    fire_event(v)
  end
  self._triggeredEvents = {}
end

TopDownController.OnDisable = function(self)
  -- function num : 0_13
  self._enabled = false
end

TopDownController.OnDisable = function(self)
  -- function num : 0_14
end

local add_patrol_points = function(object, battlecfg)
  -- function num : 0_15 , upvalues : _ENV, TrapHelper
  local cmonstermoveroute = (BeanManager.GetTableByName)("dungeonbattle.cmonstermoveroute")
  local xs = {}
  local ys = {}
  local speed = {}
  local wait = {}
  local initial = (string.split)(battlecfg.Situation, ",")
  for _,lineid in ipairs((string.split)(battlecfg.Lineid, ",")) do
    local id = tonumber(lineid)
    if id ~= 0 then
      local record = cmonstermoveroute:GetRecorder(id)
      for i,pt in ipairs(record.RouteID) do
        local ns = (string.split)(pt, ",")
        xs[#xs + 1] = tonumber(ns[1])
        ys[#ys + 1] = tonumber(ns[2])
        speed[#speed + 1] = tonumber((record.speed)[i])
        wait[#wait + 1] = (record.time)[i] / 1000
      end
      xs[#xs + 1] = tonumber(initial[1])
      ys[#ys + 1] = tonumber(initial[2])
      speed[#speed + 1] = tonumber(record.return_speed)
      wait[#wait + 1] = record.return_time / 1000
    end
  end
  if #xs ~= 0 then
    (TrapHelper.AddPatrolPoints)(object, xs, ys, speed, wait)
    ;
    (TrapHelper.StartPatrol)(object)
  end
end

TopDownController.InitEnemies = function(self, info)
  -- function num : 0_16 , upvalues : _ENV, TrapHelper, add_patrol_points
  self._enemies = {}
  local cdungeonbattleconfig = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
  local cnpcshape = (BeanManager.GetTableByName)("npc.cnpcshape")
  for i,v in pairs(info) do
    local battlecfg = cdungeonbattleconfig:GetRecorder(v.id)
    assert(battlecfg.Isimportant ~= 0 or (battlecfg.Sceneid ~= self:GetSceneID() and no_check_scene))
    local initial = ((string.split)(battlecfg.Situation, ","))
    do
      local x, y = nil, nil
      if v.x then
        x = v.x / 1000
      else
        x = tonumber(initial[1]) * 0.4
      end
      if v.z then
        y = v.z / 1000
      else
        y = tonumber(initial[2]) * -0.56
      end
      local shape = cnpcshape:GetRecorder(battlecfg.Monsterid)
      local object = (TrapHelper.CreateObject)(shape.assetBundleName, shape.mapPrefabName, x, 0, y, (self._sceneRef):GetRootGameObject())
      ;
      (TrapHelper.AddPatrol)(object, v.id)
      local event = ((EventManager.Builder).BuildPatrolBattleEvent)(v.id, v.id, object, function()
    -- function num : 0_16_0 , upvalues : _ENV, object
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetActive)(object, false)
  end
)
      ;
      (EventManager.AddEvent)(event)
      add_patrol_points(object, battlecfg)
      ;
      (TrapHelper.Warp)(object, x, y)
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (self._enemies)[i] = {id = v.id, object = object, moving = battlecfg.Ismoved ~= 0}
    end
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

TopDownController.StopWalking = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self:IsNavMeshReady() then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(((self._sceneRef).actor).object)
  end
end

TopDownController.MoveTowards = function(self, x, y, offset)
  -- function num : 0_18 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, offset)
end

TopDownController.OnMouseButtonDown = function(self, x, y)
  -- function num : 0_19 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToScreenPos)(((self._sceneRef).actor).object, x, y)
end

TopDownController.OnRockerMove = function(self, notification)
  -- function num : 0_20
  local axisVector = (notification.userInfo).axisVector
  if (notification.userInfo).axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, (notification.userInfo).axisOffset)
  end
end

TopDownController.OnRockerEnd = function(self, notification)
  -- function num : 0_21
  self:StopWalking()
end

TopDownController.AddBaseEvent = function(self, poslist)
  -- function num : 0_22 , upvalues : _ENV
  local baseevent = (EventManager.CreateEvent)()
  local postrigger = (TriggerManager.CreateTrigger)("gridpos", baseevent:GetID(), poslist)
  baseevent:AddTrigger("gridpos", postrigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_22_0 , upvalues : _ENV
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.centerjumppoint")
    req.id = 11000
    req.outpoint = 1
    LogInfoFormat("TopDownController", "-- centerjumppoint -- id = %s, outpoint = %s ---", req.id, req.outpoint)
    req:Send()
  end
)
  baseevent:AddEffect(effect)
  ;
  (EventManager.AddEvent)(baseevent)
  self._baseEvent = baseevent:GetID()
end

TopDownController.PlayDynamicTimeline = function(self, assetName, assetBundle, args)
  -- function num : 0_23 , upvalues : _ENV
  local root = (self._sceneRef):GetRootGameObject()
  return (((((CS.PixelNeko).P1).TimeLine).TimelineManager).PlayDynamicTimeline)(root, assetName, assetBundle, args)
end

TopDownController.LoadEvents = function(self)
  -- function num : 0_24 , upvalues : _ENV
  (EventManager.LoadSceneEvents)((self._sceneRef):GetSceneID())
end

TopDownController.OnAnimationEvent = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_25 , upvalues : _ENV, AudioManager
  local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  local selector = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetGroundMaterial)(x, y)
  if clipName == "WalkLeft" or clipName == "WalkRight" or clipName == "WalkUp" or clipName == "WalkDown" or clipName == "WalkDL" or clipName == "WalkDR" or clipName == "WalkUL" or clipName == "WalkUR" or clipName == "RunLeft" or clipName == "RunRight" or clipName == "RunUp" or clipName == "RunDown" or clipName == "RunDL" or clipName == "RunDR" or clipName == "RunUL" or clipName == "RunUR" or clipName == "RunLeftHat" then
    (AudioManager.PlayAudioWithSelector)(stringValue, selector, intValue)
  end
end

TopDownController.GetSceneObjects = function(self)
  -- function num : 0_26
  return {}
end

TopDownController.GetEventRecords = function(self)
  -- function num : 0_27
  return {}
end

TopDownController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_28
end

TopDownController.OnActorGridPosUpdate = function(self)
  -- function num : 0_29 , upvalues : _ENV, TrapHelper
  local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  local prevx, prevy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorPrevGridPos()
  if x ~= prevx or y ~= prevy then
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.crolemove")
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (req.position).x = x
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (req.position).y = y
    req.sceneid = self:GetSceneID()
    local enemies = {}
    local ids = {}
    for _,v in pairs(self._enemies) do
      if v.moving then
        enemies[#enemies + 1] = v.object
        ids[#ids + 1] = v.id
      end
    end
    local xs, ys = (TrapHelper.CurrentPatrolPositions)(enemies)
    for i,id in ipairs(ids) do
      local pt = (LuaNetManager.CreateBean)("protocol.battle.point")
      pt.x = (math.tointeger)((math.floor)(xs[i - 1] * 1000 + 0.5))
      pt.y = (math.tointeger)((math.floor)(ys[i - 1] * 1000 + 0.5))
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (req.monsters)[id] = pt
    end
    req:Send()
  end
end

TopDownController.OnSTriggleSuccess = function(self, eventid)
  -- function num : 0_30 , upvalues : fire_event
  if self._enabled then
    fire_event(eventid)
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._triggeredEvents)[#self._triggeredEvents + 1] = eventid
  end
end

return TopDownController

