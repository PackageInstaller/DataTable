-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/roleaddcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local RoleAddCell = class("RoleAddCell", Dialog)
RoleAddCell.AssetBundleName = "ui/layouts.activitystar"
RoleAddCell.AssetName = "ActivityStarMainChar"
RoleAddCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAddCell
  ((RoleAddCell.super).Ctor)(self, ...)
end

RoleAddCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._downRankBack = self:GetChild("CharSmallCell/DownRankBack")
  self._level = self:GetChild("CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("CharSmallCell/RankBack")
  self._rank = self:GetChild("CharSmallCell/Rank")
  self._job = self:GetChild("CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("CharSmallCell/BreakLevel")
  self._element = self:GetChild("CharSmallCell/Element")
  self._grey = self:GetChild("CharSmallCell/Grey")
  self._select = self:GetChild("CharSmallCell/Select")
  self._txt = self:GetChild("Txt")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnCheckRoleBaseInfoBtnClick, self)
end

RoleAddCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAddCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role
  local role = (Role.Create)(data.roleid)
  local image = role:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  image = role:GetRarityBottomBackRecord()
  ;
  (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._level):SetText(role:GetShowLv())
  image = role:GetRarityImageRecord()
  ;
  (self._rank):SetSprite(image.assetBundle, image.assetName)
  image = role:GetVocationImageRecord()
  ;
  (self._job):SetSprite(image.assetBundle, image.assetName)
  image = role:GetElementImageRecord()
  ;
  (self._element):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._txt):SetText(data.boostpercentage .. "%")
end

RoleAddCell.OnCheckRoleBaseInfoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CheckOtherRoleInfoDialog
  local index = nil
  local roleIdList = {}
  local cfgIdList = {}
  for i,v in ipairs((self._delegate)._roleAddRecordList) do
    if not index and v.id == (self._cellData).id then
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

return RoleAddCell

