-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_friendschat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_friendsChat = class("BM_friendsChat")
BM_friendsChat.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._friendsChat = (NekoData.Data).friendsChat
end

BM_friendsChat.GetNotReadNum = function(self, userId)
  -- function num : 0_1
  local num1 = self:GetOnLineNotReadNum(userId)
  local num2 = self:GetLocalNotReadNum(userId)
  return num1 + num2
end

BM_friendsChat.GetOnLineNotReadNum = function(self, userId)
  -- function num : 0_2
  local onlineChat = ((self._friendsChat).onlineChat)[userId]
  if onlineChat then
    return onlineChat:GetNotReadNum()
  end
  return 0
end

BM_friendsChat.GetLocalNotReadNum = function(self, userId)
  -- function num : 0_3
  local localChat = ((self._friendsChat).localChat)[userId]
  if localChat then
    return localChat:GetNotReadNum()
  end
  return 0
end

BM_friendsChat.GetFirstNotReadMsgTime = function(self, userId)
  -- function num : 0_4
  local localChat = ((self._friendsChat).localChat)[userId]
  if localChat and localChat:GetFirstNotReadMsgTime() > 0 then
    return localChat:GetFirstNotReadMsgTime()
  end
  local onlineChat = ((self._friendsChat).onlineChat)[userId]
  if onlineChat and onlineChat:GetFirstNotReadMsgTime() > 0 then
    return onlineChat:GetFirstNotReadMsgTime()
  end
  return 0
end

BM_friendsChat.GetLastChatTime = function(self, userId)
  -- function num : 0_5
  if ((self._friendsChat).onlineChat)[userId] then
    return (((self._friendsChat).onlineChat)[userId]):GetLastChatTime()
  end
  if ((self._friendsChat).localChat)[userId] then
    return (((self._friendsChat).localChat)[userId]):GetLastChatTime()
  end
  return nil
end

BM_friendsChat.GetFriendChatRecord = function(self, userId)
  -- function num : 0_6
  if not ((self._friendsChat).onlineChat)[userId] then
    return {}
  end
  return (((self._friendsChat).onlineChat)[userId]):GetAllRecord()
end

BM_friendsChat.GetLocalChatRecord = function(self, userId)
  -- function num : 0_7
  if not ((self._friendsChat).localChat)[userId] then
    return {}
  end
  return (((self._friendsChat).localChat)[userId]):GetAllRecord()
end

BM_friendsChat.RequestChatWithFriend = function(self, userId)
  -- function num : 0_8 , upvalues : _ENV
  if not ((self._friendsChat).onlineChat)[userId] then
    ((NekoData.DataManager).DM_FriendsChat):AddFriendsChat(userId)
    local dialog = (DialogManager.GetDialog)("friend.friendslistdialog")
    if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
      ((NekoData.DataManager).DM_Friends):CheckFriendPageRedData()
      local userInfo = {}
      userInfo.userId = userId
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_FriendNotReadNumChange, nil, userInfo)
    end
  end
  do
    ;
    (((self._friendsChat).onlineChat)[userId]):SetLastChatTime((ServerGameTimer.GetServerTime)())
    local friendChatDlg = (DialogManager.CreateSingletonDialog)("friend.friendschatdialog")
    if friendChatDlg then
      friendChatDlg:SelectChatFriend(userId)
    end
  end
end

BM_friendsChat.SendFriendChat = function(self, userId, msg)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.csendfriendmsg")
  protocol.userId = userId
  protocol.msg = msg
  protocol:Send()
end

BM_friendsChat.RequestLoadLocalMsg = function(self, userId, num)
  -- function num : 0_10 , upvalues : _ENV
  local curNum = (((self._friendsChat).localChat)[userId]):GetCurLoadMsgNum()
  local needLoadNum = num - curNum
  ;
  ((NekoData.DataManager).DM_FriendsChat):CheckLoadMsg(userId, needLoadNum)
end

BM_friendsChat.ResetFirstNotReadMsgTime = function(self, userId)
  -- function num : 0_11
  local localChat = ((self._friendsChat).localChat)[userId]
  if localChat then
    localChat:ResetFirstNotReadMsgTime()
  end
  local onlineChat = ((self._friendsChat).onlineChat)[userId]
  if onlineChat then
    onlineChat:ResetFirstNotReadMsgTime()
  end
end

BM_friendsChat.RandomChatFriend = function(self, chatnum)
  -- function num : 0_12 , upvalues : _ENV
  local friendList = ((NekoData.BehaviorManager).BM_Friends):GetAllFriend()
  local num = (table.nums)(friendList)
  local randomIndex = (math.random)(1, num)
  local index = 0
  local userid = 0
  for friendid,friend in pairs(friendList) do
    index = index + 1
    if index == randomIndex then
      userid = friendid
      break
    end
  end
  do
    if userid == 0 then
      return 
    end
    self:TestChatWithFriend(userid, chatnum)
  end
end

BM_friendsChat.TestChatWithFriend = function(self, userId, num)
  -- function num : 0_13 , upvalues : _ENV
  for j = 0, num do
    local randomNum = (math.random)(0, 9)
    local randomLen = (math.random)(2, 100)
    local str = ""
    for i = 1, randomLen do
      str = str .. tostring(randomNum)
    end
    self:SendFriendChat(userId, str)
  end
end

return BM_friendsChat

