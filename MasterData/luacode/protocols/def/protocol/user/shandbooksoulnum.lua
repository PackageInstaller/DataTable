local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SHandbookSoulNum = dataclass("SHandbookSoulNum", require("framework.net.protocol"))
SHandbookSoulNum.ProtocolType = 2261
SHandbookSoulNum.MaxSize = 65535
SHandbookSoulNum.HandBookId = 0
SHandbookSoulNum.soulNum = 0

function SHandbookSoulNum:Ctor(client)
  SHandbookSoulNum.super.Ctor(self, client)
end

function SHandbookSoulNum:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.HandBookId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.soulNum) then
    return false
  end
  return true
end

function SHandbookSoulNum:Unmarshal(buffer)
  local ret = true
  ret, self.HandBookId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.soulNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SHandbookSoulNum
