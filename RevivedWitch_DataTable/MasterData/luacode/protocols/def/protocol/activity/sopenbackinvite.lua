-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenbackinvite.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenBackInvite = dataclass("SOpenBackInvite", require("framework.net.protocol"))
SOpenBackInvite.ProtocolType = 2550
SOpenBackInvite.MaxSize = 65535
SOpenBackInvite.invitationCode = ""
SOpenBackInvite.inviteeNum = 0
SOpenBackInvite.returnTime = 0
SOpenBackInvite.discountTime = 0
SOpenBackInvite.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenBackInvite
  ((SOpenBackInvite.super).Ctor)(self, client)
  self.inviteeLimit = {}
  self.goodInfo = {}
end

SOpenBackInvite.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.invitationCode) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.inviteeNum) then
    return false
  end
  local length = (table.slen)(self.inviteeLimit)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.inviteeLimit)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.returnTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.discountTime) then
    return false
  end
  local length = (table.slen)(self.goodInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.goodInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SOpenBackInvite.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'

    (self.goodInfo)[i] = ((require("protocols.bean.protocol.activity.goodinfo")).Create)()
    if not ((self.goodInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBackInvite

