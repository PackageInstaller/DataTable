-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/firstgachaeetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FirstGachaDetailCell = class("FirstGachaDetailCell", Dialog)
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
FirstGachaDetailCell.AssetBundleName = "ui/layouts.gacha"
FirstGachaDetailCell.AssetName = "FirstGachaDetailCell"
FirstGachaDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FirstGachaDetailCell
  ((FirstGachaDetailCell.super).Ctor)(self, ...)
end

FirstGachaDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._backImg = self:GetChild("Back")
  self._jobTxt = self:GetChild("Job")
  self._titleTxt = self:GetChild("Title")
  self._nameTxt = self:GetChild("Name")
  self._jobImg = self:GetChild("JobImg")
  self._rankImg = self:GetChild("Rank")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

FirstGachaDetailCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
end

FirstGachaDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role, CImagePathTable, _ENV
  if data then
    self._roleId = data.roleId
    local role = (Role.Create)(self._roleId)
    if not CImagePathTable:GetRecorder(data.imgId) then
      local imgRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._backImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    ;
    (self._jobTxt):SetText(role:GetVocationName())
    ;
    (self._titleTxt):SetText(role:GetTitleName())
    ;
    (self._nameTxt):SetText(role:GetRoleName())
    imgRecord = role:GetVocationDescribeImageRecord()
    ;
    (self._jobImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = role:GetRarityImageRecord()
    ;
    (self._rankImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
end

FirstGachaDetailCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : _ENV, CheckOtherRoleInfoDialog
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")):Init({
roleIdList = {self._roleId}
, 
cfgIdList = {3}
, index = 1}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
end

return FirstGachaDetailCell

