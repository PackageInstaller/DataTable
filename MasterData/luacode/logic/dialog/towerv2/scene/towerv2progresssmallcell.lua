local TowerV2ProgressSmallCell = class("TowerV2ProgressSmallCell", Dialog)
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
TowerV2ProgressSmallCell.AssetBundleName = "ui/layouts.stair"
TowerV2ProgressSmallCell.AssetName = "StairPositionCellSmall"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2ProgressSmallCell:Ctor(...)
  TowerV2ProgressSmallCell.super.Ctor(self, ...)
end

function TowerV2ProgressSmallCell:OnCreate()
  self._image = {
    selected = self:GetChild("SmallPoint"),
    untouched = self:GetChild("SmallPointGrey"),
    touched = self:GetChild("SmallPointPass")
  }
  self._current = self:GetChild("BackNow")
  self._monsetertype_1 = self:GetChild("Monsetertype_1")
  self._monsetertype_2 = self:GetChild("Monsetertype_2")
end

local image_selected_ids = {12477, 12479}
local image_untouched_ids = {12660, 12662}
local image_touched_ids = {13176, 13178}

function TowerV2ProgressSmallCell:RefreshCell()
  local info = bm_towerv2:GetFloorInfoByIndex(self._cellData)
  local ids
  if info.state == 0 then
    ids = image_untouched_ids
  elseif info.state == 1 then
    ids = image_selected_ids
  elseif info.state == 2 then
    ids = image_touched_ids
  end
  local id = ids[1]
  self._monsetertype_1:SetActive(false)
  self._monsetertype_2:SetActive(false)
  for _, v in pairs(info.events) do
    if v.type == 1 or v.type == 2 then
      self._monsetertype_1:SetActive(v.type == 1)
      self._monsetertype_2:SetActive(v.type == 2)
      id = ids[2]
      break
    end
  end
  local recorder = cimagepath:GetRecorder(id)
  for _, v in pairs(self._image) do
    v:SetSprite(recorder.assetBundle, recorder.assetName)
  end
  self._image.untouched:SetActive(info.state == 0)
  self._image.selected:SetActive(info.state == 1 or info.id == bm_towerv2:GetCurrentFloorID())
  self._image.touched:SetActive(info.state == 2)
  self._current:SetActive(bm_towerv2:GetCurrentFloorIndex() == self._cellData)
end

function TowerV2ProgressSmallCell:OnEvent(eventName)
  if eventName == "refresh" then
    self:RefreshCell()
  end
end

return TowerV2ProgressSmallCell
