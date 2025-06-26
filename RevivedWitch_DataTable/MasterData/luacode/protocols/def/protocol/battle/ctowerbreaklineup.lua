-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ctowerbreaklineup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTowerBreakLineup = dataclass("CTowerBreakLineup", require("framework.net.protocol"))
CTowerBreakLineup.ProtocolType = 1993
CTowerBreakLineup.MaxSize = 65535
CTowerBreakLineup.lineupId = 0
CTowerBreakLineup.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTowerBreakLineup
  ((CTowerBreakLineup.super).Ctor)(self, client)
end

CTowerBreakLineup.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  return true
end

CTowerBreakLineup.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTowerBreakLineup

