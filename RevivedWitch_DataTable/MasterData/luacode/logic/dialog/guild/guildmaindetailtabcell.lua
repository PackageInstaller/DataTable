-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmaindetailtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuildEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local MsgType = (LuaNetManager.GetBeanDef)("protocol.chat.msginfo")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SShieldFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.notify.sshieldfunction")
local GuildMainDetailTabCell = class("GuildMainDetailTabCell", Dialog)
GuildMainDetailTabCell.AssetBundleName = "ui/layouts.guild"
GuildMainDetailTabCell.AssetName = "GuildMainDetail"
local SetInputModel = function(self, flag)
  -- function num : 0_0 , upvalues : _ENV, SShieldFunctionDef
  (self._introInputText):SetInteractable(flag)
  ;
  (self._introChangeBtn):SetActive((not ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.CHANGEPARTYINTRODUCE) and not flag and ((NekoData.BehaviorManager).BM_Guild):GetPower_ChangeDeclaration()))
  ;
  (self._introChangeSubmit):SetActive(flag)
  ;
  (self._introChangeCancel):SetActive(flag)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildMainDetailTabCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildMainDetailTabCell
  ((GuildMainDetailTabCell.super).Ctor)(self, ...)
  self._guildId = 0
  self._chatData = {}
  self._selectReportContent = nil
end

GuildMainDetailTabCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV
  self._guildName = self:GetChild("DetailArea/Name")
  self._guildLogo = self:GetChild("DetailArea/Logo")
  self._guildIdText = self:GetChild("DetailArea/ID/IDNum")
  self._idCopyBtn = self:GetChild("DetailArea/CopyBtn")
  self._introInputText = self:GetChild("DetailArea/IntroductionBack/InputField")
  self._introChangeBtn = self:GetChild("DetailArea/ChangeBtn4")
  self._introChangeSubmit = self:GetChild("DetailArea/YesBtn")
  self._introChangeCancel = self:GetChild("DetailArea/NoBtn")
  self._chatPanel = self:GetChild("ChatArea/ChatFrame")
  self._chatScrollbar = self:GetChild("ChatArea/Scrollbar")
  self._chatSendBtn = self:GetChild("ChatArea/Down/SendBtn")
  self._chatInputField = self:GetChild("ChatArea/Down/InputField")
  self._emojiBtn = self:GetChild("ChatArea/Down/EmojiBtn")
  self._newMessageTip = self:GetChild("ChatArea/RecordsUpBtn")
  self._emojiArea = self:GetChild("ChatArea/EmojiArea")
  self._emojiPanel = self:GetChild("ChatArea/EmojiArea/Frame")
  self._emojiScrollbar = self:GetChild("ChatArea/EmojiArea/Scrollbar")
  self._chatFrame = (TableFrame.Create)(self._chatPanel, self, true, true, true)
  ;
  (self._guildLogo):Subscribe_PointerClickEvent(self.OnLogoClicked, self)
  ;
  (self._idCopyBtn):Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  ;
  (self._introChangeBtn):Subscribe_PointerClickEvent(self.OnIntroChangeBtnClicked, self)
  ;
  (self._introChangeSubmit):Subscribe_PointerClickEvent(self.OnIntroChangeSubmitClicked, self)
  ;
  (self._introChangeCancel):Subscribe_PointerClickEvent(self.OnIntroChangeCancelClicked, self)
  ;
  (self._chatSendBtn):Subscribe_PointerClickEvent(self.OnSendBtnClicked, self)
  ;
  (self._newMessageTip):Subscribe_PointerClickEvent(self.OnNewMessageTipClicked, self)
  ;
  (self._emojiBtn):Subscribe_PointerClickEvent(self.OnEmojiBtnClicked, self)
  ;
  (self._introInputText):Subscribe_ValueChangedEvent(self.OnIntroTextInputValueChanged, self)
  ;
  (self._chatInputField):Subscribe_ValueChangedEvent(self.OnChatTextInputValueChanged, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSModifyPartyDeclaration, Common.n_OnSModifyPartyDeclaration, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAddNewMsg, Common.n_OnAddNewMsg, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShieldFunction, Common.n_ShieldFunction, nil)
  self:OnShieldFunction()
  ;
  (UIBackManager.SetUIBackShow)(true)
end

GuildMainDetailTabCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (self._chatFrame):Destroy()
  if self._emojiFrame then
    (self._emojiFrame):Destroy()
  end
end

GuildMainDetailTabCell.RefreshCell = function(self)
  -- function num : 0_4 , upvalues : _ENV, CGuildEmoji, CGuildHead, CImagePath, SetInputModel
  self._userId = ((NekoData.BehaviorManager).BM_Game):GetUserId()
  local guildInfo = ((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()
  self._guildId = guildInfo.partyId
  ;
  (self._guildIdText):SetText(self._guildId)
  ;
  (self._guildName):SetText(guildInfo.partyName)
  ;
  (self._introInputText):SetInteractable(false)
  ;
  (self._introInputText):SetText(guildInfo.partyDeclaration)
  ;
  (self._newMessageTip):SetActive(false)
  self._chatData = ((NekoData.BehaviorManager).BM_Guild):GetGuildChatData()
  ;
  (self._chatFrame):ReloadAllCell()
  self._emojiData = CGuildEmoji:GetAllIds()
  local headPhotoRecord = CGuildHead:GetRecorder(guildInfo.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._guildLogo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      LogErrorFormat("GuildMainDetailTabCell", "GuildHeadID %s Cannot Find", tostring(guildInfo.avatarId))
      SetInputModel(self, false)
    end
  end
end

GuildMainDetailTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._chatFrame then
    return #self._chatData
  else
    return #self._emojiData
  end
end

GuildMainDetailTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : MsgType
  if frame == self._chatFrame then
    local msgInfo = ((self._chatData)[index]).data
    if msgInfo.msgType == MsgType.notify then
      return "guild.guildchatnoticecell"
    else
      if msgInfo.msgType == MsgType.chat then
        if #msgInfo.hyperlinks > 0 then
          if (msgInfo.baseUserData).userId == self._userId then
            return "guild.guildchatrightimagecell"
          else
            return "guild.guildchatleftimagecell"
          end
        else
          if (msgInfo.baseUserData).userId == self._userId then
            return "guild.guildchatrightcell"
          else
            return "guild.guildchatleftcell"
          end
        end
      end
    end
  else
    do
      do return "guild.guildchatemojicell" end
    end
  end
end

GuildMainDetailTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._chatFrame then
    return (self._chatData)[index]
  else
    return (self._emojiData)[index]
  end
end

GuildMainDetailTabCell.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

GuildMainDetailTabCell.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildMainDetailTabCell.OnCopyIDBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring(self._guildId))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

GuildMainDetailTabCell.OnIntroChangeBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV, CVarconfig, SetInputModel
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarconfig:GetRecorder(96)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100340)
    return 
  end
  SetInputModel(self, true)
end

GuildMainDetailTabCell.OnSModifyPartyDeclaration = function(self)
  -- function num : 0_12 , upvalues : SetInputModel, _ENV
  SetInputModel(self, false)
  ;
  (self._introInputText):SetText((((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()).partyDeclaration)
end

GuildMainDetailTabCell.OnIntroChangeSubmitClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, CVarconfig
  local limit = tonumber((CVarconfig:GetRecorder(76)).Value)
  if limit < (string.utf8len)((self._introInputText):GetText()) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cmodifypartydeclaration")
  if csend then
    csend.partyDeclaration = (self._introInputText):GetText()
    csend.partyId = self._guildId
    csend:Send()
  end
end

GuildMainDetailTabCell.OnIntroChangeCancelClicked = function(self)
  -- function num : 0_14 , upvalues : SetInputModel, _ENV
  SetInputModel(self, false)
  ;
  (self._introInputText):SetText((((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()).partyDeclaration)
end

GuildMainDetailTabCell.OnIntroTextInputValueChanged = function(self)
  -- function num : 0_15 , upvalues : _ENV, CVarconfig
  local str = (self._introInputText):GetText()
  local limit = tonumber((CVarconfig:GetRecorder(76)).Value)
  if limit < (string.utf8len)(str) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
  ;
  (self._introInputText):SetText(str)
end

GuildMainDetailTabCell.OnMemberBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = self._guildId
    csend:Send()
  end
end

GuildMainDetailTabCell.OnCheckBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckmemberapply")
  if csend then
    csend.partyId = self._guildId
    csend:Send()
  end
end

GuildMainDetailTabCell.OnSNotifyPosition = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV
  local data = notification.userInfo
  if data.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() and data.position == -1 then
    (self._delegate):Destroy()
    return 
  end
end

GuildMainDetailTabCell.OnAddNewMsg = function(self, notification)
  -- function num : 0_19
  local move = (self._chatScrollbar):GetScrollValue() == 1
  ;
  (self._chatFrame):InsertCellsAtIndex({#self._chatData}, true, move)
  if not move then
    (self._newMessageTip):SetActive(true)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildMainDetailTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_20
  if frame == self._chatFrame then
    if proportion == 0 then
      (self._newMessageTip):SetActive(false)
    end
    local width, height = (self._chatPanel):GetRectSize()
    local total = (self._chatFrame):GetTotalLength()
    if height < total then
      (self._chatScrollbar):SetActive(true)
      ;
      (self._chatScrollbar):SetScrollSize(height / total)
      ;
      (self._chatScrollbar):SetScrollValue(1 - proportion)
    else
      ;
      (self._chatScrollbar):SetActive(false)
    end
  else
    do
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

GuildMainDetailTabCell.OnSendBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV, CVarconfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarconfig:GetRecorder(95)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100339)
    return 
  end
  local msg = (self._chatInputField):GetText()
  local limit = tonumber((CVarconfig:GetRecorder(78)).Value)
  if #msg == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100031)
    return 
  end
  if limit < (string.utf8len)(msg) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.chat.csendpartymsg")
  if csend then
    csend.msg = msg
    csend.partyId = self._guildId
    csend:Send()
    ;
    (self._chatInputField):SetText("")
  end
end

GuildMainDetailTabCell.OnChatTextInputValueChanged = function(self)
  -- function num : 0_22 , upvalues : _ENV, CVarconfig
  local str = (self._chatInputField):GetText()
  local limit = tonumber((CVarconfig:GetRecorder(78)).Value)
  if limit < (string.utf8len)(str) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
end

GuildMainDetailTabCell.OnNewMessageTipClicked = function(self)
  -- function num : 0_23
  (self._chatFrame):MoveToBottom()
end

GuildMainDetailTabCell.OnEmojiBtnClicked = function(self)
  -- function num : 0_24 , upvalues : GridFrame
  if self._emojiFrame then
    (self._emojiFrame):Destroy()
    self._emojiFrame = nil
  else
    self._emojiFrame = (GridFrame.Create)(self._emojiPanel, self, true, 6)
    ;
    (self._emojiFrame):ReloadAllCell()
    ;
    (self._emojiFrame):MoveToTop()
  end
  ;
  (self._emojiArea):SetActive(self._emojiFrame)
end

GuildMainDetailTabCell.OnDialogClicked = function(self, args)
  -- function num : 0_25 , upvalues : _ENV
  if self._emojiFrame and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._emojiPanel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    (self._emojiFrame):Destroy()
    self._emojiFrame = nil
    ;
    (self._emojiArea):SetActive(false)
  end
end

GuildMainDetailTabCell.OnLogoClicked = function(self)
  -- function num : 0_26
end

GuildMainDetailTabCell.ShouldLengthChange = function(self, frame, index)
  -- function num : 0_27
  return true
end

GuildMainDetailTabCell.OnShieldFunction = function(self)
  -- function num : 0_28 , upvalues : _ENV, SShieldFunctionDef
  (self._introChangeBtn):SetActive(not ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.CHANGEPARTYINTRODUCE))
end

return GuildMainDetailTabCell

