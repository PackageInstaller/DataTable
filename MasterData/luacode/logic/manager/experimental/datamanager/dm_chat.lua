local DM_Chat = class("DM_Chat")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local CChatConfig = BeanManager.GetTableByName("chat.cchatconfig")

function DM_Chat:Ctor()
  self._chatData = NekoData.Data.chat
  self._chatShowTime = {}
  for channelType = 1, 3 do
    self._chatData[channelType] = {}
  end
  local cfg = CChatConfig:GetRecorder(1)
  self._maxChatNum = 999
  self._showTimeInter = cfg.period * 60 * 1000
  self._chatData._worldchatswitch = true
  self._chatData._subChannel = 1
  self._cacheMsgInfo = nil
  self._chatData._guideCommentCache = false
  self._chatData._emojiInfo = {}
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Chat:Clear()
  for channelType = 1, 3 do
    while #self._chatData[channelType] > 0 do
      table.remove(self._chatData[channelType], #self._chatData[channelType])
    end
  end
  self._chatData._guideCommentCache = false
  self._chatData._guideCommentType = nil
  while self._chatData._emojiInfo[#self._chatData._emojiInfo] do
    table.remove(self._chatData._emojiInfo, #self._chatData._emojiInfo)
  end
  self._chatData._subChannel = 1
  NekoData.BehaviorManager.BM_Chat:StopLuaTest()
end

function DM_Chat:SaveChatData(chatdata)
  if not self._chatData[chatdata.channel] then
    self._chatData[chatdata.channel] = {}
  end
  local isBlock = NekoData.BehaviorManager.BM_Friends:IsBlockWorldMsgList(chatdata.userid)
  if isBlock and chatdata.channel == ChannelType.CHANNEL_WORLD then
    return
  end
  if #self._chatData[chatdata.channel] >= self._maxChatNum then
    table.remove(self._chatData[chatdata.channel], 1)
  end
  chatdata.receiveTime = ServerGameTimer.GetServerTime()
  chatdata.showTime = false
  if self._chatShowTime[chatdata.channel] and chatdata.receiveTime - self._chatShowTime[chatdata.channel] > self._showTimeInter then
    chatdata.showTime = true
  elseif #self._chatData[chatdata.channel] > 0 then
    local lastChat = self._chatData[chatdata.channel][#self._chatData[chatdata.channel]]
    if chatdata.receiveTime - lastChat.receiveTime > 60000 then
      chatdata.showTime = true
    end
  elseif not self._chatShowTime[chatdata.channel] then
    chatdata.showTime = true
  end
  if chatdata.showTime then
    self._chatShowTime[chatdata.channel] = chatdata.receiveTime
  end
  table.insert(self._chatData[chatdata.channel], chatdata)
  NekoData.BehaviorManager.BM_Chat:PopChatMsg(chatdata)
  if not self._cacheMsgInfo then
    self._cacheMsgInfo = {}
  end
  if not self._cacheMsgInfo[chatdata.channel] then
    self._cacheMsgInfo[chatdata.channel] = 1
  else
    self._cacheMsgInfo[chatdata.channel] = self._cacheMsgInfo[chatdata.channel] + 1
  end
end

function DM_Chat:OnSSendChatMsg(protocol)
  local chatinfo = {}
  chatinfo.userid = protocol.baseUserData.userId
  chatinfo.username = protocol.baseUserData.userName
  chatinfo.headid = protocol.baseUserData.avatarId
  chatinfo.frameid = protocol.baseUserData.frameId
  chatinfo.level = protocol.baseUserData.userLv
  chatinfo.showbadges = protocol.baseUserData.showBadges
  chatinfo.spiritvip = protocol.baseUserData.spiritvip
  chatinfo.iplocaladdr = protocol.baseUserData.iplocaladdr
  chatinfo.channel = protocol.channelType
  chatinfo.msg = protocol.msg
  chatinfo.serverid = protocol.serverId
  chatinfo.hyperlinks = protocol.hyperlinks
  chatinfo.bubbleID = protocol.bubbleID
  self:SaveChatData(chatinfo)
end

function DM_Chat:OnSReceiveSystemMsg(msg)
  local chatinfo = {}
  chatinfo.channel = ChannelType.CHANNEL_SYSTEM
  chatinfo.msg = msg
  self:SaveChatData(chatinfo)
end

function DM_Chat:OnSChangeSubChannel(protocol)
  self._chatData._subChannel = protocol.num
end

function DM_Chat:OnUpdate()
  if not self._cacheMsgInfo then
    return
  end
  for canneltype, msgnum in pairs(self._cacheMsgInfo) do
    local userinfo = {}
    userinfo.channelType = canneltype
    userinfo.msgNum = msgnum
    LuaNotificationCenter.PostNotification(Common.n_ChatInfoReceive, nil, userinfo)
  end
  self._cacheMsgInfo = nil
end

function DM_Chat:OnSStartComment(protocol)
  self._chatData._guideCommentCache = true
  self._chatData._guideCommentType = protocol.logType
end

function DM_Chat:OnSCompleteComment()
  self._chatData._guideCommentCache = false
  self._chatData._guideCommentType = nil
end

function DM_Chat:OnSendEmojiInfo(protocol)
  self._chatData._emojiInfo = protocol.hadEmoji
end

function DM_Chat:OnAddEmoji(protocol)
  if not table.indexof(self._chatData._emojiInfo, protocol.eomjiId) then
    table.insert(self._chatData._emojiInfo, protocol.eomjiId)
  else
    LogErrorFormat("DM_Chat", "Repeat unlock EmojiID:%s", protocol.eomjiId)
  end
end

function DM_Chat:OnWorldChatSwitch(protocol)
  if protocol.state == 1 then
    self._chatData._worldchatswitch = true
  else
    self._chatData._worldchatswitch = false
    self:ClearChatMsg()
  end
  local userinfo = {}
  userinfo.state = self._chatData._worldchatswitch
  LuaNotificationCenter.PostNotification(Common.n_ChatStateSwitch, nil, userinfo)
end

function DM_Chat:ClearChatMsg()
  for channelType = 1, 3 do
    self._chatData[channelType] = {}
  end
end

return DM_Chat
