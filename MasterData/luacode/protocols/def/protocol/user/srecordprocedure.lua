local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRecordProcedure = dataclass("SRecordProcedure", require("framework.net.protocol"))
SRecordProcedure.ProtocolType = 2216
SRecordProcedure.MaxSize = 65535
SRecordProcedure.procedure = 0

function SRecordProcedure:Ctor(client)
  SRecordProcedure.super.Ctor(self, client)
end

function SRecordProcedure:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.procedure) then
    return false
  end
  return true
end

function SRecordProcedure:Unmarshal(buffer)
  local ret = true
  ret, self.procedure = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRecordProcedure
