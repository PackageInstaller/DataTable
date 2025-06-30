-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/sreceivedonateaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveDonateAward = dataclass("SReceiveDonateAward", require("framework.net.protocol"))
SReceiveDonateAward.ProtocolType = 5036
SReceiveDonateAward.MaxSize = 65535
SReceiveDonateAward.partyId = 0
SReceiveDonateAward.awardId = 0
SReceiveDonateAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveDonateAward
  ((SReceiveDonateAward.super).Ctor)(self, client)
end

SReceiveDonateAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardId) then
    return false
  end
  return true
end

SReceiveDonateAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveDonateAward

