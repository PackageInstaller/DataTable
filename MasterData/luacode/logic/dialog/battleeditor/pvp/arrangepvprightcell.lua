local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ArrangePVPRightCell = class("ArrangePVPRightCell", Dialog)
ArrangePVPRightCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangePVPRightCell.AssetName = "ArrangeCharactorCell"

function ArrangePVPRightCell:Ctor(...)
  ArrangePVPRightCell.super.Ctor(self, ...)
end

function ArrangePVPRightCell:OnCreate()
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
  self:GetRootWindow():Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self:GetRootWindow():Subscribe_DragEvent(self.OnDrag, self)
  self:GetRootWindow():Subscribe_EndDragEvent(self.OnEndDrag, self)
  self:GetRootWindow():Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
end

function ArrangePVPRightCell:OnDestroy()
end

function ArrangePVPRightCell:RefreshCell(data)
  local shapeRecord = CNpcShapeTable:GetRecorder(data.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID) or DataCommon.DefaultImageAsset
  self._selectFrame:SetActive(self._delegate:GetSelectedID() == data.id)
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ArrangePVPRightCell:OnEvent(eventName, arg)
  if eventName == "SelectIndex" then
    self._selectFrame:SetActive(arg == self._cellData.id)
  end
end

function ArrangePVPRightCell:OnBeginDrag(args)
  self._delegate:SetSelectedID(self._cellData.id)
  self._delegate:OnRightCellBeginDrag(args.position)
end

function ArrangePVPRightCell:OnDrag(args)
  self._delegate:OnRightCellDrag(args.position)
end

function ArrangePVPRightCell:OnEndDrag(args)
  self._delegate:OnRightCellEndDrag(args.position)
end

function ArrangePVPRightCell:OnCellClicked(args)
  self._delegate:SetSelectedID(self._cellData.id)
end

return ArrangePVPRightCell
