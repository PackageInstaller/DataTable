local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CConfirmSummerEntries = dataclass("CConfirmSummerEntries", require("framework.net.protocol"))
CConfirmSummerEntries.ProtocolType = 2717
CConfirmSummerEntries.MaxSize = 65535

function CConfirmSummerEntries:Ctor(client)
  CConfirmSummerEntries.super.Ctor(self, client)
  self.entries = {}
end

function CConfirmSummerEntries:Marshal(buffer)
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

function CConfirmSummerEntries:Unmarshal(buffer)
  local ret = true
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

return CConfirmSummerEntries
