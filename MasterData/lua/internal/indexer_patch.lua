return function(types)
  for i = 0, types.Length - 1 do
    local patch_target = CS.System.Activator.CreateInstance(types[i])
    local metatable = getmetatable(patch_target)
    local original_indexer = metatable.__index
    
    function metatable.__index(object, key)
      local result = original_indexer(object, key)
      if result == nil then
        local _
        _, result = object:TryGetValue(key)
      end
      return result
    end
  end
end
