-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/sopenparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenParty = dataclass("SOpenParty", require("framework.net.protocol"))
SOpenParty.ProtocolType = 5006
SOpenParty.MaxSize = 65535
SOpenParty.partyDeclaration = ""
SOpenParty.position = 0
SOpenParty.hesitationPeriod = 0
SOpenParty.firstEnter = 0
SOpenParty.crossdayInterval = 0
SOpenParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenParty, _ENV
  ((SOpenParty.super).Ctor)(self, client)
  self.partyInfo = ((require("protocols.bean.protocol.party.partyinfo")).Create)()
end

SOpenParty.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.partyInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.partyDeclaration) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.hesitationPeriod) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.firstEnter) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.crossdayInterval) then
    return false
  end
  return true
end

SOpenParty.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.partyInfo):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenParty

