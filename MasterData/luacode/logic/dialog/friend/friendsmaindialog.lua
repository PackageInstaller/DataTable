local FriendsMainDialog = class("FriendsMainDialog", Dialog)
local TabFrame = require("framework.ui.frame.tab.tabframe")
local RedData = require("logic.manager.experimental.types.reddata")
FriendsMainDialog.AssetBundleName = "ui/layouts.friends"
FriendsMainDialog.AssetName = "FriendsMain"
local GroupBtnNum = 5

function FriendsMainDialog:Ctor(...)
  FriendsMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function FriendsMainDialog:OnCreate()
  self:GetRootWindow():Subscribe_PointerDownEvent(nil, self)
  self._groupBtnInfo = {}
  for i = 1, GroupBtnNum do
    self._groupBtnInfo[i] = {}
    self._groupBtnInfo[i].redicon = self:GetChild("Back/GroupBtn" .. i .. "/RedDot")
    self._groupBtnInfo[i].btn = self:GetChild("Back/GroupBtn" .. i)
    self._groupBtnInfo[i].btn:Subscribe_PointerClickEvent(function()
      self:OnGroupClick(i)
    end)
  end
  self._panelWnd = self:GetChild("Back/RightPanel")
  self._pageHelper = TabFrame.Create(self._panelWnd, self)
  self._title = self:GetChild("Title")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  self:SetRedData()
  LuaNotificationCenter.AddObserver(self, self.SetRedData, Common.n_FriendsRedChange, nil)
  self:OnGroupClick(4)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function FriendsMainDialog:OnDestroy()
  self._pageHelper:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
end

function FriendsMainDialog:OnGroupClick(index)
  self._pageHelper:ToPage(index)
end

function FriendsMainDialog:DidToPage(helper, index)
  local dlg = self._pageHelper:GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh()
  end
  for i = 1, GroupBtnNum do
    self._groupBtnInfo[i].btn:SetSelected(index == i)
    self._title:SetActive(index ~= GroupBtnNum)
  end
end

function FriendsMainDialog:CellAtIndex(helper, index)
  if index == 1 then
    return "friend.friendslistdialog"
  elseif index == 2 then
    return "friend.findfriendsdialog"
  elseif index == 3 then
    return "friend.blacklistdialog"
  elseif index == 4 then
    return "friend.hexmaterialdialog"
  elseif index == 5 then
    return "friend.setborderdialog"
  end
end

function FriendsMainDialog:SetRedData()
  local redData = NekoData.BehaviorManager.BM_Friends:GetRedData()
  for i = 1, 2 do
    self._groupBtnInfo[i].redicon:SetActive(redData:IsIndexTrue(i))
  end
end

function FriendsMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function FriendsMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function FriendsMainDialog:UpdateBorderList(serverData)
  local dlg = self._pageHelper:GetCellAtIndex(5)
  if dlg then
    dlg:UpdateBorderList(serverData)
  end
  dlg = self._pageHelper:GetCellAtIndex(4)
  if dlg then
    dlg:UpdateBorderList(serverData)
  end
end

function FriendsMainDialog:UpdateCurBorder(serverData)
  local dlg = self._pageHelper:GetCellAtIndex(5)
  if dlg then
    dlg:UpdateCurBorder(serverData)
  end
  dlg = self._pageHelper:GetCellAtIndex(4)
  if dlg then
    dlg:UpdateCurBorder(serverData)
  end
end

return FriendsMainDialog
