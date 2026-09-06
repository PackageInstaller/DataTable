local EquipBookCell = class("EquipBookCell", Dialog)
EquipBookCell.AssetBundleName = "ui/layouts.tujian"
EquipBookCell.AssetName = "EquipBookCell"
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local PinJiTable = BeanManager.GetTableByName("item.citempinji")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

function EquipBookCell:Ctor(...)
  EquipBookCell.super.Ctor(self, ...)
end

function EquipBookCell:OnCreate()
  self._normal = self:GetChild("Normal")
  self._normalBack = self:GetChild("Normal/Back")
  self._icon = self:GetChild("Normal/Icon")
  self._select = self:GetChild("Select")
  self._lock = self:GetChild("Lock")
  self._lockItemIcon = self:GetChild("Lock/Icon_black")
  self._num = self:GetChild("Num")
  self._normal:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetChild("Lock/Back"):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function EquipBookCell:OnDestroy()
end

function EquipBookCell:RefreshCell(data)
  local record = CImagePathTable:GetRecorder(data.icon) or DataCommon.DefaultImageAsset
  if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(data.id, HandBookTypeEnum.EQUIP) then
    self._lock:SetActive(false)
    self._normal:SetActive(true)
    self._icon:SetSprite(record.assetBundle, record.assetName)
  else
    self._normal:SetActive(false)
    self._lock:SetActive(true)
    self._lockItemIcon:SetSprite(record.assetBundle, record.assetName)
  end
  self._num:SetText(data.equipNumber)
  self._select:SetActive(self._delegate._selectId == data.id)
  local rarityRecorder = PinJiTable:GetRecorder(data.rarity)
  record = CImagePathTable:GetRecorder(rarityRecorder.imageDir)
  self._normalBack:SetSprite(record.assetBundle, record.assetName)
end

function EquipBookCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectEquip(self._cellData)
end

function EquipBookCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseEquip" then
    if self._cellData.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return EquipBookCell
