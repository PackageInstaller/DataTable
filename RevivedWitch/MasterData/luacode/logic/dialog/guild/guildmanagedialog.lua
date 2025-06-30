-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmanagedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local JobEnum = (LuaNetManager.GetBeanDef)("protocol.party.memberinfo")
local OtherUserInfo = (LuaNetManager.GetBeanDef)("protocol.chat.otheruserinfo")
local GuildManageDialog = class("GuildManageDialog", Dialog)
GuildManageDialog.AssetBundleName = "ui/layouts.guild"
GuildManageDialog.AssetName = "GuildManage"
GuildManageDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildManageDialog
  ((GuildManageDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

GuildManageDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_PointerDownEvent(nil, self)
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/Member/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/Member/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/Member/LvBack/Level")
  self._name = self:GetChild("Back/Member/NameBack/Name")
  self._jobBack = self:GetChild("Back/Member/Level")
  self._jobText = self:GetChild("Back/Member/Level/Num")
  ;
  (self._photoFrame):Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
  self._informationBtn = self:GetChild("Back/Btn1")
  self._addFriendBtn = self:GetChild("Back/Btn2")
  self._blacklistBtn = self:GetChild("Back/Btn3")
  self._blacklistBtnText = self:GetChild("Back/Btn3/_Text")
  self._removeMemberBtn = self:GetChild("Back/Btn4")
  self._reportBtn = self:GetChild("Back/Btn5")
  self._surplusCount_VicePresident = self:GetChild("ManageBack/Num1/Text")
  self._surplusCount_Elite = self:GetChild("ManageBack/Num2/Num")
  self._maxCount_VicePresident = self:GetChild("ManageBack/Num1/NumMax")
  self._maxCount_Elite = self:GetChild("ManageBack/Num2/NumMax")
  self._turnPresidentBtn = self:GetChild("ManageBack/Btn1")
  self._appointVicePresidentBtn = self:GetChild("ManageBack/Btn2")
  self._appointEliteBtn = self:GetChild("ManageBack/Btn3")
  self._appointCommonMemberBtn = self:GetChild("ManageBack/Btn4")
  self._manageBack = self:GetChild("ManageBack")
  ;
  (self._turnPresidentBtn):Subscribe_PointerClickEvent(self.OnTurnPresidentBtnClick, self)
  ;
  (self._appointVicePresidentBtn):Subscribe_PointerClickEvent(self.OnAppointVicePresidentBtnClick, self)
  ;
  (self._appointEliteBtn):Subscribe_PointerClickEvent(self.OnAppointEliteBtnClick, self)
  ;
  (self._appointCommonMemberBtn):Subscribe_PointerClickEvent(self.OnAppointCommonMemberBtnClick, self)
  ;
  (self._informationBtn):Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
  ;
  (self._addFriendBtn):Subscribe_PointerClickEvent(self.OnAddFriendClicked, self)
  ;
  (self._blacklistBtn):Subscribe_PointerClickEvent(self.OnBlacklistBtnClicked, self)
  ;
  (self._removeMemberBtn):Subscribe_PointerClickEvent(self.OnRemoveMemberBtnClick, self)
  ;
  (self._reportBtn):Subscribe_PointerClickEvent(self.OnReportClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSCheckPositionRemain, Common.n_OnSCheckPositionRemain, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSRefreshOtherUserIdentity, Common.n_OnSRefreshOtherUserIdentity, nil)
end

GuildManageDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildManageDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : OtherUserInfo, HeadPhotoTable, CImagePath, _ENV, HeadPhotoFrameTable
  (self._manageBack):SetActive(false)
  self:ShowJobCount()
  self._userId = data.userId
  self._job = data.position
  self._nameStr = data.username
  self._isBlackList = data.identity == OtherUserInfo.BLACK_LIST
  self:SetBlackListBtnState()
  local imageRecord = nil
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildManageDialog", "userInfo.avatarId %s is wrong", data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.frameId)
  if headPhotoFrameRecord then
    if not CImagePath:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildManageDialog", "userInfo.frameId %s is wrong", data.frameId)
  end
  ;
  (self._lv):SetText(data.userLevel)
  ;
  (self._name):SetText(self._nameStr)
  local jobstr = ((NekoData.BehaviorManager).BM_Guild):GetJobStr(data.position)
  ;
  (self._jobText):SetText(jobstr)
  ;
  (self._removeMemberBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_RemoveMembers())
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

GuildManageDialog.SetBlackListBtnState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local str = nil
  if self._isBlackList then
    str = (TextManager.GetText)(701027)
    ;
    (self._blacklistBtnText):SetText(str)
  else
    str = (TextManager.GetText)(701028)
    ;
    (self._blacklistBtnText):SetText(str)
  end
end

GuildManageDialog.ShowJobCount = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guild):GetPower_ChangePresident() then
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpositionremain")
    if csend then
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend:Send()
    end
  end
end

GuildManageDialog.OnSCheckPositionRemain = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, JobEnum
  (self._manageBack):SetActive(true)
  local data = notification.userInfo
  self._vicePresidentRemainder = ((NekoData.BehaviorManager).BM_Guild):GetVicePresidentLimitCount() - data[JobEnum.VICE_PRESIDENT]
  self._eliteRemainder = ((NekoData.BehaviorManager).BM_Guild):GetEliteTLimitCount() - data[JobEnum.CREAM]
  ;
  (self._surplusCount_VicePresident):SetText((math.max)(self._vicePresidentRemainder, 0))
  ;
  (self._surplusCount_Elite):SetText((math.max)(self._eliteRemainder, 0))
  ;
  (self._maxCount_VicePresident):SetText(((NekoData.BehaviorManager).BM_Guild):GetVicePresidentLimitCount())
  ;
  (self._maxCount_Elite):SetText(((NekoData.BehaviorManager).BM_Guild):GetEliteTLimitCount())
end

GuildManageDialog.OnSNotifyPosition = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local data = notification.userInfo
  if data.userId == self._userId then
    if data.position == -1 then
      self:Destroy()
      return 
    end
    self._job = data.position
    local jobstr = ((NekoData.BehaviorManager).BM_Guild):GetJobStr(data.position)
    ;
    (self._jobText):SetText(jobstr)
  end
end

GuildManageDialog.OnTurnPresidentBtnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_ChangePresident() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100287, nil)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(107, {self._nameStr}, function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cturnpresident")
    if csend then
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.userId = self._userId
      csend:Send()
    end
  end
)
end

GuildManageDialog.OnAppointVicePresidentBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV, JobEnum
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_AppointVicePresident() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100287, nil)
    return 
  end
  if self._job == JobEnum.VICE_PRESIDENT then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100299, nil)
    return 
  end
  if self._vicePresidentRemainder == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100309, nil)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cappointvicepresident")
  if csend then
    local operate = 1
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend.userId = self._userId
    csend.operate = operate
    csend:Send()
  end
end

GuildManageDialog.OnAppointEliteBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV, JobEnum
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_AppointElite() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100287, nil)
    return 
  end
  if self._job == JobEnum.CREAM then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100299, nil)
    return 
  end
  if self._eliteRemainder == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100309, nil)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cappointcream")
  if csend then
    local operate = 1
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend.userId = self._userId
    csend.operate = operate
    csend:Send()
  end
end

GuildManageDialog.OnAppointCommonMemberBtnClick = function(self)
  -- function num : 0_11 , upvalues : JobEnum, _ENV
  if self._job == JobEnum.VICE_PRESIDENT then
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cappointvicepresident")
    if csend then
      local operate = 0
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.userId = self._userId
      csend.operate = operate
      csend:Send()
    end
  else
    do
      if self._job == JobEnum.CREAM then
        local csend = (LuaNetManager.CreateProtocol)("protocol.party.cappointcream")
        if csend then
          local operate = 0
          csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
          csend.userId = self._userId
          csend.operate = operate
          csend:Send()
        end
      else
        do
          if self._job == JobEnum.MEMBER then
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100299, nil)
            return 
          else
            if self._job == JobEnum.PRESIDENT then
              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100287, nil)
              return 
            end
          end
        end
      end
    end
  end
end

GuildManageDialog.OnRemoveMemberBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_RemoveMembers() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100287, nil)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(103, nil, function()
    -- function num : 0_12_0 , upvalues : _ENV, self
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cremovemember")
    if csend then
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.userId = self._userId
      csend:Send()
    end
  end
)
end

GuildManageDialog.OnDialogClicked = function(self, args)
  -- function num : 0_13 , upvalues : _ENV
  if (self._manageBack):IsActive() and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._manageBack)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
  if not ((((CS.PixelNeko).UI).UIManager).RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

GuildManageDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

GuildManageDialog.OnPhotoClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = self._userId
  protocol:Send()
  self:Destroy()
end

GuildManageDialog.OnAddFriendClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(self._userId)
end

GuildManageDialog.OnBlacklistBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if not self._isBlackList then
    ((NekoData.BehaviorManager).BM_Friends):RequesBlackFriend(self._userId)
  else
    ;
    ((NekoData.BehaviorManager).BM_Friends):RequesRecoverBlackFriend(self._userId)
  end
end

GuildManageDialog.OnSRefreshOtherUserIdentity = function(self, notification)
  -- function num : 0_18 , upvalues : OtherUserInfo
  if (notification.userInfo).newIdentity ~= OtherUserInfo.BLACK_LIST then
    self._isBlackList = (notification.userInfo).userid ~= self._userId
    self:SetBlackListBtnState()
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

GuildManageDialog.OnReportClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local data = {reportid = self._userId, nickname = self._nameStr}
  ;
  ((DialogManager.CreateSingletonDialog)("report.reportplayerdialog")):SetData(data)
  self:Destroy()
end

return GuildManageDialog

