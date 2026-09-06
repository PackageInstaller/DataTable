local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenRuneAdvanced = dataclass("COpenRuneAdvanced", require("framework.net.protocol"))
COpenRuneAdvanced.ProtocolType = 1095
COpenRuneAdvanced.MaxSize = 65535
COpenRuneAdvanced.roleId = 0

function COpenRuneAdvanced:Ctor(client)
  COpenRuneAdvanced.super.Ctor(self, client)
end

function COpenRuneAdvanced:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function COpenRuneAdvanced:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenRuneAdvanced
