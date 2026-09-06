local TowerV2ProgressLargeCell = class("TowerV2ProgressLargeCell", Dialog)
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
TowerV2ProgressLargeCell.AssetBundleName = "ui/layouts.stair"
TowerV2ProgressLargeCell.AssetName = "StairPositionCellLarge"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2ProgressLargeCell:Ctor(...)
  TowerV2ProgressLargeCell.super.Ctor(self, ...)
end

function TowerV2ProgressLargeCell:OnCreate()
  self._image = {
    light = self:GetChild("BigPoint"),
    dark = self:GetChild("BigPointGrey")
  }
  self._current = self:GetChild("BackNow")
end

function TowerV2ProgressLargeCell:RefreshCell()
  local info = bm_towerv2:GetFloorInfoByIndex(self._cellData)
  self._image.dark:SetActive(info.state == 2)
  self._image.light:SetActive(info.state ~= 2)
  self._current:SetActive(bm_towerv2:GetCurrentFloorIndex() == self._cellData)
end

function TowerV2ProgressLargeCell:OnEvent(eventName)
  if eventName == "refresh" then
    self:RefreshCell()
  end
end

return TowerV2ProgressLargeCell
