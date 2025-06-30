-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteothersdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CShareReward = (BeanManager.GetTableByName)("sharesystem.csharereward")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InviteOtherDlg = class("InviteOtherDlg", Dialog)
InviteOtherDlg.AssetBundleName = "ui/layouts.invite"
InviteOtherDlg.AssetName = "InviteOthers"
InviteOtherDlg.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InviteOtherDlg
  ((InviteOtherDlg.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

InviteOtherDlg.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemGet = self:GetChild("Back/ItemGet")
  ;
  (self._itemGet):SetActive(false)
  self._itemCell = self:GetChild("Back/ItemCell")
  self._tipBtn = self:GetChild("Back/Ibtn")
  self._inviteCode = self:GetChild("Back/InputField")
  self._shareBtn = self:GetChild("ShareBtn")
  self._shareDot = self:GetChild("ShareBtn/RedDot")
  self._playerListBtn = self:GetChild("PlayersListBtn")
  self._rewardListBtn = self:GetChild("RewardListBtn")
  self._redDot = self:GetChild("RewardListBtn/RedDot")
  ;
  (self._redDot):SetActive(false)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.ShowTip, self)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._tipsText = self:GetChild("Back/TipsText")
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShare, self)
  ;
  (self._playerListBtn):Subscribe_PointerClickEvent(self.OnShowPlayerList, self)
  ;
  (self._rewardListBtn):Subscribe_PointerClickEvent(self.OnShowRewardList, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshActivityRewards, nil)
end

InviteOtherDlg.SetData = function(self, protocol)
  -- function num : 0_2 , upvalues : CShareReward, Item, InviteUtil
  self._inviteMax = protocol.limitNum
  self._inviteCur = protocol.inviteeNum
  self._shared = protocol.weekshare
  self._shareCode = protocol.invitationCode
  ;
  (self._inviteCode):SetText(self._shareCode)
  if self._shared == -1 then
    (self._itemCell):SetActive(false)
    ;
    (self._tipsText):SetActive(false)
    ;
    (self._itemGet):SetActive(false)
    ;
    (self._shareDot):SetActive(true)
  else
    local record = CShareReward:GetRecorder(4)
    self._item = (Item.Create)((record.itemID)[1])
    ;
    (InviteUtil.SetItemInfo)(self._itemCell, {item = self._item, num = (record.itemNum)[1]})
    if self._shared == 1 then
      (self._itemGet):SetActive(true)
      ;
      (self._shareDot):SetActive(false)
    else
      ;
      (self._shareDot):SetActive(true)
    end
  end
  do
    self:RefreshRedDot()
  end
end

InviteOtherDlg.RefreshRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local s = ((NekoData.BehaviorManager).BM_Activity):GetInviteRedDot(2)
  ;
  (self._redDot):SetActive(s)
end

InviteOtherDlg.Update = function(self, protocol)
  -- function num : 0_4
  (self._itemGet):SetActive(true)
  self:RefreshRedDot()
end

InviteOtherDlg.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

InviteOtherDlg.ShowTip = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  local dlg = (DialogManager.CreateSingletonDialog)("invite.invitetipsdlg")
  local msg = (TextManager.GetText)((CStringRes:GetRecorder(1514)).msgTextID)
  dlg:SetTip(msg)
end

InviteOtherDlg.OnItemCellClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

InviteOtherDlg.OnShare = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._shareCode == "" then
    return 
  end
  local dlg = (DialogManager.CreateSingletonDialog)("invite.inviteshareresultdlg")
  local showShare = self._inviteCur ~= self._inviteMax
  local shared = self._shared == 1
  dlg:Init(showShare, self._shareCode, shared)
  local msg = (TextManager.GetText)(((NekoData.BehaviorManager).BM_Gacha):GetShareTextID())
  msg = (string.gsub)(msg, "%$parameter1%$", self._shareCode)
  ;
  (self:GetRootWindow()):CopyToClipBoard(msg)
  self:Destroy()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

InviteOtherDlg.OnShowPlayerList = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.copeninviteelist")
  cmd:Send()
end

InviteOtherDlg.OnShowRewardList = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.cgetinvitationrewardslist")
  cmd:Send()
end

return InviteOtherDlg

