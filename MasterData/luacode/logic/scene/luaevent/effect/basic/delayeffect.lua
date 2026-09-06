local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DelayEffect = class("DelayEffect", EffectBase)

function DelayEffect:Ctor(time, context)
  self._time = time
  self._context = context
end

function DelayEffect:Run()
  self._finish = false
  self._task = self._context:AddTask(self._time, -1, function()
    self._finish = true
    if self._task then
      self._context:RemoveTask(self._task)
    end
    if self._callback then
      self._callback()
    end
  end)
end

function DelayEffect:Then(callback)
  self._callback = callback
  if self._finish then
    self._finish = false
    callback()
  end
end

return DelayEffect
