-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/scomfirecamp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SComfireCamp = dataclass("SComfireCamp", require("framework.net.protocol"))
SComfireCamp.ProtocolType = 4111
SComfireCamp.MaxSize = 65535
SComfireCamp.camp = 0
SComfireCamp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SComfireCamp
  ((SComfireCamp.super).Ctor)(self, client)
end

SComfireCamp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.camp) then
    return false
  end
  return true
end

SComfireCamp.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SComfireCamp

