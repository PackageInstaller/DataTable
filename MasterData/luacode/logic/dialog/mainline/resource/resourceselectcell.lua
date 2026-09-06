local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ResourceSelectCell = class("ResourceSelectCell", Dialog)
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
ResourceSelectCell.AssetBundleName = "ui/layouts.mainline"
ResourceSelectCell.AssetName = "ResourceDungeonSelectCell"

function ResourceSelectCell:Ctor(...)
  ResourceSelectCell.super.Ctor(self, ...)
end

function ResourceSelectCell:OnCreate()
  self._back = self:GetChild("Back")
  self._img = self:GetChild("CellImg")
  self._select = self:GetChild("Select")
  self._select:SetActive(false)
  self._stage = self:GetChild("Class")
  self._name = self:GetChild("ChapterName")
  self._condition = self:GetChild("Condition")
  self._new = self:GetChild("New")
  self._clear = self:GetChild("Clear")
  self._clear:SetActive(false)
  self._grey = self:GetChild("Grey")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ResourceSelectCell:OnDestroy()
end

function ResourceSelectCell:RefreshCell(data)
  self._data = data
  local image = ImageTable:GetRecorder(data.img)
  if image then
    self._img:SetSprite(image.assetBundle, image.assetName)
  end
  self._stage:SetText(data.stage)
  self._name:SetText(data.name)
  if data.lock then
    self._grey:SetActive(true)
    self._condition:SetActive(true)
    local str = TextManager.GetText(CStringRes:GetRecorder(1101).msgTextID)
    self._condition:SetText(str)
    self._new:SetActive(false)
    self._img:SetActive(false)
    self._name:SetActive(false)
  else
    self._grey:SetActive(false)
    self._condition:SetActive(false)
    if data.clear then
      self._new:SetActive(false)
    else
      self._new:SetActive(true)
    end
    self._img:SetActive(true)
    self._name:SetActive(true)
  end
  self._select:SetActive(self._delegate:GetSelectedId() == self._data.id)
end

function ResourceSelectCell:OnCellClicked()
  self._delegate:OnCellClicked(self._data.id)
end

function ResourceSelectCell:OnEvent(eventName, arg)
  if eventName == "SetFloorSelectedState" then
    self._select:SetActive(arg == self._data.id)
  end
end

return ResourceSelectCell
