local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenCompleteLineup = dataclass("SOpenCompleteLineup", require("framework.net.protocol"))
SOpenCompleteLineup.ProtocolType = 4125
SOpenCompleteLineup.MaxSize = 65535

function SOpenCompleteLineup:Ctor(client)
  SOpenCompleteLineup.super.Ctor(self, client)
  self.completeLineups = {}
end

function SOpenCompleteLineup:Marshal(buffer)
  local length = table.slen(self.completeLineups)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.completeLineups[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenCompleteLineup:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.completeLineups[i] = require("protocols.bean.protocol.battle.completelineup").Create()
    if not self.completeLineups[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenCompleteLineup
