-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2progresssmallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2ProgressSmallCell = class("TowerV2ProgressSmallCell", Dialog)
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
TowerV2ProgressSmallCell.AssetBundleName = "ui/layouts.stair"
TowerV2ProgressSmallCell.AssetName = "StairPositionCellSmall"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2ProgressSmallCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ProgressSmallCell
  ((TowerV2ProgressSmallCell.super).Ctor)(self, ...)
end

TowerV2ProgressSmallCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = {selected = self:GetChild("SmallPoint"), untouched = self:GetChild("SmallPointGrey"), touched = self:GetChild("SmallPointPass")}
  self._current = self:GetChild("BackNow")
  self._monsetertype_1 = self:GetChild("Monsetertype_1")
  self._monsetertype_2 = self:GetChild("Monsetertype_2")
end

local image_selected_ids = {12477, 12479}
local image_untouched_ids = {12660, 12662}
local image_touched_ids = {13176, 13178}
TowerV2ProgressSmallCell.RefreshCell = function(self)
  -- function num : 0_2 , upvalues : bm_towerv2, image_untouched_ids, image_selected_ids, image_touched_ids, _ENV, cimagepath
  (bm_towerv2:GetFloorInfoByIndex(self._cellData))
  local info = nil
  local ids = nil
  if info.state == 0 then
    ids = image_untouched_ids
  else
    if info.state == 1 then
      ids = image_selected_ids
    else
      if info.state == 2 then
        ids = image_touched_ids
      end
    end
  end
  local id = ids[1]
  ;
  (self._monsetertype_1):SetActive(false)
  ;
  (self._monsetertype_2):SetActive(false)
  for _,v in pairs(info.events) do
    if v.type ~= 1 then
      do
        (self._monsetertype_1):SetActive(v.type ~= 1 and v.type ~= 2)
        ;
        (self._monsetertype_2):SetActive(v.type == 2)
        id = ids[2]
        do break end
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local recorder = cimagepath:GetRecorder(id)
  for _,v in pairs(self._image) do
    v:SetSprite(recorder.assetBundle, recorder.assetName)
  end
  ;
  ((self._image).untouched):SetActive(info.state == 0)
  ;
  ((self._image).selected):SetActive(info.state == 1 or info.id == bm_towerv2:GetCurrentFloorID())
  ;
  ((self._image).touched):SetActive(info.state == 2)
  ;
  (self._current):SetActive(bm_towerv2:GetCurrentFloorIndex() == self._cellData)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

TowerV2ProgressSmallCell.OnEvent = function(self, eventName)
  -- function num : 0_3
  if eventName == "refresh" then
    self:RefreshCell()
  end
end

return TowerV2ProgressSmallCell

