-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/csearchparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSearchParty = dataclass("CSearchParty", require("framework.net.protocol"))
CSearchParty.ProtocolType = 5001
CSearchParty.MaxSize = 65535
CSearchParty.partyId = 0
CSearchParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSearchParty
  ((CSearchParty.super).Ctor)(self, client)
  self.excludePartyIds = {}
end

CSearchParty.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  local length = (table.slen)(self.excludePartyIds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, (self.excludePartyIds)[i]) then
      return false
    end
  end
  return true
end

CSearchParty.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CSearchParty

