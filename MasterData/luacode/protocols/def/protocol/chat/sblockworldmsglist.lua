local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBlockWorldMsgList = dataclass("SBlockWorldMsgList", require("framework.net.protocol"))
SBlockWorldMsgList.ProtocolType = 1169
SBlockWorldMsgList.MaxSize = 65535

function SBlockWorldMsgList:Ctor(client)
  SBlockWorldMsgList.super.Ctor(self, client)
  self.userIds = {}
end

function SBlockWorldMsgList:Marshal(buffer)
  local length = table.slen(self.userIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userIds[i]) then
      return false
    end
  end
  return true
end

function SBlockWorldMsgList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.userIds[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SBlockWorldMsgList
