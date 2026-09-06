local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCancelPreSetEquip = dataclass("SCancelPreSetEquip", require("framework.net.protocol"))
SCancelPreSetEquip.ProtocolType = 1264
SCancelPreSetEquip.MaxSize = 65535
SCancelPreSetEquip.equipType = 0

function SCancelPreSetEquip:Ctor(client)
  SCancelPreSetEquip.super.Ctor(self, client)
  self.roleId = {}
end

function SCancelPreSetEquip:Marshal(buffer)
  local length = table.slen(self.roleId)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipType) then
    return false
  end
  return true
end

function SCancelPreSetEquip:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roleId[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.equipType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCancelPreSetEquip
