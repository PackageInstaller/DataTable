local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDungeonMoney = dataclass("SDungeonMoney", require("framework.net.protocol"))
SDungeonMoney.ProtocolType = 1236
SDungeonMoney.MaxSize = 65535
SDungeonMoney.gold = 0

function SDungeonMoney:Ctor(client)
  SDungeonMoney.super.Ctor(self, client)
end

function SDungeonMoney:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gold) then
    return false
  end
  return true
end

function SDungeonMoney:Unmarshal(buffer)
  local ret = true
  ret, self.gold = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDungeonMoney
