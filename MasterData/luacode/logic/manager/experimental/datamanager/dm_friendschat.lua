local DM_FriendsChat = class("DM_FriendsChat")
local FriendChat = require("logic.manager.experimental.types.friendchat")
local OtherUserInfo = LuaNetManager.GetBeanDef("protocol.chat.otheruserinfo")

function DM_FriendsChat:Ctor()
  self._friendsChat = NekoData.Data.friendsChat
  self._friendsRequestLoadLocalChat = {}
  self._hasReceiveSRefreshFriendInfos = false
end

function DM_FriendsChat:Clear()
  for id, chatInfo in pairs(self._friendsChat.localChat) do
    chatInfo:Clear()
    self._friendsChat.localChat[id] = nil
  end
  for id, chatInfo in pairs(self._friendsChat.onlineChat) do
    chatInfo:Clear()
    self._friendsChat.onlineChat[id] = nil
  end
  self._friendsRequestLoadLocalChat = {}
  self._hasReceiveSRefreshFriendInfos = false
end

function DM_FriendsChat:AddFriendsChat(userId, msgbean, bfromMy)
  local chatinfo = self._friendsChat.onlineChat[userId]
  if not chatinfo then
    chatinfo = FriendChat.Create()
    self._friendsChat.onlineChat[userId] = chatinfo
  end
  if msgbean then
    chatinfo:AddChatRecord(msgbean, bfromMy)
  end
  local dialog = DialogManager.GetDialog("friend.friendslistdialog")
  if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
    chatinfo:ResetNotReadNum()
  end
end

function DM_FriendsChat:OnSAllFriendsChat(protocol)
  if self._hasReceiveSRefreshFriendInfos then
    return
  end
  self._hasReceiveSRefreshFriendInfos = true
  for index, info in pairs(protocol.user) do
    if info.identity == OtherUserInfo.FRIEND then
      self:RequestLocalChatInfo(info.baseUserData.userId)
    end
  end
  for index, info in pairs(protocol.user) do
    if info.messages then
      for _, message in pairs(info.messages) do
        self:AddFriendsChat(info.baseUserData.userId, message, false)
      end
    end
  end
  for index, info in pairs(protocol.user) do
    if info.messages then
      local csend = BattleClientProtocolManager.CreateProtocol("friendchat.cstorefriendchatlist")
      csend.userId = info.baseUserData.userId
      for _, message in pairs(info.messages) do
        local msgbean = BattleClientProtocolManager.CreateBean("data.friendchatinfo")
        msgbean.chatid = 0
        msgbean.msg = message.msg
        msgbean.time = message.time
        msgbean.sender = info.baseUserData.userId
        msgbean.mark = 1
        if 0 < #message.hyperlinks then
          local hyperlink = message.hyperlinks[1]
          if hyperlink then
            msgbean.hyperlinks = JSON.encode({
              linkType = hyperlink.linkType,
              linkText = hyperlink.linkText
            })
          end
        end
        msgbean.bubbleID = message.bubbleID
        table.insert(csend.msgs, msgbean)
      end
      LuaSqlProtocalManager:SendProtocolToRemoteThread(csend)
    end
  end
end

function DM_FriendsChat:OnSAddFriendChat(protocol)
  self:AddFriendsChat(protocol.userId, protocol.msg, protocol.spokesman == 0)
  self:StoreMsg(protocol.userId, protocol.msg, protocol.spokesman == 0)
end

function DM_FriendsChat:ResetNotReadNum(userId)
  local chatinfo = self._friendsChat.onlineChat[userId]
  if chatinfo then
    chatinfo:ResetNotReadNum()
  end
  chatinfo = self._friendsChat.localChat[userId]
  if chatinfo then
    chatinfo:ResetNotReadNum()
  end
  self:RequestResetNotReadNum(userId)
end

function DM_FriendsChat:StoreMsg(userId, msgbean, bfromMy)
  local protocol = BattleClientProtocolManager.CreateProtocol("friendchat.cstorefriendchat")
  protocol.userId = userId
  protocol.msg.msg = msgbean.msg
  protocol.msg.time = msgbean.time
  protocol.msg.bubbleID = msgbean.bubbleID
  if #msgbean.hyperlinks > 0 then
    local hyperlink = msgbean.hyperlinks[1]
    if hyperlink then
      protocol.msg.hyperlinks = JSON.encode({
        linkType = hyperlink.linkType,
        linkText = hyperlink.linkText
      })
    end
  end
  if bfromMy then
    protocol.msg.sender = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
    protocol.msg.mark = 0
  else
    protocol.msg.sender = userId
    protocol.msg.mark = 1
    local dialog = DialogManager.GetDialog("friend.friendslistdialog")
    if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
      protocol.msg.mark = 0
    end
  end
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_FriendsChat:RequestLocalChatInfo(userId)
  local protocol = BattleClientProtocolManager.CreateProtocol("friendchat.cgetlocalchatinfo")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_FriendsChat:OnSGetLocalChatInfo(protocol)
  if protocol.clientId ~= DataCommon.SqlClientId then
    return
  end
  local chatinfo = self._friendsChat.localChat[protocol.userId]
  if not chatinfo then
    chatinfo = FriendChat.Create()
    self._friendsChat.localChat[protocol.userId] = chatinfo
  end
  chatinfo:SetLocalChatInfo(protocol.redNum, protocol.totalNum)
  if protocol.redNum > 0 then
    self:CheckLoadMsg(protocol.userId, protocol.redNum)
  else
    self:CheckLoadMsg(protocol.userId)
  end
end

function DM_FriendsChat:CheckLoadMsg(userId, needLoadnum)
  needLoadnum = needLoadnum or DataCommon.PageChatNum
  if self._friendsRequestLoadLocalChat[userId] then
    return
  end
  local chatInfo = self._friendsChat.localChat[userId]
  if not chatInfo then
    return
  end
  local totalMsgNum = chatInfo:GetTotalLoalMsgNum()
  local loadMsgNum = chatInfo:GetCurLoadMsgNum()
  if totalMsgNum <= loadMsgNum then
    return
  end
  if totalMsgNum < loadMsgNum + needLoadnum then
    self:LoadMsg(userId, 1, totalMsgNum - loadMsgNum)
  else
    local beginid = totalMsgNum - loadMsgNum - needLoadnum + 1
    local endid = totalMsgNum - loadMsgNum
    self:LoadMsg(userId, beginid, endid)
  end
end

function DM_FriendsChat:LoadMsg(userId, beginId, endId)
  local protocol = BattleClientProtocolManager.CreateProtocol("friendchat.cgetfriendchat")
  protocol.userId = userId
  protocol.beginId = beginId
  protocol.endId = endId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
  self._friendsRequestLoadLocalChat[userId] = true
end

function DM_FriendsChat:AddLocalChatData(userId, msginfo)
  local chatinfo = self._friendsChat.localChat[userId]
  if not chatinfo then
    chatinfo = FriendChat.Create()
    self._friendsChat.localChat[userId] = chatinfo
  end
  local chatinfo = self._friendsChat.localChat[userId]
  chatinfo:AddLocalChatRecord(msginfo)
end

function DM_FriendsChat:OnSGetFriendChat(protocol)
  if protocol.clientId ~= DataCommon.SqlClientId then
    return
  end
  self._friendsRequestLoadLocalChat[protocol.userId] = nil
  for i = #protocol.msgs, 1, -1 do
    local info = protocol.msgs[i]
    local friendChat = {}
    friendChat.chatid = info.chatid
    friendChat.msg = info.msg
    friendChat.hyperlinks = info.hyperlinks
    friendChat.bubbleID = info.bubbleID
    friendChat.time = info.time
    friendChat.sender = info.sender
    self:AddLocalChatData(protocol.userId, friendChat)
  end
end

function DM_FriendsChat:RequestResetNotReadNum(userId)
  local protocol = BattleClientProtocolManager.CreateProtocol("friendchat.cresetnotreadnum")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_FriendsChat:RemoveFriendLocalChat(userId)
  self._friendsChat.localChat[userId] = nil
  self._friendsChat.onlineChat[userId] = nil
  local protocol = BattleClientProtocolManager.CreateProtocol("friendchat.cremovefriendchattable")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

return DM_FriendsChat
