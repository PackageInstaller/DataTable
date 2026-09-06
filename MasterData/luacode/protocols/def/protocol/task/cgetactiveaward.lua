local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetActiveAward = dataclass("CGetActiveAward", require("framework.net.protocol"))
CGetActiveAward.ProtocolType = 1617
CGetActiveAward.MaxSize = 65535
CGetActiveAward.value = 0

function CGetActiveAward:Ctor(client)
  CGetActiveAward.super.Ctor(self, client)
end

function CGetActiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  return true
end

function CGetActiveAward:Unmarshal(buffer)
  local ret = true
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetActiveAward
