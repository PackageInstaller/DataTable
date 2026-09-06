local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddSoul = dataclass("CAddSoul", require("framework.net.protocol"))
CAddSoul.ProtocolType = 1062
CAddSoul.MaxSize = 65535
CAddSoul.roleId = 0
CAddSoul.soul = 0

function CAddSoul:Ctor(client)
  CAddSoul.super.Ctor(self, client)
end

function CAddSoul:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.soul) then
    return false
  end
  return true
end

function CAddSoul:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.soul = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddSoul
