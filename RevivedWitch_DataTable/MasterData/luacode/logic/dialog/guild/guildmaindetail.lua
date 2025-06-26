-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmaindetail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuildEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local CGuildActiveOpen = (BeanManager.GetTableByName)("guild.cguildactiveopen")
local CGuildAttribute = (BeanManager.GetTableByName)("guild.cguildattribute")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local MsgType = (LuaNetManager.GetBeanDef)("protocol.chat.msginfo")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SLightPartyRedpointProtocol = require("protocols.def.protocol.party.slightpartyredpoint")
local SShieldFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.notify.sshieldfunction")
local GuildMainDetail = class("GuildMainDetail", Dialog)
GuildMainDetail.AssetBundleName = "ui/layouts.guild"
GuildMainDetail.AssetName = "GuildMain"
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

GuildMainDetail.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildMainDetail
  ((GuildMainDetail.super).Ctor)(self, ...)
  self._guildId = 0
  self._chatData = {}
  self._selectReportContent = nil
  self._groupName = "Modal"
  self._tabBtnData = {}
end

GuildMainDetail.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._guildMainFrame = self:GetChild("GuildMainDetail")
  self._guildName = self:GetChild("GuildMainDetail/DetailArea/Name")
  self._guildLogo = self:GetChild("GuildMainDetail/DetailArea/Logo")
  self._guildIbtn = self:GetChild("GuildMainDetail/DetailArea/Logo/Ibtn")
  self._guildIdText = self:GetChild("GuildMainDetail/DetailArea/ID/IDNum")
  self._idCopyBtn = self:GetChild("GuildMainDetail/DetailArea/CopyBtn")
  self._introInputText = self:GetChild("GuildMainDetail/DetailArea/IntroductionBack/InputField")
  self._introChangeBtn = self:GetChild("GuildMainDetail/DetailArea/ChangeBtn4")
  self._introChangeSubmit = self:GetChild("GuildMainDetail/DetailArea/YesBtn")
  self._introChangeCancel = self:GetChild("GuildMainDetail/DetailArea/NoBtn")
  self._lv = self:GetChild("GuildMainDetail/DetailArea/Level/Level/LevelNum")
  self._exp = self:GetChild("GuildMainDetail/DetailArea/Level/EXPNum")
  self._expMax = self:GetChild("GuildMainDetail/DetailArea/Level/Max")
  self._expProgress = self:GetChild("GuildMainDetail/DetailArea/Level/ProgressLevel/BackGround/Progress")
  self._chatPanel = self:GetChild("GuildMainDetail/ChatArea/ChatFrame")
  self._chatScrollbar = self:GetChild("GuildMainDetail/ChatArea/Scrollbar")
  self._chatSendBtn = self:GetChild("GuildMainDetail/ChatArea/Down/SendBtn")
  self._chatInputField = self:GetChild("GuildMainDetail/ChatArea/Down/InputField")
  self._emojiBtn = self:GetChild("GuildMainDetail/ChatArea/Down/EmojiBtn")
  self._newMessageTip = self:GetChild("GuildMainDetail/ChatArea/RecordsUpBtn")
  self._emojiArea = self:GetChild("GuildMainDetail/ChatArea/EmojiArea")
  self._emojiAreaBack = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/Back")
  self._emojiPanel = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/Frame")
  self._emojiTypePanel = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/emoji_mark")
  self._rightBtn = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/emoji_mark/NextBtn")
  self._panel = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/emoji_mark/Frame")
  self._leftBtn = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/emoji_mark/BackBtn")
  self._emojiScrollbar = self:GetChild("GuildMainDetail/ChatArea/EmojiArea/Scrollbar")
  self._memberBtnForNoble = self:GetChild("GuildMainDetail/DetailArea/MessageBtn")
  self._memberBtnForCivilian = self:GetChild("GuildMainDetail/DetailArea/MessageBtnN")
  self._checkBtn = self:GetChild("GuildMainDetail/DetailArea/checkBtn")
  self._checkBtnReadPoint = self:GetChild("GuildMainDetail/DetailArea/checkBtn/Image")
  self._levelIbtn = self:GetChild("Ibtn")
  self._chatFrame = (TableFrame.Create)(self._chatPanel, self, true, true, true)
  self._guildActivityFrame = self:GetChild("ActivityFrame")
  ;
  (self._guildActivityFrame):SetActive(false)
  self._activityCell1 = self:GetChild("ActivityFrame/GuildActivityCell/Back")
  self._activityName = self:GetChild("ActivityFrame/GuildActivityCell/Back/Title")
  self._activityTime = self:GetChild("ActivityFrame/GuildActivityCell/Back/Time")
  self._activityIcon = self:GetChild("ActivityFrame/GuildActivityCell/Back/Item")
  self._activityCell1RedDot = self:GetChild("ActivityFrame/GuildActivityCell/RedDot")
  self._activityGuildBossCell = self:GetChild("ActivityFrame/GuildActivityCell2/Back")
  ;
  (self._activityGuildBossCell):Subscribe_PointerClickEvent(self.OnGuildActivityGuildBossClicked, self)
  self._activityGuildBossName = self:GetChild("ActivityFrame/GuildActivityCell2/Back/Title")
  self._activityGuildBossTime = self:GetChild("ActivityFrame/GuildActivityCell2/Back/Time")
  self._activityGuildBossIcon = self:GetChild("ActivityFrame/GuildActivityCell2/Back/Item")
  self._activityGuildBossRedDot = self:GetChild("ActivityFrame/GuildActivityCell2/RedDot")
  self._chatBtn = self:GetChild("ChatBtn")
  ;
  (self._chatBtn):SetSelected(true)
  self._activityBtn = self:GetChild("ActivityBtn")
  self._activityRedDot = self:GetChild("ActivityBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._shopBtnLv = self:GetChild("ShopBtn/Level/LevelNum")
  ;
  (self._activityCell1):Subscribe_PointerClickEvent(self.OnGuildActivityCell1Clicked, self)
  ;
  (self._chatBtn):Subscribe_PointerClickEvent(self.OnChatBtnClicked, self)
  ;
  (self._activityBtn):Subscribe_PointerClickEvent(self.OnActivityBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
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
  (self._checkBtn):Subscribe_PointerClickEvent(self.OnCheckBtnClick, self)
  ;
  (self._memberBtnForNoble):Subscribe_PointerClickEvent(self.OnMemberBtnClick, self)
  ;
  (self._memberBtnForCivilian):Subscribe_PointerClickEvent(self.OnMemberBtnClick, self)
  ;
  (self._levelIbtn):Subscribe_PointerClickEvent(self.OnGuildIBtnClick, self)
  ;
  (self._guildIbtn):Subscribe_PointerClickEvent(self.OnLevelIBtnClick, self)
  ;
  (self._introInputText):Subscribe_ValueChangedEvent(self.OnIntroTextInputValueChanged, self)
  ;
  (self._chatInputField):Subscribe_ValueChangedEvent(self.OnChatTextInputValueChanged, self)
  self._levelUpCountDown = self:GetChild("GuildMainDetail/ChatArea/Waitingup")
  self._levelUpCountDownTime = self:GetChild("GuildMainDetail/ChatArea/Waitingup/Uptime")
  self._missionFinishImage = self:GetChild("GuildMainDetail/DetailArea/Everyday/Image")
  self._jumpMissionBtn = self:GetChild("GuildMainDetail/DetailArea/Everyday/MenuBtn")
  ;
  (self._jumpMissionBtn):Subscribe_PointerClickEvent(self.OnjumpMissionBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_NoTargetWindowClick, nil)
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
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshGuildExp, Common.n_SPartyDonate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActiveRedIcon, Common.n_OnSLightPartyRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActiveRedIcon, Common.n_ClientSetGuildRedpoint, nil)
  self:OnShieldFunction()
  ;
  (UIBackManager.SetUIBackShow)(true)
end

GuildMainDetail.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if self._tabBtnFrame then
    (self._tabBtnFrame):Destroy()
  end
  if self._chatFrame then
    (self._chatFrame):Destroy()
  end
  if self._emojiFrame then
    (self._emojiFrame):Destroy()
  end
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  ((NekoData.DataManager).DM_Guild):ClearUnReadMessageCount()
end

GuildMainDetail.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV, CGuildAttribute, CGuildHead, CImagePath, SLightPartyRedpointProtocol, SetInputModel, TableFrame
  self._userId = ((NekoData.BehaviorManager).BM_Game):GetUserId()
  local guildInfo = ((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()
  self._levelUpTime = guildInfo.levelUpTime // 1000
  self._guildId = guildInfo.partyId
  ;
  (self._guildIdText):SetText(self._guildId)
  ;
  (self._guildName):SetText(guildInfo.partyName)
  ;
  (self._lv):SetText(guildInfo.partyLv)
  local recorder = CGuildAttribute:GetRecorder(guildInfo.partyLv)
  ;
  (self._shopBtnLv):SetText(recorder.shoplevel)
  ;
  (self._exp):SetText(guildInfo.partyExp .. "/" .. guildInfo.partyExpMax)
  local maxLevel = ((NekoData.BehaviorManager).BM_Guild):GetGuildMaxLevel()
  ;
  (self._expMax):SetActive(maxLevel == guildInfo.partyLv and guildInfo.partyExp == guildInfo.partyExpMax)
  ;
  (self._exp):SetActive(maxLevel ~= guildInfo.partyLv or guildInfo.partyExp ~= guildInfo.partyExpMax)
  ;
  (self._expProgress):SetFillAmount(guildInfo.partyExp / guildInfo.partyExpMax)
  local waitForUpdata = guildInfo.partyExpMax <= guildInfo.partyExp and maxLevel ~= guildInfo.partyLv
  ;
  (self._levelUpCountDown):SetActive(waitForUpdata)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if waitForUpdata then
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:CountDown()
  end
, nil)
  end
  local daliyTaskProgress = (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current
  ;
  (self._missionFinishImage):SetActive(daliyTaskProgress >= 100)
  ;
  (self._jumpMissionBtn):SetActive(daliyTaskProgress < 100)
  ;
  (self._introInputText):SetInteractable(false)
  local intro = nil
  if guildInfo.partyDeclaration and #guildInfo.partyDeclaration > 0 then
    intro = guildInfo.partyDeclaration
  else
    intro = ((NekoData.BehaviorManager).BM_Message):GetString(1518)
  end
  ;
  (self._introInputText):SetText(intro)
  ;
  (self._newMessageTip):SetActive(false)
  self._chatData = ((NekoData.BehaviorManager).BM_Guild):GetGuildChatData()
  ;
  (self._chatFrame):ReloadAllCell()
  local headPhotoRecord = CGuildHead:GetRecorder(guildInfo.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._guildLogo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildMainDetail", "GuildHeadID %s Cannot Find", tostring(guildInfo.avatarId))
  end
  self._baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  ;
  (self._memberBtnForNoble):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_MembersReview())
  ;
  (self._memberBtnForCivilian):SetActive(not ((NekoData.BehaviorManager).BM_Guild):GetPower_MembersReview())
  ;
  (self._checkBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_MembersReview())
  ;
  (self._checkBtnReadPoint):SetActive(((NekoData.BehaviorManager).BM_Guild):IsActivityRedDotOnByType(SLightPartyRedpointProtocol.PARTY_APPLY))
  SetInputModel(self, false)
  ;
  ((NekoData.DataManager).DM_Guild):ClearUnReadMessageCount()
  ;
  ((NekoData.DataManager).DM_Guild):ClientCancelRedpoint()
  local isActivityRedDot = ((NekoData.BehaviorManager).BM_Guild):HasActivityRedDotOn()
  if (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag and (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag > 0 then
    isActivityRedDot = true
  end
  ;
  (self._activityRedDot):SetActive(isActivityRedDot)
  ;
  (self._activityCell1RedDot):SetActive(((NekoData.BehaviorManager).BM_Guild):IsActivityRedDotOnByType(SLightPartyRedpointProtocol.PARTY_DONATE))
  self._tabBtnFrame = (TableFrame.Create)(self._panel, self, false, false, false)
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

GuildMainDetail.RefreshActiveRedIcon = function(self)
  -- function num : 0_5 , upvalues : _ENV, SLightPartyRedpointProtocol
  local isActivityRedDot = ((NekoData.BehaviorManager).BM_Guild):HasActivityRedDotOn()
  if (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag and (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag > 0 then
    isActivityRedDot = true
  end
  ;
  (self._activityRedDot):SetActive(isActivityRedDot)
  ;
  (self._activityCell1RedDot):SetActive(((NekoData.BehaviorManager).BM_Guild):IsActivityRedDotOnByType(SLightPartyRedpointProtocol.PARTY_DONATE))
  ;
  (self._checkBtnReadPoint):SetActive(((NekoData.BehaviorManager).BM_Guild):IsActivityRedDotOnByType(SLightPartyRedpointProtocol.PARTY_APPLY))
end

GuildMainDetail.RefreshGuildExp = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local guildInfo = ((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()
  self._levelUpTime = guildInfo.levelUpTime // 1000
  ;
  (self._exp):SetText(guildInfo.partyExp .. "/" .. guildInfo.partyExpMax)
  local maxLevel = ((NekoData.BehaviorManager).BM_Guild):GetGuildMaxLevel()
  ;
  (self._exp):SetActive(maxLevel ~= guildInfo.partyLv or guildInfo.partyExp ~= guildInfo.partyExpMax)
  ;
  (self._expMax):SetActive(maxLevel == guildInfo.partyLv and guildInfo.partyExp == guildInfo.partyExpMax)
  local waitForUpdata = guildInfo.partyExpMax <= guildInfo.partyExp and maxLevel ~= guildInfo.partyLv
  ;
  (self._levelUpCountDown):SetActive(waitForUpdata)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if waitForUpdata then
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_6_0 , upvalues : self
    self:CountDown()
  end
, nil)
  end
  local daliyTaskProgress = (((NekoData.BehaviorManager).BM_Task):GetActiveInfo()).current
  ;
  (self._missionFinishImage):SetActive(daliyTaskProgress >= 100)
  ;
  (self._jumpMissionBtn):SetActive(daliyTaskProgress < 100)
  ;
  (self._expProgress):SetFillAmount(guildInfo.partyExp / guildInfo.partyExpMax)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

local GetTimeStr = function(sec)
  -- function num : 0_7 , upvalues : _ENV
  local h = sec // 3600
  sec = sec - h * 3600
  local m = (sec) // 60
  sec = sec - m * 60
  local s = sec
  return (string.format)("%02d:%02d:%02d", h, m, s)
end

GuildMainDetail.CountDown = function(self)
  -- function num : 0_8 , upvalues : _ENV, GetTimeStr
  self._levelUpTime = self._levelUpTime - 1
  if self._levelUpTime < 0 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.copenparty")
    if csend then
      csend:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  else
    do
      ;
      (self._levelUpCountDownTime):SetText(GetTimeStr(self._levelUpTime))
    end
  end
end

GuildMainDetail.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._chatFrame then
    return #self._chatData
  else
    if frame == self._tabBtnFrame then
      return #self._tabBtnData
    else
      return #self._emojiData
    end
  end
end

GuildMainDetail.CellAtIndex = function(self, frame, index)
  -- function num : 0_10 , upvalues : MsgType
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
      if frame == self._tabBtnFrame then
        return "guild.emojibtncell"
      else
        return "guild.guildchatemojicell"
      end
    end
  end
end

GuildMainDetail.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._chatFrame then
    return (self._chatData)[index]
  else
    if frame == self._tabBtnFrame then
      return (self._tabBtnData)[index]
    else
      return (self._emojiData)[index]
    end
  end
end

GuildMainDetail.OnBackBtnClicked = function(self)
  -- function num : 0_12
  self:Destroy()
end

GuildMainDetail.OnMenuBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildMainDetail.OnCopyIDBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring(self._guildId))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

GuildMainDetail.OnIntroChangeBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV, CVarconfig, SetInputModel
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarconfig:GetRecorder(96)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100340)
    return 
  end
  SetInputModel(self, true)
end

GuildMainDetail.OnSModifyPartyDeclaration = function(self)
  -- function num : 0_16 , upvalues : SetInputModel, _ENV
  SetInputModel(self, false)
  ;
  (((NekoData.BehaviorManager).BM_Guild):GetGuildInfo())
  local guildInfo = nil
  local intro = nil
  if guildInfo.partyDeclaration and #guildInfo.partyDeclaration > 0 then
    intro = guildInfo.partyDeclaration
  else
    intro = ((NekoData.BehaviorManager).BM_Message):GetString(1518)
  end
  ;
  (self._introInputText):SetText(intro)
end

GuildMainDetail.OnIntroChangeSubmitClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV, CVarconfig
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

GuildMainDetail.OnIntroChangeCancelClicked = function(self)
  -- function num : 0_18 , upvalues : SetInputModel, _ENV
  SetInputModel(self, false)
  ;
  (((NekoData.BehaviorManager).BM_Guild):GetGuildInfo())
  local guildInfo = nil
  local intro = nil
  if guildInfo.partyDeclaration and #guildInfo.partyDeclaration > 0 then
    intro = guildInfo.partyDeclaration
  else
    intro = ((NekoData.BehaviorManager).BM_Message):GetString(1518)
  end
  ;
  (self._introInputText):SetText(intro)
end

GuildMainDetail.OnIntroTextInputValueChanged = function(self)
  -- function num : 0_19 , upvalues : _ENV, CVarconfig
  local str = (self._introInputText):GetText()
  local limit = tonumber((CVarconfig:GetRecorder(76)).Value)
  if limit < (string.utf8len)(str) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
  ;
  (self._introInputText):SetText(str)
end

GuildMainDetail.OnMemberBtnClick = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildMainDetail.OnCheckBtnClick = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckmemberapply")
  if csend then
    csend.partyId = self._guildId
    csend:Send()
  end
end

GuildMainDetail.OnSNotifyPosition = function(self, notification)
  -- function num : 0_22 , upvalues : _ENV
  local data = notification.userInfo
  if data.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() and data.position == -1 then
    self:Destroy()
    return 
  end
end

GuildMainDetail.OnAddNewMsg = function(self, notification)
  -- function num : 0_23
  local move = (self._chatScrollbar):GetScrollValue() == 1
  ;
  (self._chatFrame):InsertCellsAtIndex({#self._chatData}, true, move)
  if not move then
    (self._newMessageTip):SetActive(true)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildMainDetail.OnLevelIBtnClick = function(self)
  -- function num : 0_24 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("guild.guildupgradetips")
end

GuildMainDetail.OnGuildIBtnClick = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("guild.guildtips")
end

GuildMainDetail.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_26
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

GuildMainDetail.OnSendBtnClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV, CVarconfig
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

GuildMainDetail.OnChatTextInputValueChanged = function(self)
  -- function num : 0_28 , upvalues : _ENV, CVarconfig
  local str = (self._chatInputField):GetText()
  local limit = tonumber((CVarconfig:GetRecorder(78)).Value)
  if limit < (string.utf8len)(str) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
end

GuildMainDetail.OnNewMessageTipClicked = function(self)
  -- function num : 0_29
  (self._chatFrame):MoveToBottom()
end

GuildMainDetail.OnEmojiBtnClicked = function(self)
  -- function num : 0_30 , upvalues : _ENV, GridFrame
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

GuildMainDetail.OnDialogClicked = function(self, args)
  -- function num : 0_31 , upvalues : _ENV
  if self._emojiFrame and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._emojiArea)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._emojiBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:HideEmojiFrame()
  end
end

GuildMainDetail.HideEmojiFrame = function(self)
  -- function num : 0_32
  (self._emojiFrame):Destroy()
  self._emojiFrame = nil
  ;
  (self._emojiArea):SetActive(false)
end

GuildMainDetail.OnLogoClicked = function(self)
  -- function num : 0_33
end

GuildMainDetail.ShouldLengthChange = function(self, frame, index)
  -- function num : 0_34
  return true
end

GuildMainDetail.OnShieldFunction = function(self)
  -- function num : 0_35 , upvalues : _ENV, SShieldFunctionDef
  (self._introChangeBtn):SetActive(not ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.CHANGEPARTYINTRODUCE))
end

GuildMainDetail.AddNewModal = function(self, dialog)
  -- function num : 0_36
  if dialog._dialogName ~= "guild.guildcheckdialog" and dialog._dialogName ~= "guild.guildmainmember" then
    (self:GetRootWindow()):SetActive(false)
  end
end

GuildMainDetail.OnDialogDestroy = function(self, notification)
  -- function num : 0_37
  if (notification.userInfo)._dialogName == "friend.charactershowdialog" then
    (self._rootWindow):SetActive(true)
  end
end

GuildMainDetail.OnGuildActivityCell1Clicked = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cshowpartydonateprocess")
  csend:Send()
end

GuildMainDetail.OnGuildActivityGuildBossClicked = function(self)
  -- function num : 0_39 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.boss.copenpartybosspanel")
  csend:Send()
  if (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag and (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag > 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_ClientSetGuildRedpoint, nil, nil)
  end
end

GuildMainDetail.OnChatBtnClicked = function(self)
  -- function num : 0_40
  (self._guildMainFrame):SetActive(true)
  ;
  (self._guildActivityFrame):SetActive(false)
  ;
  (self._chatBtn):SetSelected(true)
  ;
  (self._activityBtn):SetSelected(false)
end

GuildMainDetail.OnActivityBtnClicked = function(self)
  -- function num : 0_41 , upvalues : CGuildActiveOpen, CImagePath, _ENV, CStringres
  if not self._activityInit then
    self._activityInit = true
    local recorder = CGuildActiveOpen:GetRecorder(1)
    if not CImagePath:GetRecorder(recorder.ActiveImage) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._activityIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._activityName):SetText((TextManager.GetText)(recorder.ActiveName))
    ;
    (self._activityTime):SetText((TextManager.GetText)(recorder.Activetime))
    ;
    (self._activityGuildBossName):SetText((TextManager.GetText)((CStringres:GetRecorder(2249)).msgTextID))
    ;
    (self._activityGuildBossTime):SetText((TextManager.GetText)((CStringres:GetRecorder(2250)).msgTextID))
  end
  do
    ;
    (self._guildMainFrame):SetActive(false)
    ;
    (self._guildActivityFrame):SetActive(true)
    ;
    (self._chatBtn):SetSelected(false)
    ;
    (self._activityBtn):SetSelected(true)
    if (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag and (((NekoData.BehaviorManager).BM_Guild):GetGuildBossRed()).flag > 0 then
      (self._activityGuildBossRedDot):SetActive(true)
    else
      ;
      (self._activityGuildBossRedDot):SetActive(false)
    end
  end
end

GuildMainDetail.OnShopBtnClicked = function(self)
  -- function num : 0_42 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(24)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

GuildMainDetail.OnjumpMissionBtnClick = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local dlg = (DialogManager.CreateSingletonDialog)("task.taskmaindialog")
  if dlg then
    dlg:ToPage(2)
  end
end

GuildMainDetail.OnEmojiTypeBtnClicked = function(self, _type)
  -- function num : 0_44 , upvalues : _ENV, GridFrame
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

return GuildMainDetail

