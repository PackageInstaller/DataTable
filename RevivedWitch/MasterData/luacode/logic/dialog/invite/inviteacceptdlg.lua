-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteacceptdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CInviteeRewards = (BeanManager.GetTableByName)("activity.cinviteerewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InviteAcceptDlg = class("InviteAcceptDlg", Dialog)
InviteAcceptDlg.AssetBundleName = "ui/layouts.invite"
InviteAcceptDlg.AssetName = "BeInvited"
InviteAcceptDlg.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InviteAcceptDlg
  ((InviteAcceptDlg.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

InviteAcceptDlg.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemGet = self:GetChild("Back/ItemGet")
  ;
  (self._itemGet):SetActive(false)
  self._itemCell = self:GetChild("Back/ItemCell")
  self._tipBtn = self:GetChild("Back/Ibtn")
  self._inviteCode = self:GetChild("InputField")
  self._useBtn = self:GetChild("UseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.ShowTip, self)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._useBtn):Subscribe_PointerClickEvent(self.UseCode, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Update, Common.n_RefreshUseInvite, nil)
  self:SetData()
end

InviteAcceptDlg.SetData = function(self)
  -- function num : 0_2 , upvalues : CInviteeRewards, Item, InviteUtil
  local record = CInviteeRewards:GetRecorder(1)
  self._item = (Item.Create)((record.itemID)[1])
  ;
  (InviteUtil.SetItemInfo)(self._itemCell, {item = self._item, num = (record.itemAmount)[1]})
end

InviteAcceptDlg.Update = function(self, protocol)
  -- function num : 0_3
  (self._useBtn):SetInteractable(false)
  ;
  (self._itemGet):SetActive(true)
end

InviteAcceptDlg.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

InviteAcceptDlg.ShowTip = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("invite.invitetipsdlg")
end

InviteAcceptDlg.OnItemCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

InviteAcceptDlg.UseCode = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local code = (self._inviteCode):GetText()
  warn("code: ", code)
  code = (string.trim)(code)
  if not code or code == "" then
    return 
  end
  local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.cuseinvitationcode")
  cmd.invitationCode = code
  cmd:Send()
end

return InviteAcceptDlg

