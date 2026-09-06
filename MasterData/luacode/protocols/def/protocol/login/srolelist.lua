local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleList = dataclass("SRoleList", require("framework.net.protocol"))
SRoleList.ProtocolType = 1011
SRoleList.MaxSize = 655350
SRoleList.capacity = 0

function SRoleList:Ctor(client)
  SRoleList.super.Ctor(self, client)
  self.roles = {}
end

function SRoleList:Marshal(buffer)
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.roles[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.capacity) then
    return false
  end
  return true
end

function SRoleList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.roles[i] = require("protocols.bean.protocol.login.role").Create()
    if not self.roles[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.capacity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleList
