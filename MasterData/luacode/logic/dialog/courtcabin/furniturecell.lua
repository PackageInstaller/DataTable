local FurnitureCell = class("FurnitureCell", Dialog)
FurnitureCell.AssetBundleName = "ui/layouts.yard"
FurnitureCell.AssetName = "HouseDecorateItemCell"

function FurnitureCell:Ctor(...)
  FurnitureCell.super.Ctor(self, ...)
end

function FurnitureCell:OnCreate()
  self._icon = self:GetChild("Back/Item")
  self._restNum = self:GetChild("Back/Num")
  self._comfortIcon = self:GetChild("Back/ComfortableImg")
  self._comfortNum = self:GetChild("Back/ComfortableNum")
  self._name = self:GetChild("Back/Name")
  self._disable = self:GetChild("Grey")
  self._usingPanel = self:GetChild("Using")
  self._using = self:GetChild("Using/Using")
  self._reduceBtn = self:GetChild("Using/Using/Reduce")
  self._reachLimit = self:GetChild("Using/Txt")
  self._empty = self:GetChild("Empty")
  self._empty:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceClicked, self)
end

function FurnitureCell:OnDestroy()
end

function FurnitureCell:RefreshCell(data)
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
  if data.using then
    self._restNum:SetActive(false)
    self._disable:SetActive(false)
    self._using:SetActive(true)
    self._reachLimit:SetActive(false)
  elseif data.enable then
    self._restNum:SetActive(true)
    self._disable:SetActive(false)
    self._using:SetActive(false)
    self._reachLimit:SetActive(false)
    self._restNum:SetText(data.num)
  elseif data.disable then
    self._restNum:SetActive(true)
    self._disable:SetActive(true)
    self._using:SetActive(false)
    self._reachLimit:SetActive(false)
    self._restNum:SetText(data.num)
  elseif data.reachLimit then
    self._restNum:SetActive(true)
    self._disable:SetActive(false)
    self._using:SetActive(false)
    self._reachLimit:SetActive(true)
    self._restNum:SetText(data.num)
  end
end

function FurnitureCell:OnCellClicked()
  if self._cellData.enable then
    self._delegate._delegate:UseFurniture(self._cellData)
  elseif self._cellData.using then
    LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {
      layerId = self._cellData.item:GetLayerId(),
      key = self._cellData.key
    })
  end
end

function FurnitureCell:OnReduceClicked()
  if self._cellData.using then
    self._delegate._delegate:UnloadFurniture(self._cellData)
  end
end

return FurnitureCell
