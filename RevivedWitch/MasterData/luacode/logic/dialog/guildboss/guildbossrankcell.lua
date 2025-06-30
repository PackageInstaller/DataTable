-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local GuildBossRankCell = class("GuildBossRankCell", Dialog)
GuildBossRankCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankCell.AssetName = "GuildBossRankGuildCell"
GuildBossRankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankCell
  ((GuildBossRankCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossRankCell.OnCreate = function(self)
  -- function num : 0_1
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    (self._rankIcon)[i] = self:GetChild("Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._cellBack)[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._score = self:GetChild("Panel/Number")
  ;
  (self._score):SetText("")
  self._guildName = self:GetChild("Panel/GuildInfo/NameBack/NameGuild")
  ;
  (self._guildName):SetText("")
  self._guildLevel = self:GetChild("Panel/GuildInfo/NameBack/Name")
  ;
  (self._guildLevel):SetText("")
  self._guildLogo = self:GetChild("Panel/GuildInfo/IntroductionBack")
end

GuildBossRankCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossRankCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : CGuildHead, CImagePath, _ENV
  if (self._cellData).rank > 3 then
    (self._rank):SetText((self._cellData).rank)
  end
  ;
  (self._rank):SetActive((self._cellData).rank > 3)
  for i = 1, 3 do
    ((self._rankIcon)[i]):SetActive(i == (self._cellData).rank)
    ;
    ((self._cellBack)[i]):SetActive(i == (self._cellData).rank)
  end
  ;
  (self._guildName):SetText((self._cellData).name)
  ;
  (self._guildLevel):SetText("Lv" .. (self._cellData).lv)
  ;
  (self._score):SetText((self._cellData).score)
  local headPhotoRecord = CGuildHead:GetRecorder((self._cellData).avatarId)
  do
    if headPhotoRecord then
      if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._guildLogo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

return GuildBossRankCell

