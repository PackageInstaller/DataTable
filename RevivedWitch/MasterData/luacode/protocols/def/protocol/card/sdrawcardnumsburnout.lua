-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/sdrawcardnumsburnout.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDrawCardNumsBurnOut = dataclass("SDrawCardNumsBurnOut", require("framework.net.protocol"))
SDrawCardNumsBurnOut.ProtocolType = 1509
SDrawCardNumsBurnOut.MaxSize = 65535
SDrawCardNumsBurnOut.kind = 0
SDrawCardNumsBurnOut.ONE_DRAW = 1
SDrawCardNumsBurnOut.FIVE_DRAW = 2
SDrawCardNumsBurnOut.TOTAL_DRAW = 2
SDrawCardNumsBurnOut.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDrawCardNumsBurnOut
  ((SDrawCardNumsBurnOut.super).Ctor)(self, client)
end

SDrawCardNumsBurnOut.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  return true
end

SDrawCardNumsBurnOut.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDrawCardNumsBurnOut

