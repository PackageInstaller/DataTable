-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/buffmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneBuffManager = class("BuffManager")
local cdungeonbuffconfig = (BeanManager.GetTableByName)("sceneinteractive.cdungeonbuffconfig")
local AccelerateBuff = require("logic.scene.types.buff.acceleratebuff")
local InvisibleBuff = require("logic.scene.types.buff.invisiblebuff")
SceneBuffManager.Ctor = function(self)
  -- function num : 0_0
  self._buffs = {}
  self._current = -1
  self._timers = {}
end

SceneBuffManager.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._buffs) do
    v:HideEffect()
    v:Destroy()
  end
  self._buffs = {}
  for _,v in pairs(self._timers) do
    (GameTimer.RemoveTask)(v)
  end
  self._timers = {}
end

SceneBuffManager.Init = function(self, sceneid, buffinfo)
  -- function num : 0_2 , upvalues : _ENV, cdungeonbuffconfig
  self._sceneID = sceneid
  local buffs = {}
  for _,i in pairs(cdungeonbuffconfig:GetAllIds()) do
    local recorder = cdungeonbuffconfig:GetRecorder(i)
    if recorder.sceneID == sceneid then
      buffs[#buffs + 1] = self:CreateBuff(i)
    end
  end
  for _,v in ipairs(buffs) do
    local status = buffinfo[v:GetID()]
    if status == 1 then
      v:ToState(0)
    else
      if status == 0 then
        v:ToState(2)
      end
    end
    v:Activate()
    self:AddBuff(v)
  end
end

SceneBuffManager.OnDisable = function(self)
  -- function num : 0_3
  if self._current ~= -1 then
    self:OnBuffTimeout(self._current)
  end
end

SceneBuffManager.CreateBuff = function(self, id, ...)
  -- function num : 0_4 , upvalues : cdungeonbuffconfig, AccelerateBuff, InvisibleBuff, _ENV
  local recorder = cdungeonbuffconfig:GetRecorder(id)
  if recorder.typeID == 1 then
    return (AccelerateBuff.Create)(id, ...)
  else
    if recorder.typeID == 2 then
      return (InvisibleBuff.Create)(id, ...)
    end
  end
  LogErrorFormat("buff", "invalid scene buff type %d @ %d", recorder.typeID, id)
end

SceneBuffManager.AddBuff = function(self, buff)
  -- function num : 0_5
  if (self._buffs)[buff:GetID()] then
    return false
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._buffs)[buff:GetID()] = buff
  if buff:GetState() == 0 then
    self:OnRespawnTimeout(buff:GetID())
  else
    if buff:GetState() == 2 then
      self:OnBuffTimeout(buff:GetID())
    end
  end
  return true
end

SceneBuffManager.Activate = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  if self._current ~= -1 and self._current ~= id then
    self:OnBuffTimeout(self._current)
    ;
    (GameTimer.RemoveTask)((self._timers)[self._current])
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._timers)[self._current] = nil
  end
  ;
  ((self._buffs)[id]):OnActive()
  local time = ((self._buffs)[id]):GetDurationTime()
  local task = (GameTimer.AddTask)(time, 0, function()
    -- function num : 0_6_0 , upvalues : self, id
    self:OnBuffTimeout(id)
  end
)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._timers)[id] = task
  self._current = id
end

SceneBuffManager.GetBuff = function(self, id)
  -- function num : 0_7
  return (self._buffs)[id]
end

SceneBuffManager.RemoveBuff = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  if (self._timers)[id] then
    (GameTimer.RemoveTask)((self._timers)[id])
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._timers)[id] = nil
  end
  if (self._buffs)[id] then
    ((self._buffs)[id]):HideEffect()
    ;
    ((self._buffs)[id]):Destroy()
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._buffs)[id] = nil
    return true
  else
    return false
  end
end

SceneBuffManager.GetCurrentBuff = function(self)
  -- function num : 0_9
  if self._current ~= -1 then
    return (self._buffs)[self._current]
  end
end

SceneBuffManager.OnBuffTimeout = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  ((self._buffs)[id]):OnInactivate()
  local time = ((self._buffs)[id]):GetRespawnTime()
  local task = (GameTimer.AddTask)(time, 0, function()
    -- function num : 0_10_0 , upvalues : self, id
    self:OnRespawnTimeout(id)
  end
)
  ;
  (GameTimer.RemoveTask)((self._timers)[id])
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._timers)[id] = task
  if self._current == id then
    self._current = -1
  end
end

SceneBuffManager.OnRespawnTimeout = function(self, id)
  -- function num : 0_11
  ((self._buffs)[id]):OnRespawn()
end

SceneBuffManager.OnUpdate = function(self, delta)
  -- function num : 0_12
  if self._current ~= -1 then
    ((self._buffs)[self._current]):OnUpdate(delta)
  end
end

return SceneBuffManager

