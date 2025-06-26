-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendslistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CFriendConfig = (BeanManager.GetTableByName)("friend.cfriendconfig")
local OtherUserInfo = (LuaNetManager.GetBeanDef)("protocol.chat.otheruserinfo")
local CFriendEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local FriendsListDialog = class("FriendsListDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
FriendsListDialog.AssetBundleName = "ui/layouts.friends"
FriendsListDialog.AssetName = "FriendsList"
local MulTextNewLine = 2
local InputMaxHeight = 5
FriendsListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendsListDialog
  ((FriendsListDialog.super).Ctor)(self, ...)
  self._selectID = 0
  self._notReadNum = 0
  self._requestFrindsTime = nil
  self._requestInCD = nil
  self._selectReportContent = nil
  self._tabBtnData = {}
end

FriendsListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CFriendConfig
  self._txtMyID = self:GetChild("PlayerID/IDBack/ID")
  self._btnCopyID = self:GetChild("PlayerID/CopyBtn")
  self._inputField = self:GetChild("Search/FriendsInputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  self._btnSearch = self:GetChild("Search/SearchBtn")
  self._txtNum = self:GetChild("FriendsList/NumPanel/Num")
  self._txtMaxNum = self:GetChild("FriendsList/NumPanel/NumMax")
  self._frame = self:GetChild("FriendsList/Frame")
  self._empty = self:GetChild("Empty")
  self._listHelper = (TableFrame.Create)(self._frame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(2)
  self._btnThumbsUp = self:GetChild("ThumbsUpBtn")
  self._btnCollect = self:GetChild("CollectBtn")
  self._collectRedDot = self:GetChild("CollectBtn/RedDot")
  local redData = ((NekoData.BehaviorManager).BM_Friends):GetRedData()
  ;
  (self._collectRedDot):SetActive(redData:IsIndexTrue(3))
  self._chatBack = self:GetChild("ChatArea")
  self._msgInputField = self:GetChild("ChatArea/Down/InputField")
  ;
  (self._msgInputField):SetGenerateOutOfBounds(true)
  self._btnSend = self:GetChild("ChatArea/Down/SendBtn")
  self._emojiBtn = self:GetChild("ChatArea/Down/EmojiBtn")
  self._newMessageTip = self:GetChild("ChatArea/RecordsUpBtn")
  self._emojiArea = self:GetChild("ChatArea/EmojiArea")
  self._emojiPanel = self:GetChild("ChatArea/EmojiArea/Frame")
  self._emojiScrollbar = self:GetChild("ChatArea/EmojiArea/Scrollbar")
  self._rightBtn = self:GetChild("ChatArea/EmojiArea/emoji_mark/NextBtn")
  self._panel = self:GetChild("ChatArea/EmojiArea/emoji_mark/Frame")
  self._leftBtn = self:GetChild("ChatArea/EmojiArea/emoji_mark/BackBtn")
  self._wndNewMsgback = self:GetChild("ChatArea/RecordsUpBtn")
  self._txtNewMsgNum = self:GetChild("ChatArea/RecordsUpBtn/TextUp")
  self._selectFriendName = self:GetChild("ChatArea/Name")
  self._rightPanel = self:GetChild("ChatArea/RightFrame")
  self._rightListHelper = (TableFrame.Create)(self._rightPanel, self, true, true, true)
  self:SetData()
  ;
  (self._inputField):Subscribe_ValueChangedEvent(self.OnInputFieldValueChanged, self)
  ;
  (self._btnSearch):Subscribe_PointerClickEvent(self.OnSearchClicked, self)
  ;
  (self._btnCopyID):Subscribe_PointerClickEvent(self.OnCopyIDClicked, self)
  ;
  (self._msgInputField):Subscribe_ValueChangedEvent(self.OnMsgInputFieldValueChanged, self)
  ;
  (self._btnSend):Subscribe_PointerClickEvent(self.OnSendClicked, self)
  ;
  (self._wndNewMsgback):Subscribe_PointerClickEvent(self.OnReadAllNewMsg, self)
  ;
  (self._btnThumbsUp):Subscribe_PointerClickEvent(self.OnAllThumbsUpClicked, self)
  ;
  (self._btnCollect):Subscribe_PointerClickEvent(self.OnCollectClicked, self)
  ;
  (self._emojiBtn):Subscribe_PointerClickEvent(self.OnEmojiBtnClicked, self)
  local _ = 0
  self._inputFieldSX = (self._msgInputField):GetSize()
  _ = (self._msgInputField):GetPreferredSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewChatReceive, Common.n_FriendChatReceive, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLocalChatReceive, Common.n_FriendLocalChatReceive, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFriendIdentityChange, Common.n_FriendIdentityChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFriendsDataChange, Common.n_FriendsDataChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNotifyFriendsPoint, Common.n_NotifyFriendsPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFriendsLike, Common.n_FriendsLike, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFriendsShowPark, Common.n_FriendsShowPark, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFriendNotReadNumChange, Common.n_FriendNotReadNumChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  self._maxWordCount = (CFriendConfig:GetRecorder(1)).MessageMax
  self._requestColdTime = tonumber((CFriendConfig:GetRecorder(1)).RefreshLimit)
end

FriendsListDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._listHelper):Destroy()
  ;
  (self._rightListHelper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._tabBtnFrame then
    (self._tabBtnFrame):Destroy()
  end
end

local tempSortFun = function(lhs, rhs)
  -- function num : 0_3 , upvalues : _ENV
  local lhasnotread = ((NekoData.BehaviorManager).BM_FriendsChat):GetNotReadNum(lhs:GetID()) > 0
  local rhasnotread = ((NekoData.BehaviorManager).BM_FriendsChat):GetNotReadNum(rhs:GetID()) > 0
  if lhasnotread and rhasnotread then
    local lchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(lhs:GetID())
    local rchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(rhs:GetID())
    if rchattime >= lchattime then
      do return not lchattime or not rchattime end
      if lchattime and not rchattime then
        return true
      end
      if not lchattime and rchattime then
        return false
      end
      if rhs:GetFriendTime() >= lhs:GetFriendTime() then
        do
          do return lchattime or rchattime end
          if lhasnotread and not rhasnotread then
            return true
          end
          if not lhasnotread and rhasnotread then
            return false
          end
          local lonline = lhs:IsOnLine()
          local ronline = rhs:IsOnLine()
          if lonline and ronline then
            local lheart = lhs:GetSparkStatus()
            local rheart = rhs:GetSparkStatus()
            if rheart >= lheart then
              do return not lheart or not rheart end
              local lchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(lhs:GetID())
              local rchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(rhs:GetID())
              if rchattime >= lchattime then
                do return not lchattime or not rchattime end
                if lchattime and not rchattime then
                  return true
                end
                if not lchattime and rchattime then
                  return false
                end
                if rhs:GetFriendTime() >= lhs:GetFriendTime() then
                  do
                    do return lchattime or rchattime end
                    if lonline and not ronline then
                      return true
                    end
                    if not lonline and ronline then
                      return false
                    end
                    if not lonline and not ronline then
                      local lheart = lhs:GetSparkStatus()
                      local rheart = rhs:GetSparkStatus()
                      if rheart >= lheart then
                        do return not lheart or not rheart end
                        local lchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(lhs:GetID())
                        local rchattime = ((NekoData.BehaviorManager).BM_FriendsChat):GetLastChatTime(rhs:GetID())
                        if rchattime >= lchattime then
                          do return not lchattime or not rchattime end
                          if lchattime and not rchattime then
                            return true
                          end
                          if not lchattime and rchattime then
                            return false
                          end
                          if not lchattime and not rchattime then
                            local llogouttime = lhs:GetLastOnLineTime()
                            local rlogouttime = rhs:GetLastOnLineTime()
                            return rlogouttime < llogouttime
                          end
                          -- DECOMPILER ERROR: 28 unprocessed JMP targets
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

FriendsListDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV, tempSortFun, TableFrame
  self._cellInfo = {}
  local allfriends = ((NekoData.BehaviorManager).BM_Friends):GetAllFriend()
  for id,friend in pairs(allfriends) do
    if friend:IsFriend() then
      (table.insert)(self._cellInfo, friend)
    end
  end
  ;
  (table.sort)(self._cellInfo, tempSortFun)
  self:RefreshUIInfo()
  if (self._cellInfo)[1] then
    self:SetSelectFriendInfo((self._cellInfo)[1])
  else
    self:SetSelectFriendInfo(nil)
  end
  self._tabBtnFrame = (TableFrame.Create)(self._panel, self, false, false, false)
end

FriendsListDialog.OnFriendsDataChange = function(self)
  -- function num : 0_5 , upvalues : _ENV, tempSortFun
  local selectFriendIndex = nil
  if self._selectID then
    for i,v in ipairs(self._cellInfo) do
      if v:GetID() == self._selectID then
        selectFriendIndex = i
        break
      end
    end
  end
  do
    self._cellInfo = {}
    local allfriends = ((NekoData.BehaviorManager).BM_Friends):GetAllFriend()
    for id,friend in pairs(allfriends) do
      if friend:IsFriend() then
        (table.insert)(self._cellInfo, friend)
      end
    end
    ;
    (table.sort)(self._cellInfo, tempSortFun)
    if selectFriendIndex then
      local index, friend = nil, nil
      for i,v in ipairs(self._cellInfo) do
        if v:GetID() == self._selectID then
          index = i
          friend = v
          break
        end
      end
      do
        do
          ;
          (table.remove)(self._cellInfo, index)
          ;
          (table.insert)(self._cellInfo, selectFriendIndex, friend)
          self:RefreshUIInfo()
          if (self._cellInfo)[1] then
            self:SetSelectFriendInfo((self._cellInfo)[1])
          else
            self:SetSelectFriendInfo(nil)
          end
        end
      end
    end
  end
end

FriendsListDialog.OnFriendIdentityChange = function(self, notification)
  -- function num : 0_6 , upvalues : OtherUserInfo, _ENV
  if not notification then
    return 
  end
  if not notification.userInfo then
    return 
  end
  if (notification.userInfo).newIdentity and (notification.userInfo).newIdentity == OtherUserInfo.FRIEND then
    local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((notification.userInfo).userid)
    if friend then
      (table.insert)(self._cellInfo, 1, friend)
      ;
      (self._listHelper):InsertCellsAtIndex({1}, true)
      self:RefreshUIInfo()
    end
  else
    do
      if (notification.userInfo).oldIdentity and (notification.userInfo).oldIdentity == OtherUserInfo.FRIEND then
        local userIndex = nil
        for index,friend in pairs(self._cellInfo) do
          if friend:GetID() == (notification.userInfo).userid then
            userIndex = index
            break
          end
        end
        do
          ;
          (table.remove)(self._cellInfo, userIndex)
          ;
          (self._listHelper):RemoveCellsAtIndex({userIndex}, false)
          if #self._cellInfo == 0 then
            self:SetSelectFriendInfo(nil)
            self:RefreshUIInfo()
          else
            if #self._cellInfo < userIndex and #self._cellInfo > 1 then
              userIndex = #self._cellInfo
            end
            self:SetSelectFriendInfo((self._cellInfo)[userIndex])
            self:RefreshUIInfo(userIndex)
          end
        end
      end
    end
  end
end

FriendsListDialog.RefreshUIInfo = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  local lastPos = (self._listHelper):GetCurrentPosition()
  ;
  (self._listHelper):ReloadAllCell()
  if index and lastPos then
    (self._listHelper):MoveToAssignedPos(lastPos)
  else
    ;
    (self._listHelper):MoveToTop()
  end
  ;
  (self._empty):SetActive(#self._cellInfo == 0)
  ;
  (self._btnCollect):SetActive(#self._cellInfo ~= 0)
  ;
  (self._btnThumbsUp):SetActive(#self._cellInfo ~= 0)
  ;
  (self._txtMyID):SetText(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid))
  ;
  (self._txtNum):SetText(tostring(#self._cellInfo))
  ;
  (self._txtMaxNum):SetText(tostring(((NekoData.BehaviorManager).BM_Friends):GetMaxFriendsNum()))
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

FriendsListDialog.SetSelectFriendInfo = function(self, friend)
  -- function num : 0_8 , upvalues : _ENV
  if friend then
    if self._selectID > 0 then
      ((NekoData.BehaviorManager).BM_FriendsChat):ResetFirstNotReadMsgTime(self._selectID)
    end
    self._selectID = friend:GetID()
    self:SetChatData()
    ;
    (self._listHelper):FireEvent("RefreshSelectFriend", self._selectID)
    ;
    ((NekoData.DataManager).DM_FriendsChat):ResetNotReadNum(self._selectID)
    ;
    ((NekoData.DataManager).DM_Friends):CheckFriendPageRedData()
    local userInfo = {}
    userInfo.userId = self._selectID
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_FriendNotReadNumChange, nil, userInfo)
    ;
    (self._selectFriendName):SetText(friend:GetName())
  else
    do
      self._selectID = 0
      self._chatInfo = {}
      ;
      (self._selectFriendName):SetText("")
      ;
      (self._btnSend):SetActive(self._selectID > 0)
      ;
      (self._chatBack):SetActive(self._selectID > 0)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

FriendsListDialog.GetSelectedFriend = function(self)
  -- function num : 0_9
  return self._selectID
end

FriendsListDialog.NumberOfCell = function(self, helper)
  -- function num : 0_10
  if helper == self._listHelper then
    return #self._cellInfo
  else
    if helper == self._rightListHelper then
      return #self._chatInfo
    else
      if helper == self._tabBtnFrame then
        return #self._tabBtnData
      else
        if helper == self._emojiFrame then
          return #self._emojiData
        end
      end
    end
  end
end

FriendsListDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_11
  if helper == self._listHelper then
    return "friend.friendcell"
  else
    if helper == self._rightListHelper then
      local msgInfo = (self._chatInfo)[index]
      if msgInfo:IsMySendMsg() then
        if #((self._chatInfo)[index])._hyperlinks > 0 then
          return "friend.friendchatrightimagecell"
        else
          return "friend.friendchatselcell"
        end
      else
        if #((self._chatInfo)[index])._hyperlinks > 0 then
          return "friend.friendchatleftimagecell"
        else
          return "friend.friendchatinfocell"
        end
      end
    else
      do
        if helper == self._emojiFrame then
          return "friend.friendchatemojicell"
        else
          if helper == self._tabBtnFrame then
            return "guild.emojibtncell"
          end
        end
      end
    end
  end
end

FriendsListDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_12
  if helper == self._listHelper then
    return (self._cellInfo)[index]
  else
    if helper == self._rightListHelper then
      return (self._chatInfo)[index]
    else
      if helper == self._emojiFrame then
        return (self._emojiData)[index]
      else
        if helper == self._tabBtnFrame then
          return (self._tabBtnData)[index]
        end
      end
    end
  end
end

FriendsListDialog.OnFriendNotReadNumChange = function(self, notification)
  -- function num : 0_13
  (self._listHelper):FireEvent("chatnumchange", (notification.userInfo).userId)
end

FriendsListDialog.OnCopyIDClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

FriendsListDialog.OnSearchClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local keyword = (self._inputField):GetText()
  if keyword == "" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100024)
    return 
  end
  local result = ((NekoData.BehaviorManager).BM_Friends):FindFriend(keyword)
  self._cellInfo = {}
  for id,friend in pairs(result) do
    if friend:IsFriend() then
      (table.insert)(self._cellInfo, friend)
    end
  end
  if (self._cellInfo)[1] then
    self:SetSelectFriendInfo((self._cellInfo)[1])
  else
    self:SetSelectFriendInfo(nil)
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100024)
  end
  ;
  (self._listHelper):ReloadAllCell()
  ;
  (self._empty):SetActive(#self._cellInfo == 0)
  ;
  (self._btnCollect):SetActive(#self._cellInfo ~= 0)
  ;
  (self._btnThumbsUp):SetActive(#self._cellInfo ~= 0)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

FriendsListDialog.OnInputFieldValueChanged = function(self)
  -- function num : 0_16
  local keyword = (self._inputField):GetText()
  if keyword == "" then
    self:SetData()
  end
end

FriendsListDialog.OnMsgInputFieldValueChanged = function(self)
  -- function num : 0_17 , upvalues : InputMaxHeight, _ENV
  local preheight = self._prefheight
  local _ = 0
  _ = (self._msgInputField):GetPreferredSize()
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
      self._chatMsgFrameDes = curdelta
      first = {pos = predelta}
      last = {pos = self._chatMsgFrameDes}
      self._chatMsgFrameTask = (Tween.new)(0.1, first, last, "linear")
      self._needUpdate = true
    end
  end
end

FriendsListDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_18 , upvalues : _ENV
  if frame == self._listHelper then
    local width, height = (self._frame):GetRectSize()
    local total = (self._listHelper):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  else
    do
      if frame == self._rightListHelper then
        if proportion == 1 and (not self._receiveLocalTime or (ServerGameTimer.GetServerTimeForecast)() - self._receiveLocalTime > 2000) then
          ((NekoData.DataManager).DM_FriendsChat):CheckLoadMsg(self._selectID)
        end
        self:CheckNewMsgUI()
      else
        if frame == self._emojiFrame then
          local width, height = (self._emojiPanel):GetRectSize()
          local total = (self._emojiFrame):GetTotalLength()
          if height < total then
            (self._emojiScrollbar):SetActive(true)
            ;
            (self._emojiScrollbar):SetScrollSize(height / total)
            ;
            (self._emojiScrollbar):SetScrollValue(proportion)
          else
            ;
            (self._emojiScrollbar):SetActive(false)
          end
        end
      end
    end
  end
end

FriendsListDialog.CheckNewMsgUI = function(self)
  -- function num : 0_19
  if self._notReadNum ~= 0 then
    local idx = #self._chatInfo - self._notReadNum + 1
    local topindex = (self._rightListHelper):GetTopIndex()
    if topindex <= idx then
      self:HideNewMsgUI()
    end
  end
end

FriendsListDialog.Refresh = function(self)
  -- function num : 0_20
  (self._inputField):SetText("")
  self:RequestRefreshFriends()
end

FriendsListDialog.RequestRefreshFriends = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self._requestInCD then
    ((NekoData.BehaviorManager).BM_Friends):RequestRefreshFriends()
    self._requestInCD = (GameTimer.AddTask)(5, -1, function(self)
    -- function num : 0_21_0 , upvalues : _ENV
    if self._requestInCD then
      (GameTimer.RemoveTask)(self._requestInCD)
      self._requestInCD = nil
    end
  end
, self)
  end
end

FriendsListDialog.SetChatData = function(self)
  -- function num : 0_22 , upvalues : _ENV, CstringCfg
  self._chatInfo = {}
  if self._selectID > 0 then
    local localChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetLocalChatRecord(self._selectID)
    for index,info in ipairs(localChatMessage) do
      (table.insert)(self._chatInfo, info)
    end
    local allChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetFriendChatRecord(self._selectID)
    for i,info in ipairs(allChatMessage) do
      (table.insert)(self._chatInfo, info)
    end
  end
  do
    ;
    (self._rightListHelper):ReloadAllCell()
    self._onlineNotReadNum = ((NekoData.BehaviorManager).BM_FriendsChat):GetOnLineNotReadNum(self._selectID)
    self._localNotReadNum = ((NekoData.BehaviorManager).BM_FriendsChat):GetLocalNotReadNum(self._selectID)
    self._notReadNum = self._localNotReadNum + self._onlineNotReadNum
    ;
    (self._wndNewMsgback):SetActive(self._notReadNum > 3)
    ;
    (self._txtNewMsgNum):SetActive(self._notReadNum > 3)
    local str = (TextManager.GetText)((CstringCfg:GetRecorder(1035)).msgTextID)
    ;
    (self._txtNewMsgNum):SetText((string.gsub)(str, "%$parameter1%$", self._notReadNum))
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

FriendsListDialog.OnNewChatReceive = function(self, notification)
  -- function num : 0_23 , upvalues : _ENV
  if notification.userInfo and (notification.userInfo).userId == self._selectID then
    local nowmsg = #self._chatInfo
    local localChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetLocalChatRecord(self._selectID)
    local allChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetFriendChatRecord(self._selectID)
    for i = nowmsg - #localChatMessage + 1, #allChatMessage do
      (table.insert)(self._chatInfo, allChatMessage[i])
    end
    self:InsertCellsAtIndex({}, true, false)
    ;
    ((NekoData.DataManager).DM_FriendsChat):ResetNotReadNum((notification.userInfo).userId)
    ;
    ((NekoData.DataManager).DM_Friends):CheckFriendPageRedData()
    local userInfo = {}
    userInfo.userId = self._selectID
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_FriendNotReadNumChange, nil, userInfo)
  else
    do
      ;
      (self._listHelper):FireEvent("NewMsgReceive", (notification.userInfo).userId)
      if ((self._cellInfo)[1]):GetID() == (notification.userInfo).userId then
        return 
      end
      local userIndex = nil
      for index,friend in pairs(self._cellInfo) do
        if friend:GetID() == (notification.userInfo).userId then
          userIndex = index
          break
        end
      end
      do
        local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((notification.userInfo).userId)
        ;
        (table.remove)(self._cellInfo, userIndex)
        ;
        (self._listHelper):RemoveCellsAtIndex({userIndex}, false)
        ;
        (table.insert)(self._cellInfo, 1, friend)
        ;
        (self._listHelper):InsertCellsAtIndex({1}, false)
      end
    end
  end
end

FriendsListDialog.OnLocalChatReceive = function(self, notification)
  -- function num : 0_24 , upvalues : _ENV
  if notification.userInfo and (notification.userInfo).userId == self._selectID then
    self._receiveLocalTime = (ServerGameTimer.GetServerTimeForecast)()
    local nowmsg = #self._chatInfo
    local localChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetLocalChatRecord(self._selectID)
    local allChatMessage = ((NekoData.BehaviorManager).BM_FriendsChat):GetFriendChatRecord(self._selectID)
    local index = {}
    local num = #localChatMessage + #allChatMessage - nowmsg
    for i = num, 1, -1 do
      (table.insert)(index, num - i + 1)
      ;
      (table.insert)(self._chatInfo, 1, localChatMessage[i])
    end
    if self._requestNotReadLocalChat then
      self:InsertCellsAtIndex(index, false, false)
      self._requestNotReadLocalChat = nil
    else
      self:InsertCellsAtIndex(index, false, true)
    end
  end
end

FriendsListDialog.OnReadAllNewMsg = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if self._notReadNum < #self._chatInfo then
    LogWarningFormat(" OnReadAllNewMsg ", " _notReadNum:%s MoveTopToIndex:%s ", self._notReadNum, #self._chatInfo - self._notReadNum + 1)
    ;
    (self._rightListHelper):MoveTopToIndex(#self._chatInfo - self._notReadNum + 1)
  else
    ;
    ((NekoData.BehaviorManager).BM_FriendsChat):RequestLoadLocalMsg(self._selectID, self._localNotReadNum)
    self._requestNotReadLocalChat = true
  end
  self:HideNewMsgUI()
end

FriendsListDialog.HideNewMsgUI = function(self)
  -- function num : 0_26 , upvalues : _ENV
  (self._wndNewMsgback):SetActive(false)
  ;
  ((NekoData.BehaviorManager).BM_FriendsChat):ResetFirstNotReadMsgTime(self._selectID)
end

FriendsListDialog.InsertCellsAtIndex = function(self, index, isAnimate, movepos)
  -- function num : 0_27
  (self._rightListHelper):InsertCellsAtIndex(index, isAnimate, movepos)
end

FriendsListDialog.ShouldLengthChange = function(self, panel, index)
  -- function num : 0_28
  if panel == self._listHelper then
    return false
  end
  if panel == self._rightListHelper then
    return true
  end
end

FriendsListDialog.OnSendClicked = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local msg = (self._msgInputField):GetText()
  if #msg == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100031)
    return 
  end
  local wordCount = (utf8.len)(msg)
  if self._maxWordCount < wordCount then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100041, {self._maxWordCount})
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_FriendsChat):SendFriendChat(self._selectID, msg)
  ;
  (self._msgInputField):SetText("")
end

FriendsListDialog.OnLateUpdate = function(self, notification)
  -- function num : 0_30
  if self._needUpdate then
    if self._inputFieldTask then
      if (self._inputFieldTask):update((notification.userInfo).deltaTime) then
        (self._msgInputField):SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, self._inputFieldDes)
        self._inputFieldTask = nil
      else
        ;
        (self._msgInputField):SetSize(self._inputFieldSX, self._inputFieldSOX, self._inputFieldSY, ((self._inputFieldTask).subject).pos)
      end
    end
    if not self._inputFieldTask then
      self._needUpdate = false
    end
  end
end

FriendsListDialog.OnEmojiBtnClicked = function(self)
  -- function num : 0_31 , upvalues : _ENV, GridFrame
  if self._emojiFrame then
    (self._emojiFrame):Destroy()
    self._emojiFrame = nil
  else
    self._tabBtnData = ((NekoData.BehaviorManager).BM_Chat):GetShowEmojiTypes()
    ;
    (self._tabBtnFrame):ReloadAllCell()
    ;
    (self._tabBtnFrame):MoveToLeft()
    if not self._emojiType then
      self:OnEmojiTypeBtnClicked(1)
    else
      self._emojiData = ((NekoData.BehaviorManager).BM_Chat):GetEmojisByType(self._emojiType)
      self._emojiFrame = (GridFrame.Create)(self._emojiPanel, self, true, 6)
      ;
      (self._emojiFrame):ReloadAllCell()
      ;
      (self._emojiFrame):MoveToTop()
    end
  end
  ;
  (self._emojiArea):SetActive(self._emojiFrame)
end

FriendsListDialog.OnEmojiTypeBtnClicked = function(self, _type)
  -- function num : 0_32 , upvalues : _ENV, GridFrame
  if self._emojiType == _type then
    return 
  else
    self._emojiType = _type
    if self._emojiFrame then
      (self._emojiFrame):Destroy()
      self._emojiFrame = nil
    end
    self._emojiData = ((NekoData.BehaviorManager).BM_Chat):GetEmojisByType(self._emojiType)
    ;
    (self._tabBtnFrame):FireEvent("ChangedSelected", _type)
    self._emojiFrame = (GridFrame.Create)(self._emojiPanel, self, true, 6)
    ;
    (self._emojiFrame):ReloadAllCell()
    ;
    (self._emojiFrame):MoveToTop()
  end
end

FriendsListDialog.OnDialogClicked = function(self, args)
  -- function num : 0_33 , upvalues : _ENV
  if self._emojiFrame and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._emojiArea)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._emojiBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:HideEmojiFrame()
  end
end

FriendsListDialog.HideEmojiFrame = function(self)
  -- function num : 0_34
  (self._emojiFrame):Destroy()
  self._emojiFrame = nil
  ;
  (self._emojiArea):SetActive(false)
end

FriendsListDialog.OnFriendsLike = function(self, notification)
  -- function num : 0_35
  (self._listHelper):FireEvent("LikeFriends", (notification.userInfo).userId)
end

FriendsListDialog.OnFriendsShowPark = function(self, notification)
  -- function num : 0_36
  (self._listHelper):FireEvent("ShowPark", (notification.userInfo).userId)
end

FriendsListDialog.OnAllThumbsUpClicked = function(self)
  -- function num : 0_37 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clikefriends")
  protocol.userId = -1
  protocol:Send()
end

FriendsListDialog.OnCollectClicked = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.cchargefriendspoint")
  protocol:Send()
  ;
  (self._collectRedDot):SetActive(false)
  ;
  ((NekoData.DataManager).DM_Friends):OnReceiveFriendPoints()
end

FriendsListDialog.OnNotifyFriendsPoint = function(self)
  -- function num : 0_39
  (self._collectRedDot):SetActive(true)
end

return FriendsListDialog

