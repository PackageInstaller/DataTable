local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRecordGuide = dataclass("SRecordGuide", require("framework.net.protocol"))
SRecordGuide.ProtocolType = 2215
SRecordGuide.MaxSize = 65535
SRecordGuide.guide = 0

function SRecordGuide:Ctor(client)
  SRecordGuide.super.Ctor(self, client)
end

function SRecordGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guide) then
    return false
  end
  return true
end

function SRecordGuide:Unmarshal(buffer)
  local ret = true
  ret, self.guide = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRecordGuide
