-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2progresslargecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2ProgressLargeCell = class("TowerV2ProgressLargeCell", Dialog)
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
TowerV2ProgressLargeCell.AssetBundleName = "ui/layouts.stair"
TowerV2ProgressLargeCell.AssetName = "StairPositionCellLarge"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2ProgressLargeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ProgressLargeCell
  ((TowerV2ProgressLargeCell.super).Ctor)(self, ...)
end

TowerV2ProgressLargeCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = {light = self:GetChild("BigPoint"), dark = self:GetChild("BigPointGrey")}
  self._current = self:GetChild("BackNow")
end

TowerV2ProgressLargeCell.RefreshCell = function(self)
  -- function num : 0_2 , upvalues : bm_towerv2
  local info = bm_towerv2:GetFloorInfoByIndex(self._cellData)
  ;
  ((self._image).dark):SetActive(info.state == 2)
  ;
  ((self._image).light):SetActive(info.state ~= 2)
  ;
  (self._current):SetActive(bm_towerv2:GetCurrentFloorIndex() == self._cellData)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TowerV2ProgressLargeCell.OnEvent = function(self, eventName)
  -- function num : 0_3
  if eventName == "refresh" then
    self:RefreshCell()
  end
end

return TowerV2ProgressLargeCell

