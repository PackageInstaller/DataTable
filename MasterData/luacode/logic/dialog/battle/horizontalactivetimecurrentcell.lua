local HorizontalActiveTimeCurrentCell = class("HorizontalActiveTimeCurrentCell", Dialog)
HorizontalActiveTimeCurrentCell.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeCurrentCell.AssetName = "ATBCurrentCell"
local cNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")

function HorizontalActiveTimeCurrentCell:Ctor(...)
  HorizontalActiveTimeCurrentCell.super.Ctor(self, ...)
  self._headIcon = nil
  self._frameRed = nil
  self._frameBlue = nil
  self._animator = nil
end

function HorizontalActiveTimeCurrentCell:OnCreate()
  self._headIcon = self:GetChild("Back/Photo")
  self._frameRed = self:GetChild("FrameR")
  self._frameBlue = self:GetChild("FrameB")
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
end

function HorizontalActiveTimeCurrentCell:OnDestroy()
end

function HorizontalActiveTimeCurrentCell:GetEntityID()
  return self._entityID
end

function HorizontalActiveTimeCurrentCell:Refresh(entityId, orientation, shapeId)
  local camp = orientation
  self._frameBlue:GetUIObject():SetActive(camp == 1)
  self._frameBlue:GetUIObject():SetActive(camp ~= 1)
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeId)
  local headIconID = npcShapeRecorder.headID
  local imageRecord = cImagePathTable:GetRecorder(headIconID)
  if imageRecord then
    self._headIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headIcon:SetSprite("", "")
  end
  self._animator:SetTrigger("CellAct")
end

function HorizontalActiveTimeCurrentCell:SetActive(isActive)
  self._rootWindow:GetUIObject():SetActive(isActive)
end

function HorizontalActiveTimeCurrentCell:Active()
end

return HorizontalActiveTimeCurrentCell
