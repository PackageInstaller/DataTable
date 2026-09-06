local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GMHideUICell = class("GMHideUICell", Dialog)
GMHideUICell.AssetBundleName = "ui/layouts.gm"
GMHideUICell.AssetName = "GMHideUICell"

function GMHideUICell:Ctor(...)
  GMHideUICell.super.Ctor(self, ...)
end

function GMHideUICell:OnCreate()
  self._toggle = self:GetChild("_Toggle_0")
  self._text = self:GetChild("_Toggle_0/Label")
  self._toggle:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
end

function GMHideUICell:OnDestroy()
end

function GMHideUICell:RefreshCell(data)
  self._toggle:SetIsOnType(data.display)
  self._text:SetText(TextManager.GetText(CStringRes:GetRecorder(data.record.uIname).msgTextID))
end

function GMHideUICell:OnValueChanged()
  local isOn = self._toggle:GetIsOnType()
  if isOn ~= self._cellData.display then
    NekoData.BehaviorManager.BM_Game:SetGMHideUIInfo(self._delegate._tab, self._cellData.record.id, isOn)
  end
end

return GMHideUICell
