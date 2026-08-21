-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/spartydonate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPartyDonate = dataclass("SPartyDonate", require("framework.net.protocol"))
SPartyDonate.ProtocolType = 5032
SPartyDonate.MaxSize = 65535
SPartyDonate.partyId = 0
SPartyDonate.process = 0
SPartyDonate.partyCoin = 0
SPartyDonate.partyExp = 0
SPartyDonate.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPartyDonate
  ((SPartyDonate.super).Ctor)(self, client)
end

SPartyDonate.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.process) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.partyCoin) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.partyExp) then
    return false
  end
  return true
end

SPartyDonate.Unmarshal = function(self, buffer)
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

return SPartyDonate

