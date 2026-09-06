local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchTaskFinishAward = dataclass("CFetchTaskFinishAward", require("framework.net.protocol"))
CFetchTaskFinishAward.ProtocolType = 2683
CFetchTaskFinishAward.MaxSize = 65535
CFetchTaskFinishAward.id = 0

function CFetchTaskFinishAward:Ctor(client)
  CFetchTaskFinishAward.super.Ctor(self, client)
end

function CFetchTaskFinishAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CFetchTaskFinishAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchTaskFinishAward
