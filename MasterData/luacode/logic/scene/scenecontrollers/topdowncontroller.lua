local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local AudioManager = CS.PixelNeko.Audio.AudioManager
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TrapHelper = CS.PixelNeko.P1.Scene.TrapHelper
local SceneInfoTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local TopDownController = class("TopDownController", SceneController)

function TopDownController:Init()
  TopDownController.super.Init(self)
  self:PlaySceneBGM()
  local dialog = DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
  self._battleEvent = nil
  self._trap = nil
  self._triggeredEvents = {}
  LuaNotificationCenter.AddObserver(self, self.OnRockerMove, Common.n_RockerMove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterDungeon, Common.n_EnterDungeon, nil)
  LuaNotificationCenter.AddObserver(self, self.OnActorGridPosUpdate, Common.n_ActorMoved, nil)
  local record = SceneInfoTable:GetRecorder(self:GetSceneID())
  local assetBundle = record.mapAssetBundle
  local assetName = record.assetGround
  CS.PixelNeko.Lua.NavMeshStaticFunctions.LoadGroundFile(assetBundle, assetName)
  StateEventTriggerHelper.AddAllAnimationEventListener(self._sceneRef.actor.object, self.OnAnimationEvent, self)
end

function TopDownController:RemoveEnemy()
  self._sceneRef.monster:SetActive(false)
end

function TopDownController:OpenDoor()
  local x = self._sceneRef.door.object.transform.position.x
  local y = self._sceneRef.door.object.transform.position.z * -1
  CS.PixelNeko.Lua.NavMeshStaticFunctions.RemoveBlockingPoint(self._sceneRef.builder, math.floor(x / 0.4 + 0.5), math.floor(y / 0.56 + 0.5))
end

function TopDownController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  local thawEffect = EffectFactory.CreateThawEffect()
  thawEffect:Run()
  EventManager.Clear()
  TrapManager.UnInit()
  self:HideUI()
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  CS.PixelNeko.Lua.NavMeshStaticFunctions.ReleaseGroundFile()
end

function TopDownController:PlaySceneBGM()
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    LuaAudioManager.PlayBGM(v.bgm)
  else
    LuaAudioManager.PlayBGM(v.bgmNight)
  end
end

function TopDownController:PlayCatAnimation()
  self._sceneRef.cat.animator:Play("JumpDown")
end

function TopDownController:HideUI()
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
end

function TopDownController:ShowUI()
  DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
end

function TopDownController:OnEnterDungeon()
  self:StopWalking()
end

function TopDownController:RestoreTutorial(step)
  if 1 <= step then
    PixelNeko.Lua.TransformStaticFunctions.SetPosition(self._sceneRef.actor, 4.0, 0, -10.64)
    EventManager.RemoveEvent(self._battleEvent)
    self:RemoveEnemy()
  end
  if 2 <= step then
    PixelNeko.Lua.TransformStaticFunctions.SetPosition(self._sceneRef.actor, 4.4, 0, -6.720000000000001)
  end
  if 2 <= step then
    PixelNeko.Lua.TransformStaticFunctions.SetPosition(self._sceneRef.actor, 5.6000000000000005, 0, -5.6000000000000005)
    EventManager.RemoveEvent(self._doorEvent)
    self:OpenDoor()
  end
end

function TopDownController:OnNavMeshBuildFinish()
  TopDownController.super.OnNavMeshBuildFinish(self)
  local info = self:GetData("enemies")
  if info then
    self:InitEnemies(info)
  end
  local pos = self:GetData("bornPosition")
  if pos then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.FlyTo(self._sceneRef.actor.object, pos.x, pos.y)
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(self._sceneRef.actor.object, pos.dir)
    self:SetData("bornPosition", nil)
  end
  self:LoadEvents()
  local event_TA = EventManager.FindByConfigID(100041)
  if event_TA then
    local effect = EffectFactory.CreateCustomEffect(function()
      local jsonStr = JSON.encode({eventName = "2"})
      ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
    end)
    event_TA:AddEffect(effect)
  end
end

local function fire_event(eventid)
  local event = EventManager.FindByConfigID(eventid)
  if not event then
    return
  end
  if not event:IsRepeateEvent() then
    EventManager.RemoveByConfigID(eventid)
  end
  event:Fire()
end

function TopDownController:OnEnable()
  self._enabled = true
  if not self:IsNavMeshReady() then
    return
  end
  for _, v in ipairs(self._triggeredEvents) do
    fire_event(v)
  end
  self._triggeredEvents = {}
end

function TopDownController:OnDisable()
  self._enabled = false
end

function TopDownController:OnDisable()
end

local function add_patrol_points(object, battlecfg)
  local cmonstermoveroute = BeanManager.GetTableByName("dungeonbattle.cmonstermoveroute")
  local xs = {}
  local ys = {}
  local speed = {}
  local wait = {}
  local initial = string.split(battlecfg.Situation, ",")
  for _, lineid in ipairs(string.split(battlecfg.Lineid, ",")) do
    local id = tonumber(lineid)
    if id ~= 0 then
      local record = cmonstermoveroute:GetRecorder(id)
      for i, pt in ipairs(record.RouteID) do
        local ns = string.split(pt, ",")
        xs[#xs + 1] = tonumber(ns[1])
        ys[#ys + 1] = tonumber(ns[2])
        speed[#speed + 1] = tonumber(record.speed[i])
        wait[#wait + 1] = record.time[i] / 1000
      end
      xs[#xs + 1] = tonumber(initial[1])
      ys[#ys + 1] = tonumber(initial[2])
      speed[#speed + 1] = tonumber(record.return_speed)
      wait[#wait + 1] = record.return_time / 1000
    end
  end
  if #xs ~= 0 then
    TrapHelper.AddPatrolPoints(object, xs, ys, speed, wait)
    TrapHelper.StartPatrol(object)
  end
end

function TopDownController:InitEnemies(info)
  self._enemies = {}
  local cdungeonbattleconfig = BeanManager.GetTableByName("dungeonbattle.cdungeonbattleconfig")
  local cnpcshape = BeanManager.GetTableByName("npc.cnpcshape")
  for i, v in pairs(info) do
    local battlecfg = cdungeonbattleconfig:GetRecorder(v.id)
    if battlecfg.Isimportant == 0 then
      assert(battlecfg.Sceneid == self:GetSceneID() or no_check_scene)
      local initial = string.split(battlecfg.Situation, ",")
      local x, y
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
      local object = TrapHelper.CreateObject(shape.assetBundleName, shape.mapPrefabName, x, 0, y, self._sceneRef:GetRootGameObject())
      TrapHelper.AddPatrol(object, v.id)
      local event = EventManager.Builder.BuildPatrolBattleEvent(v.id, v.id, object, function()
        CS.PixelNeko.Lua.TransformStaticFunctions.SetActive(object, false)
      end)
      EventManager.AddEvent(event)
      add_patrol_points(object, battlecfg)
      TrapHelper.Warp(object, x, y)
      self._enemies[i] = {
        id = v.id,
        object = object,
        moving = battlecfg.Ismoved ~= 0
      }
    end
  end
end

function TopDownController:StopWalking()
  if self:IsNavMeshReady() then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(self._sceneRef.actor.object)
  end
end

function TopDownController:MoveTowards(x, y, offset)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTowards(self._sceneRef.actor.object, x, y, offset)
end

function TopDownController:OnMouseButtonDown(x, y)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveToScreenPos(self._sceneRef.actor.object, x, y)
end

function TopDownController:OnRockerMove(notification)
  local axisVector = notification.userInfo.axisVector
  if notification.userInfo.axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, notification.userInfo.axisOffset)
  end
end

function TopDownController:OnRockerEnd(notification)
  self:StopWalking()
end

function TopDownController:AddBaseEvent(poslist)
  local baseevent = EventManager.CreateEvent()
  local postrigger = TriggerManager.CreateTrigger("gridpos", baseevent:GetID(), poslist)
  baseevent:AddTrigger("gridpos", postrigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    local req = LuaNetManager.CreateProtocol("protocol.battle.centerjumppoint")
    req.id = 11000
    req.outpoint = 1
    LogInfoFormat("TopDownController", "-- centerjumppoint -- id = %s, outpoint = %s ---", req.id, req.outpoint)
    req:Send()
  end)
  baseevent:AddEffect(effect)
  EventManager.AddEvent(baseevent)
  self._baseEvent = baseevent:GetID()
end

function TopDownController:PlayDynamicTimeline(assetName, assetBundle, args)
  local root = self._sceneRef:GetRootGameObject()
  return CS.PixelNeko.P1.TimeLine.TimelineManager.PlayDynamicTimeline(root, assetName, assetBundle, args)
end

function TopDownController:LoadEvents()
  EventManager.LoadSceneEvents(self._sceneRef:GetSceneID())
end

function TopDownController:OnAnimationEvent(floatValue, intValue, stringValue, obj, clipName)
  local x, y = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
  local selector = CS.PixelNeko.Lua.NavMeshStaticFunctions.GetGroundMaterial(x, y)
  if clipName == "WalkLeft" or clipName == "WalkRight" or clipName == "WalkUp" or clipName == "WalkDown" or clipName == "WalkDL" or clipName == "WalkDR" or clipName == "WalkUL" or clipName == "WalkUR" or clipName == "RunLeft" or clipName == "RunRight" or clipName == "RunUp" or clipName == "RunDown" or clipName == "RunDL" or clipName == "RunDR" or clipName == "RunUL" or clipName == "RunUR" or clipName == "RunLeftHat" then
    AudioManager.PlayAudioWithSelector(stringValue, selector, intValue)
  end
end

function TopDownController:GetSceneObjects()
  return {}
end

function TopDownController:GetEventRecords()
  return {}
end

function TopDownController:Update(deltaTime, unscaleDeltaTime)
end

function TopDownController:OnActorGridPosUpdate()
  local x, y = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
  local prevx, prevy = NekoData.BehaviorManager.BM_Dungeon:GetActorPrevGridPos()
  if x ~= prevx or y ~= prevy then
    local req = LuaNetManager.CreateProtocol("protocol.battle.crolemove")
    req.position.x = x
    req.position.y = y
    req.sceneid = self:GetSceneID()
    local enemies = {}
    local ids = {}
    for _, v in pairs(self._enemies) do
      if v.moving then
        enemies[#enemies + 1] = v.object
        ids[#ids + 1] = v.id
      end
    end
    local xs, ys = TrapHelper.CurrentPatrolPositions(enemies)
    for i, id in ipairs(ids) do
      local pt = LuaNetManager.CreateBean("protocol.battle.point")
      pt.x = math.tointeger(math.floor(xs[i - 1] * 1000 + 0.5))
      pt.y = math.tointeger(math.floor(ys[i - 1] * 1000 + 0.5))
      req.monsters[id] = pt
    end
    req:Send()
  end
end

function TopDownController:OnSTriggleSuccess(eventid)
  if self._enabled then
    fire_event(eventid)
  else
    self._triggeredEvents[#self._triggeredEvents + 1] = eventid
  end
end

return TopDownController
