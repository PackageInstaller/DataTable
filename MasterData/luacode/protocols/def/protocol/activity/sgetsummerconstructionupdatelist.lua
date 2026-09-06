local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSummerConstructionUpdateList = dataclass("SGetSummerConstructionUpdateList", require("framework.net.protocol"))
SGetSummerConstructionUpdateList.ProtocolType = 2474
SGetSummerConstructionUpdateList.MaxSize = 65535

function SGetSummerConstructionUpdateList:Ctor(client)
  SGetSummerConstructionUpdateList.super.Ctor(self, client)
  self.constructionList = {}
  self.unusedconstruction = {}
end

function SGetSummerConstructionUpdateList:Marshal(buffer)
  local length = table.slen(self.constructionList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.constructionList[i]) then
      return false
    end
  end
  local length = table.slen(self.unusedconstruction)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unusedconstruction[i]) then
      return false
    end
  end
  return true
end

function SGetSummerConstructionUpdateList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.constructionList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    ret, self.unusedconstruction[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SGetSummerConstructionUpdateList
