local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDecomposeEquips = dataclass("CDecomposeEquips", require("framework.net.protocol"))
CDecomposeEquips.ProtocolType = 1208
CDecomposeEquips.MaxSize = 65535

function CDecomposeEquips:Ctor(client)
  CDecomposeEquips.super.Ctor(self, client)
  self.equipKeys = {}
end

function CDecomposeEquips:Marshal(buffer)
  local length = table.slen(self.equipKeys)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKeys[i]) then
      return false
    end
  end
  return true
end

function CDecomposeEquips:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.equipKeys[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CDecomposeEquips
