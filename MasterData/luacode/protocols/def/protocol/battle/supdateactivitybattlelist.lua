local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateActivityBattleList = dataclass("SUpdateActivityBattleList", require("framework.net.protocol"))
SUpdateActivityBattleList.ProtocolType = 4127
SUpdateActivityBattleList.MaxSize = 65535
SUpdateActivityBattleList.activityId = 0

function SUpdateActivityBattleList:Ctor(client)
  SUpdateActivityBattleList.super.Ctor(self, client)
  self.battleNodes = {}
end

function SUpdateActivityBattleList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  local length = table.slen(self.battleNodes)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.battleNodes[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUpdateActivityBattleList:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.battleNodes[i] = require("protocols.bean.protocol.battle.activitybattlenode").Create()
    if not self.battleNodes[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateActivityBattleList
