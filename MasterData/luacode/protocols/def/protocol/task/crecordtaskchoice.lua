local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordTaskChoice = dataclass("CRecordTaskChoice", require("framework.net.protocol"))
CRecordTaskChoice.ProtocolType = 1614
CRecordTaskChoice.MaxSize = 65535
CRecordTaskChoice.taskid = 0
CRecordTaskChoice.choice = ""

function CRecordTaskChoice:Ctor(client)
  CRecordTaskChoice.super.Ctor(self, client)
end

function CRecordTaskChoice:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.choice) then
    return false
  end
  return true
end

function CRecordTaskChoice:Unmarshal(buffer)
  local ret = true
  ret, self.taskid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.choice = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordTaskChoice
