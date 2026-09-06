local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetDungeonRandomItem = dataclass("SGetDungeonRandomItem", require("framework.net.protocol"))
SGetDungeonRandomItem.ProtocolType = 1931
SGetDungeonRandomItem.MaxSize = 65535
SGetDungeonRandomItem.sceneId = 0
SGetDungeonRandomItem.key = 0

function SGetDungeonRandomItem:Ctor(client)
  SGetDungeonRandomItem.super.Ctor(self, client)
end

function SGetDungeonRandomItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function SGetDungeonRandomItem:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetDungeonRandomItem
