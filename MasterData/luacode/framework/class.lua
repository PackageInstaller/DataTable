require("framework.readonly")

function class(classname, super)
  local cls
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {
      Ctor = function()
      end
    }
  end
  cls.__cname = classname
  cls.__index = cls
  
  function cls.Create(...)
    local instance = {}
    setmetatable(instance, cls)
    instance.class = cls
    instance:Ctor(...)
    return instance
  end
  
  return cls
end

local metatable_strictclass = {}

function metatable_strictclass.__index(table, key)
  local retValue = table.__debug__variables[key]
  if retValue and type(retValue) == "function" then
    return function(this, ...)
      if this == table then
        return retValue(table.__debug__variables, ...)
      else
        return retValue(this, ...)
      end
    end
  end
  return retValue
end

function metatable_strictclass.__newindex(table, key, value)
  error("inaccessible due to its protection level. key = " .. tostring(key) .. ", value = " .. tostring(value))
end

function strictclass(classname, super)
  local cls
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {
      Ctor = function()
      end
    }
  end
  cls.__cname = classname
  
  function cls.Create(...)
    local instance = {}
    setmetatable(instance, {__index = cls})
    instance:Ctor(...)
    local instanceWrapper = {}
    instanceWrapper.__debug__class = cls
    instanceWrapper.__debug__variables = instance
    setmetatable(instanceWrapper, metatable_strictclass)
    return instanceWrapper
  end
  
  return cls
end

local metatable_dataclass = {}

function metatable_dataclass.__index(table, key)
  local retValue = table.__debug__variables[key]
  if retValue ~= nil then
    if type(retValue) == "function" then
      return function(this, ...)
        if this == table then
          return retValue(table.__debug__variables, ...)
        else
          return retValue(this, ...)
        end
      end
    end
  else
    error("'" .. tostring(table.__debug__variables.__cname) .. "' does not contain a definition for '" .. tostring(key) .. "'")
  end
  return retValue
end

function metatable_dataclass.__newindex(table, key, value)
  if table.__debug__variables[key] ~= nil then
    if type(table.__debug__variables[key]) == type(value) or fixedpoint.judgetype(table.__debug__variables[key]) and fixedpoint.judgetype(value) then
      table.__debug__variables[key] = value
    else
      error("Cannot implicitly convert type '" .. type(value) .. "' to '" .. type(table.__debug__variables[key]) .. "'.")
    end
  else
    error("'" .. tostring(table.__debug__variables.__cname) .. "' does not contain a definition for '" .. tostring(key) .. "'")
  end
end

function dataclass(classname, super)
  local cls
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {
      Ctor = function()
      end
    }
  end
  cls.__cname = classname
  
  function cls.Create(...)
    local instance = {}
    setmetatable(instance, {__index = cls})
    instance:Ctor(...)
    local instanceWrapper = {}
    instanceWrapper.__debug__class = cls
    instanceWrapper.__debug__variables = instance
    setmetatable(instanceWrapper, metatable_dataclass)
    return instanceWrapper
  end
  
  return cls
end

local metatable_readonly = {}

function metatable_readonly.__index(table, key)
  local retValue = table.__debug__variables[key]
  if retValue and type(retValue) == "function" then
    if string.sub(key, 1, 3) == "Get" or string.sub(key, 1, 3) == "Can" or string.sub(key, 1, 2) == "Is" or key == "Clone" then
      return function(this, ...)
        if this == table then
          return retValue(table.__debug__variables, ...)
        else
          return retValue(this, ...)
        end
      end
    else
      error("inaccessible due to its protection level. key = " .. tostring(key))
    end
  else
    error("inaccessible due to its protection level. key = " .. tostring(key))
  end
end

function metatable_readonly.__newindex(table, key, value)
  error("inaccessible due to its protection level. key = " .. tostring(key) .. ", value = " .. tostring(value))
end

function readonly(class)
  local instanceWrapper = {}
  instanceWrapper.__debug__variables = class.__debug__variables
  setmetatable(instanceWrapper, metatable_readonly)
  return instanceWrapper
end

function readonly_NEKO_RELEASE(class)
  return class
end

function readonly_table(tbl)
  return read_only(tbl)
end

function readonly_table_NEKO_RELEASE(tbl)
  return tbl
end

if NEKO_RELEASE then
  strictclass = class
  dataclass = class
  readonly = readonly_NEKO_RELEASE
end
