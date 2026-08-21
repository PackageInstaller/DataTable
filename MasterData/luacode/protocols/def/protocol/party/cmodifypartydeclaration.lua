-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cmodifypartydeclaration.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CModifyPartyDeclaration = dataclass("CModifyPartyDeclaration", require("framework.net.protocol"))
CModifyPartyDeclaration.ProtocolType = 5007
CModifyPartyDeclaration.MaxSize = 65535
CModifyPartyDeclaration.partyId = 0
CModifyPartyDeclaration.partyDeclaration = ""
CModifyPartyDeclaration.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CModifyPartyDeclaration
  ((CModifyPartyDeclaration.super).Ctor)(self, client)
end

CModifyPartyDeclaration.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.partyDeclaration) then
    return false
  end
  return true
end

CModifyPartyDeclaration.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CModifyPartyDeclaration

