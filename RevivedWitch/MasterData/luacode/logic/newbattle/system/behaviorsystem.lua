-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/behaviorsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local BehaviorSystem = strictclass("BehaviorSystem", System)
BehaviorSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BehaviorSystem, _ENV
  ((BehaviorSystem.super).Ctor)(self, ...)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).BehaviorComponent)
end

BehaviorSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : BehaviorSystem
  ((BehaviorSystem.super).Destroy)(self)
end

BehaviorSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local BehaviorComponent = (BattleECS.Components).BehaviorComponent
  for _,entity in ipairs(self._entitys) do
    ((entity:GetComponent(BehaviorComponent))._behavior):Exec3(0)
  end
end

return BehaviorSystem

