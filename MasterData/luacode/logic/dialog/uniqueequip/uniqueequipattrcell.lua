local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local UniqueEquipAttrCell = class("UniqueEquipAttrCell", Dialog)
UniqueEquipAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipAttrCell.AssetName = "CharEquipPropertyCell"

function UniqueEquipAttrCell:Ctor(...)
  UniqueEquipAttrCell.super.Ctor(self, ...)
end

function UniqueEquipAttrCell:OnCreate()
  self._simplePanel = self:GetChild("Prop1")
  self._simplePanel_icon = self:GetChild("Prop1/Image")
  self._simplePanel_name = self:GetChild("Prop1/Name")
  self._simplePanel_num = self:GetChild("Prop1/Num")
  self._normalPanel = self:GetChild("Prop2")
  self._normalPanel_icon = self:GetChild("Prop2/Image")
  self._normalPanel_name = self:GetChild("Prop2/Name")
  self._normalPanel_curNum = self:GetChild("Prop2/Num")
  self._normalPanel_nextNum = self:GetChild("Prop2/Num2")
end

function UniqueEquipAttrCell:OnDestroy()
end

function UniqueEquipAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  if data.nextValue then
    self._simplePanel:SetActive(false)
    self._normalPanel:SetActive(true)
    self._normalPanel_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._normalPanel_name:SetText(TextManager.GetText(record.classnameTextID))
    if record.isDecimal == 1 then
      local str = data.attrValue / 1000 * 100
      self._normalPanel_curNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
      str = data.nextValue / 1000 * 100
      self._normalPanel_nextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
    else
      self._normalPanel_curNum:SetText(data.attrValue)
      self._normalPanel_nextNum:SetText(data.nextValue)
    end
  else
    self._simplePanel:SetActive(true)
    self._normalPanel:SetActive(false)
    self._simplePanel_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._simplePanel_name:SetText(TextManager.GetText(record.classnameTextID))
    if record.isDecimal == 1 then
      local str = data.attrValue / 1000 * 100
      self._simplePanel_num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
    else
      self._simplePanel_num:SetText(data.attrValue)
    end
  end
end

return UniqueEquipAttrCell
