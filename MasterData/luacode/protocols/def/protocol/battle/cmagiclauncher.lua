local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMagicLauncher = dataclass("CMagicLauncher", require("framework.net.protocol"))
CMagicLauncher.ProtocolType = 1971
CMagicLauncher.MaxSize = 65535
CMagicLauncher.instanceId = 0
CMagicLauncher.launcherId = 0
CMagicLauncher.targetId = 0
CMagicLauncher.power = 0
CMagicLauncher.direction = 0

function CMagicLauncher:Ctor(client)
  CMagicLauncher.super.Ctor(self, client)
end

function CMagicLauncher:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.instanceId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.launcherId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.targetId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolFloat(buffer, self.power) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolFloat(buffer, self.direction) then
    return false
  end
  return true
end

function CMagicLauncher:Unmarshal(buffer)
  local ret = true
  ret, self.instanceId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.launcherId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.targetId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.power = ProtocolBufferStaticFunctions.ReadFloat(buffer)
  if not ret then
    return ret
  end
  ret, self.direction = ProtocolBufferStaticFunctions.ReadFloat(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMagicLauncher
