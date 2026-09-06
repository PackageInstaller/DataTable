local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SProfessionRune = dataclass("SProfessionRune", require("framework.net.protocol"))
SProfessionRune.ProtocolType = 1098
SProfessionRune.MaxSize = 65535
SProfessionRune.roleId = 0
SProfessionRune.professionRune = 0

function SProfessionRune:Ctor(client)
  SProfessionRune.super.Ctor(self, client)
end

function SProfessionRune:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.professionRune) then
    return false
  end
  return true
end

function SProfessionRune:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.professionRune = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SProfessionRune
