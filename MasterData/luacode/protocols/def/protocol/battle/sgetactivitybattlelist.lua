local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetActivityBattleList = dataclass("SGetActivityBattleList", require("framework.net.protocol"))
SGetActivityBattleList.ProtocolType = 4124
SGetActivityBattleList.MaxSize = 65535
SGetActivityBattleList.activityId = 0
SGetActivityBattleList.time2NextPeriod = 0

function SGetActivityBattleList:Ctor(client)
  SGetActivityBattleList.super.Ctor(self, client)
  self.battleNodes = {}
end

function SGetActivityBattleList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time2NextPeriod) then
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

function SGetActivityBattleList:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.time2NextPeriod = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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

return SGetActivityBattleList
