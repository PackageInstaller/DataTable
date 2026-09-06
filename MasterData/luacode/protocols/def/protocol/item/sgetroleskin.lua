local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetRoleSkin = dataclass("SGetRoleSkin", require("framework.net.protocol"))
SGetRoleSkin.ProtocolType = 1250
SGetRoleSkin.MaxSize = 65535
SGetRoleSkin.roleId = 0

function SGetRoleSkin:Ctor(client)
  SGetRoleSkin.super.Ctor(self, client)
  self.skins = {}
end

function SGetRoleSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.skins)) then
    return false
  end
  for key, value in pairs(self.skins) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetRoleSkin:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.item.beans.skininfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.skins[key] = value
  end
  return ret
end

return SGetRoleSkin
