local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChooseBackground = dataclass("CChooseBackground", require("framework.net.protocol"))
CChooseBackground.ProtocolType = 2271
CChooseBackground.MaxSize = 65535
CChooseBackground.roleId = 0
CChooseBackground.skin = 0

function CChooseBackground:Ctor(client)
  CChooseBackground.super.Ctor(self, client)
end

function CChooseBackground:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin) then
    return false
  end
  return true
end

function CChooseBackground:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChooseBackground
