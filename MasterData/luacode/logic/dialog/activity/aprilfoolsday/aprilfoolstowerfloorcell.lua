local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CClownSpecialCfg = BeanManager.GetTableByName("activity.cclownspecialcfg")
local AprilFoolsTowerFloorCell = class("AprilFoolsTowerFloorCell", Dialog)
AprilFoolsTowerFloorCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerFloorCell.AssetName = "ActivityAprilFoolsTowerCell"
local FloorType = {
  None = 0,
  Box = 1,
  Story = 2,
  Battle = 3,
  Boss = 4
}

function AprilFoolsTowerFloorCell:Ctor(...)
  AprilFoolsTowerFloorCell.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  local npcShapeId = tonumber(CClownSpecialCfg:GetRecorder(6).Value)
  self._showNpcShapeRecorder = CNPCShape:GetRecorder(npcShapeId)
end

function AprilFoolsTowerFloorCell:OnCreate()
  self._backImg = self:GetChild("LevelBack")
  self._layerNum = self:GetChild("NumBack/Num")
  self._typeImg = self:GetChild("LayerType")
  self._top = self:GetChild("BackTop")
  self._normal = self:GetChild("BackNormal")
  self._charModel = self:GetChild("Model")
  self._base = self:GetChild("Base")
end

function AprilFoolsTowerFloorCell:OnDestroy()
  if self._handler ~= 0 then
    self._charModel:ReleaseModel(self._handler)
    self._handler = 0
  end
end

function AprilFoolsTowerFloorCell:RefreshCell(data)
  self._layerNum:SetText(data.floorId)
  local imageRecord = CImagePath:GetRecorder(data.worldimg) or DataCommon.DefaultImageAsset
  self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePath:GetRecorder(data.eventimg) or DataCommon.DefaultImageAsset
  self._typeImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local showCharModel = true
  if data.floorType == FloorType.Boss then
    self._top:SetActive(true)
    self._normal:SetActive(false)
    if data.state == self._dm.TowerFloorStateType.Finish then
      showCharModel = false
    end
  else
    self._top:SetActive(false)
    self._normal:SetActive(true)
  end
  if data.floorId == 1 then
    self._base:SetActive(true)
    self._normal:SetActive(false)
    showCharModel = false
  else
    self._base:SetActive(false)
    self._normal:SetActive(true)
  end
  self._charModel:SetActive(showCharModel)
  local currentFloorId = self._bm:GetGardenPartyCurrentFloorId()
  if data.floorId == currentFloorId then
    if self._handler then
      self._charModel:ReleaseModel(self._handler)
      self._handler = nil
    end
    self._handler = self._charModel:AddModelSync(self._showNpcShapeRecorder.assetBundleName, self._showNpcShapeRecorder.prefabNameUI)
  elseif self._handler ~= 0 then
    self._charModel:ReleaseModel(self._handler)
    self._handler = 0
  end
end

function AprilFoolsTowerFloorCell:OnEvent(eventName, arg)
  if eventName == "RefreshModel" then
    if arg == self._cellData.floorId then
      if self._handler then
        self._charModel:ReleaseModel(self._handler)
        self._handler = nil
      end
      self._handler = self._charModel:AddModelSync(self._showNpcShapeRecorder.assetBundleName, self._showNpcShapeRecorder.prefabNameUI)
    elseif self._handler then
      self._charModel:ReleaseModel(self._handler)
      self._handler = nil
    end
  end
end

return AprilFoolsTowerFloorCell
