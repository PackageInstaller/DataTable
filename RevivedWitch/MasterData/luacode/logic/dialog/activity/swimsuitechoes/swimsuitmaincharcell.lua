-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitmaincharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local SwimSuitMainCharCell = class("SwimSuitMainCharCell", Dialog)
SwimSuitMainCharCell.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitMainCharCell.AssetName = "ActivitySummer2MainChar"
SwimSuitMainCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitMainCharCell
  ((SwimSuitMainCharCell.super).Ctor)(self, ...)
end

SwimSuitMainCharCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._upTxt = self:GetChild("Txt")
  ;
  (self._frame):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SwimSuitMainCharCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitMainCharCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role
  local role = (Role.Create)(data.roleid)
  local image = role:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._upTxt):SetText(data.boostpercentage .. "%")
end

SwimSuitMainCharCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CheckOtherRoleInfoDialog
  local index = nil
  local roleIdList = {}
  local cfgIdList = {}
  for i,v in ipairs((self._delegate)._charUpData) do
    if not index and v.roleid == (self._cellData).roleid then
      index = i
    end
    ;
    (table.insert)(roleIdList, v.roleid)
    ;
    (table.insert)(cfgIdList, 3)
  end
  ;
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")):Init({roleIdList = roleIdList, cfgIdList = cfgIdList, index = index}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
end

return SwimSuitMainCharCell

