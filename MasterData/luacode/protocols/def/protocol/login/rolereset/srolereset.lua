local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleReset = dataclass("SRoleReset", require("framework.net.protocol"))
SRoleReset.ProtocolType = 1088
SRoleReset.MaxSize = 65535
SRoleReset.roleId = 0
SRoleReset.isPreview = 0

function SRoleReset:Ctor(client)
  SRoleReset.super.Ctor(self, client)
  self.itemList = {}
end

function SRoleReset:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isPreview) then
    return false
  end
  local length = table.slen(self.itemList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRoleReset:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isPreview = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemList[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRoleReset
