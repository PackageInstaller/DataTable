local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRecordExploreAward = dataclass("SRecordExploreAward", require("framework.net.protocol"))
SRecordExploreAward.ProtocolType = 1967
SRecordExploreAward.MaxSize = 65535

function SRecordExploreAward:Ctor(client)
  SRecordExploreAward.super.Ctor(self, client)
  self.records = {}
end

function SRecordExploreAward:Marshal(buffer)
  local length = table.slen(self.records)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.records[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRecordExploreAward:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.records[i] = require("protocols.bean.protocol.battle.exploreawardrecord").Create()
    if not self.records[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRecordExploreAward
