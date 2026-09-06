local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
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
UserInfo.partyName = ""

function UserInfo:Ctor()
  self.guides = {}
  self.buffGuides = {}
  self.procedures = {}
  self.configs = {}
  self.tips = {}
  self.npcTips = {}
end

function UserInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.username) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userlevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userexp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.strengthLimit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.serverId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isNew) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.guides)) then
    return false
  end
  for key, value in pairs(self.guides) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.buffGuides)) then
    return false
  end
  for key, value in pairs(self.buffGuides) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.procedures)) then
    return false
  end
  for key, value in pairs(self.procedures) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.power) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.introduce) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.configs)) then
    return false
  end
  for key, value in pairs(self.configs) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.phoneNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.mailAddr) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.isGM) then
    return false
  end
  local length = table.slen(self.tips)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.tips[i]) then
      return false
    end
  end
  local length = table.slen(self.npcTips)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.npcTips[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.enchant_MaNa) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.createTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.backgroundRole) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.backgroundSkin) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guest) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likedNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.iplocaladdr) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyName) then
    return false
  end
  return true
end

function UserInfo:Unmarshal(buffer)
  local ret = true
  ret, self.userid = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.username = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.userlevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.userexp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.strengthLimit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.serverId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isNew = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.guides[key] = value
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.buffGuides[key] = value
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.procedures[key] = value
  end
  ret, self.power = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.introduce = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.configs[key] = value
  end
  ret, self.phoneNum = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.mailAddr = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.isGM = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.tips[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.npcTips[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.enchant_MaNa = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.createTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.backgroundRole = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.backgroundSkin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.guest = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.likedNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.iplocaladdr = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.partyName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return UserInfo
