local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShopRedpointNotify = dataclass("SShopRedpointNotify", require("framework.net.protocol"))
SShopRedpointNotify.ProtocolType = 3623
SShopRedpointNotify.MaxSize = 65535

function SShopRedpointNotify:Ctor(client)
  SShopRedpointNotify.super.Ctor(self, client)
  self.redPointList = {}
  self.freeRedPointList = {}
end

function SShopRedpointNotify:Marshal(buffer)
  local length = table.slen(self.redPointList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redPointList[i]) then
      return false
    end
  end
  local length = table.slen(self.freeRedPointList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.freeRedPointList[i]) then
      return false
    end
  end
  return true
end

function SShopRedpointNotify:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.redPointList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.freeRedPointList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SShopRedpointNotify
