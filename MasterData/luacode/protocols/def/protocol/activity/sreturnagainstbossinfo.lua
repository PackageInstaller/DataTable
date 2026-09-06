local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReturnAgainstBossInfo = dataclass("SReturnAgainstBossInfo", require("framework.net.protocol"))
SReturnAgainstBossInfo.ProtocolType = 2668
SReturnAgainstBossInfo.MaxSize = 65535
SReturnAgainstBossInfo.bossId = 0

function SReturnAgainstBossInfo:Ctor(client)
  SReturnAgainstBossInfo.super.Ctor(self, client)
  self.againstBossInfo = require("protocols.bean.protocol.activity.againstbossinfo").Create()
end

function SReturnAgainstBossInfo:Marshal(buffer)
  if not self.againstBossInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  return true
end

function SReturnAgainstBossInfo:Unmarshal(buffer)
  local ret = true
  if not self.againstBossInfo:Unmarshal(buffer) then
    return false
  end
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReturnAgainstBossInfo
