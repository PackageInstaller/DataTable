local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTouchDungeonObject = dataclass("CTouchDungeonObject", require("framework.net.protocol"))
CTouchDungeonObject.ProtocolType = 1930
CTouchDungeonObject.MaxSize = 65535
CTouchDungeonObject.sceneId = 0

function CTouchDungeonObject:Ctor(client)
  CTouchDungeonObject.super.Ctor(self, client)
  self.keys = {}
end

function CTouchDungeonObject:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  local length = table.slen(self.keys)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.keys[i]) then
      return false
    end
  end
  return true
end

function CTouchDungeonObject:Unmarshal(buffer)
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
    ret, self.keys[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CTouchDungeonObject
