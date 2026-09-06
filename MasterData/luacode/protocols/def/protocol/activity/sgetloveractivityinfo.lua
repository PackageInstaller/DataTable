local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetLoverActivityInfo = dataclass("SGetLoverActivityInfo", require("framework.net.protocol"))
SGetLoverActivityInfo.ProtocolType = 2589
SGetLoverActivityInfo.MaxSize = 65535
SGetLoverActivityInfo.firstEnter = 0

function SGetLoverActivityInfo:Ctor(client)
  SGetLoverActivityInfo.super.Ctor(self, client)
  self.constructions = {}
end

function SGetLoverActivityInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstEnter) then
    return false
  end
  local length = table.slen(self.constructions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.constructions[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetLoverActivityInfo:Unmarshal(buffer)
  local ret = true
  ret, self.firstEnter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.constructions[i] = require("protocols.bean.protocol.activity.loverconstruction").Create()
    if not self.constructions[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetLoverActivityInfo
