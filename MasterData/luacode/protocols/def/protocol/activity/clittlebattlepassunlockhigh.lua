local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLittleBattlePassUnlockHigh = dataclass("CLittleBattlePassUnlockHigh", require("framework.net.protocol"))
CLittleBattlePassUnlockHigh.ProtocolType = 2665
CLittleBattlePassUnlockHigh.MaxSize = 65535
CLittleBattlePassUnlockHigh.WaitProtocol = "protocol.notify.scancelloading"

function CLittleBattlePassUnlockHigh:Ctor(client)
  CLittleBattlePassUnlockHigh.super.Ctor(self, client)
end

function CLittleBattlePassUnlockHigh:Marshal(buffer)
  return true
end

function CLittleBattlePassUnlockHigh:Unmarshal(buffer)
  local ret = true
  return ret
end

return CLittleBattlePassUnlockHigh
