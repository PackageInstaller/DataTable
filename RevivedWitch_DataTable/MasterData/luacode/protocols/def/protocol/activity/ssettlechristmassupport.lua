-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssettlechristmassupport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSettleChristmasSupport = dataclass("SSettleChristmasSupport", require("framework.net.protocol"))
SSettleChristmasSupport.ProtocolType = 2570
SSettleChristmasSupport.MaxSize = 65535
SSettleChristmasSupport.state = 0
SSettleChristmasSupport.settle = 0
SSettleChristmasSupport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSettleChristmasSupport
  ((SSettleChristmasSupport.super).Ctor)(self, client)
end

SSettleChristmasSupport.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.settle) then
    return false
  end
  return true
end

SSettleChristmasSupport.Unmarshal = function(self, buffer)
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

return SSettleChristmasSupport

