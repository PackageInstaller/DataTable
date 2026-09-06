local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshBattlesTimes = dataclass("SRefreshBattlesTimes", require("framework.net.protocol"))
SRefreshBattlesTimes.ProtocolType = 2638
SRefreshBattlesTimes.MaxSize = 65535
SRefreshBattlesTimes.bossId = 0
SRefreshBattlesTimes.resetConfigId = 0
SRefreshBattlesTimes.leftTimes = 0

function SRefreshBattlesTimes:Ctor(client)
  SRefreshBattlesTimes.super.Ctor(self, client)
end

function SRefreshBattlesTimes:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resetConfigId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftTimes) then
    return false
  end
  return true
end

function SRefreshBattlesTimes:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.resetConfigId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshBattlesTimes
