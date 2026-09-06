local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLineupInfo = dataclass("SLineupInfo", require("framework.net.protocol"))
SLineupInfo.ProtocolType = 1040
SLineupInfo.MaxSize = 65535
SLineupInfo.commonLinupId = 0
SLineupInfo.towerLineupId = 0
SLineupInfo.bossRushLineupId = 0
SLineupInfo.autoExploreLineupId = 0
SLineupInfo.guardRestoreLineupId = 0
SLineupInfo.damageStabLineupId = 0
SLineupInfo.magicImpairLineupId = 0
SLineupInfo.undecidedRoadLineupId = 0
SLineupInfo.springFestivalLineupId = 0
SLineupInfo.srChallengeLineupId = 0

function SLineupInfo:Ctor(client)
  SLineupInfo.super.Ctor(self, client)
  self.lineupList = {}
  self.supportRole = require("protocols.bean.protocol.chat.supportrole").Create()
end

function SLineupInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.commonLinupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.towerLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossRushLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoExploreLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guardRestoreLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.damageStabLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.magicImpairLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.undecidedRoadLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.springFestivalLineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.srChallengeLineupId) then
    return false
  end
  local length = table.slen(self.lineupList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.lineupList[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.supportRole:Marshal(buffer) then
    return false
  end
  return true
end

function SLineupInfo:Unmarshal(buffer)
  local ret = true
  ret, self.commonLinupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.towerLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bossRushLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.autoExploreLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.guardRestoreLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.damageStabLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.magicImpairLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.undecidedRoadLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.springFestivalLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.srChallengeLineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.lineupList[i] = require("protocols.bean.protocol.login.lineup").Create()
    if not self.lineupList[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.supportRole:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLineupInfo
