local middleclass = {
  _VERSION = "middleclass v4.1.1",
  _DESCRIPTION = "Object Orientation for Lua",
  _URL = "https://github.com/kikito/middleclass",
  _LICENSE = "    MIT LICENSE\n    Copyright (c) 2011 Enrique García Cota\n    Permission is hereby granted, free of charge, to any person obtaining a\n    copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\n    without limitation the rights to use, copy, modify, merge, publish,\n    distribute, sublicense, and/or sell copies of the Software, and to\n    permit persons to whom the Software is furnished to do so, subject to\n    the following conditions:\n    The above copyright notice and this permission notice shall be included\n    in all copies or substantial portions of the Software.\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n  "
}

local function _createIndexWrapper(aClass, f)
  if nil == f then
    return aClass.__instanceDict
  else
    return function(self, name)
      local value = aClass.__instanceDict[name]
      if nil ~= value then
        return value
      elseif type(f) == "function" then
        return (f(self, name))
      else
        return f[name]
      end
    end
  end
end

local function _propagateInstanceMethod(aClass, name, f)
  f = "__index" == name and _createIndexWrapper(aClass, f) or f
  aClass.__instanceDict[name] = f
  for subclass in pairs(aClass.subclasses) do
    if rawget(subclass.__declaredMethods, name) == nil then
      _propagateInstanceMethod(subclass, name, f)
    end
  end
end

local function _declareInstanceMethod(aClass, name, f)
  aClass.__declaredMethods[name] = f
  if nil == f and aClass.super then
    f = aClass.super.__instanceDict[name]
  end
  _propagateInstanceMethod(aClass, name, f)
end

local function _tostring(self)
  return "class " .. self.name
end

local function _call(self, ...)
  return self:new(...)
end

local function _createClass(name, super)
  local dict = {}
  dict.__index = dict
  local aClass = {
    name = name,
    super = super,
    static = {},
    __instanceDict = dict,
    __declaredMethods = {},
    subclasses = setmetatable({}, {__mode = "k"})
  }
  if super then
    setmetatable(aClass.static, {
      __index = function(_, k)
        local result = rawget(dict, k)
        if nil == result then
          return super.static[k]
        end
        return result
      end
    })
  else
    setmetatable(aClass.static, {
      __index = function(_, k)
        return rawget(dict, k)
      end
    })
  end
  setmetatable(aClass, {
    __index = aClass.static,
    __tostring = _tostring,
    __call = _call,
    __newindex = _declareInstanceMethod
  })
  return aClass
end

local function _includeMixin(aClass, mixin)
  assert(type(mixin) == "table", "mixin must be a table")
  for name, method in pairs(mixin) do
    if "included" ~= name and "static" ~= name then
      aClass[name] = method
    end
  end
  for name, method in pairs(mixin.static or {}) do
    aClass.static[name] = method
  end
  if type(mixin.included) == "function" then
    mixin:included(aClass)
  end
  return aClass
end

local DefaultMixin = {
  __tostring = function(self)
    return "instance of " .. tostring(self.class)
  end,
  initialize = function(self, ...)
  end,
  isInstanceOf = function(self, aClass)
    return type(aClass) == "table" and type(self) == "table" and (self.class == aClass or "table" == type(self.class) and type(self.class.isSubclassOf) == "function" and self.class:isSubclassOf(aClass))
  end,
  static = {
    allocate = function(self)
      assert(type(self) == "table", "Make sure that you are using 'Class:allocate' instead of 'Class.allocate'")
      return setmetatable({class = self}, self.__instanceDict)
    end,
    new = function(self, ...)
      assert(type(self) == "table", "Make sure that you are using 'Class:new' instead of 'Class.new'")
      local instance = self:allocate()
      instance:initialize(...)
      return instance
    end,
    newWith = function(self, instance, ...)
      assert(type(self) == "table", "Make sure that you are using 'Class:new' instead of 'Class.new'")
      assert(type(instance) == "table", "Make sure instance is table")
      instance.class = self
      setmetatable(instance, self.__instanceDict)
      instance:initialize(...)
      return instance
    end,
    subclass = function(self, name)
      assert(type(self) == "table", "Make sure that you are using 'Class:subclass' instead of 'Class.subclass'")
      assert(type(name) == "string", "You must provide a name(string) for your class")
      local subclass = _createClass(name, self)
      for methodName, f in pairs(self.__instanceDict) do
        _propagateInstanceMethod(subclass, methodName, f)
      end
      
      function subclass.initialize(instance, ...)
        return self.initialize(instance, ...)
      end
      
      self.subclasses[subclass] = true
      self:subclassed(subclass)
      return subclass
    end,
    subclassed = function(self, other)
    end,
    isSubclassOf = function(self, other)
      return type(other) == "table" and "table" == type(self.super) and (self.super == other or self.super:isSubclassOf(other))
    end,
    include = function(self, ...)
      assert(type(self) == "table", "Make sure you that you are using 'Class:include' instead of 'Class.include'")
      for _, mixin in ipairs({
        ...
      }) do
        _includeMixin(self, mixin)
      end
      return self
    end
  }
}

function middleclass.class(name, super)
  assert(type(name) == "string", "A name (string) is needed for the new class")
  return super and super:subclass(name) or _includeMixin(_createClass(name), DefaultMixin)
end

setmetatable(middleclass, {
  __call = function(_, ...)
    return middleclass.class(...)
  end
})
return middleclass
