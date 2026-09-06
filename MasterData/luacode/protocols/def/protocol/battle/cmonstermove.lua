local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMonsterMove = dataclass("CMonsterMove", require("framework.net.protocol"))
CMonsterMove.ProtocolType = 1968
CMonsterMove.MaxSize = 65535
CMonsterMove.sceneid = 0

function CMonsterMove:Ctor(client)
  CMonsterMove.super.Ctor(self, client)
  self.monsters = {}
end

function CMonsterMove:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.monsters)) then
    return false
  end
  for key, value in pairs(self.monsters) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function CMonsterMove:Unmarshal(buffer)
  local ret = true
  ret, self.sceneid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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
    value = require("protocols.bean.protocol.battle.point").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.monsters[key] = value
  end
  return ret
end

return CMonsterMove
