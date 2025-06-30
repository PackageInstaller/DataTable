-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cbreaklineup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBreakLineup = dataclass("CBreakLineup", require("framework.net.protocol"))
CBreakLineup.ProtocolType = 1043
CBreakLineup.MaxSize = 65535
CBreakLineup.lineupId = 0
CBreakLineup.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBreakLineup
  ((CBreakLineup.super).Ctor)(self, client)
end

CBreakLineup.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  return true
end

CBreakLineup.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBreakLineup

