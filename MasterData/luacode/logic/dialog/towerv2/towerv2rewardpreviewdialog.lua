local TowerV2RewardPreviewDialog = class("TowerV2RewardPreviewDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
TowerV2RewardPreviewDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RewardPreviewDialog.AssetName = "StairRewardPreview"

function TowerV2RewardPreviewDialog:Ctor(...)
  TowerV2RewardPreviewDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2RewardPreviewDialog:OnCreate()
  self._cells = {}
  self._frame = self:GetChild("Panel/Frame")
  self._progress = self:GetChild("Panel/Count/Num")
  self._continue = self:GetChild("Panel/GoOnBtn")
  self._continue:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._timeout = self:GetChild("Panel/Refresh/Time")
  self._shop = self:GetChild("Panel/shop")
  self._shop:Subscribe_PointerClickEvent(self.OnShopClick, self)
  self._helper = TableFrame.Create(self._frame, self, false, true, false, true)
  LuaNotificationCenter.AddObserver(self, self.OnReward, Common.n_TowerV2Reward, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self._timeoutTask = GameTimer.AddTask(0, 60, self.RefreshTimeout, self)
  self:Refresh()
  self._helper:ReloadAllCell()
  self:MoveToFirstReward()
end

function TowerV2RewardPreviewDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  GameTimer.RemoveTask(self._timeoutTask)
end

function TowerV2RewardPreviewDialog:Refresh()
  self._data = NekoData.BehaviorManager.BM_TowerV2:GetPreviewRewards()
  local count = NekoData.BehaviorManager.BM_TowerV2:GetReachedCount()
  self._progress:SetText(count)
end

function TowerV2RewardPreviewDialog:OnReward(notification)
  self:Refresh()
  local ids = {}
  for i, v in pairs(self._data) do
    if v.id == notification.userInfo.id then
      ids[#ids + 1] = i
      break
    end
  end
  self._helper:ReloadCellsAtIndex(ids, false)
end

function TowerV2RewardPreviewDialog:MoveToFirstReward()
  local id = 1
  local current = NekoData.BehaviorManager.BM_TowerV2:GetReachedCount()
  for i, v in ipairs(self._data) do
    if current >= v.pt and not v.got then
      id = i
      break
    end
  end
  self._helper:MoveLeftToIndex(math.max(id - 1, 1), false)
end

function TowerV2RewardPreviewDialog:RefreshTimeout()
  local sec = (NekoData.BehaviorManager.BM_TowerV2:GetRefreshTime() - 60000) // 1000
  local str = TextManager.GetText(700770)
  str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  self._timeout:SetText(str)
end

function TowerV2RewardPreviewDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("towerv2.towerv2rewardpreviewdialog")
end

function TowerV2RewardPreviewDialog:OnShopClick()
  NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(25)
end

function TowerV2RewardPreviewDialog:NumberOfCell(helper)
  return #self._data
end

function TowerV2RewardPreviewDialog:CellAtIndex(helper, index)
  return "towerv2.towerv2rewardpreviewcell"
end

function TowerV2RewardPreviewDialog:DataAtIndex(helper, index)
  return self._data[index]
end

return TowerV2RewardPreviewDialog
