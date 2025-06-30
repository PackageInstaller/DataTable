-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/login/lineupstation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local LineupStation = dataclass("LineupStation")
LineupStation.FRONT_ROW = 1
LineupStation.MIDDLE_ROW = 2
LineupStation.BACK_ROW = 3
LineupStation.ALTERNATE_FRONT_ROW = 4
LineupStation.ALTERNATE_MIDDLE_ROW = 5
LineupStation.ALTERNATE_BACK_ROW = 6
LineupStation.Ctor = function(self)
  -- function num : 0_0
end

LineupStation.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

LineupStation.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return LineupStation

