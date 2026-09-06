local TowerV2PackDialog = class("TowerV2PackDialog", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DM_RedDot = NekoData.DataManager.DM_RedDot
TowerV2PackDialog.AssetBundleName = "ui/layouts.stair"
TowerV2PackDialog.AssetName = "StairItemList"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2PackDialog:Ctor(...)
  TowerV2PackDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2PackDialog:OnCreate()
  self._frame = self:GetChild("Back/Frame")
  self._button = self:GetChild("Back/CancelBtn")
  self._scroll = self:GetChild("Back/Scrollbar")
  self._scroll:SetActive(false)
  self._empty = self:GetChild("Back/Empty")
  self._getButton = self:GetChild("Btn4")
  self._getButton:SetActive(true)
  self._getButton:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._button:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._shopButton = self:GetChild("shop")
  self._shopButton:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_TowerV2UpdateUnreceivedReward, nil)
  self._helper = GridFrame.Create(self._frame, self, true, 4, true)
  self:Refresh()
end

function TowerV2PackDialog:OnDestroy()
  self._helper:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2PackDialog:Refresh()
  self._data = {}
  local hasReward = false
  for k, v in pairs(bm_towerv2:GetUnreceivedReward()) do
    table.insert(self._data, {itemId = k, itemNum = v})
    hasReward = true
  end
  if hasReward then
    self._getButton:SetInteractable(true)
  else
    self._getButton:SetInteractable(false)
  end
  self._helper:ReloadAllCell()
  self._empty:SetActive(self:NumberOfCell() == 0)
end

function TowerV2PackDialog:OnBackBtnClicked()
  self:Destroy()
end

function TowerV2PackDialog:OnGetBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.crougetowergetunreceivedreward")
  csend:Send()
end

function TowerV2PackDialog:OnShopBtnClicked()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(25)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

function TowerV2PackDialog:OnCellClick(index)
end

function TowerV2PackDialog:NumberOfCell(helper)
  return #self._data
end

function TowerV2PackDialog:CellAtIndex(helper, index)
  return "towerv2.scene.towerv2packcell"
end

function TowerV2PackDialog:DataAtIndex(helper, index)
  return self._data[index]
end

function TowerV2PackDialog:OnCurPosChange(helper, ratio)
  self._scroll:SetScrollValue(ratio)
end

return TowerV2PackDialog
