local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAllUnlockFunc = dataclass("SAllUnlockFunc", require("framework.net.protocol"))
SAllUnlockFunc.ProtocolType = 1804
SAllUnlockFunc.MaxSize = 65535

function SAllUnlockFunc:Ctor(client)
  SAllUnlockFunc.super.Ctor(self, client)
  self.funcLisk = {}
end

function SAllUnlockFunc:Marshal(buffer)
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

function SAllUnlockFunc:Unmarshal(buffer)
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

return SAllUnlockFunc
