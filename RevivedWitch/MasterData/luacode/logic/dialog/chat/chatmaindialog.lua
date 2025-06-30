-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/chatmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CChatConfig = (BeanManager.GetTableByName)("chat.cchatconfig")
local ChatMainDialog = class("ChatMainDialog", Dialog)
ChatMainDialog.AssetBundleName = "ui/layouts.chat"
ChatMainDialog.AssetName = "ChatNewMain"
local MulTextNewLine = 2
local BottomToTop = 2
local InputMaxHeight = 5
ChatMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChatMainDialog, _ENV, CChatConfig
  ((ChatMainDialog.super).Ctor)(self, ...)
  self._groupName = "Chat"
  self._cellinfo = nil
  self._openChat = false
  self._needUpdate = false
  self._curProportion = 0
  self._chatData = {}
  self._selfinfo = {}
  self._curChannel = 0
  local myRoleTable = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  for key,info in pairs(myRoleTable) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    (self._selfinfo)[key] = info
  end
  self._chatCfg = CChatConfig:GetRecorder(1)
  self._maxWordCount = (self._chatCfg).charactermax
  self._worldChannelPeriod = (self._chatCfg).period
  self._worldChannelSendTime = nil
  self._channelMax = (math.min)((self._chatCfg).channelmax, 50)
end

ChatMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : MulTextNewLine, TableFrame, ChannelType, _ENV
  self._worldMsgFrame = self:GetChild("Back/MessageAreaWorld")
  self._chatMsgFrame = self:GetChild("Back/MessageArea")
  self._downBoard = self:GetChild("Back/Down")
  self._sendBtn = self:GetChild("Back/Down/SendBtn")
  self._inputField = self:GetChild("Back/Down/InputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  ;
  (self._inputField):SetLineType(MulTextNewLine)
  self._arrowBtn = self:GetChild("Back/ArrowBtn")
  self._new = self:GetChild("Back/RecordsUpBtn")
  self._txtNewMsgNum = self:GetChild("Back/RecordsUpBtn/TextUp")
  self._txtNotChat = self:GetChild("Back/Down/Text")
  self._channelInfo = self:GetChild("Back/ChatNewChannel")
  self._channelInputImg = self:GetChild("Back/ChatNewChannel/GoBtn")
  self._channelInputField = self:GetChild("Back/ChatNewChannel/Back/InputField")
  self._channelInputPlaceHolder = self:GetChild("Back/ChatNewChannel/Back/InputField/_Placeholder")
  self._groupBtnInfo = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtnInfo)[i] = {}
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

      if i > 1 then
        ((self._groupBtnInfo)[i]).redicon = self:GetChild("Back/GroupArea/GroupBtn" .. i .. "/RedDot")
      end
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._groupBtnInfo)[i]).btn = self:GetChild("Back/GroupArea/GroupBtn" .. i)
      ;
      (((self._groupBtnInfo)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSelectChannel(i)
  end
)
      if ((self._groupBtnInfo)[i]).redicon then
        (((self._groupBtnInfo)[i]).redicon):SetActive(false)
      end
    end
  end
  self._frame = (TableFrame.Create)(self._chatMsgFrame, self, true, true, true)
  self._worldFrame = (TableFrame.Create)(self._worldMsgFrame, self, true, true, true)
  ;
  (self._frame):SetMargin(40, 0)
  ;
  (self._worldFrame):SetMargin(40, 0)
  self:InitPosInfo()
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnChatDialogHideStateExit, self)
  ;
  (self._sendBtn):Subscribe_PointerClickEvent(self.OnSendBtnClick, self)
  ;
  (self._arrowBtn):Subscribe_PointerClickEvent(self.OnArrowBtnClick, self)
  ;
  (self._new):Subscribe_PointerClickEvent(self.OnNewMessage, self)
  ;
  (self._inputField):Subscribe_ValueChangedEvent(self.OnInputFieldValueChanged, self)
  ;
  (self._channelInputImg):Subscribe_PointerClickEvent(self.OnChannelInputFieldEditEnd, self)
  self:OnSelectChannel(ChannelType.CHANNEL_WORLD)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewMsgCome, Common.n_ChatInfoReceive, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetSubChannelInfo, Common.n_SubChannelChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnModalDialogOpen, Common.n_ModalDialogOpen, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAllModalDialogClose, Common.n_AllModalDialogClose, nil)
end

ChatMainDialog.SelectChannel = function(self, channel)
  -- function num : 0_2
  self:OnSelectChannel(channel)
end

ChatMainDialog.InitPosInfo = function(self)
  -- function num : 0_3
  local _ = 0
  self._inputFieldSX = (self._inputField):GetSize()
  self._chatMsgFrameSX = (self._chatMsgFrame):GetSize()
  self._chatMsgFramePX = (self._chatMsgFrame):GetPosition()
  -- DECOMPILER ERROR at PC28: Overwrote pending register: R1 in 'AssignReg'

  -- DECOMPILER ERROR at PC29: Overwrote pending register: R1 in 'AssignReg'

  -- DECOMPILER ERROR at PC32: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC33: Overwrote pending register: R5 in 'AssignReg'

  -- DECOMPILER ERROR at PC35: Overwrote pending register: R1 in 'AssignReg'

  -- DECOMPILER ERROR at PC36: Overwrote pending register: R1 in 'AssignReg'

  -- DECOMPILER ERROR at PC37: Overwrote pending register: R1 in 'AssignReg'

  -- DECOMPILER ERROR at PC42: Overwrote pending register: R1 in 'AssignReg'

end

ChatMainDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._worldFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChatMainDialog.Toggle = function(self)
  -- function num : 0_5
  if self._openChat then
    self._openChat = false
    ;
    (self:GetRootWindow()):PlayAnimation("ChatDialogHide")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("ChatDialogShow")
    self._openChat = true
  end
end

ChatMainDialog.OnSelectChannel = function(self, index)
  -- function num : 0_6 , upvalues : ChannelType
  if self._curChannel == index then
    return 
  end
  if (self._groupBtnInfo)[self._curChannel] then
    (((self._groupBtnInfo)[self._curChannel]).btn):SetSelected(false)
  end
  self._curChannel = index
  ;
  (((self._groupBtnInfo)[self._curChannel]).btn):SetSelected(true)
  if ((self._groupBtnInfo)[self._curChannel]).redicon then
    (((self._groupBtnInfo)[self._curChannel]).redicon):SetActive(false)
  end
  ;
  (self._txtNotChat):SetActive(self._curChannel == ChannelType.CHANNEL_SYSTEM)
  ;
  (self._inputField):SetActive(self._curChannel ~= ChannelType.CHANNEL_SYSTEM)
  ;
  (self._sendBtn):SetActive(self._curChannel ~= ChannelType.CHANNEL_SYSTEM)
  ;
  (self._chatMsgFrame):SetActive(self._curChannel ~= ChannelType.CHANNEL_WORLD)
  ;
  (self._worldMsgFrame):SetActive(self._curChannel == ChannelType.CHANNEL_WORLD)
  ;
  (self._channelInfo):SetActive(self._curChannel == ChannelType.CHANNEL_WORLD)
  self:RefreshChatInfo()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

ChatMainDialog.RefreshChatInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV, ChannelType
  self._chatData = {}
  local chatTable = ((NekoData.BehaviorManager).BM_Chat):GetChannelChatData(self._curChannel)
  for i = 1, #chatTable do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (self._chatData)[i] = chatTable[i]
  end
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    (self._worldFrame):ReloadAllCell()
    self:SetSubChannelInfo()
  else
    ;
    (self._frame):ReloadAllCell()
  end
  self._newMsgNum = 0
  self:RefreshNewMsgNumInfo()
end

ChatMainDialog.SetSubChannelInfo = function(self)
  -- function num : 0_8 , upvalues : CstringCfg, _ENV
  local str = (CstringCfg:GetRecorder(1086)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Chat):GetSubChannel())
  str = (string.gsub)(str, "%$parameter2%$", (self._chatCfg).channelmin)
  str = (string.gsub)(str, "%$parameter3%$", self._channelMax)
  ;
  (self._channelInputPlaceHolder):SetText(str)
  ;
  (self._channelInputField):SetText("")
end

ChatMainDialog.MoveToBottom = function(self, isAnimate)
  -- function num : 0_9 , upvalues : ChannelType
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    (self._worldFrame):MoveToBottom(isAnimate)
  else
    ;
    (self._frame):MoveToBottom(isAnimate)
  end
end

ChatMainDialog.GetTotalLength = function(self)
  -- function num : 0_10 , upvalues : ChannelType
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    return (self._worldFrame):GetTotalLength()
  end
  return (self._frame):GetTotalLength()
end

ChatMainDialog.ReloadCellsAtIndex = function(self, index, isAnimate)
  -- function num : 0_11 , upvalues : ChannelType
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    (self._worldFrame):ReloadCellsAtIndex(index, isAnimate)
  else
    ;
    (self._frame):ReloadCellsAtIndex(index, isAnimate)
  end
end

ChatMainDialog.RemoveCellsAtIndex = function(self, index, isAnimate)
  -- function num : 0_12 , upvalues : ChannelType
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    (self._worldFrame):RemoveCellsAtIndex(index, isAnimate)
  else
    ;
    (self._frame):RemoveCellsAtIndex(index, isAnimate)
  end
end

ChatMainDialog.InsertCellsAtIndex = function(self, index, isAnimate)
  -- function num : 0_13 , upvalues : ChannelType
  if self._curChannel == ChannelType.CHANNEL_WORLD then
    (self._worldFrame):InsertCellsAtIndex(index, isAnimate)
  else
    ;
    (self._frame):InsertCellsAtIndex(index, isAnimate)
  end
end

ChatMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_14
  return #self._chatData
end

ChatMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_15 , upvalues : ChannelType
  local ids = self._chatData
  if self._curChannel == ChannelType.CHANNEL_SYSTEM then
    if (ids[index]).showTime then
      return "chat.systeminfotimecell"
    else
      return "chat.systeminfocell"
    end
  end
  if (self._selfinfo).userid ~= (ids[index]).userid then
    if (ids[index]).showTime then
      return "chat.chatinfotimecell"
    else
      return "chat.chatinfocell"
    end
  else
    if (self._selfinfo).userid == (ids[index]).userid then
      if (ids[index]).showTime then
        return "chat.chatselftimecell"
      else
        return "chat.chatselfcell"
      end
    end
  end
end

ChatMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_16
  local ids = self._chatData
  self._data = ids[index]
  return self._data
end

ChatMainDialog.OnNewMsgCome = function(self, notification)
  -- function num : 0_17 , upvalues : _ENV, ChannelType
  if not notification then
    return 
  end
  if notification.userInfo and (notification.userInfo).channelType ~= self._curChannel then
    if ((self._groupBtnInfo)[(notification.userInfo).channelType]).redicon then
      (((self._groupBtnInfo)[(notification.userInfo).channelType]).redicon):SetActive(true)
    end
    return 
  end
  local comeNum = (notification.userInfo).msgNum
  if not comeNum then
    comeNum = 1
  end
  local nowmsg = #self._chatData
  do
    if nowmsg + comeNum >= 999 then
      local index = {}
      for i = 1, nowmsg + comeNum - 999 do
        (table.remove)(self._chatData, 1)
        ;
        (table.insert)(index, i)
      end
      self:RemoveCellsAtIndex(index)
      nowmsg = #self._chatData
    end
    local chatTable = ((NekoData.BehaviorManager).BM_Chat):GetChannelChatData(self._curChannel)
    for i = nowmsg + 1, #chatTable do
      (table.insert)(self._chatData, chatTable[i])
    end
    self:InsertCellsAtIndex({}, true)
    if (notification.userInfo).channelType == ChannelType.CHANNEL_SYSTEM then
      if self._curProportion ~= 0 then
        self._newMsgNum = self._newMsgNum + 1
      else
        self:MoveToBottom()
        self._newMsgNum = 0
      end
    else
      if (self._selfinfo).userid ~= ((self._chatData)[#self._chatData]).userid then
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
    end
    self:RefreshNewMsgNumInfo()
  end
end

ChatMainDialog.RefreshNewMsgNumInfo = function(self)
  -- function num : 0_18 , upvalues : CstringCfg, _ENV
  (self._new):SetActive(self._newMsgNum > 0)
  ;
  (self._txtNewMsgNum):SetActive(self._newMsgNum > 0)
  local str = (CstringCfg:GetRecorder(1035)).msgTextID
  str = (TextManager.GetText)(str)
  ;
  (self._txtNewMsgNum):SetText((string.gsub)(str, "%$parameter1%$", self._newMsgNum))
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ChatMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_19
  self._curProportion = proportion
end

ChatMainDialog.CopyCellInfo = function(self, x, y, flag, str)
  -- function num : 0_20
  local _, _, _, copyY = (self._copyBgd):GetSize()
  local _, rootX, _, rootY = (self:GetRootWindow()):GetSize()
  local _, _, _, downY = (self._downBoard):GetSize()
  local width, height = (self._chatMsgFrame):GetRectSize()
  local total = self:GetTotalLength()
  if height < total then
    (self._copyBgd):SetPosition(0, rootX / 2, 0, downY + (y - self._curProportion * (total - height)))
  else
    ;
    (self._copyBgd):SetPosition(0, rootX / 2, 0, downY + height - total + y)
  end
  ;
  (self._copyBgd):SetActive(flag)
  self._cellinfo = str
end

ChatMainDialog.SetColorInCell = function(self, talk, color)
  -- function num : 0_21
  self._celltalk = talk
  self._celltalkColor = color
  ;
  (self._celltalk):SetColor("gray")
end

ChatMainDialog.SetColor = function(self, color)
  -- function num : 0_22
  if self._celltalk then
    (self._celltalk):SetColor(color)
    self._celltalk = nil
  end
end

ChatMainDialog.OnLateUpdate = function(self, notification)
  -- function num : 0_23
  if self._needUpdate then
    if self._inputFieldTask then
      if (self._inputFieldTask):update((notification.userInfo).deltaTime) then
        (self._inputField):SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, self._inputFieldDes)
        self._inputFieldTask = nil
      else
        ;
        (self._inputField):SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, ((self._inputFieldTask).subject).pos)
      end
    end
    if self._chatMsgFrameTask then
      if (self._chatMsgFrameTask):update((notification.userInfo).deltaTime) then
        (self._chatMsgFrame):SetSize(self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY - self._chatMsgFrameDes)
        ;
        (self._chatMsgFrame):SetPosition(self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY + self._chatMsgFrameDes)
        self._chatMsgFrameTask = nil
      else
        ;
        (self._chatMsgFrame):SetSize(self._chatMsgFrameSX, self._chatMsgFrameSOX, self._chatMsgFrameSY, self._chatMsgFrameSOY - ((self._chatMsgFrameTask).subject).pos)
        ;
        (self._chatMsgFrame):SetPosition(self._chatMsgFramePX, self._chatMsgFramePOX, self._chatMsgFramePY, self._chatMsgFramePOY + ((self._chatMsgFrameTask).subject).pos)
      end
    end
    if not self._inputFieldTask and not self._chatMsgFrameTask then
      self._needUpdate = false
    end
  end
end

ChatMainDialog.OnChatDialogHideStateExit = function(self, arg1, arg2)
  -- function num : 0_24
  if not self._openChat and arg2 == "chatdialoghide" then
    self:Destroy()
  end
end

ChatMainDialog.OnSendBtnClick = function(self, args)
  -- function num : 0_25 , upvalues : ChannelType, _ENV
  if self._curChannel == ChannelType.CHANNEL_SYSTEM then
    return 
  end
  local msg = (self._inputField):GetText()
  if self:IsLocalGMmsg(msg) then
    (self._inputField):SetText("")
    return 
  end
  local wordCount = (utf8.len)(msg)
  if self._maxWordCount < wordCount then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100041, {self._maxWordCount})
    return 
  end
  if wordCount == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100059)
    return 
  end
  if self._curChannel == ChannelType.CHANNEL_WORLD and self._worldChannelSendTime then
    local delta = (ServerGameTimer.GetServerTimeForecast)() - self._worldChannelSendTime
    if delta < self._worldChannelPeriod * 1000 then
      local lefttime = self._worldChannelSendTime + self._worldChannelPeriod * 1000 - (ServerGameTimer.GetServerTimeForecast)()
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100061, {(math.ceil)(lefttime / 1000)})
      return 
    end
  end
  do
    ;
    ((NekoData.BehaviorManager).BM_Chat):SendMsg(msg, self._curChannel)
    if self._curChannel == ChannelType.CHANNEL_WORLD then
      self._worldChannelSendTime = (ServerGameTimer.GetServerTimeForecast)()
    end
    ;
    (self._inputField):SetText("")
  end
end

ChatMainDialog.OnArrowBtnClick = function(self, args)
  -- function num : 0_26
  self._openChat = false
  ;
  (self:GetRootWindow()):PlayAnimation("ChatDialogHide")
end

ChatMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_27
  self:OnArrowBtnClick()
end

ChatMainDialog.OnNewMessage = function(self, args)
  -- function num : 0_28
  self:MoveToBottom(true)
  self._newMsgNum = 0
  self:RefreshNewMsgNumInfo()
end

ChatMainDialog.OnCopyBtnClick = function(self, args)
  -- function num : 0_29
end

ChatMainDialog.OnInputFieldValueChanged = function(self)
  -- function num : 0_30 , upvalues : InputMaxHeight, _ENV
  local preheight = self._prefheight
  local _ = 0
  _ = (self._inputField):GetPreferredSize()
  if preheight then
    local predelta = preheight - self._inputFieldPreY
    local curdelta = self._prefheight - self._inputFieldPreY
    if curdelta < self._inputFieldPreY * InputMaxHeight and preheight ~= self._prefheight then
      if self._inputFieldPreY * InputMaxHeight < predelta then
        predelta = self._inputFieldPreY * InputMaxHeight
      end
      self._inputFieldDes = self._inputFieldSOY + curdelta
      local first = {pos = self._inputFieldSOY + predelta}
      local last = {pos = self._inputFieldDes}
      self._inputFieldTask = (Tween.new)(0.1, first, last, "linear")
      self._needUpdate = true
    end
  end
end

ChatMainDialog.OnChannelInputFieldEditEnd = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local msg = (self._channelInputField):GetText()
  if not tonumber(msg) then
    return 
  end
  if tonumber(msg) < 1 or self._channelMax < tonumber(msg) then
    self:SetSubChannelInfo()
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100103)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.cchangesubchannel")
  protocol.num = tonumber(msg)
  protocol:Send()
end

ChatMainDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_32
end

ChatMainDialog.ShouldLengthChange = function(self, frame)
  -- function num : 0_33
  return true
end

ChatMainDialog.IsLocalGMmsg = function(self, msg)
  -- function num : 0_34 , upvalues : _ENV
  local str = (string.sub)(msg, 1, 2)
  if not (string.sub)(msg, 3) then
    local lastStr = str ~= "//" or ""
  end
  if lastStr == "testchat" then
    ((NekoData.BehaviorManager).BM_FriendsChat):RandomChatFriend(200)
    return true
  end
  if lastStr ~= "" then
    local posS, posE = (string.find)(lastStr, "chat")
    local posBS, posBE = (string.find)(lastStr, " ")
    if posS and posE and posBS and posBE then
      local strtemp = (string.sub)(lastStr, posBE + 1)
      local pos1, pos2 = (string.find)(strtemp, " ")
      if pos1 and pos2 then
        local strUserId = (string.sub)(strtemp, 1, pos1)
        local strNum = (string.sub)(strtemp, pos2)
        ;
        ((NekoData.BehaviorManager).BM_FriendsChat):TestChatWithFriend(tonumber(strUserId), tonumber(strNum))
        return true
      end
    end
  end
  do
    return false
  end
end

ChatMainDialog.OnModalDialogOpen = function(self)
  -- function num : 0_35
  (self:GetRootWindow()):SetActive(false)
end

ChatMainDialog.OnAllModalDialogClose = function(self)
  -- function num : 0_36
  (self:GetRootWindow()):SetActive(true)
end

return ChatMainDialog

