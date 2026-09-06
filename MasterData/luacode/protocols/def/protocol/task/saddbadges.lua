local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddBadges = dataclass("SAddBadges", require("framework.net.protocol"))
SAddBadges.ProtocolType = 1624
SAddBadges.MaxSize = 65535

function SAddBadges:Ctor(client)
  SAddBadges.super.Ctor(self, client)
  self.badges = {}
end

function SAddBadges:Marshal(buffer)
  local length = table.slen(self.badges)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.badges[i]) then
      return false
    end
  end
  return true
end

function SAddBadges:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.badges[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SAddBadges
