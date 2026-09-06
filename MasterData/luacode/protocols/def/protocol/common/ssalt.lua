local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSalt = dataclass("SSalt", require("framework.net.protocol"))
SSalt.ProtocolType = 107
SSalt.MaxSize = 256
SSalt.salt = ""
SSalt.open = 0

function SSalt:Ctor(client)
  SSalt.super.Ctor(self, client)
end

function SSalt:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.salt) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.open) then
    return false
  end
  return true
end

function SSalt:Unmarshal(buffer)
  local ret = true
  ret, self.salt = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.open = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSalt
