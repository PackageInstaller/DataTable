local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSummerActivityInfo = dataclass("SGetSummerActivityInfo", require("framework.net.protocol"))
SGetSummerActivityInfo.ProtocolType = 2470
SGetSummerActivityInfo.MaxSize = 65535
SGetSummerActivityInfo.firstEnter = 0
SGetSummerActivityInfo.sunlight = 0
SGetSummerActivityInfo.state = 0
SGetSummerActivityInfo.constructionRedpoint = 0
SGetSummerActivityInfo.snackRedpoint = 0

function SGetSummerActivityInfo:Ctor(client)
  SGetSummerActivityInfo.super.Ctor(self, client)
  self.missions = {}
  self.constructions = {}
end

function SGetSummerActivityInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstEnter) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sunlight) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  local length = table.slen(self.missions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.missions[i]:Marshal(buffer) then
      return false
    end
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.constructionRedpoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.snackRedpoint) then
    return false
  end
  return true
end

function SGetSummerActivityInfo:Unmarshal(buffer)
  local ret = true
  ret, self.firstEnter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sunlight = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.missions[i] = require("protocols.bean.protocol.activity.summermission").Create()
    if not self.missions[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.constructions[i] = require("protocols.bean.protocol.activity.summerconstruction").Create()
    if not self.constructions[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.constructionRedpoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.snackRedpoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSummerActivityInfo
