-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/composed/composedeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedEffect = class("ComposedEffect")
local Future = require("logic.scene.luaevent.effect.future")
ComposedEffect.Ctor = function(self, ...)
  -- function num : 0_0
  self._effects = {...}
  self._current = nil
  self._params = {}
end

ComposedEffect.Destroy = function(self)
  -- function num : 0_1
end

ComposedEffect.AddEffect = function(self, effect)
  -- function num : 0_2 , upvalues : _ENV
  (table.insert)(self._effects, effect)
end

local run_next_effect = function(self, next, args)
  -- function num : 0_3 , upvalues : _ENV, run_next_effect
  if not args then
    args = {}
  end
  return function()
    -- function num : 0_3_0 , upvalues : next, _ENV, self, args, run_next_effect
    if (table.nums)(self._effects) < next then
      self._current = nil
      if self._callback then
        (self._callback)()
      else
        self._finished = true
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
      return 
    end
    self._current = next
    local effect = nil
    if args.init then
      if ((self._effects)[next]):GetParam("runoninit") and not ((self._effects)[next]):GetParam("alternative") then
        effect = (self._effects)[next]
        ;
        (run_next_effect(self, next + 1, args))()
        do return  end
        effect = (self._effects)[next]
        effect:Run(args)
        effect:Then(run_next_effect(self, next + 1, args))
      end
    end
  end

end

ComposedEffect.Run = function(self, args)
  -- function num : 0_4 , upvalues : run_next_effect
  self._finished = false
  ;
  (run_next_effect(self, 1, args))()
end

ComposedEffect.Bind = function(self, object)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(self._effects) do
    v:Bind(object)
  end
end

ComposedEffect.BindOnDemand = function(self, object)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in pairs(self._effects) do
    v:BindOnDemand(object)
  end
end

ComposedEffect.Then = function(self, callback)
  -- function num : 0_7
  if self._finished then
    callback()
    self._callback = nil
    self._finished = false
  else
    self._callback = callback
  end
end

ComposedEffect.GetEffects = function(self)
  -- function num : 0_8
  return self._effects
end

ComposedEffect.GetParam = function(self, name)
  -- function num : 0_9
  do return (name == "runoninit" or self._params) and (self._params)[name] end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ComposedEffect.SetParam = function(self, name, value)
  -- function num : 0_10
  if value == nil then
    value = true
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._params)[name] = value
end

return ComposedEffect

