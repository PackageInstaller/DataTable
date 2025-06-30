-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/effectrunner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectRunner = {}
local _id = 0
local _effects = {}
local gen_id = function()
  -- function num : 0_0 , upvalues : _id
  _id = _id + 1
  return _id
end

EffectRunner.AddEffect = function(effect)
  -- function num : 0_1 , upvalues : gen_id, _effects
  local id = gen_id()
  _effects[id] = effect
  return id
end

EffectRunner.RemoveEffect = function(id)
  -- function num : 0_2 , upvalues : _effects
  local exist = _effects[id] ~= nil
  _effects[id] = nil
  do return exist end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EffectRunner.Clear = function()
  -- function num : 0_3 , upvalues : _effects
  _effects = {}
end

EffectRunner.OnUpdate = function(deltaTime)
  -- function num : 0_4 , upvalues : _ENV, _effects
  for i,v in pairs(_effects) do
    v:OnUpdate(deltaTime)
  end
end

EffectRunner.OnFixedUpdate = function()
  -- function num : 0_5 , upvalues : _ENV, _effects
  for i,v in pairs(_effects) do
    v:OnFixedUpdate()
  end
end

EffectRunner.OnLateUpdate = function(deltaTime)
  -- function num : 0_6 , upvalues : _ENV, _effects
  for i,v in ipairs(_effects) do
    v:OnLateUpdate(deltaTime)
  end
end

return EffectRunner

