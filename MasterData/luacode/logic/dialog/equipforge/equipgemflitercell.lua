local EquipGemFliterCell = class("EquipGemFliterCell", Dialog)
EquipGemFliterCell.AssetBundleName = "ui/layouts.equip"
EquipGemFliterCell.AssetName = "EquipXQFliterFrameCell"

function EquipGemFliterCell:Ctor(...)
  EquipGemFliterCell.super.Ctor(self, ...)
end

function EquipGemFliterCell:OnCreate()
  self._name = self:GetChild("SelectBtn/Txt")
  self._selectBtn = self:GetChild("SelectBtn")
  self._selectBtn:Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

function EquipGemFliterCell:OnDestroy()
end

function EquipGemFliterCell:RefreshCell(data)
  self._name:SetText(TextManager.GetText(data.nameid))
  self._selectBtn:SetSelected(true)
end

function EquipGemFliterCell:OnBtnClicked()
  self._delegate:OnGemFliterIDSelect(self._cellData.id)
end

function EquipGemFliterCell:OnEvent(eventName, fliterId, bSelect)
  if eventName == "Select" and self._cellData.id == fliterId then
    self._selectBtn:SetSelected(bSelect)
  end
end

return EquipGemFliterCell
