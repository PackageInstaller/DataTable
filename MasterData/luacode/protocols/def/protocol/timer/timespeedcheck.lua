local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TimeSpeedCheck = dataclass("TimeSpeedCheck", require("framework.net.protocol"))
TimeSpeedCheck.ProtocolType = 1702
TimeSpeedCheck.MaxSize = 65535
TimeSpeedCheck.clientTime = 0
TimeSpeedCheck.serverTime = 0

function TimeSpeedCheck:Ctor(client)
  TimeSpeedCheck.super.Ctor(self, client)
end

function TimeSpeedCheck:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.clientTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.serverTime) then
    return false
  end
  return true
end

function TimeSpeedCheck:Unmarshal(buffer)
  local ret = true
  ret, self.clientTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.serverTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TimeSpeedCheck
