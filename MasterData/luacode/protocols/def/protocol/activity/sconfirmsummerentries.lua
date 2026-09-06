local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SConfirmSummerEntries = dataclass("SConfirmSummerEntries", require("framework.net.protocol"))
SConfirmSummerEntries.ProtocolType = 2718
SConfirmSummerEntries.MaxSize = 65535
SConfirmSummerEntries.result = 0

function SConfirmSummerEntries:Ctor(client)
  SConfirmSummerEntries.super.Ctor(self, client)
end

function SConfirmSummerEntries:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SConfirmSummerEntries:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SConfirmSummerEntries
