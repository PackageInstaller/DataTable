local RecommendCharCharacterCell = class("RecommendCharCharacterCell", Dialog)
local Role = require("logic.manager.experimental.types.role")
RecommendCharCharacterCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharCharacterCell.AssetName = "RecommendCharCharacterCell"

function RecommendCharCharacterCell:Ctor(...)
  RecommendCharCharacterCell.super.Ctor(self, ...)
end

function RecommendCharCharacterCell:OnCreate(data)
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Photo")
  self._rank = self:GetChild("Rank")
  self._job = self:GetChild("Job")
  self._select = self:GetChild("Select")
  self._element = self:GetChild("Element")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RecommendCharCharacterCell:OnDestroy()
end

function RecommendCharCharacterCell:RefreshCell(data)
  if data == self._delegate._delegate._select.id and self._delegate._index == self._delegate._delegate._select.index then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  local role = Role.Create(data, nil, true)
  if role then
    local imageRecord = role:GetShapeHeadImageRecord()
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetRarityImageRecord()
    self._rank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetVocationImageRecord()
    self._job:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetSmallRarityBackRecord()
    self._back:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = role:GetElementImageRecord()
    self._element:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function RecommendCharCharacterCell:OnCellClicked()
  if self._cellData then
    self._delegate:OnCellClicked(self._cellData)
  end
end

function RecommendCharCharacterCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "SetSelectedRole" then
    if arg.id == self._cellData and self._delegate._delegate._select.index == self._delegate._index then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return RecommendCharCharacterCell
