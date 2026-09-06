local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPartyBossPanelInfo = dataclass("SPartyBossPanelInfo", require("framework.net.protocol"))
SPartyBossPanelInfo.ProtocolType = 5041
SPartyBossPanelInfo.MaxSize = 65535
SPartyBossPanelInfo.startime = 0
SPartyBossPanelInfo.endtime = 0
SPartyBossPanelInfo.score = 0
SPartyBossPanelInfo.rank = 0
SPartyBossPanelInfo.chances = 0
SPartyBossPanelInfo.costspirit = 0

function SPartyBossPanelInfo:Ctor(client)
  SPartyBossPanelInfo.super.Ctor(self, client)
  self.damagerecords = {}
  self.bossstates = {}
end

function SPartyBossPanelInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.startime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endtime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chances) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.costspirit) then
    return false
  end
  local length = table.slen(self.damagerecords)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.damagerecords[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.bossstates)) then
    return false
  end
  for key, value in pairs(self.bossstates) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SPartyBossPanelInfo:Unmarshal(buffer)
  local ret = true
  ret, self.startime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.endtime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chances = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.costspirit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.damagerecords[i] = require("protocols.bean.protocol.party.boss.partybossdamagerecord").Create()
    if not self.damagerecords[i]:Unmarshal(buffer) then
      return false
    end
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
    value = require("protocols.bean.protocol.party.boss.partybossstate").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.bossstates[key] = value
  end
  return ret
end

return SPartyBossPanelInfo
