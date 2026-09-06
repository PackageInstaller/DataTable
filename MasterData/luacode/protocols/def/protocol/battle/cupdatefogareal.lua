local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpdateFogAreal = dataclass("CUpdateFogAreal", require("framework.net.protocol"))
CUpdateFogAreal.ProtocolType = 1932
CUpdateFogAreal.MaxSize = 65535
CUpdateFogAreal.sceneId = 0

function CUpdateFogAreal:Ctor(client)
  CUpdateFogAreal.super.Ctor(self, client)
  self.points = {}
  self.prePoints = {}
end

function CUpdateFogAreal:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  local length = table.slen(self.points)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.points[i]) then
      return false
    end
  end
  local length = table.slen(self.prePoints)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.prePoints[i]) then
      return false
    end
  end
  return true
end

function CUpdateFogAreal:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.points[i] = ProtocolBufferStaticFunctions.ReadInt16(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.prePoints[i] = ProtocolBufferStaticFunctions.ReadInt16(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CUpdateFogAreal
