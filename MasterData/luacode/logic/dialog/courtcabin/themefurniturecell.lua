local ThemeFurnitureCell = class("ThemeFurnitureCell", Dialog)
ThemeFurnitureCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureCell.AssetName = "HouseThemeCellSmall"

function ThemeFurnitureCell:Ctor(...)
  ThemeFurnitureCell.super.Ctor(self, ...)
end

function ThemeFurnitureCell:OnCreate()
  self._icon = self:GetChild("Back/Item")
  self._comfortIcon = self:GetChild("Back/ComfortableImg")
  self._comfortNum = self:GetChild("Back/ComfortableNum")
  self._name = self:GetChild("Back/Name")
  self._disable = self:GetChild("Back/Grey")
end

function ThemeFurnitureCell:OnDestroy()
end

function ThemeFurnitureCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(data.item:GetName())
  local comfort = data.item:GetComfort()
  self._comfortNum:SetText(comfort)
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  if data.disable then
    self._disable:SetActive(true)
  else
    self._disable:SetActive(false)
  end
end

return ThemeFurnitureCell
