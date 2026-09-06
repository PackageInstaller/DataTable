local DelayedWrapper = class("DelayedWrapper")

function DelayedWrapper:Ctor(creator, binder)
  self._creator = creator
  self._binder = binder
  self._finished = false
end

function DelayedWrapper:Destroy()
  self._finished = false
end

function DelayedWrapper:Run(args)
  local effect = self._creator()
  if self._binder then
    effect:Bind(self._binder())
  end
  effect:Run(args)
  effect:Then(function()
    self:OnFinished()
  end)
end

function DelayedWrapper:Then(callback)
  self._callback = callback
  if self._finished then
    self._finished = false
    callback()
  end
end

function DelayedWrapper:OnFinished()
  self._finished = true
  if self._callback then
    self._callback()
  end
end

return DelayedWrapper
