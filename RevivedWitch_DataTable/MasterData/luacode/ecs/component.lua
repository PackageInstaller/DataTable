-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/ecs/component.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = dataclass("Component")
Component.Ctor = function(self, entity)
  -- function num : 0_0
  self._entity = entity
end

return Component

