local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ArrangeLeftRoleCell = class("ArrangeLeftRoleCell", Dialog)
ArrangeLeftRoleCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangeLeftRoleCell.AssetName = "ArrangeCharactorCell"

function ArrangeLeftRoleCell:Ctor(...)
  ArrangeLeftRoleCell.super.Ctor(self, ...)
  self._id = 0
end

function ArrangeLeftRoleCell:OnCreate()
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
end

function ArrangeLeftRoleCell:OnDestroy()
end

function ArrangeLeftRoleCell:SetRoleConfigId(roleConfigId)
  self._id = roleConfigId
  self._selectFrame:SetActive(false)
  local monsterRecord = RoleConfigTable:GetRecorder(roleConfigId)
  local shapeRecord = CNpcShapeTable:GetRecorder(monsterRecord.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ArrangeLeftRoleCell:Selected(selected)
  self._selectFrame:SetActive(selected)
end

return ArrangeLeftRoleCell
