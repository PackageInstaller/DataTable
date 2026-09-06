local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ArrangeLeftMonsterCell = class("ArrangeLeftMonsterCell", Dialog)
ArrangeLeftMonsterCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangeLeftMonsterCell.AssetName = "ArrangeCharactorCell"

function ArrangeLeftMonsterCell:Ctor(...)
  ArrangeLeftMonsterCell.super.Ctor(self, ...)
  self._id = 0
end

function ArrangeLeftMonsterCell:OnCreate()
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
end

function ArrangeLeftMonsterCell:OnDestroy()
end

function ArrangeLeftMonsterCell:SetMonsterId(monsterId)
  self._id = monsterId
  self._selectFrame:SetActive(false)
  local monsterRecord = CMonsterConfigTable:GetRecorder(monsterId)
  local shapeRecord = CNpcShapeTable:GetRecorder(monsterRecord.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID)
  if imageRecord then
    self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._image:SetSprite("", "")
  end
end

function ArrangeLeftMonsterCell:Selected(selected)
  self._selectFrame:SetActive(selected)
end

return ArrangeLeftMonsterCell
