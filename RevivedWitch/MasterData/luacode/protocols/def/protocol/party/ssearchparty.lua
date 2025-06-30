-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/ssearchparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSearchParty = dataclass("SSearchParty", require("framework.net.protocol"))
SSearchParty.ProtocolType = 5002
SSearchParty.MaxSize = 65535
SSearchParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSearchParty
  ((SSearchParty.super).Ctor)(self, client)
  self.allParty = {}
end

SSearchParty.Marshal = function(self, buffer)
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

SSearchParty.Unmarshal = function(self, buffer)
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

return SSearchParty

