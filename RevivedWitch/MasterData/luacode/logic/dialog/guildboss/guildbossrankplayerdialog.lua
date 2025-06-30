-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossrankplayerdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuildBossRankPlayerDialog = class("GuildBossRankPlayerDialog", Dialog)
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CGuildBossInfo = (BeanManager.GetTableByName)("guild.cguildchallengebossinfo")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
GuildBossRankPlayerDialog.AssetBundleName = "ui/layouts.guild"
GuildBossRankPlayerDialog.AssetName = "GuildBossRankPlayerFrame"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
GuildBossRankPlayerDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossRankPlayerDialog
  ((GuildBossRankPlayerDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossRankPlayerDialog.OnCreate = function(self)
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

    (self._personalRankPanel_rankIcon)[i] = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._personalRankPanel_cellBack)[i] = self:GetChild("Char/GuildBossRankPlayerCell/Back" .. i)
  end
  ;
  (self:GetChild("Char/GuildBossRankPlayerCell/BackPlayer")):SetActive(true)
  ;
  (self:GetChild("Char/GuildBossRankPlayerCell/Back")):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Rank")
  self._personalRankPanel_battleTimes = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Number1")
  ;
  (self._personalRankPanel_battleTimes):SetText("")
  self._personalRankPanel_damageNum = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Number2")
  ;
  (self._personalRankPanel_damageNum):SetText("")
  self._personalRankPanel_photo = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._personalRankPanel_photoFrame = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._personalRankPanel_name = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/NameBack/Name")
  self._personalRankPanel_selfName = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._personalRankPanel_level = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/LvBack/Level")
  self._personalRankPanel_click = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Click")
  ;
  (self._personalRankPanel_click):SetActive(false)
end

GuildBossRankPlayerDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossRankPlayerDialog.Refresh = function(self, selectBossId, rankList, personalRankData)
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

GuildBossRankPlayerDialog.NumberOfCell = function(self, helper)
  -- function num : 0_4
  return #self._rankList
end

GuildBossRankPlayerDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_5
  return "guildboss.guildbossrankplayercell"
end

GuildBossRankPlayerDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_6
  return (self._rankList)[index]
end

GuildBossRankPlayerDialog.RefreshPersonalRank = function(self)
  -- function num : 0_7 , upvalues : CGuildBossInfo, _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable
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
    (self._personalRankPanel_level):SetText((self._personalRankData).lv)
    ;
    (self._personalRankPanel_name):SetActive(false)
    ;
    (self._personalRankPanel_selfName):SetText((self._personalRankData).name)
    ;
    (self._personalRankPanel_battleTimes):SetText((self._personalRankData).extra)
    local recorder = CGuildBossInfo:GetRecorder(self._selectBossId)
    do
      if recorder then
        local Num = (string.format)("%.2f", (self._personalRankData).score / recorder.point1 * 100)
        Num = Num .. "%"
        ;
        (self._personalRankPanel_damageNum):SetText(Num)
      end
      local headPhotoRecord = HeadPhotoTable:GetRecorder((self._personalRankData).avatarId)
      if headPhotoRecord then
        if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._personalRankPanel_photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        (self._personalRankPanel_photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
      end
      do
        local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((self._personalRankData).frameId)
        if headPhotoFrameRecord then
          if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._personalRankPanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          (self._personalRankPanel_photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
        end
        ;
        (self._personalRankPanel):SetActive(false)
        -- DECOMPILER ERROR: 10 unprocessed JMP targets
      end
    end
  end
end

return GuildBossRankPlayerDialog

