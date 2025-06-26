-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/enum_camp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Enum_Camp = dataclass("Enum_Camp")
Enum_Camp.LeftFighter = 1
Enum_Camp.RightFighter = 2
Enum_Camp.Ctor = function(self)
  -- function num : 0_0
end

Enum_Camp.Marshal = function(self, data)
  -- function num : 0_1
end

Enum_Camp.Unmarshal = function(self, data)
  -- function num : 0_2
end

Enum_Camp.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return Enum_Camp

