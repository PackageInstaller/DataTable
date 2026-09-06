local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ImportBattleBeans = dataclass("ImportBattleBeans", require("framework.net.protocol"))
ImportBattleBeans.ProtocolType = 1905
ImportBattleBeans.MaxSize = 65535

function ImportBattleBeans:Ctor(client)
  ImportBattleBeans.super.Ctor(self, client)
  self.dungeonType = require("protocols.bean.protocol.battle.dungeontype").Create()
end

function ImportBattleBeans:Marshal(buffer)
  if not self.dungeonType:Marshal(buffer) then
    return false
  end
  return true
end

function ImportBattleBeans:Unmarshal(buffer)
  local ret = true
  if not self.dungeonType:Unmarshal(buffer) then
    return false
  end
  return ret
end

return ImportBattleBeans
