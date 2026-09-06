local BookListNPCCell = class("BookListNPCCell", Dialog)
BookListNPCCell.AssetBundleName = "ui/layouts.tujiannew"
BookListNPCCell.AssetName = "BookListNPCCell"
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")

function BookListNPCCell:Ctor(...)
  BookListNPCCell.super.Ctor(self, ...)
  self._lock = true
  self._id = nil
end

function BookListNPCCell:OnCreate()
  self._name = self:GetChild("Num")
  self._photo = self:GetChild("Normal/NPC")
  self._lockIcon = self:GetChild("Lock")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BookListNPCCell:OnDestroy()
end

function BookListNPCCell:RefreshCell(data)
  local spriteRecord = CImagePath:GetRecorder(data.imageID) or DataCommon.DefaultImageAsset
  self._photo:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._id = data.id
  self._lock = not NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(self._id, HandBookTypeEnum.NPC)
  self._lockIcon:SetActive(self._lock)
  if self._lock then
    self._name:SetText("-")
  else
    self._name:SetText(TextManager.GetText(data.nameTextId))
  end
end

function BookListNPCCell:OnCellClicked()
  if self._lock then
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("handbook.npcdetailinfodialog")
  if dialog then
    dialog:Refresh(self._id)
  end
end

return BookListNPCCell
