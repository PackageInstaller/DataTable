local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local OtherUserInfo = dataclass("OtherUserInfo")
OtherUserInfo.identity = 0
OtherUserInfo.lastLogoutTime = 0
OtherUserInfo.friendTime = 0
OtherUserInfo.lastOnLineTime = 0
OtherUserInfo.likeStatus = 0
OtherUserInfo.sparkStatus = 0
OtherUserInfo.FRIEND = 1
OtherUserInfo.BLACK_LIST = 2
OtherUserInfo.APPLICANT = 3
OtherUserInfo.SEARCH = 4
OtherUserInfo.ADD = 5
OtherUserInfo.STRANGER = 6

function OtherUserInfo:Ctor()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
  self.messages = {}
end

function OtherUserInfo:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.identity) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.lastLogoutTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.friendTime) then
    return false
  end
  local length = table.slen(self.messages)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.messages[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.lastOnLineTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likeStatus) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sparkStatus) then
    return false
  end
  return true
end

function OtherUserInfo:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.identity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lastLogoutTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.friendTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.messages[i] = require("protocols.bean.protocol.chat.friendchat").Create()
    if not self.messages[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.lastOnLineTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.likeStatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sparkStatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return OtherUserInfo
