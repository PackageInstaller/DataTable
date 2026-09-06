local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleGiveGift = dataclass("CRoleGiveGift", require("framework.net.protocol"))
CRoleGiveGift.ProtocolType = 1025
CRoleGiveGift.MaxSize = 65535
CRoleGiveGift.id = 0

function CRoleGiveGift:Ctor(client)
  CRoleGiveGift.super.Ctor(self, client)
  self.items = {}
end

function CRoleGiveGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.items)) then
    return false
  end
  for key, value in pairs(self.items) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CRoleGiveGift:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.items[key] = value
  end
  return ret
end

return CRoleGiveGift
