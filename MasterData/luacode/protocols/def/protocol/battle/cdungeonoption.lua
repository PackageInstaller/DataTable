local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDungeonOption = dataclass("CDungeonOption", require("framework.net.protocol"))
CDungeonOption.ProtocolType = 1926
CDungeonOption.MaxSize = 65535
CDungeonOption.optionId = 0

function CDungeonOption:Ctor(client)
  CDungeonOption.super.Ctor(self, client)
end

function CDungeonOption:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.optionId) then
    return false
  end
  return true
end

function CDungeonOption:Unmarshal(buffer)
  local ret = true
  ret, self.optionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDungeonOption
