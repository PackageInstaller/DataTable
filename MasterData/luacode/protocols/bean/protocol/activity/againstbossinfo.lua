local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local AgainstBossInfo = dataclass("AgainstBossInfo")

function AgainstBossInfo:Ctor()
  self.weeklyAwardsList = {}
  self.witchInfo = require("protocols.bean.protocol.activity.witchinfo").Create()
  self.bossInfoList = {}
end

function AgainstBossInfo:Marshal(buffer)
  local length = table.slen(self.weeklyAwardsList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.weeklyAwardsList[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.witchInfo:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.bossInfoList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.bossInfoList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function AgainstBossInfo:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.weeklyAwardsList[i] = require("protocols.bean.protocol.activity.weeklyawards").Create()
    if not self.weeklyAwardsList[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.witchInfo:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.bossInfoList[i] = require("protocols.bean.protocol.activity.bossinfo").Create()
    if not self.bossInfoList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return AgainstBossInfo
