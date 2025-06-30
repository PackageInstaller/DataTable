-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/summondatacomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local SummonDataComponent = dataclass("SummonDataComponent", Component)
SummonDataComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SummonDataComponent
  ((SummonDataComponent.super).Ctor)(self, ...)
  self._yuziSummonData = {}
  self._summonBuffData = {}
  self._alternateFighter = {}
end

return SummonDataComponent

