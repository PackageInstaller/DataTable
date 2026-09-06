local TabFrame = require("framework.ui.frame.tab.tabframe")
local BagDialog = class("BagDialog", Dialog)
BagDialog.AssetBundleName = "ui/layouts.workshop"
BagDialog.AssetName = "WorkShopMain"

function BagDialog:Ctor(...)
  BagDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._tab = nil
end

function BagDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  self._groupBtns = {}
  for i = 1, 4 do
    self._groupBtns[i] = self:GetChild("GroupBtnArea/Btn" .. i .. "/GroupBtn")
    self._groupBtns[i]:Subscribe_PointerClickEvent(function()
      self:OnGroupBtnClick(i)
    end)
  end
  local unlock = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.RoleReset)
  self._groupBtns[4]:SetActive(unlock)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._frame = TabFrame.Create(self._panel, self)
  self:OnGroupBtnClick(1)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:CheckCachedFM()
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function BagDialog:OnDestroy()
  self._frame:Destroy()
  UIBackManager.SetUIBackShow(false)
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
end

function BagDialog:Init(sceneController)
  self._baseSceneController = sceneController
end

function BagDialog:CheckCachedFM()
  if NekoData.BehaviorManager.BM_BagInfo:HasCachedFMKey() == false then
    return
  end
  local keyTable = NekoData.BehaviorManager.BM_BagInfo:GetCachedFMKeyTable()
  local fmResultTipDialog = DialogManager.CreateSingletonDialog("equipforge.equipfmresultdialog")
  fmResultTipDialog:RefreshFromCachedFM(keyTable)
end

function BagDialog:OnGroupBtnClick(index)
  if self._tab ~= index then
    self._tab = index
    local cellPage = self._frame:ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
end

function BagDialog:DidToPage(frame, index)
  for k, v in pairs(self._groupBtns) do
    if k == index then
      v:SetSelected(true)
    else
      v:SetSelected(false)
    end
  end
end

function BagDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "equip.equipbagtabcell"
  elseif index == 2 then
    return "bag.bagdialog"
  elseif index == 3 then
    return "bag.valuablebagtabcell"
  elseif index == 4 then
    return "bag.rolereset.roleresetmaindialog"
  end
end

function BagDialog:OnBackBtnClicked()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  self:Destroy()
end

function BagDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return BagDialog
