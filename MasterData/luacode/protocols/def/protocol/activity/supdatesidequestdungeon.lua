local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateSideQuestDungeon = dataclass("SUpdateSideQuestDungeon", require("framework.net.protocol"))
SUpdateSideQuestDungeon.ProtocolType = 2427
SUpdateSideQuestDungeon.MaxSize = 65536

function SUpdateSideQuestDungeon:Ctor(client)
  SUpdateSideQuestDungeon.super.Ctor(self, client)
  self.dungeons = require("protocols.bean.protocol.activity.sidequestdungeoninfo").Create()
end

function SUpdateSideQuestDungeon:Marshal(buffer)
  if not self.dungeons:Marshal(buffer) then
    return false
  end
  return true
end

function SUpdateSideQuestDungeon:Unmarshal(buffer)
  local ret = true
  if not self.dungeons:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUpdateSideQuestDungeon
