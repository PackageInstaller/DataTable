local Future = class("Future")

function Future:Ctor(root, args)
  self._root = root
  self._args = args
  self._params = {}
end

function Future:Destroy()
end

function Future:Then(callback)
  if self._finish then
    self._finish = false
    callback()
    self._callback = nil
  else
    self._callback = callback
  end
  return self
end

function Future:Run(args)
  self._root:Run(self._args or args)
  self._root:Then(function()
    self._finish = true
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
    if self._callback then
      self._callback()
    end
  end)
end

function Future:GetParam(name)
  return self._params[name]
end

function Future:SetParam(name, value)
  self._params[name] = value
end

function Future:Finished()
  return self._finish
end

function Future.NoOp()
  return {
    Run = function(self)
      self.finished = true
      LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
      if self.callback then
        self.callback()
      end
    end,
    Then = function(self, c)
      if self.finished then
        c()
      else
        self.callback = c
      end
    end,
    Finished = function()
      return true
    end,
    GetParam = function()
    end,
    SetParam = function()
    end,
    Destroy = function()
    end
  }
end

return Future
