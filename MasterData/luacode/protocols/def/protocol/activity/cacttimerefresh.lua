local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActTimeRefresh = dataclass("CActTimeRefresh", require("framework.net.protocol"))
CActTimeRefresh.ProtocolType = 2658
CActTimeRefresh.MaxSize = 65535
CActTimeRefresh.activityId = 0

function CActTimeRefresh:Ctor(client)
  CActTimeRefresh.super.Ctor(self, client)
end

function CActTimeRefresh:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function CActTimeRefresh:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActTimeRefresh
