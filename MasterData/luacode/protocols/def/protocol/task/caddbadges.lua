local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddBadges = dataclass("CAddBadges", require("framework.net.protocol"))
CAddBadges.ProtocolType = 1623
CAddBadges.MaxSize = 65535

function CAddBadges:Ctor(client)
  CAddBadges.super.Ctor(self, client)
  self.badges = {}
end

function CAddBadges:Marshal(buffer)
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

function CAddBadges:Unmarshal(buffer)
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

return CAddBadges
