local FirstGachaDetailCell = class("FirstGachaDetailCell", Dialog)
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
FirstGachaDetailCell.AssetBundleName = "ui/layouts.gacha"
FirstGachaDetailCell.AssetName = "FirstGachaDetailCell"

function FirstGachaDetailCell:Ctor(...)
  FirstGachaDetailCell.super.Ctor(self, ...)
end

function FirstGachaDetailCell:OnCreate()
  self._backImg = self:GetChild("Back")
  self._jobTxt = self:GetChild("Job")
  self._titleTxt = self:GetChild("Title")
  self._nameTxt = self:GetChild("Name")
  self._jobImg = self:GetChild("JobImg")
  self._rankImg = self:GetChild("Rank")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function FirstGachaDetailCell:OnDestroy()
  DialogManager.DestroySingletonDialog("mainline.bossrush.checkotherroleinfodialog")
end

function FirstGachaDetailCell:RefreshCell(data)
  if data then
    self._roleId = data.roleId
    local role = Role.Create(self._roleId)
    local imgRecord = CImagePathTable:GetRecorder(data.imgId) or DataCommon.DefaultImageAsset
    self._backImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self._jobTxt:SetText(role:GetVocationName())
    self._titleTxt:SetText(role:GetTitleName())
    self._nameTxt:SetText(role:GetRoleName())
    imgRecord = role:GetVocationDescribeImageRecord()
    self._jobImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = role:GetRarityImageRecord()
    self._rankImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
end

function FirstGachaDetailCell:OnCellClick(args)
  DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog"):Init({
    roleIdList = {
      self._roleId
    },
    cfgIdList = {3},
    index = 1
  }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
end

return FirstGachaDetailCell
