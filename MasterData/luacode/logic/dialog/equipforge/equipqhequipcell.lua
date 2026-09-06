local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipQHEquipCell = class("EquipQHEquipCell", Dialog)
EquipQHEquipCell.AssetBundleName = "ui/layouts.equip"
EquipQHEquipCell.AssetName = "EquipQHEquipCell"

function EquipQHEquipCell:Ctor(...)
  EquipQHEquipCell.super.Ctor(self, ...)
end

function EquipQHEquipCell:OnCreate()
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._reduceBtn = self:GetChild("Frame/Reduce")
  self._lvText = self:GetChild("Frame/Panel/Level/Num")
  self._lvMaxText = self:GetChild("Frame/Panel/Level/NumMax")
  self._select = self:GetChild("Frame/Panel/Select")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._select:SetActive(false)
  self._charPhoto:SetActive(false)
  self._charBack:SetActive(false)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

function EquipQHEquipCell:OnDestroy()
end

function EquipQHEquipCell:RefreshCell(data)
  local id
  local item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(data.key)
  id = item:GetID()
  local record = item:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  local imageId = CItemAttrTable:GetRecorder(id).icon
  local imageRecord = CImagePathTable:GetRecorder(imageId) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._lvText:SetText(item:GetStrengthenLevel())
  self._lvMaxText:SetText(item:GetStrengthenMaxLevel())
end

function EquipQHEquipCell:OnReduceBtnClicked()
  self._delegate:ReduceItems(self._cellData.key)
end

function EquipQHEquipCell:OnCellLongPress()
  local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData.key)
    tipsDialog:SetTipsParmFunc(function()
      local width, height = self:GetRootWindow():GetRectSize()
      local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = pos.x,
        posY = pos.y
      }
    end)
  end
end

return EquipQHEquipCell
