-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/behaviorcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local BehaviorComponent = dataclass("BehaviorComponent", Component)
BehaviorComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BehaviorComponent
  ((BehaviorComponent.super).Ctor)(self, ...)
  self._behavior = {}
end

return BehaviorComponent

