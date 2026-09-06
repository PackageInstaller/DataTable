local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateSummerMissions = dataclass("SUpdateSummerMissions", require("framework.net.protocol"))
SUpdateSummerMissions.ProtocolType = 2510
SUpdateSummerMissions.MaxSize = 65535
SUpdateSummerMissions.sunlight = 0

function SUpdateSummerMissions:Ctor(client)
  SUpdateSummerMissions.super.Ctor(self, client)
  self.missions = {}
end

function SUpdateSummerMissions:Marshal(buffer)
  local length = table.slen(self.missions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.missions[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sunlight) then
    return false
  end
  return true
end

function SUpdateSummerMissions:Unmarshal(buffer)
  local ret = true
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
  ret, self.sunlight = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUpdateSummerMissions
