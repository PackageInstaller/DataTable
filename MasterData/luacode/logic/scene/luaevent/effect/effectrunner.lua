local EffectRunner = {}
local _id = 0
local _effects = {}

local function gen_id()
  _id = _id + 1
  return _id
end

function EffectRunner.AddEffect(effect)
  local id = gen_id()
  _effects[id] = effect
  return id
end

function EffectRunner.RemoveEffect(id)
  local exist = _effects[id] ~= nil
  _effects[id] = nil
  return exist
end

function EffectRunner.Clear()
  _effects = {}
end

function EffectRunner.OnUpdate(deltaTime)
  for i, v in pairs(_effects) do
    v:OnUpdate(deltaTime)
  end
end

function EffectRunner.OnFixedUpdate()
  for i, v in pairs(_effects) do
    v:OnFixedUpdate()
  end
end

function EffectRunner.OnLateUpdate(deltaTime)
  for i, v in ipairs(_effects) do
    v:OnLateUpdate(deltaTime)
  end
end

return EffectRunner
