local TowerV2CompleteDialog = class("TowerV2CompleteDialog", Dialog)
TowerV2CompleteDialog.AssetBundleName = "ui/layouts.stair"
TowerV2CompleteDialog.AssetName = "StairEnd"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2
local GridFrame = require("framework.ui.frame.grid.gridframe")

function TowerV2CompleteDialog:Ctor(...)
  TowerV2CompleteDialog.super.Ctor(self, ...)
end

function TowerV2CompleteDialog:OnCreate()
  self._frame = self:GetChild("Frame/Line/ItemFrame")
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._refesh = {
    text = self:GetChild("Detail/Refresh/Time"),
    info = self:GetChild("Detail/Refresh/Ibtn")
  }
  self._resetBtn = self:GetChild("DownArea/DualBtn/GoBtn")
  self._resetBtn:Subscribe_PointerClickEvent(self.OnResetBtnClicked, self)
  self._frame:SetActive(false)
  self._helper = GridFrame.Create(self._frame, self, true, 3)
  LuaNotificationCenter.AddObserver(self, self.OnReward, Common.n_TowerV2Reward, nil)
  self._handle = self:GetRootWindow():Subscribe_StateUpdateEvent(self.OnStateUpdate, self)
  self._refesh.info:Subscribe_PointerClickEvent(self.OnRefreshInfoClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  self._timeoutTask = GameTimer.AddTask(0, 60, self.RefreshTimeout, self)
end

function TowerV2CompleteDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  if self._timeoutTask then
    GameTimer.RemoveTask(self._timeoutTask)
  end
end

function TowerV2CompleteDialog:SetData(items)
  self._items = items or {}
  self:Refresh()
end

function TowerV2CompleteDialog:Refresh()
  if #self._items ~= 0 then
    self._frame:SetActive(true)
    self._helper:ReloadAllCell()
  end
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
end

function TowerV2CompleteDialog:RefreshTimeout()
  local sec = (bm_towerv2:GetRefreshTime() - 60000) // 1000
  local str = TextManager.GetText(700770)
  str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  self._refesh.text:SetText(str)
end

function TowerV2CompleteDialog:OnReward(notification)
  self:SetData(NekoData.BehaviorManager.BM_TowerV2:GetLastRewards())
  self:Refresh()
end

function TowerV2CompleteDialog:OnNewStairs()
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2completedialog")
end

function TowerV2CompleteDialog:OnContinueClick()
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= NekoData.BehaviorManager.BM_Currency:GetSpirit() then
    NekoData.BehaviorManager.BM_TowerV2:Forward()
  else
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function TowerV2CompleteDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(59, nil, function()
    local type = 66
    if bm_towerv2:GetState() == "complete" then
      type = nil
    end
    EffectFactory.CreateJumpBackEffect(type):Run()
  end)
end

function TowerV2CompleteDialog:OnResetBtnClicked()
  bm_towerv2:Reset(1)
end

function TowerV2CompleteDialog:OnTeamClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("forward")
end

function TowerV2CompleteDialog:OnStateUpdate(handle, stateName, normalizedTime)
  if 1 <= normalizedTime and bm_towerv2:GetState() == "complete" then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(116, nil, function()
      EffectFactory.CreateJumpBackEffect():Run()
    end)
    self:GetRootWindow():Unsubscribe_StateUpdateEvent(self._handle)
  end
end

function TowerV2CompleteDialog:OnPreviewRewardClick()
  LuaNotificationCenter.AddObserver(self, self.OnPreviewReward, Common.n_TowerV2PreviewReward)
  bm_towerv2:RequestRewardPreview()
end

function TowerV2CompleteDialog:OnPreviewReward()
  DialogManager.CreateSingletonDialog("towerv2.towerv2rewardpreviewdialog")
  LuaNotificationCenter.RemoveObserver(self, Common.n_TowerV2PreviewReward)
end

function TowerV2CompleteDialog:OnRefreshSpirit(notification)
end

function TowerV2CompleteDialog:RefreshSpiritRedPoint()
end

function TowerV2CompleteDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < 86400000 then
      return true
    end
  end
  return false
end

function TowerV2CompleteDialog:OnSpiritClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function TowerV2CompleteDialog:OnRefreshInfoClick()
  DialogManager.CreateSingletonDialog("towerv2.towerv2tipdialog")
end

function TowerV2CompleteDialog:AddNewModal()
end

function TowerV2CompleteDialog:NumberOfCell(helper)
  return #self._items
end

function TowerV2CompleteDialog:CellAtIndex(helper, index)
  return "towerv2.towerv2itemcell"
end

function TowerV2CompleteDialog:DataAtIndex(helper, index)
  return self._items[index]
end

return TowerV2CompleteDialog
