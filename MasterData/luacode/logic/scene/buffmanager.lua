local SceneBuffManager = class("BuffManager")
local cdungeonbuffconfig = BeanManager.GetTableByName("sceneinteractive.cdungeonbuffconfig")
local AccelerateBuff = require("logic.scene.types.buff.acceleratebuff")
local InvisibleBuff = require("logic.scene.types.buff.invisiblebuff")

function SceneBuffManager:Ctor()
  self._buffs = {}
  self._current = -1
  self._timers = {}
end

function SceneBuffManager:Destroy()
  for _, v in pairs(self._buffs) do
    v:HideEffect()
    v:Destroy()
  end
  self._buffs = {}
  for _, v in pairs(self._timers) do
    GameTimer.RemoveTask(v)
  end
  self._timers = {}
end

function SceneBuffManager:Init(sceneid, buffinfo)
  self._sceneID = sceneid
  local buffs = {}
  for _, i in pairs(cdungeonbuffconfig:GetAllIds()) do
    local recorder = cdungeonbuffconfig:GetRecorder(i)
    if recorder.sceneID == sceneid then
      buffs[#buffs + 1] = self:CreateBuff(i)
    end
  end
  for _, v in ipairs(buffs) do
    local status = buffinfo[v:GetID()]
    if status == 1 then
      v:ToState(0)
    elseif status == 0 then
      v:ToState(2)
    end
    v:Activate()
    self:AddBuff(v)
  end
end

function SceneBuffManager:OnDisable()
  if self._current ~= -1 then
    self:OnBuffTimeout(self._current)
  end
end

function SceneBuffManager:CreateBuff(id, ...)
  local recorder = cdungeonbuffconfig:GetRecorder(id)
  if recorder.typeID == 1 then
    return AccelerateBuff.Create(id, ...)
  elseif recorder.typeID == 2 then
    return InvisibleBuff.Create(id, ...)
  end
  LogErrorFormat("buff", "invalid scene buff type %d @ %d", recorder.typeID, id)
end

function SceneBuffManager:AddBuff(buff)
  if self._buffs[buff:GetID()] then
    return false
  end
  self._buffs[buff:GetID()] = buff
  if buff:GetState() == 0 then
    self:OnRespawnTimeout(buff:GetID())
  elseif buff:GetState() == 2 then
    self:OnBuffTimeout(buff:GetID())
  end
  return true
end

function SceneBuffManager:Activate(id)
  if self._current ~= -1 and self._current ~= id then
    self:OnBuffTimeout(self._current)
    GameTimer.RemoveTask(self._timers[self._current])
    self._timers[self._current] = nil
  end
  self._buffs[id]:OnActive()
  local time = self._buffs[id]:GetDurationTime()
  local task = GameTimer.AddTask(time, 0, function()
    self:OnBuffTimeout(id)
  end)
  self._timers[id] = task
  self._current = id
end

function SceneBuffManager:GetBuff(id)
  return self._buffs[id]
end

function SceneBuffManager:RemoveBuff(id)
  if self._timers[id] then
    GameTimer.RemoveTask(self._timers[id])
    self._timers[id] = nil
  end
  if self._buffs[id] then
    self._buffs[id]:HideEffect()
    self._buffs[id]:Destroy()
    self._buffs[id] = nil
    return true
  else
    return false
  end
end

function SceneBuffManager:GetCurrentBuff()
  if self._current ~= -1 then
    return self._buffs[self._current]
  end
end

function SceneBuffManager:OnBuffTimeout(id)
  self._buffs[id]:OnInactivate()
  local time = self._buffs[id]:GetRespawnTime()
  local task = GameTimer.AddTask(time, 0, function()
    self:OnRespawnTimeout(id)
  end)
  GameTimer.RemoveTask(self._timers[id])
  self._timers[id] = task
  if self._current == id then
    self._current = -1
  end
end

function SceneBuffManager:OnRespawnTimeout(id)
  self._buffs[id]:OnRespawn()
end

function SceneBuffManager:OnUpdate(delta)
  if self._current ~= -1 then
    self._buffs[self._current]:OnUpdate(delta)
  end
end

return SceneBuffManager
