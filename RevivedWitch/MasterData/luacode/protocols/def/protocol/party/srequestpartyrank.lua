-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/srequestpartyrank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRequestPartyRank = dataclass("SRequestPartyRank", require("framework.net.protocol"))
SRequestPartyRank.ProtocolType = 5039
SRequestPartyRank.MaxSize = 65535
SRequestPartyRank.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRequestPartyRank
  ((SRequestPartyRank.super).Ctor)(self, client)
  self.allParty = {}
end

SRequestPartyRank.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.allParty)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.allParty)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SRequestPartyRank.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.allParty)[i] = ((require("protocols.bean.protocol.party.partyinfo")).Create)()
    if not ((self.allParty)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRequestPartyRank

