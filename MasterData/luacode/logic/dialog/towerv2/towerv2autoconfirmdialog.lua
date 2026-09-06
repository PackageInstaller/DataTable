local TowerV2AutoConfirmDialog = class("TowerEventBoxTips", Dialog)
TowerV2AutoConfirmDialog.AssetBundleName = "ui/layouts.stair"
TowerV2AutoConfirmDialog.AssetName = "StairSecondConfirm"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2AutoConfirmDialog:Ctor(...)
  TowerV2AutoConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2AutoConfirmDialog:OnCreate()
  self._confirm = self:GetChild("ConfirmButton")
  self._cancel = self:GetChild("CancelButton")
  self._confirm:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self._cancel:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  self:Refresh()
end

function TowerV2AutoConfirmDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2AutoConfirmDialog:Refresh()
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
end

function TowerV2AutoConfirmDialog:OnConfirmClick()
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= NekoData.BehaviorManager.BM_Currency:GetSpirit() then
    if self._clicked then
      return
    end
    NekoData.BehaviorManager.BM_TowerV2:Forward()
    self._clicked = true
  else
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function TowerV2AutoConfirmDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("towerv2.towerv2autoconfirmdialog")
  bm_towerv2:StopAutoExplore()
end

function TowerV2AutoConfirmDialog:RefreshCost()
end

function TowerV2AutoConfirmDialog:OnRefreshSpirit(notification)
  self:RefreshCost()
end

function TowerV2AutoConfirmDialog:RefreshSpiritRedPoint()
end

function TowerV2AutoConfirmDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < 86400000 then
      return true
    end
  end
  return false
end

function TowerV2AutoConfirmDialog:OnSpiritClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

return TowerV2AutoConfirmDialog
