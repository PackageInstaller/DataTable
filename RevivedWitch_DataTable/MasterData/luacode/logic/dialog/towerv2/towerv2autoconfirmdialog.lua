-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2autoconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2AutoConfirmDialog = class("TowerEventBoxTips", Dialog)
TowerV2AutoConfirmDialog.AssetBundleName = "ui/layouts.stair"
TowerV2AutoConfirmDialog.AssetName = "StairSecondConfirm"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2AutoConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2AutoConfirmDialog
  ((TowerV2AutoConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2AutoConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cost = {panel = self:GetChild("CostBack"), value = self:GetChild("CostBack/Txt2"), insufficient = self:GetChild("CostBack/Txt2Red")}
  self._confirm = self:GetChild("ConfirmButton")
  self._cancel = self:GetChild("CancelButton")
  self._spirit = {text = self:GetChild("TopGroup/VIT/Text"), button = self:GetChild("TopGroup/VIT/Add"), reddot = self:GetChild("TopGroup/VIT/RedDot")}
  ;
  (self._confirm):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (self._cancel):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  ((self._spirit).button):Subscribe_PointerClickEvent(self.OnSpiritClick, self._parts)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Destroy, Common.n_TowerV2Refresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  self:Refresh()
end

TowerV2AutoConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2AutoConfirmDialog.Refresh = function(self)
  -- function num : 0_3
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
end

TowerV2AutoConfirmDialog.OnConfirmClick = function(self)
  -- function num : 0_4 , upvalues : bm_towerv2, _ENV
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit() then
    if self._clicked then
      return 
    end
    ;
    ((NekoData.BehaviorManager).BM_TowerV2):Forward()
    self._clicked = true
  else
    ;
    ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

TowerV2AutoConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, bm_towerv2
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2autoconfirmdialog")
  bm_towerv2:StopAutoExplore()
end

TowerV2AutoConfirmDialog.RefreshCost = function(self)
  -- function num : 0_6 , upvalues : bm_towerv2, _ENV
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost == 0 then
    cost = ((bm_towerv2:GetFloorInfoByIndex(1)).cfg).apCost
  end
  ;
  ((self._cost).value):SetText(tostring(cost))
  ;
  ((self._cost).insufficient):SetText(tostring(cost))
  local insufficient = ((NekoData.BehaviorManager).BM_Currency):GetSpirit() < cost
  ;
  ((self._cost).value):SetActive(not insufficient)
  ;
  ((self._cost).insufficient):SetActive(insufficient)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerV2AutoConfirmDialog.OnRefreshSpirit = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  local current = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  ((self._spirit).text):SetText(tostring(current) .. "/" .. tostring(limit))
  self:RefreshCost()
end

TowerV2AutoConfirmDialog.RefreshSpiritRedPoint = function(self)
  -- function num : 0_8
  ((self._spirit).reddot):SetActive(self:HaveSpiritItemSoonExpire())
end

TowerV2AutoConfirmDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < 86400000 then
      return true
    end
  end
  return false
end

TowerV2AutoConfirmDialog.OnSpiritClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

return TowerV2AutoConfirmDialog

