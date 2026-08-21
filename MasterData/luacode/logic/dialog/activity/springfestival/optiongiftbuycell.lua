-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/optiongiftbuycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSelectItemCfg = (BeanManager.GetTableByName)("item.cselectitemcfg")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local OptionGiftBuyCell = class("OptionGiftBuyCell", Dialog)
OptionGiftBuyCell.AssetBundleName = "ui/layouts.activitynewyear"
OptionGiftBuyCell.AssetName = "ActivityNewYearRoleOptionalBuyCell"
OptionGiftBuyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OptionGiftBuyCell
  ((OptionGiftBuyCell.super).Ctor)(self, ...)
end

OptionGiftBuyCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Item")
  self._name = self:GetChild("ItemName")
  self._frame = self:GetChild("Frame")
  self._element = self:GetChild("Element")
  self._job = self:GetChild("Job")
  self._rank = self:GetChild("Rank")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

OptionGiftBuyCell.OnDestroy = function(self)
  -- function num : 0_2
end

OptionGiftBuyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSelectItemCfg, CImagePathTable, _ENV, CRoleItem, Role
  local recorder = CSelectItemCfg:GetRecorder(data.id)
  if not CImagePathTable:GetRecorder(recorder.icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  if data.option and data.option > 0 then
    local roleCfg = CRoleItem:GetRecorder(data.option)
    local role = (Role.Create)(roleCfg.roleid)
    if not role:GetShapeLittleHeadImageRecord() then
      local image = DataCommon.DefaultImageAsset
    end
    ;
    (self._icon):SetSprite(image.assetBundle, image.assetName)
    image = role:GetElementImageRecord()
    ;
    (self._element):SetSprite(image.assetBundle, image.assetName)
    image = role:GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    image = role:GetRarityImageRecord()
    ;
    (self._rank):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._element):SetActive(true)
    ;
    (self._job):SetActive(true)
    ;
    (self._rank):SetActive(true)
  else
    do
      ;
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._element):SetActive(false)
      ;
      (self._job):SetActive(false)
      ;
      (self._rank):SetActive(false)
      ;
      (self._name):SetText((TextManager.GetText)(recorder.description))
    end
  end
end

OptionGiftBuyCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.springfestival.roleopstiondialog")):SetData(self._cellData, self._delegate)
end

return OptionGiftBuyCell

