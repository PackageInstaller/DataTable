-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2completedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2CompleteDialog = class("TowerV2CompleteDialog", Dialog)
TowerV2CompleteDialog.AssetBundleName = "ui/layouts.stair"
TowerV2CompleteDialog.AssetName = "StairEnd"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
local GridFrame = require("framework.ui.frame.grid.gridframe")
TowerV2CompleteDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2CompleteDialog
  ((TowerV2CompleteDialog.super).Ctor)(self, ...)
end

TowerV2CompleteDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._frame = self:GetChild("Frame/Line/ItemFrame")
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._spirit = {text = self:GetChild("TopGroup/VIT/Text"), button = self:GetChild("TopGroup/VIT/Add"), reddot = self:GetChild("TopGroup/VIT/RedDot")}
  self._nodeCount = self:GetChild("Detail/Count/Num")
  self._nodeTotal = self:GetChild("Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Detail/Count/Box/NewRedDot1")
  self._spirit = {text = self:GetChild("TopGroup/VIT/Text"), button = self:GetChild("TopGroup/VIT/Add"), reddot = self:GetChild("TopGroup/VIT/RedDot")}
  self._refesh = {text = self:GetChild("Detail/Refresh/Time"), info = self:GetChild("Detail/Refresh/Ibtn")}
  ;
  (self._frame):SetActive(false)
  self._helper = (GridFrame.Create)(self._frame, self, true, 3)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReward, Common.n_TowerV2Reward, nil)
  self._handle = (self:GetRootWindow()):Subscribe_StateUpdateEvent(self.OnStateUpdate, self)
  ;
  ((self._refesh).info):Subscribe_PointerClickEvent(self.OnRefreshInfoClick, self)
  ;
  (self._rewardPreview):Subscribe_PointerClickEvent(self.OnPreviewRewardClick, self)
  ;
  ((self._spirit).button):Subscribe_PointerClickEvent(self.OnSpiritClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  self._timeoutTask = (GameTimer.AddTask)(0, 60, self.RefreshTimeout, self)
end

TowerV2CompleteDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._helper):Destroy()
  ;
  (GameTimer.RemoveTask)(self._timeoutTask)
end

TowerV2CompleteDialog.SetData = function(self, items)
  -- function num : 0_3
  if not items then
    self._items = {}
    self:Refresh()
  end
end

TowerV2CompleteDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : bm_towerv2
  if #self._items ~= 0 then
    (self._frame):SetActive(true)
    ;
    (self._helper):ReloadAllCell()
  end
  ;
  (self._nodeCount):SetText(bm_towerv2:GetReachedCount())
  ;
  (self._nodeTotal):SetText(bm_towerv2:GetFloorTotalCount())
  ;
  (self._rewardRedpoint):SetActive(bm_towerv2:RewardHasRedpoint())
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
end

TowerV2CompleteDialog.RefreshTimeout = function(self)
  -- function num : 0_5 , upvalues : bm_towerv2, _ENV
  local sec = (bm_towerv2:GetRefreshTime() - 60000) // 1000
  local str = (TextManager.GetText)(700770)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  ((self._refesh).text):SetText(str)
end

TowerV2CompleteDialog.OnReward = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  self:SetData(((NekoData.BehaviorManager).BM_TowerV2):GetLastRewards())
  self:Refresh()
end

TowerV2CompleteDialog.OnNewStairs = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.scene.TowerV2CompleteDialog")
end

TowerV2CompleteDialog.OnContinueClick = function(self)
  -- function num : 0_8 , upvalues : bm_towerv2, _ENV
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit() then
    ((NekoData.BehaviorManager).BM_TowerV2):Forward()
  else
    ;
    ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

TowerV2CompleteDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, bm_towerv2
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(59, nil, function()
    -- function num : 0_9_0 , upvalues : bm_towerv2, _ENV
    local type = 66
    if bm_towerv2:GetState() == "complete" then
      type = nil
    end
    ;
    ((EffectFactory.CreateJumpBackEffect)(type)):Run()
  end
)
end

TowerV2CompleteDialog.OnTeamClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("forward")
end

TowerV2CompleteDialog.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_11 , upvalues : bm_towerv2, _ENV
  if normalizedTime >= 1 and bm_towerv2:GetState() == "complete" then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(116, nil, function()
    -- function num : 0_11_0 , upvalues : _ENV
    ((EffectFactory.CreateJumpBackEffect)()):Run()
  end
)
    ;
    (self:GetRootWindow()):Unsubscribe_StateUpdateEvent(self._handle)
  end
end

TowerV2CompleteDialog.OnPreviewRewardClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, bm_towerv2
  (LuaNotificationCenter.AddObserver)(self, self.OnPreviewReward, Common.n_TowerV2PreviewReward)
  bm_towerv2:RequestRewardPreview()
end

TowerV2CompleteDialog.OnPreviewReward = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("towerv2.towerv2rewardpreviewdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_TowerV2PreviewReward)
end

TowerV2CompleteDialog.OnRefreshSpirit = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV
  local limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  local current = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  ((self._spirit).text):SetText(tostring(current) .. "/" .. tostring(limit))
end

TowerV2CompleteDialog.RefreshSpiritRedPoint = function(self)
  -- function num : 0_15
  ((self._spirit).reddot):SetActive(self:HaveSpiritItemSoonExpire())
end

TowerV2CompleteDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < 86400000 then
      return true
    end
  end
  return false
end

TowerV2CompleteDialog.OnSpiritClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

TowerV2CompleteDialog.OnRefreshInfoClick = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("towerv2.towerv2tipdialog")
end

TowerV2CompleteDialog.AddNewModal = function(self)
  -- function num : 0_19
end

TowerV2CompleteDialog.NumberOfCell = function(self, helper)
  -- function num : 0_20
  return #self._items
end

TowerV2CompleteDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_21
  return "towerv2.towerv2itemcell"
end

TowerV2CompleteDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_22
  return (self._items)[index]
end

return TowerV2CompleteDialog

