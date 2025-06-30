-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/roledeadcountcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local RoleDeadCountComponent = dataclass("RoleDeadCountComponent", Component)
RoleDeadCountComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleDeadCountComponent
  ((RoleDeadCountComponent.super).Ctor)(self, ...)
  self._maxCount = 0
  self._currentCount = 0
  self._roleDeadDisappear = false
end

return RoleDeadCountComponent

