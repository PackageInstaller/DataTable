local CSelectItemCfg = BeanManager.GetTableByName("item.cselectitemcfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemTable = BeanManager.GetTableByName("item.citemattr")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local OptionGiftBuyCell = class("OptionGiftBuyCell", Dialog)
OptionGiftBuyCell.AssetBundleName = "ui/layouts.activitynewyear"
OptionGiftBuyCell.AssetName = "ActivityNewYearRoleOptionalBuyCell"

function OptionGiftBuyCell:Ctor(...)
  OptionGiftBuyCell.super.Ctor(self, ...)
end

function OptionGiftBuyCell:OnCreate()
  self._icon = self:GetChild("Item")
  self._name = self:GetChild("ItemName")
  self._frame = self:GetChild("Frame")
  self._element = self:GetChild("Element")
  self._job = self:GetChild("Job")
  self._rank = self:GetChild("Rank")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function OptionGiftBuyCell:OnDestroy()
end

function OptionGiftBuyCell:RefreshCell(data)
  local recorder = CSelectItemCfg:GetRecorder(data.id)
  local imageRecord = CImagePathTable:GetRecorder(recorder.icon) or DataCommon.DefaultImageAsset
  if data.option and data.option > 0 then
    local roleCfg = CRoleItem:GetRecorder(data.option)
    local role = Role.Create(roleCfg.roleid)
    local image = role:GetShapeLittleHeadImageRecord() or DataCommon.DefaultImageAsset
    self._icon:SetSprite(image.assetBundle, image.assetName)
    image = role:GetElementImageRecord()
    self._element:SetSprite(image.assetBundle, image.assetName)
    image = role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    image = role:GetRarityImageRecord()
    self._rank:SetSprite(image.assetBundle, image.assetName)
    self._element:SetActive(true)
    self._job:SetActive(true)
    self._rank:SetActive(true)
  else
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._element:SetActive(false)
    self._job:SetActive(false)
    self._rank:SetActive(false)
  end
  self._name:SetText(TextManager.GetText(recorder.description))
end

function OptionGiftBuyCell:OnCellClicked()
  DialogManager.CreateSingletonDialog("activity.springfestival.roleopstiondialog"):SetData(self._cellData, self._delegate)
end

return OptionGiftBuyCell
