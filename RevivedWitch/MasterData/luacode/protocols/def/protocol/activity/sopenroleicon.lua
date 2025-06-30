-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenroleicon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenRoleIcon = dataclass("SOpenRoleIcon", require("framework.net.protocol"))
SOpenRoleIcon.ProtocolType = 2593
SOpenRoleIcon.MaxSize = 65535
SOpenRoleIcon.roleNum = 0
SOpenRoleIcon.isMask = 0
SOpenRoleIcon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenRoleIcon
  ((SOpenRoleIcon.super).Ctor)(self, client)
  self.roleMap = {}
  self.progressReward = {}
end

SOpenRoleIcon.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.roleMap)) then
    return false
  end
  for key,value in pairs(self.roleMap) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.progressReward)) then
    return false
  end
  for key,value in pairs(self.progressReward) do
    -- DECOMPILER ERROR at PC58: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    -- DECOMPILER ERROR at PC66: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.isMask) then
    return false
  end
  return true
end

SOpenRoleIcon.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.roleMap)[key] = value
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.progressReward)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenRoleIcon

