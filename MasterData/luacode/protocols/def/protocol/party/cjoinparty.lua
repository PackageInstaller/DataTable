local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CJoinParty = dataclass("CJoinParty", require("framework.net.protocol"))
CJoinParty.ProtocolType = 5004
CJoinParty.MaxSize = 65535

function CJoinParty:Ctor(client)
  CJoinParty.super.Ctor(self, client)
  self.partyIdList = {}
end

function CJoinParty:Marshal(buffer)
  local length = table.slen(self.partyIdList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyIdList[i]) then
      return false
    end
  end
  return true
end

function CJoinParty:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.partyIdList[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CJoinParty
