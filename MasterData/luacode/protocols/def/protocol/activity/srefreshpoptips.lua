local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshPopTips = dataclass("SRefreshPopTips", require("framework.net.protocol"))
SRefreshPopTips.ProtocolType = 2561
SRefreshPopTips.MaxSize = 65535
SRefreshPopTips.activityID = 0
SRefreshPopTips.status = 0

function SRefreshPopTips:Ctor(client)
  SRefreshPopTips.super.Ctor(self, client)
end

function SRefreshPopTips:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  return true
end

function SRefreshPopTips:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshPopTips
