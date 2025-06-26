-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/delayeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DelayEffect = class("DelayEffect", EffectBase)
DelayEffect.Ctor = function(self, time, context)
  -- function num : 0_0
  self._time = time
  self._context = context
end

DelayEffect.Run = function(self)
  -- function num : 0_1
  self._finish = false
  self._task = (self._context):AddTask(self._time, -1, function()
    -- function num : 0_1_0 , upvalues : self
    self._finish = true
    if self._task then
      (self._context):RemoveTask(self._task)
    end
    if self._callback then
      (self._callback)()
    end
  end
)
end

DelayEffect.Then = function(self, callback)
  -- function num : 0_2
  self._callback = callback
  if self._finish then
    self._finish = false
    callback()
  end
end

return DelayEffect

