local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictDefendRecord = dataclass("SFantasyConflictDefendRecord", require("framework.net.protocol"))
SFantasyConflictDefendRecord.ProtocolType = 4156
SFantasyConflictDefendRecord.MaxSize = 65535

function SFantasyConflictDefendRecord:Ctor(client)
  SFantasyConflictDefendRecord.super.Ctor(self, client)
  self.enemyRoleList = {}
end

function SFantasyConflictDefendRecord:Marshal(buffer)
  local length = table.slen(self.enemyRoleList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.enemyRoleList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SFantasyConflictDefendRecord:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.enemyRoleList[i] = require("protocols.bean.protocol.battle.fantasyconflictdefendrecord").Create()
    if not self.enemyRoleList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SFantasyConflictDefendRecord
