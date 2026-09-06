local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMove2BattleIsland = dataclass("SMove2BattleIsland", require("framework.net.protocol"))
SMove2BattleIsland.ProtocolType = 1996
SMove2BattleIsland.MaxSize = 65535
SMove2BattleIsland.islandID = 0

function SMove2BattleIsland:Ctor(client)
  SMove2BattleIsland.super.Ctor(self, client)
  self.enemy = {}
end

function SMove2BattleIsland:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandID) then
    return false
  end
  local length = table.slen(self.enemy)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.enemy[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SMove2BattleIsland:Unmarshal(buffer)
  local ret = true
  ret, self.islandID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.enemy[i] = require("protocols.bean.protocol.battle.islandmonsterinfo").Create()
    if not self.enemy[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SMove2BattleIsland
