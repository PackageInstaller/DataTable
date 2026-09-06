local TowerV2BuffDialog = class("TowerEventBoxTips", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
TowerV2BuffDialog.AssetBundleName = "ui/layouts.stair"
TowerV2BuffDialog.AssetName = "StairBuffList"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2BuffDialog:Ctor(...)
  TowerV2BuffDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2BuffDialog:OnCreate()
  self._frame = self:GetChild("Back/Frame")
  self._button = self:GetChild("Back/CancelBtn")
  self._scroll = self:GetChild("Back/Scrollbar")
  self._scroll:SetActive(false)
  self._empty = self:GetChild("Back/Empty")
  self._button:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self._helper = GridFrame.Create(self._frame, self, true, 4, true)
end

function TowerV2BuffDialog:OnDestroy()
  self._helper:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2BuffDialog:Refresh()
  self._data = {}
  for _, v in ipairs(bm_towerv2:GetBuffs()) do
    for i = 1, v.count do
      if v.id ~= 0 then
        table.insert(self._data, {
          id = v.id,
          cfg = v.cfg
        })
      end
    end
  end
  self._helper:ReloadAllCell()
  self._empty:SetActive(self:NumberOfCell() == 0)
end

function TowerV2BuffDialog:OnBackBtnClicked()
  self:Destroy()
end

function TowerV2BuffDialog:OnCellClick(index)
end

function TowerV2BuffDialog:NumberOfCell(helper)
  return #self._data
end

function TowerV2BuffDialog:CellAtIndex(helper, index)
  return "towerv2.towerv2buffcell"
end

function TowerV2BuffDialog:DataAtIndex(helper, index)
  return self._data[index]
end

function TowerV2BuffDialog:OnCurPosChange(helper, ratio)
  self._scroll:SetScrollValue(ratio)
end

return TowerV2BuffDialog
