local CFurnitureItem = BeanManager.GetTableByName("item.cfurnitureitem")
local FurnitureComfortCell = class("FurnitureComfortCell", Dialog)
FurnitureComfortCell.AssetBundleName = "ui/layouts.yard"
FurnitureComfortCell.AssetName = "HouseComfortableCell"

function FurnitureComfortCell:Ctor(...)
  FurnitureComfortCell.super.Ctor(self, ...)
end

function FurnitureComfortCell:OnCreate()
  self._name = self:GetChild("Name")
  self._comfortNum = self:GetChild("Num")
  self._comfortIcon = self:GetChild("Image")
end

function FurnitureComfortCell:OnDestroy()
end

function FurnitureComfortCell:RefreshCell(data)
  self._name:SetText(data:GetName())
  self._comfortNum:SetText(data:GetComfort())
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
end

return FurnitureComfortCell
