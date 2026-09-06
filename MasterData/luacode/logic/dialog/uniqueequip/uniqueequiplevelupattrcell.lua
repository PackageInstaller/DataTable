local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local UniqueEquipLevelUpAttrCell = class("UniqueEquipLevelUpAttrCell", Dialog)
UniqueEquipLevelUpAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpAttrCell.AssetName = "CharEquipQHPropCell"

function UniqueEquipLevelUpAttrCell:Ctor(...)
  UniqueEquipLevelUpAttrCell.super.Ctor(self, ...)
end

function UniqueEquipLevelUpAttrCell:OnCreate()
  self._name = self:GetChild("LeftPanel/Txt")
  self._lastNum = self:GetChild("LeftPanel/Num")
  self._curNum = self:GetChild("RightPanel/Num")
end

function UniqueEquipLevelUpAttrCell:OnDestroy()
end

function UniqueEquipLevelUpAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  if record.isDecimal == 1 then
    local str = data.lastValue / 1000 * 100
    self._lastNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
    str = data.curValue / 1000 * 100
    self._curNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
  else
    self._lastNum:SetText(data.lastValue)
    self._curNum:SetText(data.curValue)
  end
end

return UniqueEquipLevelUpAttrCell
