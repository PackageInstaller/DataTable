local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SystemType = dataclass("SystemType")
SystemType.WINDOWS = 0
SystemType.IOS = 1
SystemType.ANDROID = 2
SystemType.UNITY = 3
SystemType.MAC = 4
SystemType.LINUX = 5

function SystemType:Ctor()
end

function SystemType:Marshal(buffer)
  return true
end

function SystemType:Unmarshal(buffer)
  local ret = true
  return ret
end

return SystemType
