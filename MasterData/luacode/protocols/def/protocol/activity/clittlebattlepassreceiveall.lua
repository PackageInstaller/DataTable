local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLittleBattlePassReceiveAll = dataclass("CLittleBattlePassReceiveAll", require("framework.net.protocol"))
CLittleBattlePassReceiveAll.ProtocolType = 2663
CLittleBattlePassReceiveAll.MaxSize = 65535

function CLittleBattlePassReceiveAll:Ctor(client)
  CLittleBattlePassReceiveAll.super.Ctor(self, client)
end

function CLittleBattlePassReceiveAll:Marshal(buffer)
  return true
end

function CLittleBattlePassReceiveAll:Unmarshal(buffer)
  local ret = true
  return ret
end

return CLittleBattlePassReceiveAll
