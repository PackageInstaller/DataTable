local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActiveActivities = dataclass("CActiveActivities", require("framework.net.protocol"))
CActiveActivities.ProtocolType = 2444
CActiveActivities.MaxSize = 65535

function CActiveActivities:Ctor(client)
  CActiveActivities.super.Ctor(self, client)
end

function CActiveActivities:Marshal(buffer)
  return true
end

function CActiveActivities:Unmarshal(buffer)
  local ret = true
  return ret
end

return CActiveActivities
