-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_friendschat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_FriendsChat = class("DM_FriendsChat")
local FriendChat = require("logic.manager.experimental.types.friendchat")
local OtherUserInfo = (LuaNetManager.GetBeanDef)("protocol.chat.otheruserinfo")
DM_FriendsChat.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._friendsChat = (NekoData.Data).friendsChat
  self._friendsRequestLoadLocalChat = {}
  self._hasReceiveSRefreshFriendInfos = false
end

DM_FriendsChat.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for id,chatInfo in pairs((self._friendsChat).localChat) do
    chatInfo:Clear()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._friendsChat).localChat)[id] = nil
  end
  for id,chatInfo in pairs((self._friendsChat).onlineChat) do
    chatInfo:Clear()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._friendsChat).onlineChat)[id] = nil
  end
  self._friendsRequestLoadLocalChat = {}
  self._hasReceiveSRefreshFriendInfos = false
end

DM_FriendsChat.AddFriendsChat = function(self, userId, msgbean, bfromMy)
  -- function num : 0_2 , upvalues : FriendChat, _ENV
  local chatinfo = ((self._friendsChat).onlineChat)[userId]
  if not chatinfo then
    chatinfo = (FriendChat.Create)()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._friendsChat).onlineChat)[userId] = chatinfo
  end
  if msgbean then
    chatinfo:AddChatRecord(msgbean, bfromMy)
  end
  local dialog = (DialogManager.GetDialog)("friend.friendslistdialog")
  if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
    chatinfo:ResetNotReadNum()
  end
end

DM_FriendsChat.OnSAllFriendsChat = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, OtherUserInfo
  if self._hasReceiveSRefreshFriendInfos then
    return 
  end
  self._hasReceiveSRefreshFriendInfos = true
  for index,info in pairs(protocol.user) do
    if info.identity == OtherUserInfo.FRIEND then
      self:RequestLocalChatInfo((info.baseUserData).userId)
    end
  end
  for index,info in pairs(protocol.user) do
    if info.messages then
      for _,message in pairs(info.messages) do
        self:AddFriendsChat((info.baseUserData).userId, message, false)
      end
    end
  end
  for index,info in pairs(protocol.user) do
    if info.messages then
      local csend = (BattleClientProtocolManager.CreateProtocol)("friendchat.cstorefriendchatlist")
      csend.userId = (info.baseUserData).userId
      for _,message in pairs(info.messages) do
        local msgbean = (BattleClientProtocolManager.CreateBean)("data.friendchatinfo")
        msgbean.chatid = 0
        msgbean.msg = message.msg
        msgbean.time = message.time
        msgbean.sender = (info.baseUserData).userId
        msgbean.mark = 1
        do
          do
            if #message.hyperlinks > 0 then
              local hyperlink = (message.hyperlinks)[1]
              if hyperlink then
                msgbean.hyperlinks = (JSON.encode)({linkType = hyperlink.linkType, linkText = hyperlink.linkText})
              end
            end
            ;
            (table.insert)(csend.msgs, msgbean)
            -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      LuaSqlProtocalManager:SendProtocolToRemoteThread(csend)
    end
  end
end

DM_FriendsChat.OnSAddFriendChat = function(self, protocol)
  -- function num : 0_4
  self:AddFriendsChat(protocol.userId, protocol.msg, protocol.spokesman == 0)
  self:StoreMsg(protocol.userId, protocol.msg, protocol.spokesman == 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DM_FriendsChat.ResetNotReadNum = function(self, userId)
  -- function num : 0_5
  local chatinfo = ((self._friendsChat).onlineChat)[userId]
  if chatinfo then
    chatinfo:ResetNotReadNum()
  end
  chatinfo = ((self._friendsChat).localChat)[userId]
  if chatinfo then
    chatinfo:ResetNotReadNum()
  end
  self:RequestResetNotReadNum(userId)
end

DM_FriendsChat.StoreMsg = function(self, userId, msgbean, bfromMy)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("friendchat.cstorefriendchat")
  protocol.userId = userId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (protocol.msg).msg = msgbean.msg
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (protocol.msg).time = msgbean.time
  do
    if #msgbean.hyperlinks > 0 then
      local hyperlink = (msgbean.hyperlinks)[1]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

      if hyperlink then
        (protocol.msg).hyperlinks = (JSON.encode)({linkType = hyperlink.linkType, linkText = hyperlink.linkText})
      end
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

    if bfromMy then
      (protocol.msg).sender = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (protocol.msg).mark = 0
    else
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (protocol.msg).sender = userId
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (protocol.msg).mark = 1
      local dialog = (DialogManager.GetDialog)("friend.friendslistdialog")
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == userId then
        (protocol.msg).mark = 0
      end
    end
    do
      LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
    end
  end
end

DM_FriendsChat.RequestLocalChatInfo = function(self, userId)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("friendchat.cgetlocalchatinfo")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

DM_FriendsChat.OnSGetLocalChatInfo = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, FriendChat
  if protocol.clientId ~= DataCommon.SqlClientId then
    return 
  end
  local chatinfo = ((self._friendsChat).localChat)[protocol.userId]
  if not chatinfo then
    chatinfo = (FriendChat.Create)()
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._friendsChat).localChat)[protocol.userId] = chatinfo
  end
  chatinfo:SetLocalChatInfo(protocol.redNum, protocol.totalNum)
  if protocol.redNum > 0 then
    self:CheckLoadMsg(protocol.userId, protocol.redNum)
  else
    self:CheckLoadMsg(protocol.userId)
  end
end

DM_FriendsChat.CheckLoadMsg = function(self, userId, needLoadnum)
  -- function num : 0_9 , upvalues : _ENV
  if not needLoadnum then
    needLoadnum = DataCommon.PageChatNum
  end
  if (self._friendsRequestLoadLocalChat)[userId] then
    return 
  end
  local chatInfo = ((self._friendsChat).localChat)[userId]
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

DM_FriendsChat.LoadMsg = function(self, userId, beginId, endId)
  -- function num : 0_10 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("friendchat.cgetfriendchat")
  protocol.userId = userId
  protocol.beginId = beginId
  protocol.endId = endId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._friendsRequestLoadLocalChat)[userId] = true
end

DM_FriendsChat.AddLocalChatData = function(self, userId, msginfo)
  -- function num : 0_11 , upvalues : FriendChat
  local chatinfo = ((self._friendsChat).localChat)[userId]
  if not chatinfo then
    chatinfo = (FriendChat.Create)()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._friendsChat).localChat)[userId] = chatinfo
  end
  local chatinfo = ((self._friendsChat).localChat)[userId]
  chatinfo:AddLocalChatRecord(msginfo)
end

DM_FriendsChat.OnSGetFriendChat = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV
  if protocol.clientId ~= DataCommon.SqlClientId then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._friendsRequestLoadLocalChat)[protocol.userId] = nil
  for i = #protocol.msgs, 1, -1 do
    local info = (protocol.msgs)[i]
    local friendChat = {}
    friendChat.chatid = info.chatid
    friendChat.msg = info.msg
    friendChat.hyperlinks = info.hyperlinks
    friendChat.time = info.time
    friendChat.sender = info.sender
    self:AddLocalChatData(protocol.userId, friendChat)
  end
end

DM_FriendsChat.RequestResetNotReadNum = function(self, userId)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("friendchat.cresetnotreadnum")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

DM_FriendsChat.RemoveFriendLocalChat = function(self, userId)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._friendsChat).localChat)[userId] = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._friendsChat).onlineChat)[userId] = nil
  local protocol = (BattleClientProtocolManager.CreateProtocol)("friendchat.cremovefriendchattable")
  protocol.userId = userId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

return DM_FriendsChat

