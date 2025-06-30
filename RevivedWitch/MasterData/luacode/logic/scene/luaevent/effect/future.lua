-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/future.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Future = class("Future")
Future.Ctor = function(self, root, args)
  -- function num : 0_0
  self._root = root
  self._args = args
  self._params = {}
end

Future.Destroy = function(self)
  -- function num : 0_1
end

Future.Then = function(self, callback)
  -- function num : 0_2
  if self._finish then
    self._finish = false
    callback()
    self._callback = nil
  else
    self._callback = callback
  end
  return self
end

Future.Run = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  ;
  (self._root):Run(self._args or args)
  ;
  (self._root):Then(function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self._finish = true
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
    if self._callback then
      (self._callback)()
    end
  end
)
end

Future.GetParam = function(self, name)
  -- function num : 0_4
  return (self._params)[name]
end

Future.SetParam = function(self, name, value)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._params)[name] = value
end

Future.Finished = function(self)
  -- function num : 0_6
  return self._finish
end

Future.NoOp = function()
  -- function num : 0_7 , upvalues : _ENV
  return {Run = function(self)
    -- function num : 0_7_0 , upvalues : _ENV
    self.finished = true
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
    if self.callback then
      (self.callback)()
    end
  end
, Then = function(self, c)
    -- function num : 0_7_1
    if self.finished then
      c()
    else
      self.callback = c
    end
  end
, Finished = function()
    -- function num : 0_7_2
    return true
  end
, GetParam = function()
    -- function num : 0_7_3
  end
, SetParam = function()
    -- function num : 0_7_4
  end
, Destroy = function()
    -- function num : 0_7_5
  end
}
end

return Future

