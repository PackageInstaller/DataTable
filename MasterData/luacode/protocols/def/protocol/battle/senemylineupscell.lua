local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnemyLineupsCell = dataclass("SEnemyLineupsCell", require("framework.net.protocol"))
SEnemyLineupsCell.ProtocolType = 4109
SEnemyLineupsCell.MaxSize = 65535
SEnemyLineupsCell.refreshTimes = 0

function SEnemyLineupsCell:Ctor(client)
  SEnemyLineupsCell.super.Ctor(self, client)
  self.lineupsInfo = {}
end

function SEnemyLineupsCell:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.refreshTimes) then
    return false
  end
  local length = table.slen(self.lineupsInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.lineupsInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SEnemyLineupsCell:Unmarshal(buffer)
  local ret = true
  ret, self.refreshTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.lineupsInfo[i] = require("protocols.bean.protocol.battle.enemylineup").Create()
    if not self.lineupsInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SEnemyLineupsCell
