-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/scheckpartyinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCheckPartyInfo = dataclass("SCheckPartyInfo", require("framework.net.protocol"))
SCheckPartyInfo.ProtocolType = 5020
SCheckPartyInfo.MaxSize = 65535
SCheckPartyInfo.partyDeclaration = ""
SCheckPartyInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCheckPartyInfo, _ENV
  ((SCheckPartyInfo.super).Ctor)(self, client)
  self.partyInfo = ((require("protocols.bean.protocol.party.partyinfo")).Create)()
  self.allMember = {}
end

SCheckPartyInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (self.partyInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.partyDeclaration) then
    return false
  end
  local length = (table.slen)(self.allMember)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.allMember)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SCheckPartyInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.partyInfo):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.allMember)[i] = ((require("protocols.bean.protocol.party.memberinfo")).Create)()
    if not ((self.allMember)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCheckPartyInfo

