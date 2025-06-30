-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/class.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("framework.readonly")
class = function(classname, super)
  -- function num : 0_0 , upvalues : _ENV
  local cls = nil
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {Ctor = function()
    -- function num : 0_0_0
  end
}
  end
  cls.__cname = classname
  cls.__index = cls
  cls.Create = function(...)
    -- function num : 0_0_1 , upvalues : _ENV, cls
    local instance = {}
    setmetatable(instance, cls)
    instance.class = cls
    instance:Ctor(...)
    return instance
  end

  return cls
end

local metatable_strictclass = {}
metatable_strictclass.__index = function(table, key)
  -- function num : 0_1 , upvalues : _ENV
  local retValue = (table.__debug__variables)[key]
  if retValue and type(retValue) == "function" then
    return function(this, ...)
    -- function num : 0_1_0 , upvalues : table, retValue
    if this == table then
      return retValue(table.__debug__variables, ...)
    else
      return retValue(this, ...)
    end
  end

  end
  return retValue
end

metatable_strictclass.__newindex = function(table, key, value)
  -- function num : 0_2 , upvalues : _ENV
  error("inaccessible due to its protection level. key = " .. tostring(key) .. ", value = " .. tostring(value))
end

strictclass = function(classname, super)
  -- function num : 0_3 , upvalues : _ENV, metatable_strictclass
  local cls = nil
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {Ctor = function()
    -- function num : 0_3_0
  end
}
  end
  cls.__cname = classname
  cls.Create = function(...)
    -- function num : 0_3_1 , upvalues : _ENV, cls, metatable_strictclass
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
metatable_dataclass.__index = function(table, key)
  -- function num : 0_4 , upvalues : _ENV
  local retValue = (table.__debug__variables)[key]
  -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

  if retValue ~= nil and type(retValue) == "function" then
    return function(this, ...)
    -- function num : 0_4_0 , upvalues : table, retValue
    if this == table then
      return retValue(table.__debug__variables, ...)
    else
      return retValue(this, ...)
    end
  end

  end
  error("\'" .. tostring((table.__debug__variables).__cname) .. "\' does not contain a definition for \'" .. tostring(key) .. "\'")
  return retValue
end

metatable_dataclass.__newindex = function(table, key, value)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  if (table.__debug__variables)[key] ~= nil then
    if type((table.__debug__variables)[key]) == type(value) or (fixedpoint.judgetype)((table.__debug__variables)[key]) and (fixedpoint.judgetype)(value) then
      (table.__debug__variables)[key] = value
    else
      error("Cannot implicitly convert type \'" .. type(value) .. "\' to \'" .. type((table.__debug__variables)[key]) .. "\'.")
    end
  else
    error("\'" .. tostring((table.__debug__variables).__cname) .. "\' does not contain a definition for \'" .. tostring(key) .. "\'")
  end
end

dataclass = function(classname, super)
  -- function num : 0_6 , upvalues : _ENV, metatable_dataclass
  local cls = nil
  if type(super) ~= "table" then
    super = nil
  end
  if super then
    cls = {}
    setmetatable(cls, {__index = super})
    cls.super = super
  else
    cls = {Ctor = function()
    -- function num : 0_6_0
  end
}
  end
  cls.__cname = classname
  cls.Create = function(...)
    -- function num : 0_6_1 , upvalues : _ENV, cls, metatable_dataclass
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
metatable_readonly.__index = function(table, key)
  -- function num : 0_7 , upvalues : _ENV
  local retValue = (table.__debug__variables)[key]
  if retValue and type(retValue) == "function" then
    if (string.sub)(key, 1, 3) == "Get" or (string.sub)(key, 1, 3) == "Can" or (string.sub)(key, 1, 2) == "Is" or key == "Clone" then
      return function(this, ...)
    -- function num : 0_7_0 , upvalues : table, retValue
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

metatable_readonly.__newindex = function(table, key, value)
  -- function num : 0_8 , upvalues : _ENV
  error("inaccessible due to its protection level. key = " .. tostring(key) .. ", value = " .. tostring(value))
end

readonly = function(class)
  -- function num : 0_9 , upvalues : _ENV, metatable_readonly
  local instanceWrapper = {}
  instanceWrapper.__debug__variables = class.__debug__variables
  setmetatable(instanceWrapper, metatable_readonly)
  return instanceWrapper
end

readonly_NEKO_RELEASE = function(class)
  -- function num : 0_10
  return class
end

readonly_table = function(tbl)
  -- function num : 0_11 , upvalues : _ENV
  return read_only(tbl)
end

readonly_table_NEKO_RELEASE = function(tbl)
  -- function num : 0_12
  return tbl
end

if NEKO_RELEASE then
  strictclass = class
  dataclass = class
  readonly = readonly_NEKO_RELEASE
end

