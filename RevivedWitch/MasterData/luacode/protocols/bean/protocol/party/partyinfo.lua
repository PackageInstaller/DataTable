-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/party/partyinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local PartyInfo = dataclass("PartyInfo")
PartyInfo.partyId = 0
PartyInfo.enterNum = 0
PartyInfo.totalNum = 0
PartyInfo.avatarId = 0
PartyInfo.partyName = ""
PartyInfo.partyLv = 0
PartyInfo.partyExp = 0
PartyInfo.autoAcceptApply = 0
PartyInfo.AUTO = 1
PartyInfo.MANUAL = 0
PartyInfo.Ctor = function(self)
  -- function num : 0_0
end

PartyInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enterNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.partyName) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.partyLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.partyExp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

PartyInfo.Unmarshal = function(self, buffer)
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
  return ret
end

return PartyInfo

