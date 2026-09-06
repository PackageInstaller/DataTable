local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockFunc = dataclass("SUnlockFunc", require("framework.net.protocol"))
SUnlockFunc.ProtocolType = 1803
SUnlockFunc.MaxSize = 65535

function SUnlockFunc:Ctor(client)
  SUnlockFunc.super.Ctor(self, client)
  self.funcLisk = {}
end

function SUnlockFunc:Marshal(buffer)
  local length = table.slen(self.funcLisk)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.funcLisk[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUnlockFunc:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.funcLisk[i] = require("protocols.bean.protocol.notify.fununlock").Create()
    if not self.funcLisk[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUnlockFunc
