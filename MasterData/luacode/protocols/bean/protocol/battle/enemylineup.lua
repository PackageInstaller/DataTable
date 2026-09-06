local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local EnemyLineup = dataclass("EnemyLineup")
EnemyLineup.battleId = 0

function EnemyLineup:Ctor()
  self.enemyUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
  self.enemyRoleList = {}
end

function EnemyLineup:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  if not self.enemyUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.enemyRoleList)) then
    return false
  end
  for key, value in pairs(self.enemyRoleList) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function EnemyLineup:Unmarshal(buffer)
  local ret = true
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.enemyUserData:Unmarshal(buffer) then
    return false
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.ranking.role").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.enemyRoleList[key] = value
  end
  return ret
end

return EnemyLineup
