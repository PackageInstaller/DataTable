-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/otheruserinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
OtherUserInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
  self.messages = {}
end

OtherUserInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.identity) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.lastLogoutTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.friendTime) then
    return false
  end
  local length = (table.slen)(self.messages)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.messages)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.lastOnLineTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.likeStatus) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sparkStatus) then
    return false
  end
  return true
end

OtherUserInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.baseUserData):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    (self.messages)[i] = ((require("protocols.bean.protocol.chat.friendchat")).Create)()
    if not ((self.messages)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return OtherUserInfo

