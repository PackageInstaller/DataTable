local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeThemeName = dataclass("CChangeThemeName", require("framework.net.protocol"))
CChangeThemeName.ProtocolType = 2363
CChangeThemeName.MaxSize = 65535
CChangeThemeName.name = ""
CChangeThemeName.key = 0

function CChangeThemeName:Ctor(client)
  CChangeThemeName.super.Ctor(self, client)
end

function CChangeThemeName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CChangeThemeName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeThemeName
