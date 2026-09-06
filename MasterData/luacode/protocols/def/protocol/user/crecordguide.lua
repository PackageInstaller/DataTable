local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordGuide = dataclass("CRecordGuide", require("framework.net.protocol"))
CRecordGuide.ProtocolType = 2211
CRecordGuide.MaxSize = 65535
CRecordGuide.guide = 0

function CRecordGuide:Ctor(client)
  CRecordGuide.super.Ctor(self, client)
end

function CRecordGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guide) then
    return false
  end
  return true
end

function CRecordGuide:Unmarshal(buffer)
  local ret = true
  ret, self.guide = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordGuide
