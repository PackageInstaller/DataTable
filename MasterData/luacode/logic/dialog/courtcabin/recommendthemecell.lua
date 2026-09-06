local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RecommendThemeCell = class("RecommendThemeCell", Dialog)
RecommendThemeCell.AssetBundleName = "ui/layouts.yard"
RecommendThemeCell.AssetName = "HouseThemeCell1"

function RecommendThemeCell:Ctor(...)
  RecommendThemeCell.super.Ctor(self, ...)
end

function RecommendThemeCell:OnCreate()
  self._icon = self:GetChild("Normal/Img")
  self._comfortIcon = self:GetChild("Normal/ComfortableImg")
  self._comfortNum = self:GetChild("Normal/ComfortableNum")
  self._name = self:GetChild("Normal/Name")
  self._select = self:GetChild("Normal/Select")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RecommendThemeCell:OnDestroy()
end

function RecommendThemeCell:RefreshCell(data)
  local comfort = 0
  for i, v in ipairs(data.items) do
    local item = FurnitureItem.Create(v)
    comfort = comfort + item:GetComfort()
  end
  self._comfortNum:SetText(comfort)
  self._name:SetText(data.name)
  local imgRecord = CImagePathTable:GetRecorder(data.imageBig)
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._select:SetActive(data.id == self._delegate._themeId)
  imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
end

function RecommendThemeCell:OnCellClicked()
  self._delegate:SelectTheme(self._cellData.id)
end

function RecommendThemeCell:OnEvent(eventName, arg)
  if eventName == "SelectTheme" then
    self._select:SetActive(self._cellData.id == arg)
  end
end

return RecommendThemeCell
