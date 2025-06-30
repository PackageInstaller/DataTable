-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schristmassupport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChristmasSupport = dataclass("SChristmasSupport", require("framework.net.protocol"))
SChristmasSupport.ProtocolType = 2565
SChristmasSupport.MaxSize = 65535
SChristmasSupport.num = 0
SChristmasSupport.addScore = 0
SChristmasSupport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChristmasSupport
  ((SChristmasSupport.super).Ctor)(self, client)
end

SChristmasSupport.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.addScore) then
    return false
  end
  return true
end

SChristmasSupport.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasSupport

