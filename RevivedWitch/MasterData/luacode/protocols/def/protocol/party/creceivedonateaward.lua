-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/creceivedonateaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveDonateAward = dataclass("CReceiveDonateAward", require("framework.net.protocol"))
CReceiveDonateAward.ProtocolType = 5035
CReceiveDonateAward.MaxSize = 65535
CReceiveDonateAward.partyId = 0
CReceiveDonateAward.awardId = 0
CReceiveDonateAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveDonateAward
  ((CReceiveDonateAward.super).Ctor)(self, client)
end

CReceiveDonateAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardId) then
    return false
  end
  return true
end

CReceiveDonateAward.Unmarshal = function(self, buffer)
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

return CReceiveDonateAward

