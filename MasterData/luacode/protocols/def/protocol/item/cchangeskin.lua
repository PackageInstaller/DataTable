local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeSkin = dataclass("CChangeSkin", require("framework.net.protocol"))
CChangeSkin.ProtocolType = 1247
CChangeSkin.MaxSize = 65535
CChangeSkin.roleId = 0
CChangeSkin.skin2Change = 0

function CChangeSkin:Ctor(client)
  CChangeSkin.super.Ctor(self, client)
end

function CChangeSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin2Change) then
    return false
  end
  return true
end

function CChangeSkin:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skin2Change = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeSkin
