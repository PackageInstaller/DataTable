-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/deaddisappearcountcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local DeadDisappearCountComponent = dataclass("DeadDisappearCountComponent", Component)
DeadDisappearCountComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DeadDisappearCountComponent
  ((DeadDisappearCountComponent.super).Ctor)(self, ...)
  self._deadTotalCount = 0
  self._deadCurrentCount = 0
  self._isDeadDisappear = false
  self._battleEndTotalCount = 0
  self._battleEndCurrentCount = 0
  self._isBattleEnd = false
end

return DeadDisappearCountComponent

