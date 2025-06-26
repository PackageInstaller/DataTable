-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/friendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendChat = strictclass("FriendChat")
local FriendChatRecord = require("logic.manager.experimental.types.friendchatrecord")
FriendChat.Ctor = function(self)
  -- function num : 0_0
  self._lastChatTime = nil
  self._notReadNum = 0
  self._totalChatNum = 0
  self._firstNotReadMsgTime = nil
  self._chatList = {}
end

FriendChat.Clear = function(self)
  -- function num : 0_1
  self._chatList = {}
end

FriendChat.AddChatRecord = function(self, bean, bfromMy)
  -- function num : 0_2 , upvalues : FriendChatRecord, _ENV
  self._lastChatTime = bean.time
  if not bfromMy then
    self._notReadNum = self._notReadNum + 1
  end
  local chatrecord = (FriendChatRecord.Create)()
  chatrecord:SetData(bean, bfromMy)
  ;
  (table.insert)(self._chatList, chatrecord)
  if self._notReadNum > 0 and (self._chatList)[self._notReadNum] then
    self._firstNotReadMsgTime = ((self._chatList)[self._notReadNum])._chatTime
  end
end

FriendChat.SetLastChatTime = function(self, time)
  -- function num : 0_3
  self._lastChatTime = time
end

FriendChat.ResetNotReadNum = function(self)
  -- function num : 0_4
  self._notReadNum = 0
end

FriendChat.GetNotReadNum = function(self)
  -- function num : 0_5
  return self._notReadNum
end

FriendChat.GetLastChatTime = function(self)
  -- function num : 0_6
  return self._lastChatTime
end

FriendChat.GetAllRecord = function(self)
  -- function num : 0_7
  return self._chatList
end

FriendChat.ResetFirstNotReadMsgTime = function(self)
  -- function num : 0_8
  self._firstNotReadMsgTime = nil
end

FriendChat.GetFirstNotReadMsgTime = function(self)
  -- function num : 0_9
  return self._firstNotReadMsgTime or 0
end

FriendChat.SetLocalChatInfo = function(self, redNum, totalNum)
  -- function num : 0_10
  self._notReadNum = redNum
  self._totalChatNum = totalNum
end

FriendChat.AddLocalChatRecord = function(self, bean)
  -- function num : 0_11 , upvalues : FriendChatRecord, _ENV
  if not self._lastChatTime then
    self._lastChatTime = bean.time
  end
  if self._lastChatTime < bean.time then
    self._lastChatTime = bean.time
  end
  local chatrecord = (FriendChatRecord.Create)()
  chatrecord:SetData(bean, bean.sender == (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid)
  ;
  (table.insert)(self._chatList, 1, chatrecord)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FriendChat.GetTotalLoalMsgNum = function(self)
  -- function num : 0_12
  return self._totalChatNum
end

FriendChat.GetCurLoadMsgNum = function(self)
  -- function num : 0_13
  return #self._chatList
end

return FriendChat

