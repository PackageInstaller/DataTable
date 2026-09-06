local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetInitComments = dataclass("SGetInitComments", require("framework.net.protocol"))
SGetInitComments.ProtocolType = 1513
SGetInitComments.MaxSize = 65535
SGetInitComments.commentType = 0
SGetInitComments.roleId = 0

function SGetInitComments:Ctor(client)
  SGetInitComments.super.Ctor(self, client)
  self.userComment = require("protocols.bean.protocol.card.commentinfo").Create()
  self.comments = {}
end

function SGetInitComments:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.commentType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not self.userComment:Marshal(buffer) then
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

function SGetInitComments:Unmarshal(buffer)
  local ret = true
  ret, self.commentType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.userComment:Unmarshal(buffer) then
    return false
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

return SGetInitComments
