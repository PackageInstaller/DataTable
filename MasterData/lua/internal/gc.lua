local GC = {
  subscribers = {}
}

function GC:restart()
  collectgarbage("setpause", 200)
  collectgarbage("setstepmul", 200)
  collectgarbage("restart")
end

function GC:stop()
  collectgarbage("stop")
end

function GC:count()
  return collectgarbage("count")
end

function GC:collect()
  for func, _ in pairs(self.subscribers) do
    func()
  end
  collectgarbage("collect")
  collectgarbage("collect")
end

function GC:subscribe(func)
  self.subscribers[func] = true
end

function GC:unsubscribe(func)
  self.subscribers[func] = nil
end

return GC
