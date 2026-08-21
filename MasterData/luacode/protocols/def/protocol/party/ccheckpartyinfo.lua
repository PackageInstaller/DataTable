-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/ccheckpartyinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckPartyInfo = dataclass("CCheckPartyInfo", require("framework.net.protocol"))
CCheckPartyInfo.ProtocolType = 5019
CCheckPartyInfo.MaxSize = 65535
CCheckPartyInfo.partyId = 0
CCheckPartyInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckPartyInfo
  ((CCheckPartyInfo.super).Ctor)(self, client)
end

CCheckPartyInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  return true
end

CCheckPartyInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPartyInfo

