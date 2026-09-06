local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CChatConfig = BeanManager.GetTableByName("chat.cchatconfig")
local CChatFrameConfig = BeanManager.GetTableByName("headphoto.cchatframeconfig")
local ChatMainDialog = class("ChatMainDialog", Dialog)
ChatMainDialog.AssetBundleName = "ui/layouts.chat"
ChatMainDialog.AssetName = "ChatNewMain"
local MulTextNewLine = 2
local BottomToTop = 2
local InputMaxHeight = 5

function ChatMainDialog:Ctor(...)
  ChatMainDialog.super.Ctor(self, ...)
  self._groupName = "Chat"
  self._cellinfo = nil
  self._openChat = false
  self._needUpdate = false
  self._curProportion = 0
  self._chatData = {}
  self._selfinfo = {}
  self._curChannel = 0
  local myRoleTable = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  for key, info in pairs(myRoleTable) do
    self._selfinfo[key] = info
  end
  self._chatCfg = CChatConfig:GetRecorder(1)
  self._maxWordCount = self._chatCfg.charactermax
  self._worldChannelPeriod = self._chatCfg.period
  self._worldChannelSendTime = nil
  self._channelMax = math.min(self._chatCfg.channelmax, 50)
end

function ChatMainDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._worldMsgFrame = self:GetChild("Back/MessageAreaWorld")
  self._chatMsgFrame = self:GetChild("Back/MessageArea")
  self._downBoard = self:GetChild("Back/Down")
  self._sendBtn = self:GetChild("Back/Down/SendBtn")
  self._inputField = self:GetChild("Back/Down/InputField")
  self._inputField:SetGenerateOutOfBounds(true)
  self._inputField:SetLineType(MulTextNewLine)
  self._arrowBtn = self:GetChild("Back/ArrowBtn")
  self._new = self:GetChild("Back/RecordsUpBtn")
  self._txtNewMsgNum = self:GetChild("Back/RecordsUpBtn/TextUp")
  self._txtNotChat = self:GetChild("Back/Down/Text")
  self._emojiBtn = self:GetChild("Back/Down/EmojiBtn")
  self._emojiArea = self:GetChild("Back/Down/EmojiArea")
  self._emojiPanel = self:GetChild("Back/Down/EmojiArea/Frame")
  self._emojiScrollbar = self:GetChild("Back/Down/EmojiArea/Scrollbar")
  self._rightBtn = self:GetChild("Back/Down/EmojiArea/emoji_mark/NextBtn")
  self._panel = self:GetChild("Back/Down/EmojiArea/emoji_mark/Frame")
  self._leftBtn = self:GetChild("Back/Down/EmojiArea/emoji_mark/BackBtn")
  self._borderBtn = self:GetChild("Back/Down/ChangeBtn")
  self._borderArea = self:GetChild("Back/Down/ChatFrameArea")
  self._borderPanel = self:GetChild("Back/Down/ChatFrameArea/Frame")
  self._borderScrollbar = self:GetChild("Back/Down/ChatFrameArea/Scrollbar")
  self._borderScrollbar:SetActive(false)
  self._borderArea:SetActive(false)
  self._borderCancelBtn = self:GetChild("Back/Down/ChatFrameArea/CancelBtn")
  self._borderCancelBtn:SetActive(false)
  self._borderConfirmBtn = self:GetChild("Back/Down/ChatFrameArea/ConfirmBtn")
  self._borderConfirmBtn:SetActive(false)
  self._confirmBtnText = self:GetChild("Back/Down/ChatFrameArea/ConfirmBtn/_Text")
  self._confirmBtnText:SetText("")
  self._borderBtn:Subscribe_PointerClickEvent(self.OnBorderBtnClicked, self)
  self._borderCancelBtn:Subscribe_PointerClickEvent(self.OnBorderCancelBtnClicked, self)
  self._borderConfirmBtn:Subscribe_PointerClickEvent(self.OnBorderConfirmBtnClicked, self)
  self._curSelectBorderId = 0
  self._tabBtnFrame = TableFrame.Create(self._panel, self, false, false, false)
  self._groupBtnInfo = {}
  for i = 1, 3 do
    self._groupBtnInfo[i] = {}
    if 1 < i then
      self._groupBtnInfo[i].redicon = self:GetChild("Back/GroupArea/GroupBtn" .. i .. "/RedDot")
    end
    self._groupBtnInfo[i].btn = self:GetChild("Back/GroupArea/GroupBtn" .. i)
    self._groupBtnInfo[i].btn:Subscribe_PointerClickEvent(function()
      self:OnSelectChannel(i)
    end)
    if self._groupBtnInfo[i].redicon then
      self._groupBtnInfo[i].redicon:SetActive(false)
    end
  end
  self._frame = TableFrame.Create(self._chatMsgFrame, self, true, true, true)
  self._worldFrame = TableFrame.Create(self._worldMsgFrame, self, true, true, true)
  self._frame:SetMargin(40, 0)
  self._worldFrame:SetMargin(40, 0)
  self:InitPosInfo()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnChatDialogHideStateExit, self)
  self._sendBtn:Subscribe_PointerClickEvent(self.OnSendBtnClick, self)
  self._arrowBtn:Subscribe_PointerClickEvent(self.OnArrowBtnClick, self)
  self._new:Subscribe_PointerClickEvent(self.OnNewMessage, self)
  self._inputField:Subscribe_ValueChangedEvent(self.OnInputFieldValueChanged, self)
  self._emojiBtn:Subscribe_PointerClickEvent(self.OnEmojiBtnClicked, self)
  self:OnSelectChannel(ChannelType.CHANNEL_WORLD)
  LuaNotificationCenter.AddObserver(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNewMsgCome, Common.n_ChatInfoReceive, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChatStateSwitch, Common.n_ChatStateSwitch, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChatBlockWorldMsg, Common.n_ChatBlockWorldMsg, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.SetSubChannelInfo, Common.n_SubChannelChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnModalDialogOpen, Common.n_ModalDialogOpen, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAllModalDialogClose, Common.n_AllModalDialogClose, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function ChatMainDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._borderArea._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    if self._borderFrame then
      self._borderFrame:Destroy()
      self._borderFrame = nil
      self._borderArea:SetActive(false)
      self._openChat = true
    end
    if self._emojiFrame then
      self._emojiFrame:Destroy()
      self._emojiFrame = nil
      self._emojiArea:SetActive(false)
      self._openChat = true
    end
  end
end

function ChatMainDialog:SelectChannel(channel)
  self:OnSelectChannel(channel)
end

function ChatMainDialog:InitPosInfo()
  local _ = 0
  self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, self._inputFieldSOY = self._inputField:GetSize()
  self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY = self._chatMsgFrame:GetSize()
  self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY = self._chatMsgFrame:GetPosition()
  _, _, _, self._changeChatMsgFrameSOY = self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY
  _, _, _, self._changeChatMsgFramePOY = self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY
  _, self._inputFieldPreY = self._inputField:GetPreferredSize()
end

function ChatMainDialog:OnDestroy()
  self._frame:Destroy()
  self._worldFrame:Destroy()
  self._tabBtnFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChatMainDialog:Toggle()
  if self._openChat then
    self._openChat = false
    self:GetRootWindow():PlayAnimation("ChatDialogHide")
  else
    self:GetRootWindow():PlayAnimation("ChatDialogShow")
    self._openChat = true
  end
end

function ChatMainDialog:OnSelectChannel(index)
  if self._curChannel == index then
    return
  end
  if self._groupBtnInfo[self._curChannel] then
    self._groupBtnInfo[self._curChannel].btn:SetSelected(false)
  end
  self._curChannel = index
  self._groupBtnInfo[self._curChannel].btn:SetSelected(true)
  if self._groupBtnInfo[self._curChannel].redicon then
    self._groupBtnInfo[self._curChannel].redicon:SetActive(false)
  end
  self._txtNotChat:SetActive(self._curChannel == ChannelType.CHANNEL_SYSTEM)
  self._inputField:SetActive(self._curChannel ~= ChannelType.CHANNEL_SYSTEM)
  self._sendBtn:SetActive(self._curChannel ~= ChannelType.CHANNEL_SYSTEM)
  self._chatMsgFrame:SetActive(self._curChannel ~= ChannelType.CHANNEL_WORLD)
  self._worldMsgFrame:SetActive(self._curChannel == ChannelType.CHANNEL_WORLD)
  self:RefreshChatInfo()
end

function ChatMainDialog:RefreshChatInfo()
  self._chatData = {}
  local chatTable = NekoData.BehaviorManager.BM_Chat:GetChannelChatData(self._curChannel)
  for i = 1, #chatTable do
    self._chatData[i] = chatTable[i]
  end
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldFrame:ReloadAllCell()
    self:SetSubChannelInfo()
  else
    self._frame:ReloadAllCell()
  end
  self._newMsgNum = 0
  self:RefreshNewMsgNumInfo()
end

function ChatMainDialog:SetSubChannelInfo()
  LogInfoFormat("SetSubChannelInfo ", " SubChannel:%s ", NekoData.BehaviorManager.BM_Chat:GetSubChannel())
end

function ChatMainDialog:MoveToBottom(isAnimate)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldFrame:MoveToBottom(isAnimate)
  else
    self._frame:MoveToBottom(isAnimate)
  end
end

function ChatMainDialog:GetTotalLength()
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    return self._worldFrame:GetTotalLength()
  end
  return self._frame:GetTotalLength()
end

function ChatMainDialog:ReloadCellsAtIndex(index, isAnimate)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldFrame:ReloadCellsAtIndex(index, isAnimate)
  else
    self._frame:ReloadCellsAtIndex(index, isAnimate)
  end
end

function ChatMainDialog:RemoveCellsAtIndex(index, isAnimate)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldFrame:RemoveCellsAtIndex(index, isAnimate)
  else
    self._frame:RemoveCellsAtIndex(index, isAnimate)
  end
end

function ChatMainDialog:InsertCellsAtIndex(index, isAnimate)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldFrame:InsertCellsAtIndex(index, isAnimate)
  else
    self._frame:InsertCellsAtIndex(index, isAnimate)
  end
end

function ChatMainDialog:NumberOfCell(frame)
  if frame == self._worldFrame then
    return #self._chatData
  elseif frame == self._tabBtnFrame then
    return #self._tabBtnData
  elseif frame == self._emojiFrame then
    return #self._emojiData
  elseif frame == self._borderFrame then
    return #self._borderDataList
  end
end

function ChatMainDialog:CellAtIndex(frame, index)
  if frame == self._worldFrame then
    local ids = self._chatData
    if self._curChannel == ChannelType.CHANNEL_SYSTEM then
      if ids[index].showTime then
        return "chat.systeminfotimecell"
      else
        return "chat.systeminfocell"
      end
    end
    if self._selfinfo.userid ~= ids[index].userid then
      if ids[index].showTime then
        return "chat.chatinfotimecell"
      else
        return "chat.chatinfocell"
      end
    elseif self._selfinfo.userid == ids[index].userid then
      if ids[index].showTime then
        return "chat.chatselftimecell"
      else
        return "chat.chatselfcell"
      end
    end
  elseif frame == self._emojiFrame then
    return "chat.chatemojicell"
  elseif frame == self._tabBtnFrame then
    return "guild.emojibtncell"
  elseif frame == self._borderFrame then
    return "chat.chatbordercell"
  end
end

function ChatMainDialog:DataAtIndex(frame, index)
  if frame == self._worldFrame then
    local ids = self._chatData
    self._data = ids[index]
    return self._data
  elseif frame == self._emojiFrame then
    return self._emojiData[index]
  elseif frame == self._tabBtnFrame then
    return self._tabBtnData[index]
  elseif frame == self._borderFrame then
    return self._borderDataList[index]
  end
end

function ChatMainDialog:OnNewMsgCome(notification)
  if not notification then
    return
  end
  if notification.userInfo and notification.userInfo.channelType ~= self._curChannel then
    if self._groupBtnInfo[notification.userInfo.channelType].redicon then
      self._groupBtnInfo[notification.userInfo.channelType].redicon:SetActive(true)
    end
    return
  end
  local comeNum = notification.userInfo.msgNum
  comeNum = comeNum or 1
  local nowmsg = #self._chatData
  if 999 <= nowmsg + comeNum then
    local index = {}
    for i = 1, nowmsg + comeNum - 999 do
      table.remove(self._chatData, 1)
      table.insert(index, i)
    end
    self:RemoveCellsAtIndex(index)
    nowmsg = #self._chatData
  end
  local chatTable = NekoData.BehaviorManager.BM_Chat:GetChannelChatData(self._curChannel)
  for i = nowmsg + 1, #chatTable do
    table.insert(self._chatData, chatTable[i])
  end
  self:InsertCellsAtIndex({}, true)
  if notification.userInfo.channelType == ChannelType.CHANNEL_SYSTEM then
    if self._curProportion ~= 0 then
      self._newMsgNum = self._newMsgNum + 1
    else
      self:MoveToBottom()
      self._newMsgNum = 0
    end
  elseif self._selfinfo.userid ~= self._chatData[#self._chatData].userid then
    if self._curProportion ~= 0 then
      self._newMsgNum = self._newMsgNum + 1
    else
      self:MoveToBottom()
      self._newMsgNum = 0
    end
  else
    self:MoveToBottom()
    self._newMsgNum = 0
  end
  self:RefreshNewMsgNumInfo()
end

function ChatMainDialog:OnChatStateSwitch()
  self:RefreshChatInfo()
end

function ChatMainDialog:OnChatBlockWorldMsg()
  self:RefreshChatInfo()
end

function ChatMainDialog:RefreshNewMsgNumInfo()
  self._new:SetActive(self._newMsgNum > 0)
  self._txtNewMsgNum:SetActive(self._newMsgNum > 0)
  local str = CstringCfg:GetRecorder(1035).msgTextID
  str = TextManager.GetText(str)
  self._txtNewMsgNum:SetText(string.gsub(str, "%$parameter1%$", self._newMsgNum))
end

function ChatMainDialog:OnCurPosChange(frame, proportion)
  if frame == self._worldFrame then
    self._curProportion = proportion
  elseif frame == self._emojiFrame then
    local width, height = self._emojiPanel:GetRectSize()
    local total = self._emojiFrame:GetTotalLength()
    if height < total then
      self._emojiScrollbar:SetActive(true)
      self._emojiScrollbar:SetScrollSize(height / total)
      self._emojiScrollbar:SetScrollValue(proportion)
    else
      self._emojiScrollbar:SetActive(false)
    end
  end
end

function ChatMainDialog:CopyCellInfo(x, y, flag, str)
  local _, _, _, copyY = self._copyBgd:GetSize()
  local _, rootX, _, rootY = self:GetRootWindow():GetSize()
  local _, _, _, downY = self._downBoard:GetSize()
  local width, height = self._chatMsgFrame:GetRectSize()
  local total = self:GetTotalLength()
  if height < total then
    self._copyBgd:SetPosition(0, rootX / 2, 0, downY + (y - self._curProportion * (total - height)))
  else
    self._copyBgd:SetPosition(0, rootX / 2, 0, downY + height - total + y)
  end
  self._copyBgd:SetActive(flag)
  self._cellinfo = str
end

function ChatMainDialog:SetColorInCell(talk, color)
  self._celltalk = talk
  self._celltalkColor = color
  self._celltalk:SetColor("gray")
end

function ChatMainDialog:SetColor(color)
  if self._celltalk then
    self._celltalk:SetColor(color)
    self._celltalk = nil
  end
end

function ChatMainDialog:OnLateUpdate(notification)
  if self._needUpdate then
    if self._inputFieldTask then
      if self._inputFieldTask:update(notification.userInfo.deltaTime) then
        self._inputField:SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, self._inputFieldDes)
        self._inputFieldTask = nil
      else
        self._inputField:SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, self._inputFieldTask.subject.pos)
      end
    end
    if self._chatMsgFrameTask then
      if self._chatMsgFrameTask:update(notification.userInfo.deltaTime) then
        self._chatMsgFrame:SetSize(self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY - self._chatMsgFrameDes)
        self._chatMsgFrame:SetPosition(self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY + self._chatMsgFrameDes)
        self._chatMsgFrameTask = nil
      else
        self._chatMsgFrame:SetSize(self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY - self._chatMsgFrameTask.subject.pos)
        self._chatMsgFrame:SetPosition(self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY + self._chatMsgFrameTask.subject.pos)
      end
    end
    if not self._inputFieldTask and not self._chatMsgFrameTask then
      self._needUpdate = false
    end
  end
end

function ChatMainDialog:OnEmojiBtnClicked()
  if self._emojiFrame then
    self._emojiFrame:Destroy()
    self._emojiFrame = nil
  else
    self._tabBtnData = NekoData.BehaviorManager.BM_Chat:GetShowEmojiTypes()
    self._tabBtnFrame:ReloadAllCell()
    self._tabBtnFrame:MoveToLeft()
    if not self._emojiType then
      self:OnEmojiTypeBtnClicked(1)
    else
      self._emojiData = NekoData.BehaviorManager.BM_Chat:GetEmojisByType(self._emojiType)
      self._emojiFrame = GridFrame.Create(self._emojiPanel, self, true, 6)
      self._emojiFrame:ReloadAllCell()
      self._emojiFrame:MoveToTop()
    end
  end
  self._emojiArea:SetActive(self._emojiFrame)
end

function ChatMainDialog:OnEmojiTypeBtnClicked(_type)
  if self._emojiType == _type then
    return
  else
    self._emojiType = _type
    if self._emojiFrame then
      self._emojiFrame:Destroy()
      self._emojiFrame = nil
    end
    self._emojiData = NekoData.BehaviorManager.BM_Chat:GetEmojisByType(self._emojiType)
    self._tabBtnFrame:FireEvent("ChangedSelected", _type)
    self._emojiFrame = GridFrame.Create(self._emojiPanel, self, true, 6)
    self._emojiFrame:ReloadAllCell()
    self._emojiFrame:MoveToTop()
  end
end

function ChatMainDialog:OnDialogClicked(args)
  if self._emojiFrame and not CS.PixelNeko.UI.UIManager.RectangleContainsScreenPoint(self._emojiArea._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not CS.PixelNeko.UI.UIManager.RectangleContainsScreenPoint(self._emojiBtn._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:HideEmojiFrame()
  end
end

function ChatMainDialog:HideEmojiFrame()
  self._emojiFrame:Destroy()
  self._emojiFrame = nil
  self._emojiArea:SetActive(false)
end

function ChatMainDialog:OnChatDialogHideStateExit(arg1, arg2)
  if not self._openChat and arg2 == "chatdialoghide" then
    if self._borderFrame then
      self._borderFrame:Destroy()
      self._borderFrame = nil
      self._borderArea:SetActive(false)
      self._openChat = true
    elseif self._emojiFrame then
      self._emojiFrame:Destroy()
      self._emojiFrame = nil
      self._emojiArea:SetActive(false)
      self._openChat = true
    else
      self:Destroy()
    end
  end
end

function ChatMainDialog:OnSendBtnClick(args)
  if self._curChannel == ChannelType.CHANNEL_SYSTEM then
    return
  end
  local msg = self._inputField:GetText()
  if self:IsLocalGMmsg(msg) then
    self._inputField:SetText("")
    return
  end
  local wordCount = utf8.len(msg)
  if wordCount > self._maxWordCount then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100041, {
      self._maxWordCount
    })
    return
  end
  if wordCount == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100059)
    return
  end
  local state = NekoData.BehaviorManager.BM_Chat:GetWorldChatSwitch()
  if state == false then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100215)
    return
  end
  if self._curChannel == ChannelType.CHANNEL_WORLD and self._worldChannelSendTime then
    local delta = ServerGameTimer.GetServerTimeForecast() - self._worldChannelSendTime
    if delta < self._worldChannelPeriod * 1000 then
      local lefttime = self._worldChannelSendTime + self._worldChannelPeriod * 1000 - ServerGameTimer.GetServerTimeForecast()
      NekoData.BehaviorManager.BM_Message:SendMessageById(100061, {
        math.ceil(lefttime / 1000)
      })
      return
    end
  end
  NekoData.BehaviorManager.BM_Chat:SendMsg(msg, nil, self._curChannel)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldChannelSendTime = ServerGameTimer.GetServerTimeForecast()
  end
  self._inputField:SetText("")
end

function ChatMainDialog:OnSendEmojiMsg(emoji)
  if self._curChannel == ChannelType.CHANNEL_SYSTEM then
    return
  end
  local state = NekoData.BehaviorManager.BM_Chat:GetWorldChatSwitch()
  if state == false then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100215)
    return
  end
  if self._curChannel == ChannelType.CHANNEL_WORLD and self._worldChannelSendTime then
    local delta = ServerGameTimer.GetServerTimeForecast() - self._worldChannelSendTime
    if delta < self._worldChannelPeriod * 1000 then
      local lefttime = self._worldChannelSendTime + self._worldChannelPeriod * 1000 - ServerGameTimer.GetServerTimeForecast()
      NekoData.BehaviorManager.BM_Message:SendMessageById(100061, {
        math.ceil(lefttime / 1000)
      })
      return
    end
  end
  NekoData.BehaviorManager.BM_Chat:SendMsg("", emoji, self._curChannel)
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    self._worldChannelSendTime = ServerGameTimer.GetServerTimeForecast()
  end
  self._inputField:SetText("")
end

function ChatMainDialog:OnArrowBtnClick(args)
  if self._borderFrame then
    self._borderFrame:Destroy()
    self._borderFrame = nil
    self._borderArea:SetActive(false)
    self._openChat = true
  elseif self._emojiFrame then
    self._emojiFrame:Destroy()
    self._emojiFrame = nil
    self._emojiArea:SetActive(false)
    self._openChat = true
  else
    self._openChat = false
    self:GetRootWindow():PlayAnimation("ChatDialogHide")
  end
end

function ChatMainDialog:OnBackBtnClicked()
  self:OnArrowBtnClick()
end

function ChatMainDialog:OnNewMessage(args)
  self:MoveToBottom(true)
  self._newMsgNum = 0
  self:RefreshNewMsgNumInfo()
end

function ChatMainDialog:OnCopyBtnClick(args)
end

function ChatMainDialog:OnInputFieldValueChanged()
  local preheight = self._prefheight
  local _ = 0
  _, self._prefheight = self._inputField:GetPreferredSize()
  if preheight then
    local predelta = preheight - self._inputFieldPreY
    local curdelta = self._prefheight - self._inputFieldPreY
    if curdelta < self._inputFieldPreY * InputMaxHeight and preheight ~= self._prefheight then
      if predelta > self._inputFieldPreY * InputMaxHeight then
        predelta = self._inputFieldPreY * InputMaxHeight
      end
      self._inputFieldDes = self._inputFieldSOY + curdelta
      local first = {
        pos = self._inputFieldSOY + predelta
      }
      local last = {
        pos = self._inputFieldDes
      }
      self._inputFieldTask = Tween.new(0.1, first, last, "linear")
      self._needUpdate = true
    end
  end
end

function ChatMainDialog:OnEveryWhereClick(args)
end

function ChatMainDialog:ShouldLengthChange(frame)
  return true
end

function ChatMainDialog:IsLocalGMmsg(msg)
  local str = string.sub(msg, 1, 2)
  if str == "//" then
    local lastStr = string.sub(msg, 3) or ""
    if lastStr == "testchat" then
      NekoData.BehaviorManager.BM_FriendsChat:RandomChatFriend(200)
      return true
    end
    if lastStr ~= "" then
      local posS, posE = string.find(lastStr, "chat")
      local posBS, posBE = string.find(lastStr, " ")
      if posS and posE and posBS and posBE then
        local strtemp = string.sub(lastStr, posBE + 1)
        local pos1, pos2 = string.find(strtemp, " ")
        if pos1 and pos2 then
          local strUserId = string.sub(strtemp, 1, pos1)
          local strNum = string.sub(strtemp, pos2)
          NekoData.BehaviorManager.BM_FriendsChat:TestChatWithFriend(tonumber(strUserId), tonumber(strNum))
          return true
        end
      end
    end
  end
  return false
end

function ChatMainDialog:OnModalDialogOpen()
  self:GetRootWindow():SetActive(false)
end

function ChatMainDialog:OnAllModalDialogClose()
  self:GetRootWindow():SetActive(true)
end

function ChatMainDialog:OnBorderBtnClicked()
  if self._borderFrame then
    self._borderFrame:Destroy()
    self._borderFrame = nil
    self._borderArea:SetActive(false)
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.chat.cchatbubblegetinfo")
    protocol:Send()
  end
end

function ChatMainDialog:ShowBorderWindow(BorderData)
  self.BorderData = BorderData
  if not self._borderFrame then
    self._borderDataList = {}
    local allIDs = CChatFrameConfig:GetAllIds()
    for i, v in ipairs(allIDs) do
      local borderData = {}
      local record = CChatFrameConfig:GetRecorder(v)
      borderData.record = record
      borderData.isOwned = self:IsBorderUnlock(record.id)
      borderData.isCurrent = self:IsBorderCurrent(record.id)
      if borderData.isOwned == 1 then
        table.insert(self._borderDataList, borderData)
      elseif record.unlockvisibleornot == 1 then
        table.insert(self._borderDataList, borderData)
      end
    end
    table.sort(self._borderDataList, function(a, b)
      if a.isCurrent == b.isCurrent then
        if a.isOwned == b.isOwned then
          return a.record.order < b.record.order
        end
        return a.isOwned > b.isOwned
      end
      return a.isCurrent > b.isCurrent
    end)
    self._borderFrame = GridFrame.Create(self._borderPanel, self, true, 4)
    self._borderFrame:ReloadAllCell()
    self._borderFrame:MoveToTop()
    self._borderArea:SetActive(true)
    if self.BorderData.curBubble >= 0 then
      self:OnSelectBorder(self.BorderData.curBubble)
    else
      self._borderCancelBtn:SetActive(false)
      self._borderConfirmBtn:SetActive(false)
    end
  end
end

function ChatMainDialog:OnBorderCancelBtnClicked()
  if self._curSelectBorderId >= 0 and self:IsBorderUnlock(self._curSelectBorderId) == 1 then
    if self._curSelectBorderId == self.BorderData.curBubble then
      if self._borderFrame then
        self._borderFrame:Destroy()
        self._borderFrame = nil
        self._borderArea:SetActive(false)
      end
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100533)
    end
  end
end

function ChatMainDialog:OnBorderConfirmBtnClicked()
  if self._curSelectBorderId >= 0 then
    if self:IsBorderUnlock(self._curSelectBorderId) == 1 then
      if self._curSelectBorderId == self.BorderData.curBubble then
        if self._borderFrame then
          self._borderFrame:Destroy()
          self._borderFrame = nil
          self._borderArea:SetActive(false)
        end
      else
        local protocol = LuaNetManager.CreateProtocol("protocol.chat.cchatbubblesetbubble")
        protocol.bubbleID = self._curSelectBorderId
        protocol:Send()
      end
    else
      self:CheckAndJumpShopID()
    end
  end
end

function ChatMainDialog:CheckAndJumpShopID()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID("63+65")
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

function ChatMainDialog:OnSelectBorder(borderId)
  self._curSelectBorderId = borderId
  self._borderFrame:FireEvent("ChooseBorder", borderId)
  if self:IsBorderUnlock(borderId) == 1 then
    self._confirmBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2284))
    self._borderCancelBtn:SetActive(true)
  else
    self._borderCancelBtn:SetActive(false)
    self._confirmBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2285))
  end
  self._borderConfirmBtn:SetActive(true)
end

function ChatMainDialog:UpdateCurBorder(serverData)
  if not self.BorderData then
    return
  end
  self.BorderData.curBubble = serverData.curBubble
  if self.BorderData.curBubble >= 0 then
    self:OnSelectBorder(self.BorderData.curBubble)
  else
    self._borderCancelBtn:SetActive(false)
    self._borderConfirmBtn:SetActive(false)
  end
  if self._borderFrame then
    self._borderFrame:Destroy()
    self._borderFrame = nil
    self._borderArea:SetActive(false)
  end
end

function ChatMainDialog:IsBorderUnlock(borderId)
  local record = CChatFrameConfig:GetRecorder(borderId)
  if record and record.id == 0 then
    return 1
  end
  if not self.BorderData then
    return 0
  end
  for k, v in pairs(self.BorderData.had) do
    if v == borderId then
      return 1
    end
  end
  return 0
end

function ChatMainDialog:IsBorderCurrent(borderId)
  if not self.BorderData then
    return 0
  end
  if self.BorderData.curBubble == borderId then
    return 1
  end
  return 0
end

return ChatMainDialog
