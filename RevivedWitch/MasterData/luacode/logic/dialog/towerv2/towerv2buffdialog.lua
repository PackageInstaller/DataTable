-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2buffdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2BuffDialog = class("TowerEventBoxTips", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
TowerV2BuffDialog.AssetBundleName = "ui/layouts.stair"
TowerV2BuffDialog.AssetName = "StairBuffList"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2BuffDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2BuffDialog
  ((TowerV2BuffDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2BuffDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame
  self._frame = self:GetChild("Back/Frame")
  self._button = self:GetChild("Back/CancelBtn")
  self._scroll = self:GetChild("Back/Scrollbar")
  self._empty = self:GetChild("Back/Empty")
  ;
  (self._button):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self._helper = (GridFrame.Create)(self._frame, self, true, 4, true)
end

TowerV2BuffDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._helper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2BuffDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, bm_towerv2
  self._data = {}
  for _,v in ipairs(bm_towerv2:GetBuffs()) do
    for i = 1, v.count do
      if v.id ~= 0 then
        (table.insert)(self._data, {id = v.id, cfg = v.cfg})
      end
    end
  end
  ;
  (self._helper):ReloadAllCell()
  ;
  (self._empty):SetActive(self:NumberOfCell() == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerV2BuffDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

TowerV2BuffDialog.OnCellClick = function(self, index)
  -- function num : 0_5
end

TowerV2BuffDialog.NumberOfCell = function(self, helper)
  -- function num : 0_6
  return #self._data
end

TowerV2BuffDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  return "towerv2.towerv2buffcell"
end

TowerV2BuffDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_8
  return (self._data)[index]
end

TowerV2BuffDialog.OnCurPosChange = function(self, helper, ratio)
  -- function num : 0_9
  (self._scroll):SetScrollValue(ratio)
end

return TowerV2BuffDialog

