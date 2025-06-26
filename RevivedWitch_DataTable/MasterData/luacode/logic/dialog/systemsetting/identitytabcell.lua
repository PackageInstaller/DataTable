-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/identitytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IdentityTabCell = class("IdentityTabCell", Dialog)
IdentityTabCell.AssetBundleName = "ui/layouts.setting"
IdentityTabCell.AssetName = "SettingIdentity"
IdentityTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : IdentityTabCell
  ((IdentityTabCell.super).Ctor)(self, ...)
end

IdentityTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._phoneBindBtn = self:GetChild("Phone/Btn")
  self._phoneBindBefore = self:GetChild("Phone/Before")
  self._phoneBindAfter = self:GetChild("Phone/After")
  self._phoneBindAfterTxt = self:GetChild("Phone/After/Txt")
  self._mailboxBindBtn = self:GetChild("Mail/Btn")
  self._mailboxBindBefore = self:GetChild("Mail/Before")
  self._mailboxBindAfter = self:GetChild("Mail/After")
  self._mailboxBindAfterTxt = self:GetChild("Mail/After/Txt")
  self._service = self:GetChild("Service")
  ;
  (self._service):SetActive(false)
  if (SdkManager.GetChannel)() == "leit" then
    if ((SdkManager.GetAgent)()):IsChannelPackage() then
      local phoneBindAnchoredx, phoneBindAnchoredy = (self:GetChild("Phone")):GetAnchoredPosition()
      ;
      (self:GetChild("Phone")):SetActive(false)
      ;
      (self:GetChild("Mail")):SetActive(false)
      ;
      (self:GetChild("Number")):SetAnchoredPosition(phoneBindAnchoredx, phoneBindAnchoredy)
    else
      do
        ;
        (self._service):SetActive(true)
        ;
        (self:GetChild("Service/Btn")):Subscribe_PointerClickEvent(self.OnServiceClick, self)
        self._code = self:GetChild("Number/Btn")
        ;
        (self._code):Subscribe_PointerClickEvent(self.OnCodeBtnClicked, self)
        ;
        (self._phoneBindBtn):Subscribe_PointerClickEvent(self.OnPhoneBindBtnClicked, self)
        ;
        (self._mailboxBindBtn):Subscribe_PointerClickEvent(self.OnMailboxBindBtnClicked, self)
        self:RefreshTabCell()
      end
    end
  end
end

IdentityTabCell.OnDestroy = function(self)
  -- function num : 0_2
end

IdentityTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  if userInfo.phoneNum == "" then
    (self._phoneBindBefore):SetActive(true)
    ;
    (self._phoneBindAfter):SetActive(false)
    ;
    (self._phoneBindBtn):SetActive(true)
  else
    ;
    (self._phoneBindBefore):SetActive(false)
    ;
    (self._phoneBindAfter):SetActive(true)
    ;
    (self._phoneBindBtn):SetActive(false)
    ;
    (self._phoneBindAfterTxt):SetText(userInfo.phoneNum)
  end
  if userInfo.mailAddr == "" then
    (self._mailboxBindBefore):SetActive(true)
    ;
    (self._mailboxBindAfter):SetActive(false)
    ;
    (self._mailboxBindBtn):SetActive(true)
  else
    ;
    (self._mailboxBindBefore):SetActive(false)
    ;
    (self._mailboxBindAfter):SetActive(true)
    ;
    (self._mailboxBindBtn):SetActive(false)
    ;
    (self._mailboxBindAfterTxt):SetText(userInfo.mailAddr)
  end
end

IdentityTabCell.OnPhoneBindBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local crefreshphonecdtime = (LuaNetManager.CreateProtocol)("protocol.user.crefreshphonecdtime")
  if crefreshphonecdtime then
    crefreshphonecdtime:Send()
  end
  ;
  (DialogManager.CreateSingletonDialog)("systemsetting.phonebinddialog")
end

IdentityTabCell.OnMailboxBindBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local crefreshmailcdtime = (LuaNetManager.CreateProtocol)("protocol.user.crefreshmailcdtime")
  if crefreshmailcdtime then
    crefreshmailcdtime:Send()
  end
  ;
  (DialogManager.CreateSingletonDialog)("systemsetting.mailboxbinddialog")
end

IdentityTabCell.OnCodeBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.code.codedialog")
end

IdentityTabCell.OnServiceClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((SdkManager.GetAgent)()):ShowCustomerService("")
end

return IdentityTabCell

