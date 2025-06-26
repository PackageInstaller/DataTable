-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/smodifypartydeclaration.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SModifyPartyDeclaration = dataclass("SModifyPartyDeclaration", require("framework.net.protocol"))
SModifyPartyDeclaration.ProtocolType = 5026
SModifyPartyDeclaration.MaxSize = 65535
SModifyPartyDeclaration.partyDeclaration = ""
SModifyPartyDeclaration.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SModifyPartyDeclaration
  ((SModifyPartyDeclaration.super).Ctor)(self, client)
end

SModifyPartyDeclaration.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.partyDeclaration) then
    return false
  end
  return true
end

SModifyPartyDeclaration.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SModifyPartyDeclaration

