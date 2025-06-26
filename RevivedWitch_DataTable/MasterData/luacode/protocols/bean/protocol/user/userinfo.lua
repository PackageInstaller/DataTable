-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/user/userinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local UserInfo = dataclass("UserInfo")
UserInfo.userid = 0
UserInfo.username = ""
UserInfo.userlevel = 0
UserInfo.userexp = 0
UserInfo.strengthLimit = 0
UserInfo.serverId = 0
UserInfo.isNew = 0
UserInfo.power = 0
UserInfo.avatarId = 0
UserInfo.frameId = 0
UserInfo.introduce = ""
UserInfo.phoneNum = ""
UserInfo.mailAddr = ""
UserInfo.isGM = 0
UserInfo.enchant_MaNa = 0
UserInfo.createTime = 0
UserInfo.backgroundRole = 0
UserInfo.backgroundSkin = 0
UserInfo.guest = 0
UserInfo.likedNum = 0
UserInfo.iplocaladdr = ""
UserInfo.Ctor = function(self)
  -- function num : 0_0
  self.guides = {}
  self.buffGuides = {}
  self.procedures = {}
  self.configs = {}
  self.tips = {}
  self.npcTips = {}
end

UserInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.username) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.userlevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.userexp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.strengthLimit) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.serverId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isNew) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.guides)) then
    return false
  end
  for key,value in pairs(self.guides) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.buffGuides)) then
    return false
  end
  for key,value in pairs(self.buffGuides) do
    -- DECOMPILER ERROR at PC106: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
    -- DECOMPILER ERROR at PC114: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.procedures)) then
    return false
  end
  for key,value in pairs(self.procedures) do
    -- DECOMPILER ERROR at PC139: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
    -- DECOMPILER ERROR at PC147: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.introduce) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.configs)) then
    return false
  end
  for key,value in pairs(self.configs) do
    -- DECOMPILER ERROR at PC204: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
    -- DECOMPILER ERROR at PC212: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.phoneNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.mailAddr) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.isGM) then
    return false
  end
  local length = (table.slen)(self.tips)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC262: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC263: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC74) then
      return false
    end
  end
  local length = (table.slen)(self.npcTips)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC287: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC74, (self.npcTips)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enchant_MaNa) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.createTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.backgroundRole) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.backgroundSkin) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guest) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.likedNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.iplocaladdr) then
    return false
  end
  return true
end

UserInfo.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC85: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.guides)[key] = value
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
    -- DECOMPILER ERROR at PC121: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC127: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.buffGuides)[key] = value
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
    -- DECOMPILER ERROR at PC157: Overwrote pending register: R11 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC163: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (self.procedures)[key] = value
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
    -- DECOMPILER ERROR at PC225: Overwrote pending register: R14 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC231: Confused about usage of register: R19 in 'UnsetPending'

    ;
    (self.configs)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC274: Confused about usage of register: R20 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC297: Confused about usage of register: R21 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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

return UserInfo

