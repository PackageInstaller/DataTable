local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local RankCell = class("RankCell", Dialog)
RankCell.AssetBundleName = "ui/layouts.activitynewyear"
RankCell.AssetName = "ActivityNewYearlRoleOptionalCell"

function RankCell:Ctor(...)
  RankCell.super.Ctor(self, ...)
end

function RankCell:OnCreate()
  self._check = self:GetChild("Cell/Check")
  self._element = self:GetChild("Cell/Element")
  self._job = self:GetChild("Cell/Job")
  self._frame = self:GetChild("Cell/Frame")
  self._photo = self:GetChild("Cell/Photo")
  self._name = self:GetChild("Name")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

function RankCell:OnDestroy()
end

function RankCell:RefreshCell(id)
  local roleCfg = CRoleItem:GetRecorder(id)
  local role = Role.Create(roleCfg.roleid)
  self._role = role
  self._name:SetText(role:GetRoleName())
  local rarity = role:GetRarityImageRecord()
  local image = role:GetSmallRarityBackRecord()
  image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  image = role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  if id == self._delegate._data.option then
    self._check:SetActive(true)
  else
    self._check:SetActive(false)
  end
end

function RankCell:OnCellClicked()
  if self._cellData == self._delegate._data.option then
    self._delegate:OnCellClicked(nil)
  else
    self._delegate:OnCellClicked(self._cellData)
  end
end

function RankCell:OnCellLongPress()
  local role = self._role
  local dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  if dialog then
    dialog:Init({
      roleIdList = {
        role:GetId()
      },
      cfgIdList = {3},
      index = 1
    }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
  end
end

function RankCell:OnEvent(arg)
  if arg == self._cellData then
    self._check:SetActive(true)
  else
    self._check:SetActive(false)
  end
end

return RankCell
