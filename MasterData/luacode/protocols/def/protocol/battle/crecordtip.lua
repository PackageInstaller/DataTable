local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordTip = dataclass("CRecordTip", require("framework.net.protocol"))
CRecordTip.ProtocolType = 4120
CRecordTip.MaxSize = 65535
CRecordTip.id = 0
CRecordTip.kind = 0
CRecordTip.TIP = 1
CRecordTip.NPC = 2

function CRecordTip:Ctor(client)
  CRecordTip.super.Ctor(self, client)
end

function CRecordTip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  return true
end

function CRecordTip:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordTip
