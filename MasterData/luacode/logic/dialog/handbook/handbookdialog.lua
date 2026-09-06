local TabFrame = require("framework.ui.frame.tab.tabframe")
local HandBookDialog = class("HandBookDialog", Dialog)
HandBookDialog.AssetBundleName = "ui/layouts.tujian"
HandBookDialog.AssetName = "BookMain"

function HandBookDialog:Ctor(...)
  HandBookDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._isRoleList = false
  self._uiBackActive = false
end

function HandBookDialog:OnCreate()
  self._groupBtnInfo = {}
  for i = 1, 4 do
    self._groupBtnInfo[i] = {}
    self._groupBtnInfo[i].btn = self:GetChild("GroupBtnArea/Btn" .. i .. "/GroupBtn")
    self._groupBtnInfo[i].btn:Subscribe_PointerClickEvent(function()
      self:OnGroupClick(i)
    end)
  end
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._roleBookRed = self:GetChild("GroupBtnArea/Btn2/GroupBtn/RedDot")
  self._roleBookRed:SetActive(false)
  self._panelWnd = self:GetChild("Frame")
  self._pageHelper = TabFrame.Create(self._panelWnd, self)
  self._groupBtnInfo[1].btn:SetActive(true)
  self._pageHelper:ToPage(1)
  self:RefreshRoleHandBookRedData()
  LuaNotificationCenter.AddObserver(self, self.RefreshRoleHandBookRedData, Common.n_RefreshRoleFavorRedData, nil)
end

function HandBookDialog:OnDestroy()
  self._pageHelper:Destroy()
  if self._uiBackActive then
    UIBackManager.SetUIBackShow(false)
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function HandBookDialog:OnGroupClick(index)
  if index == 4 then
    self._pageHelper:ToPage(5)
    return
  end
  self._pageHelper:ToPage(index)
end

function HandBookDialog:DidToPage(helper, index)
  if index == 1 then
    UIBackManager.SetUIBackShow(false)
    self._uiBackActive = false
  else
    if not self._uiBackActive then
      UIBackManager.SetUIBackShow(true)
      self._uiBackActive = true
    end
    UIBackManager.SetUIModalBackColor(2)
  end
  local dlg = self._pageHelper:GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh()
  end
  if dlg.OnEnable then
    dlg:OnEnable()
  end
  for i = 1, 3 do
    self._groupBtnInfo[i].btn:SetSelected(index == i)
  end
  if index == 4 then
    self._groupBtnInfo[1].btn:SetSelected(true)
  end
  if index == 5 then
    self._groupBtnInfo[4].btn:SetSelected(true)
  else
    self._groupBtnInfo[4].btn:SetSelected(false)
  end
end

function HandBookDialog:CellAtIndex(helper, index)
  if index == 1 then
    return "handbook.rolebooknewdialog"
  elseif index == 2 then
    return "handbook.equipbookdialog"
  elseif index == 3 then
    return "handbook.monsterbookdialog"
  elseif index == 4 then
    return "handbook.rolebooklistdialog"
  elseif index == 5 then
    return "handbook.memorybookdialog"
  end
end

function HandBookDialog:RefreshRoleHandBookRedData()
  self._roleBookRed:SetActive(NekoData.BehaviorManager.BM_HandBook:IsShowRoleFavorAwardRed())
end

function HandBookDialog:OnBackBtnClicked()
  self:Destroy()
end

function HandBookDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function HandBookDialog:SetRoleList(isList)
  self._isRoleList = isList
end

function HandBookDialog:SetPage(index)
  self._pageHelper:ToPage(index)
end

return HandBookDialog
