local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDecomposeEquips = dataclass("SDecomposeEquips", require("framework.net.protocol"))
SDecomposeEquips.ProtocolType = 1261
SDecomposeEquips.MaxSize = 65535

function SDecomposeEquips:Ctor(client)
  SDecomposeEquips.super.Ctor(self, client)
  self.equipKeys = {}
end

function SDecomposeEquips:Marshal(buffer)
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

function SDecomposeEquips:Unmarshal(buffer)
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

return SDecomposeEquips
