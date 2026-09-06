local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshSupportRoleList = dataclass("SRefreshSupportRoleList", require("framework.net.protocol"))
SRefreshSupportRoleList.ProtocolType = 1146
SRefreshSupportRoleList.MaxSize = 65535

function SRefreshSupportRoleList:Ctor(client)
  SRefreshSupportRoleList.super.Ctor(self, client)
  self.rolesFromFriends = {}
  self.rolesFromStrangers = {}
end

function SRefreshSupportRoleList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rolesFromFriends)) then
    return false
  end
  for key, value in pairs(self.rolesFromFriends) do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.rolesFromStrangers)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.rolesFromStrangers[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshSupportRoleList:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.chat.supportroleforshow").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.rolesFromFriends[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.rolesFromStrangers[i] = require("protocols.bean.protocol.chat.strangersupportroleforshow").Create()
    if not self.rolesFromStrangers[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshSupportRoleList
