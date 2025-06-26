-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankguilddialog.lua 

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
local GuildBossRankGuildDialog = class("GuildBossRankGuildDialog", Dialog)
GuildBossRankGuildDialog.AssetBundleName = "ui/layouts.guild"
GuildBossRankGuildDialog.AssetName = "GuildBossRankGuildFrame"
GuildBossRankGuildDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankGuildDialog
  ((GuildBossRankGuildDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossRankGuildDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = (TableFrame.Create)(self._rankFrame, self, true, true, true)
  self._emptyText = self:GetChild("EmptyTxt")
  ;
  (self._emptyText):SetActive(false)
  self._personalRankPanel = self:GetChild("Char")
  self._myEmptyText = self:GetChild("Char/EmptyTxt")
  ;
  (self._myEmptyText):SetActive(false)
  self._personalRankPanel_rankIcon = {}
  self._personalRankPanel_cellBack = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

    (self._personalRankPanel_rankIcon)[i] = self:GetChild("Char/GuildBossRankGuildCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._personalRankPanel_cellBack)[i] = self:GetChild("Char/GuildBossRankGuildCell/Back" .. i)
  end
  ;
  (self:GetChild("Char/GuildBossRankGuildCell/BackPlayer")):SetActive(true)
  ;
  (self:GetChild("Char/GuildBossRankGuildCell/Back")):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/GuildBossRankGuildCell/Panel/Rank")
  self._personalRankPanel_score = self:GetChild("Char/GuildBossRankGuildCell/Panel/Number")
  ;
  (self._personalRankPanel_score):SetText("")
  self._personalRankPanel_guildName = self:GetChild("Char/GuildBossRankGuildCell/Panel/GuildInfo/NameBack/NameGuild")
  ;
  (self._personalRankPanel_guildName):SetText("")
  self._personalRankPanel_guildLevel = self:GetChild("Char/GuildBossRankGuildCell/Panel/GuildInfo/NameBack/Name")
  ;
  (self._personalRankPanel_guildLevel):SetText("")
  self._personalRankPanel_guildLogo = self:GetChild("Char/GuildBossRankGuildCell/Panel/GuildInfo/IntroductionBack")
  self._personalRankPanel_txt = self:GetChild("Char/GuildBossRankGuildCell/Panel/Txt")
  self._personalRankPanel_click = self:GetChild("Char/GuildBossRankGuildCell/Panel/Click")
  ;
  (self._personalRankPanel_click):SetActive(false)
end

GuildBossRankGuildDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossRankGuildDialog.Refresh = function(self, selectBossId, rankList, personalRankData)
  -- function num : 0_3
  self._selectBossId = selectBossId
  self._rankList = rankList
  self._personalRankData = personalRankData
  ;
  (self._rankHelper):ReloadAllCell()
  ;
  (self._rankHelper):MoveToTop()
  self:RefreshPersonalRank()
  local rankNum = #self._rankList
  ;
  (self._emptyText):SetActive(rankNum == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GuildBossRankGuildDialog.NumberOfCell = function(self, helper)
  -- function num : 0_4
  return #self._rankList
end

GuildBossRankGuildDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  return "guildboss.guildbossrankcell"
end

GuildBossRankGuildDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_6
  return (self._rankList)[index]
end

GuildBossRankGuildDialog.RefreshPersonalRank = function(self)
  -- function num : 0_7 , upvalues : CGuildHead, CImagePath, _ENV
  if self._personalRankData then
    (self._personalRankPanel):SetActive(true)
    if (self._personalRankData).rank > 3 then
      (self._personalRankPanel_rank):SetActive(true)
      ;
      (self._personalRankPanel_rank):SetText((self._personalRankData).rank)
    else
      if (self._personalRankData).rank == -1 then
        (self._personalRankPanel_rank):SetActive(true)
        ;
        (self._personalRankPanel_rank):SetText("未上榜")
      else
        if (self._personalRankData).rank == -2 then
          (self._personalRankPanel_rank):SetActive(true)
          ;
          (self._personalRankPanel_rank):SetText("未挑战")
        else
          ;
          (self._personalRankPanel_rank):SetActive(false)
        end
      end
    end
    for i = 1, 3 do
      ((self._personalRankPanel_rankIcon)[i]):SetActive(i == (self._personalRankData).rank)
      ;
      ((self._personalRankPanel_cellBack)[i]):SetActive(i == (self._personalRankData).rank)
    end
    ;
    (self._personalRankPanel_guildName):SetText((self._personalRankData).name)
    ;
    (self._personalRankPanel_guildLevel):SetText("Lv" .. (self._personalRankData).lv)
    ;
    (self._personalRankPanel_score):SetText((self._personalRankData).score)
    local headPhotoRecord = CGuildHead:GetRecorder((self._personalRankData).avatarId)
    if headPhotoRecord then
      if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._personalRankPanel_guildLogo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    (self._personalRankPanel):SetActive(false)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

return GuildBossRankGuildDialog

