local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local RemindCell = class("RemindCell", Dialog)
RemindCell.AssetBundleName = "ui/layouts.activitychristmas"
RemindCell.AssetName = "ActivityChristmasRemindCell"

function RemindCell:Ctor(...)
  RemindCell.super.Ctor(self, ...)
end

function RemindCell:OnCreate()
  self._image = self:GetChild("Trunk")
  self._text = self:GetChild("_Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RemindCell:OnDestroy()
end

function RemindCell:RefreshCell(data)
  local record = CImagePathTable:GetRecorder(data.record.photoid) or DataCommon.DefaultImageAsset
  self._image:SetSprite(record.assetBundle, record.assetName)
  self._text:SetText(TextManager.GetText(data.record.textid))
end

function RemindCell:OnCellClicked()
  local record = CInterfaceFunction:GetRecorder(self._cellData.record.puppetAllphy)
  if record then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      dialog:SetDialogLibraryId(record.sectionID, false, dialog.DialogType.Christmas)
    end
  else
    LogErrorFormat("RemindCell", "record with id %s is not exist in cinterfacefunction", self._cellData.record.puppetAllphy)
  end
end

return RemindCell
