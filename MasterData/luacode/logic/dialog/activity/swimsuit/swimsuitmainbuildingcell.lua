local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local UIManager = CS.PixelNeko.UI.UIManager
local SwimSuitMainBuildingCell = class("SwimSuitMainBuildingCell", Dialog)
SwimSuitMainBuildingCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainBuildingCell.AssetName = "ActivitySummerMainBuyCell"

function SwimSuitMainBuildingCell:Ctor(...)
  SwimSuitMainBuildingCell.super.Ctor(self, ...)
end

function SwimSuitMainBuildingCell:OnCreate()
  self._back = self:GetChild("Back")
  self._itemIcon = self:GetChild("Back/Item")
  self._name = self:GetChild("Back/Name")
  self._num = self:GetChild("Back/Num")
  self._num:SetActive(false)
  self._usingPanel = self:GetChild("Using")
  self._select = self:GetChild("Select")
  self._reduceBtn = self:GetChild("Using/Using/Reduce")
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._itemIcon:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SwimSuitMainBuildingCell:OnGlobalPointerDown(args)
end

function SwimSuitMainBuildingCell:OnDestroy()
end

function SwimSuitMainBuildingCell:RefreshCell(data)
  self._select:SetActive(false)
  local recorder = CHexagonLand:GetRecorder(data.id)
  local image = CImagePathTable:GetRecorder(recorder.image) or DataCommon.DefaultImageAsset
  self._itemIcon:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(TextManager.GetText(recorder.name))
  if data.tag == "DIY" then
    self._usingPanel:SetActive(data.used)
  elseif data.tag == "SHOP" then
    self._usingPanel:SetActive(false)
  end
end

function SwimSuitMainBuildingCell:OnCellClick()
  if not self._cellData.used then
    self._delegate:OnBuildingCellClick(self._cellData.id)
  end
end

function SwimSuitMainBuildingCell:OnReduceClick()
  self._delegate:OnBuildingCellReduceClick(self._cellData.id)
end

function SwimSuitMainBuildingCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._select:SetActive(self._cellData.id == arg)
  end
end

return SwimSuitMainBuildingCell
