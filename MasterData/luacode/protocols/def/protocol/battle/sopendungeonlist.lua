local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDungeonList = dataclass("SOpenDungeonList", require("framework.net.protocol"))
SOpenDungeonList.ProtocolType = 1911
SOpenDungeonList.MaxSize = 65535

function SOpenDungeonList:Ctor(client)
  SOpenDungeonList.super.Ctor(self, client)
  self.world = {}
end

function SOpenDungeonList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.world)) then
    return false
  end
  for key, value in pairs(self.world) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenDungeonList:Unmarshal(buffer)
  local ret = true
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
    value = require("protocols.bean.protocol.battle.dungeonworld").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.world[key] = value
  end
  return ret
end

return SOpenDungeonList
