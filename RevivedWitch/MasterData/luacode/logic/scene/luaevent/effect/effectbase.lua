-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/effectbase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = class("EffectBase")
EffectBase.Ctor = function(self)
  -- function num : 0_0
  self._params = {}
end

EffectBase.SetCfgID = function(self, id)
  -- function num : 0_1
  self._cfgid = id
end

EffectBase.GetCfgID = function(self)
  -- function num : 0_2
  return self._cfgid
end

EffectBase.Destroy = function(self)
  -- function num : 0_3
end

EffectBase.Run = function(self, args)
  -- function num : 0_4
end

EffectBase.Cancel = function(self)
  -- function num : 0_5
end

EffectBase.Then = function(self, callback)
  -- function num : 0_6 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  callback()
end

EffectBase.Bind = function(self, object)
  -- function num : 0_7
  self._object = object
  local alternative = self:GetParam("alternative")
  if alternative then
    alternative:Bind(object)
  end
end

EffectBase.BindOnDemand = function(self, object)
  -- function num : 0_8
  if not self._path or self._path == "" then
    self._object = object
    local alternative = self:GetParam("alternative")
    if alternative then
      alternative:BindOnDemand(object)
    end
  end
end

EffectBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_9
end

EffectBase.OnFixedUpdate = function(self)
  -- function num : 0_10
end

EffectBase.OnLateUpdate = function(self, deltaTime)
  -- function num : 0_11
end

EffectBase.GetParam = function(self, name)
  -- function num : 0_12
  if self._params then
    return (self._params)[name]
  end
end

EffectBase.SetParam = function(self, name, value)
  -- function num : 0_13
  if value == nil then
    value = true
  end
  if not self._params then
    self._params = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._params)[name] = value
  end
end

return EffectBase

