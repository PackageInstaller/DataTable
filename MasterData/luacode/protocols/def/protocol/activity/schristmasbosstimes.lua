-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schristmasbosstimes.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChristmasBossTimes = dataclass("SChristmasBossTimes", require("framework.net.protocol"))
SChristmasBossTimes.ProtocolType = 2587
SChristmasBossTimes.MaxSize = 65535
SChristmasBossTimes.times = 0
SChristmasBossTimes.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChristmasBossTimes
  ((SChristmasBossTimes.super).Ctor)(self, client)
end

SChristmasBossTimes.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.times) then
    return false
  end
  return true
end

SChristmasBossTimes.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasBossTimes

