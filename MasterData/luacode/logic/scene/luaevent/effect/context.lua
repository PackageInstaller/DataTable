local Context = class("Context")

function Context:Ctor()
  self._timers = {}
end

function Context:Destroy()
  for _, v in pairs(self._timers) do
    GameTimer.RemoveTask(v)
  end
  self._timers = {}
end

function Context:AddTask(...)
  local timer = GameTimer.AddTask(...)
  self._timers[#self._timers + 1] = timer
end

function Context:RemoveTask(id)
  for i, v in pairs(self._timers) do
    if v == id then
      GameTimer.RemoveTask(id)
      self._timers[i] = nil
      return
    end
  end
end

return Context
