local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordLowFrameBattle = dataclass("CRecordLowFrameBattle", require("framework.net.protocol"))
CRecordLowFrameBattle.ProtocolType = 2262
CRecordLowFrameBattle.MaxSize = 65535
CRecordLowFrameBattle.fps = 0
CRecordLowFrameBattle.roles = ""
CRecordLowFrameBattle.effect = ""

function CRecordLowFrameBattle:Ctor(client)
  CRecordLowFrameBattle.super.Ctor(self, client)
end

function CRecordLowFrameBattle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolFloat(buffer, self.fps) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.roles) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.effect) then
    return false
  end
  return true
end

function CRecordLowFrameBattle:Unmarshal(buffer)
  local ret = true
  ret, self.fps = ProtocolBufferStaticFunctions.ReadFloat(buffer)
  if not ret then
    return ret
  end
  ret, self.roles = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.effect = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordLowFrameBattle
