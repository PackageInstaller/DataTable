local ComposedEffect = class("ComposedEffect")
local Future = require("logic.scene.luaevent.effect.future")

function ComposedEffect:Ctor(...)
  self._effects = {
    ...
  }
  self._current = nil
  self._params = {}
end

function ComposedEffect:Destroy()
end

function ComposedEffect:AddEffect(effect)
  table.insert(self._effects, effect)
end

local function run_next_effect(self, next, args)
  args = args or {}
  return function()
    if next > table.nums(self._effects) then
      self._current = nil
      if self._callback then
        self._callback()
      else
        self._finished = true
      end
      LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
      return
    end
    self._current = next
    local effect
    if args.init then
      if self._effects[next]:GetParam("runoninit") then
        effect = self._effects[next]:GetParam("alternative") or self._effects[next]
      else
        run_next_effect(self, next + 1, args)()
        return
      end
    else
      effect = self._effects[next]
    end
    effect:Run(args)
    effect:Then(run_next_effect(self, next + 1, args))
  end
end

function ComposedEffect:Run(args)
  self._finished = false
  run_next_effect(self, 1, args)()
end

function ComposedEffect:Bind(object)
  for _, v in pairs(self._effects) do
    v:Bind(object)
  end
end

function ComposedEffect:BindOnDemand(object)
  for _, v in pairs(self._effects) do
    v:BindOnDemand(object)
  end
end

function ComposedEffect:Then(callback)
  if self._finished then
    callback()
    self._callback = nil
    self._finished = false
  else
    self._callback = callback
  end
end

function ComposedEffect:GetEffects()
  return self._effects
end

function ComposedEffect:GetParam(name)
  return name == "runoninit" or self._params and self._params[name]
end

function ComposedEffect:SetParam(name, value)
  if value == nil then
    value = true
  end
  self._params[name] = value
end

return ComposedEffect
