-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/delayedwrapper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DelayedWrapper = class("DelayedWrapper")
DelayedWrapper.Ctor = function(self, creator, binder)
  -- function num : 0_0
  self._creator = creator
  self._binder = binder
  self._finished = false
end

DelayedWrapper.Destroy = function(self)
  -- function num : 0_1
  self._finished = false
end

DelayedWrapper.Run = function(self, args)
  -- function num : 0_2
  local effect = (self._creator)()
  if self._binder then
    effect:Bind((self._binder)())
  end
  effect:Run(args)
  effect:Then(function()
    -- function num : 0_2_0 , upvalues : self
    self:OnFinished()
  end
)
end

DelayedWrapper.Then = function(self, callback)
  -- function num : 0_3
  self._callback = callback
  if self._finished then
    self._finished = false
    callback()
  end
end

DelayedWrapper.OnFinished = function(self)
  -- function num : 0_4
  self._finished = true
  if self._callback then
    (self._callback)()
  end
end

return DelayedWrapper

