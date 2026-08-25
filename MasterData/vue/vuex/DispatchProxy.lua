local function new(store, mutations)
  local mt = {}
  
  local proxy = {}
  
  function mt:__index(key)
    if self == proxy then
      if mutations and type(mutations[key]) ~= "function" then
        error("cannot find mutation : " .. key)
      end
      
      local function dispatchFn(proxy, ...)
        store:dispatch(key, ...)
      end
      
      proxy[key] = dispatchFn
      return dispatchFn
    else
      error("cannot call with dot mutation : " .. key)
    end
  end
  
  setmetatable(proxy, mt)
  return proxy
end

return {new = new}
