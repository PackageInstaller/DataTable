local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CConfirmEntries = dataclass("CConfirmEntries", require("framework.net.protocol"))
CConfirmEntries.ProtocolType = 2485
CConfirmEntries.MaxSize = 65535
CConfirmEntries.battleType = 0
CConfirmEntries.battleId = 0

function CConfirmEntries:Ctor(client)
  CConfirmEntries.super.Ctor(self, client)
  self.entries = {}
end

function CConfirmEntries:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  local length = table.slen(self.entries)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.entries[i]) then
      return false
    end
  end
  return true
end

function CConfirmEntries:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.entries[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CConfirmEntries
