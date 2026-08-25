local hook

local function setHook(h)
  hook = h
end

local function devtoolPlugin(store)
  if not hook then
    return
  end
  hook.emit("vuex:init", store)
  hook.on("vuex:travel-to-state", function(targetState)
    store:replaceState(targetState)
  end)
  hook.on("vuex:patch-to-state", function(targetState)
    store:patchState(targetState)
  end)
  store:subscribe(function(type, payload, state)
    hook.emit("vuex:mutation", type, payload, state)
  end)
end

return {devtoolPlugin = devtoolPlugin, setHook = setHook}
