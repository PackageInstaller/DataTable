-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/sgetholdpartyconsume.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetHoldPartyConsume = dataclass("SGetHoldPartyConsume", require("framework.net.protocol"))
SGetHoldPartyConsume.ProtocolType = 5028
SGetHoldPartyConsume.MaxSize = 65535
SGetHoldPartyConsume.number = 0
SGetHoldPartyConsume.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetHoldPartyConsume
  ((SGetHoldPartyConsume.super).Ctor)(self, client)
end

SGetHoldPartyConsume.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.number) then
    return false
  end
  return true
end

SGetHoldPartyConsume.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetHoldPartyConsume

