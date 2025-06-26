-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2rewardpreviewdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2RewardPreviewDialog = class("TowerV2RewardPreviewDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
TowerV2RewardPreviewDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RewardPreviewDialog.AssetName = "StairRewardPreview"
TowerV2RewardPreviewDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2RewardPreviewDialog
  ((TowerV2RewardPreviewDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2RewardPreviewDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._cells = {}
  self._frame = self:GetChild("Panel/Frame")
  self._progress = self:GetChild("Panel/Count/Num")
  self._continue = self:GetChild("Panel/GoOnBtn")
  ;
  (self._continue):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._timeout = self:GetChild("Panel/Refresh/Time")
  self._shop = self:GetChild("Panel/shop")
  ;
  (self._shop):Subscribe_PointerClickEvent(self.OnShopClick, self)
  self._helper = (TableFrame.Create)(self._frame, self, false, true, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReward, Common.n_TowerV2Reward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self._timeoutTask = (GameTimer.AddTask)(0, 60, self.RefreshTimeout, self)
  self:Refresh()
  ;
  (self._helper):ReloadAllCell()
  self:MoveToFirstReward()
end

TowerV2RewardPreviewDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._helper):Destroy()
  ;
  (GameTimer.RemoveTask)(self._timeoutTask)
end

TowerV2RewardPreviewDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = ((NekoData.BehaviorManager).BM_TowerV2):GetPreviewRewards()
  local count = ((NekoData.BehaviorManager).BM_TowerV2):GetReachedCount()
  ;
  (self._progress):SetText(count)
end

TowerV2RewardPreviewDialog.OnReward = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  self:Refresh()
  local ids = {}
  for i,v in pairs(self._data) do
    if v.id == (notification.userInfo).id then
      ids[#ids + 1] = i
      break
    end
  end
  do
    ;
    (self._helper):ReloadCellsAtIndex(ids, false)
  end
end

TowerV2RewardPreviewDialog.MoveToFirstReward = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local id = 1
  local current = ((NekoData.BehaviorManager).BM_TowerV2):GetReachedCount()
  for i,v in ipairs(self._data) do
    if v.pt <= current and not v.got then
      id = i
      break
    end
  end
  do
    ;
    (self._helper):MoveLeftToIndex((math.max)(id - 1, 1), false)
  end
end

TowerV2RewardPreviewDialog.RefreshTimeout = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local sec = (((NekoData.BehaviorManager).BM_TowerV2):GetRefreshTime() - 60000) // 1000
  local str = (TextManager.GetText)(700770)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  (self._timeout):SetText(str)
end

TowerV2RewardPreviewDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2rewardpreviewdialog")
end

TowerV2RewardPreviewDialog.OnShopClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(25)
end

TowerV2RewardPreviewDialog.NumberOfCell = function(self, helper)
  -- function num : 0_9
  return #self._data
end

TowerV2RewardPreviewDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_10
  return "towerv2.towerv2rewardpreviewcell"
end

TowerV2RewardPreviewDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_11
  return (self._data)[index]
end

return TowerV2RewardPreviewDialog

