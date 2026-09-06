local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLittleBattlePassReceiveCollection = dataclass("CLittleBattlePassReceiveCollection", require("framework.net.protocol"))
CLittleBattlePassReceiveCollection.ProtocolType = 2664
CLittleBattlePassReceiveCollection.MaxSize = 65535
CLittleBattlePassReceiveCollection.CollectionType = 0
CLittleBattlePassReceiveCollection.level = 0
CLittleBattlePassReceiveCollection.HIGH = 2
CLittleBattlePassReceiveCollection.COMMON = 1

function CLittleBattlePassReceiveCollection:Ctor(client)
  CLittleBattlePassReceiveCollection.super.Ctor(self, client)
end

function CLittleBattlePassReceiveCollection:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.CollectionType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function CLittleBattlePassReceiveCollection:Unmarshal(buffer)
  local ret = true
  ret, self.CollectionType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLittleBattlePassReceiveCollection
