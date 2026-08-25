local DT = require("System.DataTable")
local DTFileSpier = {}

function DTFileSpier.new(owner, file, cache)
  local inst = {
    __owner = owner,
    __file = file,
    __cache = cache or false
  }
  do return setmetatable, inst end
  return setmetatable, inst, DTFileSpier
end

function DTFileSpier:__index(key)
  if nil == key then
    return
  end
  local cfg = self.__owner:GetLine(self.__file, key)
  if self.__cache and nil ~= key then
    self[key] = cfg
  end
  if not cfg and self.__owner.isServerBattle then
    local Log = require("log")
  end
  return cfg
end

local DTSpier = {}

function DTSpier.new(owner, cache)
  local inst = {
    __owner = owner,
    __dtFiles = {},
    __cache = cache or false
  }
  do return setmetatable, inst end
  return setmetatable, inst, DTSpier
end

function DTSpier:__index(key)
  local func = DTSpier[key]
  if type(func) == "function" then
    return function(arg1, ...)
      if arg1 == self then
        do return func, self, ... end
        return func, self, ...
      else
        do return func, self, arg1, ... end
        return func, self, arg1, ...
      end
    end
  end
  local dtFiles = self.__dtFiles
  local dtFileSpier = dtFiles[key]
  if not dtFileSpier then
    dtFileSpier = DTFileSpier.new(self.__owner, key, self.__cache)
    dtFiles[key] = dtFileSpier
  end
  return dtFileSpier
end

function DTSpier:GetResourceCache()
  return self.__owner
end

function DTSpier:GetConstant(key, defaultVal)
  local cfg = self.Constant[key]
  local v
  if cfg then
    if type(cfg.Data) == "table" then
      v = cfg.Data[1]
    else
      v = cfg.Data
    end
  end
  if nil ~= v then
    return v
  else
    return defaultVal
  end
end

function DTSpier:GetOriginalConstant(key, defaultVal)
  local cfg = self.Constant[key]
  if not cfg then
    return defaultVal
  end
  local data = cfg.Data
  if nil ~= data then
    return data
  else
    return defaultVal
  end
end

function DTSpier:LoopTable(tableName, func)
  local tableData = self[tableName]
  local cfg = DT[tableName]
  for key, data in pairs(cfg) do
    local cache = tableData[key]
    func(key, data)
  end
end

return DTSpier
