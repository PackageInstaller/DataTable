local SceneBuff = class("Buff")
local cdungeonbuffconfig = BeanManager.GetTableByName("sceneinteractive.cdungeonbuffconfig")

function SceneBuff:Ctor(id)
  self._id = id
  self._state = 0
  self._cfg = cdungeonbuffconfig:GetRecorder(id)
end

function SceneBuff:Destroy()
end

function SceneBuff:Activate()
end

function SceneBuff:Deactivate()
end

function SceneBuff:GetID()
  return self._id
end

function SceneBuff:GetType()
  return self._cfg.typeID
end

function SceneBuff:GetState()
  return self._state
end

function SceneBuff:ToState(state)
  self._state = state
end

function SceneBuff:GetDurationTime()
end

function SceneBuff:GetRespawnTime()
end

function SceneBuff:OnActive()
end

function SceneBuff:OnInactivate()
end

function SceneBuff:OnRespawn()
end

function SceneBuff:OnUpdate(delta)
end

return SceneBuff
