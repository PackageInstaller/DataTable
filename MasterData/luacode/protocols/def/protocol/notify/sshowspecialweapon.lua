local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowSpecialWeapon = dataclass("SShowSpecialWeapon", require("framework.net.protocol"))
SShowSpecialWeapon.ProtocolType = 1807
SShowSpecialWeapon.MaxSize = 65535

function SShowSpecialWeapon:Ctor(client)
  SShowSpecialWeapon.super.Ctor(self, client)
  self.roles = {}
end

function SShowSpecialWeapon:Marshal(buffer)
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roles[i]) then
      return false
    end
  end
  return true
end

function SShowSpecialWeapon:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roles[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SShowSpecialWeapon
