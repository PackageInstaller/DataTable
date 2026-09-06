local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CharactorInfoCell = class("CharactorInfoCell", Dialog)
CharactorInfoCell.AssetBundleName = "ui/layouts.battleeditor"
CharactorInfoCell.AssetName = "CharactorInfoCell"

function CharactorInfoCell:Ctor(...)
  CharactorInfoCell.super.Ctor(self, ...)
end

function CharactorInfoCell:OnCreate(root)
  self._photo = self:GetChild("Photo")
  self._name = self:GetChild("NameBack/NameTXT")
  self._jobName = self:GetChild("NameBack/JobTXT")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function CharactorInfoCell:OnDestroy()
end

function CharactorInfoCell:RefreshCell(data)
  local shapeRecord = CNpcShapeTable:GetRecorder(data.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.bustID) or DataCommon.DefaultImageAsset
  self._name:SetText(data.name)
  self._jobName:SetText(data.vocation)
  self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function CharactorInfoCell:OnCellClicked(args)
  DialogManager.CreateSingletonDialog("battleeditor.charactorinfodetaildialog"):RefreshRoleInfoDetail(self._cellData.id)
end

return CharactorInfoCell
