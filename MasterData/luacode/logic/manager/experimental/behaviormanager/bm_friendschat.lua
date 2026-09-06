local BM_friendsChat = class("BM_friendsChat")

function BM_friendsChat:Ctor()
  self._friendsChat = NekoData.Data.friendsChat
end

function BM_friendsChat:GetNotReadNum(userId)
  local num1 = self:GetOnLineNotReadNum(userId)
  local num2 = self:GetLocalNotReadNum(userId)
  return num1 + num2
end

function BM_friendsChat:GetOnLineNotReadNum(userId)
  local onlineChat = self._friendsChat.onlineChat[userId]
  if onlineChat then
    return onlineChat:GetNotReadNum()
  end
  return 0
end

function BM_friendsChat:GetLocalNotReadNum(userId)
  local localChat = self._friendsChat.localChat[userId]
  if localChat then
    return localChat:GetNotReadNum()
  end
  return 0
end

function BM_friendsChat:GetFirstNotReadMsgTime(userId)
  local localChat = self._friendsChat.localChat[userId]
  if localChat and localChat:GetFirstNotReadMsgTime() > 0 then
    return localChat:GetFirstNotReadMsgTime()
  end
  local onlineChat = self._friendsChat.onlineChat[userId]
  if onlineChat and onlineChat:GetFirstNotReadMsgTime() > 0 then
    return onlineChat:GetFirstNotReadMsgTime()
  end
  return 0
end

function BM_friendsChat:GetLastChatTime(userId)
  if self._friendsChat.onlineChat[userId] then
    return self._friendsChat.onlineChat[userId]:GetLastChatTime()
  end
  if self._friendsChat.localChat[userId] then
    return self._friendsChat.localChat[userId]:GetLastChatTime()
  end
  return nil
end

function BM_friendsChat:GetFriendChatRecord(userId)
  if not self._friendsChat.onlineChat[userId] then
    return {}
  end
  return self._friendsChat.onlineChat[userId]:GetAllRecord()
end

function BM_friendsChat:GetLocalChatRecord(userId)
  if not self._friendsChat.localChat[userId] then
    return {}
  end
  return self._friendsChat.localChat[userId]:GetAllRecord()
end

function BM_friendsChat:RequestChatWithFriend(userId)
  if not self._friendsChat.onlineChat[userId] then
    NekoData.DataManager.DM_FriendsChat:AddFriendsChat(userId)
    local dialog = DialogManager.GetDialog("friend.friendslistdialog")
    if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
      NekoData.DataManager.DM_Friends:CheckFriendPageRedData()
      local userInfo = {}
      userInfo.userId = userId
      LuaNotificationCenter.PostNotification(Common.n_FriendNotReadNumChange, nil, userInfo)
    end
  end
  self._friendsChat.onlineChat[userId]:SetLastChatTime(ServerGameTimer.GetServerTime())
  local friendChatDlg = DialogManager.CreateSingletonDialog("friend.friendschatdialog")
  if friendChatDlg then
    friendChatDlg:SelectChatFriend(userId)
  end
end

function BM_friendsChat:SendFriendChat(userId, msg)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.csendfriendmsg")
  protocol.userId = userId
  protocol.msg = msg
  protocol:Send()
end

function BM_friendsChat:RequestLoadLocalMsg(userId, num)
  local curNum = self._friendsChat.localChat[userId]:GetCurLoadMsgNum()
  local needLoadNum = num - curNum
  NekoData.DataManager.DM_FriendsChat:CheckLoadMsg(userId, needLoadNum)
end

function BM_friendsChat:ResetFirstNotReadMsgTime(userId)
  local localChat = self._friendsChat.localChat[userId]
  if localChat then
    localChat:ResetFirstNotReadMsgTime()
  end
  local onlineChat = self._friendsChat.onlineChat[userId]
  if onlineChat then
    onlineChat:ResetFirstNotReadMsgTime()
  end
end

function BM_friendsChat:RandomChatFriend(chatnum)
  local friendList = NekoData.BehaviorManager.BM_Friends:GetAllFriend()
  local num = table.nums(friendList)
  local randomIndex = math.random(1, num)
  local index = 0
  local userid = 0
  for friendid, friend in pairs(friendList) do
    index = index + 1
    if index == randomIndex then
      userid = friendid
      break
    end
  end
  if userid == 0 then
    return
  end
  self:TestChatWithFriend(userid, chatnum)
end

function BM_friendsChat:TestChatWithFriend(userId, num)
  for j = 0, num do
    local randomNum = math.random(0, 9)
    local randomLen = math.random(2, 100)
    local str = ""
    for i = 1, randomLen do
      str = str .. tostring(randomNum)
    end
    self:SendFriendChat(userId, str)
  end
end

return BM_friendsChat
