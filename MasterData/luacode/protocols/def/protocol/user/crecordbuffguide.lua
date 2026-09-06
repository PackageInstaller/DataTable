local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordBuffGuide = dataclass("CRecordBuffGuide", require("framework.net.protocol"))
CRecordBuffGuide.ProtocolType = 2270
CRecordBuffGuide.MaxSize = 65535
CRecordBuffGuide.buffType = 0

function CRecordBuffGuide:Ctor(client)
  CRecordBuffGuide.super.Ctor(self, client)
end

function CRecordBuffGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buffType) then
    return false
  end
  return true
end

function CRecordBuffGuide:Unmarshal(buffer)
  local ret = true
  ret, self.buffType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordBuffGuide
