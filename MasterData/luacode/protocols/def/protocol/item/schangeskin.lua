local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeSkin = dataclass("SChangeSkin", require("framework.net.protocol"))
SChangeSkin.ProtocolType = 1248
SChangeSkin.MaxSize = 65535
SChangeSkin.roleId = 0
SChangeSkin.skin2Change = 0

function SChangeSkin:Ctor(client)
  SChangeSkin.super.Ctor(self, client)
end

function SChangeSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin2Change) then
    return false
  end
  return true
end

function SChangeSkin:Unmarshal(buffer)
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

return SChangeSkin
