-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetspringredpacket.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetSpringRedPacket = dataclass("SGetSpringRedPacket", require("framework.net.protocol"))
SGetSpringRedPacket.ProtocolType = 2577
SGetSpringRedPacket.MaxSize = 65535
SGetSpringRedPacket.redPacketType = 0
SGetSpringRedPacket.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetSpringRedPacket
  ((SGetSpringRedPacket.super).Ctor)(self, client)
end

SGetSpringRedPacket.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.redPacketType) then
    return false
  end
  return true
end

SGetSpringRedPacket.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSpringRedPacket

