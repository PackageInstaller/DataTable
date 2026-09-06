local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpringBossState = dataclass("SSpringBossState", require("framework.net.protocol"))
SSpringBossState.ProtocolType = 2579
SSpringBossState.MaxSize = 65535
SSpringBossState.score = 0
SSpringBossState.rank = 0

function SSpringBossState:Ctor(client)
  SSpringBossState.super.Ctor(self, client)
  self.bossList = {}
end

function SSpringBossState:Marshal(buffer)
  local length = table.slen(self.bossList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.bossList[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  return true
end

function SSpringBossState:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.bossList[i] = require("protocols.bean.protocol.activity.springboss").Create()
    if not self.bossList[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringBossState
