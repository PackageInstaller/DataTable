local HorizontalActiveTimeCell = class("HorizontalActiveTimeCell", Dialog)
HorizontalActiveTimeCell.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeCell.AssetName = "ATBCell"
local cNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")

function HorizontalActiveTimeCell:Ctor(...)
  HorizontalActiveTimeCell.super.Ctor(self, ...)
  self._headIcon = nil
  self._frameRed = nil
  self._frameBlue = nil
  self._animator = nil
end

function HorizontalActiveTimeCell:OnCreate()
  self._headIcon = self:GetChild("Back/Photo")
  self._frameRed = self:GetChild("FrameR")
  self._frameBlue = self:GetChild("FrameB")
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
end

function HorizontalActiveTimeCell:OnDestroy()
end

function HorizontalActiveTimeCell:GetEntityID()
  return self._entityID
end

function HorizontalActiveTimeCell:Refresh(info)
  local camp = info.orientation
  self._frameBlue:GetUIObject():SetActive(camp == 1)
  self._frameBlue:GetUIObject():SetActive(camp ~= 1)
  local npcShapeRecorder = cNPCShape:GetRecorder(info.shapeId)
  local headIconID = npcShapeRecorder.headID
  local imageRecord = cImagePathTable:GetRecorder(headIconID)
  if imageRecord then
    self._headIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headIcon:SetSprite("", "")
  end
end

function HorizontalActiveTimeCell:SetActive(isActive)
  self._rootWindow:GetUIObject():SetActive(isActive)
end

function HorizontalActiveTimeCell:Active()
end

function HorizontalActiveTimeCell:In()
  self._animator:SetTrigger("In")
end

function HorizontalActiveTimeCell:Out()
  self._animator:SetTrigger("Out")
end

function HorizontalActiveTimeCell:Show()
  self._animator:SetTrigger("Show")
end

function HorizontalActiveTimeCell:Change()
end

return HorizontalActiveTimeCell
