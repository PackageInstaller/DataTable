local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSkatingOption = dataclass("CSkatingOption", require("framework.net.protocol"))
CSkatingOption.ProtocolType = 1966
CSkatingOption.MaxSize = 65535
CSkatingOption.option = 0
CSkatingOption.instanceId = 0
CSkatingOption.switchId = 0
CSkatingOption.END = 1
CSkatingOption.RECOVER = 2

function CSkatingOption:Ctor(client)
  CSkatingOption.super.Ctor(self, client)
end

function CSkatingOption:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.option) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.instanceId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.switchId) then
    return false
  end
  return true
end

function CSkatingOption:Unmarshal(buffer)
  local ret = true
  ret, self.option = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  ret, self.instanceId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.switchId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSkatingOption
