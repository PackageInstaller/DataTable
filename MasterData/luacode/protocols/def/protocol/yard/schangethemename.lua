local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeThemeName = dataclass("SChangeThemeName", require("framework.net.protocol"))
SChangeThemeName.ProtocolType = 2364
SChangeThemeName.MaxSize = 65535
SChangeThemeName.name = ""
SChangeThemeName.key = 0

function SChangeThemeName:Ctor(client)
  SChangeThemeName.super.Ctor(self, client)
end

function SChangeThemeName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function SChangeThemeName:Unmarshal(buffer)
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

return SChangeThemeName
