local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenReward = dataclass("COpenReward", require("framework.net.protocol"))
COpenReward.ProtocolType = 4115
COpenReward.MaxSize = 65535
COpenReward.process = 0

function COpenReward:Ctor(client)
  COpenReward.super.Ctor(self, client)
end

function COpenReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.process) then
    return false
  end
  return true
end

function COpenReward:Unmarshal(buffer)
  local ret = true
  ret, self.process = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenReward
