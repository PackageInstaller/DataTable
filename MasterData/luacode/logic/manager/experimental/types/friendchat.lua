local FriendChat = strictclass("FriendChat")
local FriendChatRecord = require("logic.manager.experimental.types.friendchatrecord")

function FriendChat:Ctor()
  self._lastChatTime = nil
  self._notReadNum = 0
  self._totalChatNum = 0
  self._firstNotReadMsgTime = nil
  self._chatList = {}
end

function FriendChat:Clear()
  self._chatList = {}
end

function FriendChat:AddChatRecord(bean, bfromMy)
  self._lastChatTime = bean.time
  if not bfromMy then
    self._notReadNum = self._notReadNum + 1
  end
  local chatrecord = FriendChatRecord.Create()
  chatrecord:SetData(bean, bfromMy)
  table.insert(self._chatList, chatrecord)
  if self._notReadNum > 0 and self._chatList[self._notReadNum] then
    self._firstNotReadMsgTime = self._chatList[self._notReadNum]._chatTime
  end
end

function FriendChat:SetLastChatTime(time)
  self._lastChatTime = time
end

function FriendChat:ResetNotReadNum()
  self._notReadNum = 0
end

function FriendChat:GetNotReadNum()
  return self._notReadNum
end

function FriendChat:GetLastChatTime()
  return self._lastChatTime
end

function FriendChat:GetAllRecord()
  return self._chatList
end

function FriendChat:ResetFirstNotReadMsgTime()
  self._firstNotReadMsgTime = nil
end

function FriendChat:GetFirstNotReadMsgTime()
  return self._firstNotReadMsgTime or 0
end

function FriendChat:SetLocalChatInfo(redNum, totalNum)
  self._notReadNum = redNum
  self._totalChatNum = totalNum
end

function FriendChat:AddLocalChatRecord(bean)
  if not self._lastChatTime then
    self._lastChatTime = bean.time
  end
  if self._lastChatTime < bean.time then
    self._lastChatTime = bean.time
  end
  local chatrecord = FriendChatRecord.Create()
  chatrecord:SetData(bean, bean.sender == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  table.insert(self._chatList, 1, chatrecord)
end

function FriendChat:GetTotalLoalMsgNum()
  return self._totalChatNum
end

function FriendChat:GetCurLoadMsgNum()
  return #self._chatList
end

return FriendChat
