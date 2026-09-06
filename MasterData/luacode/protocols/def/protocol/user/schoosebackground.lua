local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChooseBackground = dataclass("SChooseBackground", require("framework.net.protocol"))
SChooseBackground.ProtocolType = 2272
SChooseBackground.MaxSize = 65535
SChooseBackground.roleId = 0
SChooseBackground.skin = 0

function SChooseBackground:Ctor(client)
  SChooseBackground.super.Ctor(self, client)
end

function SChooseBackground:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin) then
    return false
  end
  return true
end

function SChooseBackground:Unmarshal(buffer)
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

return SChooseBackground
