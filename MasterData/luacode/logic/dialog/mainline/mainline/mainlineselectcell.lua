local MainLineSelectCell = class("MainLineSelectCell", Dialog)
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
MainLineSelectCell.AssetBundleName = "ui/layouts.mainline"
MainLineSelectCell.AssetName = "MainLineSelectCell"

function MainLineSelectCell:Ctor(...)
  MainLineSelectCell.super.Ctor(self, ...)
  self.guideEffectHandler = nil
end

function MainLineSelectCell:OnCreate()
  self._back = self:GetChild("Back")
  self._img = self:GetChild("CellImg")
  self._select = self:GetChild("Select")
  self._select:SetActive(false)
  self._floor = self:GetChild("Floor")
  self._name = self:GetChild("ChapterName")
  self._guideEffect = self:GetChild("Effect")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MainLineSelectCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MainLineSelectCell:RefreshCell(data)
  self._data = data
  local image = ImageTable:GetRecorder(data.img)
  if image then
    self._img:SetSprite(image.assetBundle, image.assetName)
  end
  self._floor:SetText(data.floor)
  self._name:SetText(data.name)
  self._select:SetActive(self._delegate:GetSelectedId() == self._data.id)
end

function MainLineSelectCell:OnCellClicked()
  self._delegate:OnCellClicked(self._data)
end

function MainLineSelectCell:OnEvent(eventName, arg)
  if eventName == "SetFloorSelectedState" then
    self._select:SetActive(arg == self._data.id)
  end
end

return MainLineSelectCell
