-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/baseuserdata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BaseUserData = dataclass("BaseUserData")
BaseUserData.userId = 0
BaseUserData.userName = ""
BaseUserData.avatarId = 0
BaseUserData.frameId = 0
BaseUserData.userLv = 0
BaseUserData.spiritvip = 0
BaseUserData.iplocaladdr = ""
BaseUserData.Ctor = function(self)
  -- function num : 0_0
  self.showBadges = {}
end

BaseUserData.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.userName) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.userLv) then
    return false
  end
  local length = (table.slen)(self.showBadges)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.showBadges)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spiritvip) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.iplocaladdr) then
    return false
  end
  return true
end

BaseUserData.Unmarshal = function(self, buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BaseUserData

