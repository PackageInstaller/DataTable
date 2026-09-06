local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictDefendRecord = dataclass("CFantasyConflictDefendRecord", require("framework.net.protocol"))
CFantasyConflictDefendRecord.ProtocolType = 4155
CFantasyConflictDefendRecord.MaxSize = 65535

function CFantasyConflictDefendRecord:Ctor(client)
  CFantasyConflictDefendRecord.super.Ctor(self, client)
end

function CFantasyConflictDefendRecord:Marshal(buffer)
  return true
end

function CFantasyConflictDefendRecord:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFantasyConflictDefendRecord
