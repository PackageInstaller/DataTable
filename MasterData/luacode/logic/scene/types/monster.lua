local Monster = class("Monster")
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TrapHelper = CS.PixelNeko.P1.Scene.TrapHelper
local cdungeonbattleconfig = BeanManager.GetTableByName("dungeonbattle.cdungeonbattleconfig")
local cnpcshape = BeanManager.GetTableByName("npc.cnpcshape")
local cmonstermoveroute = BeanManager.GetTableByName("dungeonbattle.cmonstermoveroute")
local cmonsterchasingroute = BeanManager.GetTableByName("dungeonbattle.cmonsterchasingroute")

function Monster:Ctor(id)
  self._id = id
  self._object = nil
  self._target = nil
  self._cfg = cdungeonbattleconfig:GetRecorder(id)
  if self._cfg.chasingRoute ~= 0 then
    self._chasecfg = cmonsterchasingroute:GetRecorder(self._cfg.chasingRoute)
  end
  self._returnCount = 0
  self._initialWorldPos = {}
  self._pauseCount = {patrol = 0, chase = 0}
end

function Monster:Destroy()
  if self._minimapID then
    NekoData.BehaviorManager.BM_MiniMap:RemoveObject(self._minimapID)
    self._minimapID = nil
  end
  if self._object ~= nil then
    CS.UnityEngine.GameObject.Destroy(self._object)
    self._object = nil
  end
  if self._event then
    EventManager.RemoveEvent(self._event:GetID())
    self._event = nil
  end
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    controller:OnMonsterDestroy(self._id)
  end
end

function Monster:GetID()
  return self._id
end

function Monster:GetObject()
  return self._object
end

function Monster:GetWorldPos()
  return TransformStaticFunctions.GetPosition(self._object)
end

function Monster:GetGridPos()
  local x, y, z = TransformStaticFunctions.GetPosition(self._object)
  return math.floor(x / 0.4 + 0.5), math.floor(z / -0.56 + 0.5)
end

function Monster:GetMinimapID()
  return self._minimapID
end

function Monster:CanPatrol()
  return self._cfg.IsMoved ~= 0
end

function Monster:CanChase()
  return self._cfg.chasingRoute ~= 0
end

function Monster:SetTarget(target)
  if self._chasecfg then
    TrapHelper.SetChaseTarget(self._object, target)
    self._target = target
  end
end

function Monster:GetTarget()
  return self._target
end

function Monster:GetChaseState()
  return TrapHelper.GetChaseState(self._object)
end

function Monster:PauseChase()
  self._pauseCount.chase = self._pauseCount.chase + 1
  TrapHelper.PauseChase(self._object)
end

function Monster:ResumeChase()
  self._pauseCount.chase = math.max(0, self._pauseCount.chase - 1)
  if self._pauseCount.chase == 0 then
    TrapHelper.ResumeChase(self._object, true)
  end
end

function Monster:PausePatrol()
  self._pauseCount.patrol = self._pauseCount.patrol + 1
  TrapHelper.PausePatrol(self._object)
end

function Monster:ResumePatrol()
  self._pauseCount.patrol = math.max(0, self._pauseCount.patrol - 1)
  if self._pauseCount.patrol == 0 then
    TrapHelper.ResumePatrol(self._object)
  end
end

function Monster:BuildObject(pos, parent)
  pos = pos or {}
  local shape = cnpcshape:GetRecorder(self._cfg.Monsterid)
  local initial = string.split(self._cfg.Situation, ",")
  local x, y
  if pos.x then
    x = pos.x / 1000
  else
    x = tonumber(initial[1]) * 0.4
  end
  if pos.z then
    y = pos.z / 1000
  else
    y = tonumber(initial[2]) * -0.56
  end
  self._initialWorldPos = {
    x = tonumber(initial[1]) * 0.4,
    y = tonumber(initial[2]) * -0.56
  }
  self._initialGridPos = {
    x = math.floor(x / 0.4 + 0.5),
    y = math.floor(y / -0.56 + 0.5)
  }
  self._object = TrapHelper.CreateObject(shape.assetBundleName, shape.mapPrefabName, x, 0, y, parent)
end

local function add_patrol_points(object, battlecfg)
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

local function add_chase(object, id, cfg)
  if cfg.chasingRoute == 0 then
    return
  end
  local recorder = cmonsterchasingroute:GetRecorder(cfg.chasingRoute)
  local area = string.split(recorder.maxChasingArea, ",")
  local w, h = tonumber(area[3]) * 0.4, tonumber(area[4]) * 0.56
  local x = tonumber(area[1]) * 0.4 + w / 2
  local y = tonumber(area[2]) * -0.56 - h / 2
  local triggerRadius = tonumber(recorder.triggerRadius)
  local chasingRadius = tonumber(recorder.chasingRadius)
  if triggerRadius > chasingRadius then
    LogWarningFormat("chase", "monster %d chasing radius < trigger radius", id)
    chasingRadius = triggerRadius
  end
  TrapHelper.AddChase(object, id, triggerRadius, chasingRadius, x, y, w, h, recorder.direction)
end

function Monster:Activate()
  self._minimapID = NekoData.BehaviorManager.BM_MiniMap:AddObject(2, self._initialGridPos.y, self._initialGridPos.x, true)
  TrapHelper.AddPatrol(self._object, self._id)
  add_patrol_points(self._object, self._cfg)
  add_chase(self._object, self._id, self._cfg)
  self._event = EventManager.Builder.BuildPatrolBattleEvent(self._id, self._cfg.id, self._object, function()
    self:Destroy()
  end)
  EventManager.AddEvent(self._event)
end

function Monster:OnEnterArea()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  TrapHelper.StartChase(self._object, tonumber(self._chasecfg.chasingSpeed))
  self._returnCount = self._returnCount + 1
end

local function return_from_chase(self)
  self._task = GameTimer.AddTask(self._chasecfg.returnDelay / 1000, 0, function()
    TrapHelper.StopChase(self._object, tonumber(self._chasecfg.returnSpeed), self._initialWorldPos.x, 0, self._initialWorldPos.y, self._returnCount > self._chasecfg.chaseTimes)
    if self._returnCount > self._chasecfg.chaseTimes then
      self._returnCount = 0
    end
    self._task = nil
  end)
end

function Monster:OnLeaveRadius()
  TrapHelper.PauseChase(self._object)
  return_from_chase(self)
end

function Monster:OnLeaveArea()
  TrapHelper.PauseChase(self._object)
  return_from_chase(self)
end

return Monster
