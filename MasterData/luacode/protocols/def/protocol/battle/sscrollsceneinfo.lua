local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SScrollSceneInfo = dataclass("SScrollSceneInfo", require("framework.net.protocol"))
SScrollSceneInfo.ProtocolType = 4103
SScrollSceneInfo.MaxSize = 65535
SScrollSceneInfo.sceneId = 0

function SScrollSceneInfo:Ctor(client)
  SScrollSceneInfo.super.Ctor(self, client)
  self.scrollSceneInfo = {}
end

function SScrollSceneInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.scrollSceneInfo)) then
    return false
  end
  for key, value in pairs(self.scrollSceneInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SScrollSceneInfo:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.scrollSceneInfo[key] = value
  end
  return ret
end

return SScrollSceneInfo
