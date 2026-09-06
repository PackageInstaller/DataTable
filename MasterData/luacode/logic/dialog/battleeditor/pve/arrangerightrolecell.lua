local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ArrangeRightRoleCell = class("ArrangeRightRoleCell", Dialog)
ArrangeRightRoleCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangeRightRoleCell.AssetName = "ArrangeCharactorCell"

function ArrangeRightRoleCell:Ctor(...)
  ArrangeRightRoleCell.super.Ctor(self, ...)
end

function ArrangeRightRoleCell:OnCreate()
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
  self:GetRootWindow():Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self:GetRootWindow():Subscribe_DragEvent(self.OnDrag, self)
  self:GetRootWindow():Subscribe_EndDragEvent(self.OnEndDrag, self)
  self:GetRootWindow():Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
end

function ArrangeRightRoleCell:OnDestroy()
end

function ArrangeRightRoleCell:RefreshCell(data)
  local shapeRecord = CNpcShapeTable:GetRecorder(data.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID) or DataCommon.DefaultImageAsset
  self._selectFrame:SetActive(self._delegate:GetSelectedID() == data.id)
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ArrangeRightRoleCell:OnEvent(eventName, arg)
  if eventName == "SelectIndex" then
    self._selectFrame:SetActive(arg == self._cellData.id)
  end
end

function ArrangeRightRoleCell:OnBeginDrag(args)
  self._delegate:SetSelectedID(self._cellData.id)
  self._delegate:OnRightCellBeginDrag(args.position)
end

function ArrangeRightRoleCell:OnDrag(args)
  self._delegate:OnRightCellDrag(args.position)
end

function ArrangeRightRoleCell:OnEndDrag(args)
  self._delegate:OnRightCellEndDrag(args.position)
end

function ArrangeRightRoleCell:OnCellClicked(args)
  self._delegate:SetSelectedID(self._cellData.id)
end

return ArrangeRightRoleCell
