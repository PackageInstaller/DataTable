local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordProcedure = dataclass("CRecordProcedure", require("framework.net.protocol"))
CRecordProcedure.ProtocolType = 2212
CRecordProcedure.MaxSize = 65535
CRecordProcedure.procedure = 0

function CRecordProcedure:Ctor(client)
  CRecordProcedure.super.Ctor(self, client)
end

function CRecordProcedure:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.procedure) then
    return false
  end
  return true
end

function CRecordProcedure:Unmarshal(buffer)
  local ret = true
  ret, self.procedure = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordProcedure
