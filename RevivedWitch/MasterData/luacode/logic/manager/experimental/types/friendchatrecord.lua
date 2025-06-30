-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/friendchatrecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendChatRecord = strictclass("FriendChatRecord")
FriendChatRecord.Ctor = function(self)
  -- function num : 0_0
  self._bMyMsg = nil
  self._chatTime = nil
  self._chatmsg = nil
  self._hyperlinks = nil
end

FriendChatRecord.SetData = function(self, bean, bFromMy)
  -- function num : 0_1 , upvalues : _ENV
  self._bMyMsg = bFromMy
  self._chatTime = bean.time
  self._chatmsg = bean.msg
  self._hyperlinks = {}
  if type(bean.hyperlinks) == "table" then
    self._hyperlinks = bean.hyperlinks
  else
    if bean.hyperlinks ~= "" then
      self._hyperlinks = {}
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._hyperlinks)[1] = {}
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._hyperlinks)[1] = (JSON.decode)(bean.hyperlinks)
    end
  end
end

FriendChatRecord.IsMySendMsg = function(self)
  -- function num : 0_2
  if not self._bMyMsg then
    return false
  end
  return true
end

FriendChatRecord.GetChatMsg = function(self)
  -- function num : 0_3
  return self._chatmsg
end

FriendChatRecord.GetChatTimeStr = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (ServerGameTimer.GetDetailTimeStr)(self._chatTime)
end

FriendChatRecord.GetChatTime = function(self)
  -- function num : 0_5
  return self._chatTime
end

return FriendChatRecord

