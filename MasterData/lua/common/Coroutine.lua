local CO = {}
local default_runner
local co_runner = setmetatable({}, {__mode = "v"})

function CO.call(co, ...)
  local ret, message = coroutine.resume(co, ...)
  if not ret then
    error("Coroutine", message)
  end
end

function CO.coroutine_call(func, owner)
  return function(...)
    local co = coroutine.create(func)
    if owner ~= nil then
      local runner = owner:GetComponent(typeof(CS.CoroutineRunner))
      if runner == nil then
        runner = owner.gameObject:AddComponent(typeof(CS.CoroutineRunner))
      end
      co_runner[co] = runner
    end
    CO.call(co, ...)
  end
end

function CO.yield_return(yield_to)
  local co = coroutine.running() or error("this function must be run in coroutine")
  
  local function func_for_resuming()
    CO.call(co)
  end
  
  local runner = co_runner[co]
  if runner == nil then
    if default_runner == nil then
      default_runner = CS.LuaManager.Instance:GetComponent(typeof(CS.CoroutineRunner))
    end
    runner = default_runner
  end
  runner:YieldAndCallback(yield_to, func_for_resuming)
  coroutine.yield()
end

return CO
