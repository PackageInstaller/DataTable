-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/createrolecomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local CreaterRoleComponent = dataclass("CreaterRoleComponent", Component)
CreaterRoleComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CreaterRoleComponent
  ((CreaterRoleComponent.super).Ctor)(self, ...)
  self._playerInfoList = {}
end

return CreaterRoleComponent

