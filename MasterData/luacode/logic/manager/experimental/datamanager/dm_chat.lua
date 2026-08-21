-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_chat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Chat = class("DM_Chat")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local CChatConfig = (BeanManager.GetTableByName)("chat.cchatconfig")
DM_Chat.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CChatConfig
  self._chatData = (NekoData.Data).chat
  self._chatShowTime = {}
  for channelType = 1, 3 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._chatData)[channelType] = {}
  end
  local cfg = CChatConfig:GetRecorder(1)
  self._maxChatNum = 999
  self._showTimeInter = cfg.period * 60 * 1000
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._chatData)._subChannel = 1
  self._cacheMsgInfo = nil
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._chatData)._guideCommentCache = false
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._chatData)._emojiInfo = {}
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Chat.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for channelType = 1, 3 do
    while #(self._chatData)[channelType] > 0 do
      (table.remove)((self._chatData)[channelType], #(self._chatData)[channelType])
    end
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._chatData)._guideCommentCache = false
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._chatData)._guideCommentType = nil
  while ((self._chatData)._emojiInfo)[#(self._chatData)._emojiInfo] do
    (table.remove)((self._chatData)._emojiInfo, #(self._chatData)._emojiInfo)
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._chatData)._subChannel = nil
  ;
  ((NekoData.BehaviorManager).BM_Chat):StopLuaTest()
end

DM_Chat.SaveChatData = function(self, chatdata)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._chatData)[chatdata.channel] then
    (self._chatData)[chatdata.channel] = {}
  end
  if self._maxChatNum <= #(self._chatData)[chatdata.channel] then
    (table.remove)((self._chatData)[chatdata.channel], 1)
  end
  chatdata.receiveTime = (ServerGameTimer.GetServerTime)()
  chatdata.showTime = false
  if (self._chatShowTime)[chatdata.channel] and self._showTimeInter < chatdata.receiveTime - (self._chatShowTime)[chatdata.channel] then
    chatdata.showTime = true
  else
    if #(self._chatData)[chatdata.channel] > 0 then
      local lastChat = ((self._chatData)[chatdata.channel])[#(self._chatData)[chatdata.channel]]
      if chatdata.receiveTime - lastChat.receiveTime > 60000 then
        chatdata.showTime = true
      end
    else
      do
        if not (self._chatShowTime)[chatdata.channel] then
          chatdata.showTime = true
        end
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R2 in 'UnsetPending'

        if chatdata.showTime then
          (self._chatShowTime)[chatdata.channel] = chatdata.receiveTime
        end
        ;
        (table.insert)((self._chatData)[chatdata.channel], chatdata)
        ;
        ((NekoData.BehaviorManager).BM_Chat):PopChatMsg(chatdata)
        if not self._cacheMsgInfo then
          self._cacheMsgInfo = {}
        end
        -- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

        if not (self._cacheMsgInfo)[chatdata.channel] then
          (self._cacheMsgInfo)[chatdata.channel] = 1
        else
          -- DECOMPILER ERROR at PC110: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (self._cacheMsgInfo)[chatdata.channel] = (self._cacheMsgInfo)[chatdata.channel] + 1
        end
      end
    end
  end
end

DM_Chat.OnSSendChatMsg = function(self, protocol)
  -- function num : 0_3
  local chatinfo = {}
  chatinfo.userid = (protocol.baseUserData).userId
  chatinfo.username = (protocol.baseUserData).userName
  chatinfo.headid = (protocol.baseUserData).avatarId
  chatinfo.frameid = (protocol.baseUserData).frameId
  chatinfo.level = (protocol.baseUserData).userLv
  chatinfo.channel = protocol.channelType
  chatinfo.msg = protocol.msg
  chatinfo.serverid = protocol.serverId
  chatinfo.hyperlinks = protocol.hyperlinks
  self:SaveChatData(chatinfo)
end

DM_Chat.OnSReceiveSystemMsg = function(self, msg)
  -- function num : 0_4 , upvalues : ChannelType
  local chatinfo = {}
  chatinfo.channel = ChannelType.CHANNEL_SYSTEM
  chatinfo.msg = msg
  self:SaveChatData(chatinfo)
end

DM_Chat.OnSChangeSubChannel = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._chatData)._subChannel = protocol.num
end

DM_Chat.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._cacheMsgInfo then
    return 
  end
  for canneltype,msgnum in pairs(self._cacheMsgInfo) do
    local userinfo = {}
    userinfo.channelType = canneltype
    userinfo.msgNum = msgnum
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ChatInfoReceive, nil, userinfo)
  end
  self._cacheMsgInfo = nil
end

DM_Chat.OnSStartComment = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._chatData)._guideCommentCache = true
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._chatData)._guideCommentType = protocol.logType
end

DM_Chat.OnSCompleteComment = function(self)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._chatData)._guideCommentCache = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._chatData)._guideCommentType = nil
end

DM_Chat.OnSendEmojiInfo = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._chatData)._emojiInfo = protocol.hadEmoji
end

DM_Chat.OnAddEmoji = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  if not (table.indexof)((self._chatData)._emojiInfo, protocol.eomjiId) then
    (table.insert)((self._chatData)._emojiInfo, protocol.eomjiId)
  else
    LogErrorFormat("DM_Chat", "Repeat unlock EmojiID:%s", protocol.eomjiId)
  end
end

return DM_Chat

