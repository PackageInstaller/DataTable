local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local EquipQHItemCell = class("EquipQHItemCell", Dialog)
EquipQHItemCell.AssetBundleName = "ui/layouts.equip"
EquipQHItemCell.AssetName = "EquipQHItemCell"

function EquipQHItemCell:Ctor(...)
  EquipQHItemCell.super.Ctor(self, ...)
end

function EquipQHItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._count = self:GetChild("ItemCell/_Count")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._reduceBtn = self:GetChild("Reduce")
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
end

function EquipQHItemCell:OnDestroy()
end

function EquipQHItemCell:RefreshCell(data)
  self._count:SetText(NumberManager.GetShowNumber(data.count))
  local id
  if data.tag == "item" then
    id = data.key
    local item = Item.Create(id)
    local record = item:GetPinJiImage()
    self._frame:SetSprite(record.assetBundle, record.assetName)
  elseif data.tag == "equip" then
    local item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(data.key)
    id = item:GetID()
    local record = item:GetPinJiImage()
    self._frame:SetSprite(record.assetBundle, record.assetName)
  end
  local imageId = CItemAttrTable:GetRecorder(id).icon
  local imageRecord = CImagePathTable:GetRecorder(imageId)
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function EquipQHItemCell:OnReduceBtnClicked()
  self._delegate:ReduceItems(self._cellData.key)
end

return EquipQHItemCell
