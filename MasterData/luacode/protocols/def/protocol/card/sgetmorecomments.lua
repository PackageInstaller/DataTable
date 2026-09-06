local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetMoreComments = dataclass("SGetMoreComments", require("framework.net.protocol"))
SGetMoreComments.ProtocolType = 1514
SGetMoreComments.MaxSize = 65535
SGetMoreComments.commentType = 0
SGetMoreComments.roleId = 0
SGetMoreComments.firstIndex = 0

function SGetMoreComments:Ctor(client)
  SGetMoreComments.super.Ctor(self, client)
  self.comments = {}
end

function SGetMoreComments:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.commentType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstIndex) then
    return false
  end
  local length = table.slen(self.comments)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.comments[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetMoreComments:Unmarshal(buffer)
  local ret = true
  ret, self.commentType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.firstIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.comments[i] = require("protocols.bean.protocol.card.commentinfo").Create()
    if not self.comments[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetMoreComments
