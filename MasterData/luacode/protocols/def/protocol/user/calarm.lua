local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAlarm = dataclass("CAlarm", require("framework.net.protocol"))
CAlarm.ProtocolType = 2273
CAlarm.MaxSize = 65535
CAlarm.context = ""

function CAlarm:Ctor(client)
  CAlarm.super.Ctor(self, client)
end

function CAlarm:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.context) then
    return false
  end
  return true
end

function CAlarm:Unmarshal(buffer)
  local ret = true
  ret, self.context = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAlarm
