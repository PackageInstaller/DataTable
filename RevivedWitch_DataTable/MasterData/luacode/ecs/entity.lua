-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/ecs/entity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Entity = class("Entity")
Entity.Ctor = function(self, world, entityId)
  -- function num : 0_0
  self._world = world
  self._entityId = entityId
  self._components = {}
end

Entity.AddComponent = function(self, ComponentClass, ...)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._components)[ComponentClass.__cname] then
    (self._components)[ComponentClass.__cname] = (ComponentClass.Create)(self, ...)
    ;
    (self._world):FireEvent(((self._world)._events).ComponentAdded, self, (self._components)[ComponentClass.__cname])
  end
  return (self._components)[ComponentClass.__cname]
end

Entity.GetComponent = function(self, ComponentClass)
  -- function num : 0_2
  return (self._components)[ComponentClass.__cname]
end

Entity.GetComponents = function(self, ...)
  -- function num : 0_3 , upvalues : _ENV
  local ComponentClasses = (table.pack)(...)
  local components = {}
  for i = 1, ComponentClasses.n do
    components[i] = (self._components)[(ComponentClasses[i]).__cname]
  end
  return (table.unpack)(components, 1, ComponentClasses.n)
end

Entity.RemoveComponent = function(self, ComponentClass)
  -- function num : 0_4
  if (self._components)[ComponentClass.__cname] then
    (self._world):FireEvent(((self._world)._events).ComponentWillRemoved, self, (self._components)[ComponentClass.__cname])
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._components)[ComponentClass.__cname] = nil
  end
end

Entity.Destroy = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local deleteComponents = {}
  for componentName,_ in pairs(self._components) do
    (table.insert)(deleteComponents, componentName)
  end
  for _,componentName in ipairs(deleteComponents) do
    if (self._components)[componentName] then
      (self._world):FireEvent(((self._world)._events).ComponentWillRemoved, self, (self._components)[componentName])
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._components)[componentName] = nil
    end
  end
end

return Entity

