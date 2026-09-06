local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshCavernTaskActive = dataclass("SRefreshCavernTaskActive", require("framework.net.protocol"))
SRefreshCavernTaskActive.ProtocolType = 2348
SRefreshCavernTaskActive.MaxSize = 65535
SRefreshCavernTaskActive.nums = 0
SRefreshCavernTaskActive.leftRefreshTime = 0

function SRefreshCavernTaskActive:Ctor(client)
  SRefreshCavernTaskActive.super.Ctor(self, client)
  self.cavernTask = require("protocols.bean.protocol.yard.caverntask").Create()
end

function SRefreshCavernTaskActive:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nums) then
    return false
  end
  if not self.cavernTask:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftRefreshTime) then
    return false
  end
  return true
end

function SRefreshCavernTaskActive:Unmarshal(buffer)
  local ret = true
  ret, self.nums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.cavernTask:Unmarshal(buffer) then
    return false
  end
  ret, self.leftRefreshTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshCavernTaskActive
