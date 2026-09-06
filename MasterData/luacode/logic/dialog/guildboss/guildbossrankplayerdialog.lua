local GuildBossRankPlayerDialog = class("GuildBossRankPlayerDialog", Dialog)
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
GuildBossRankPlayerDialog.AssetBundleName = "ui/layouts.guild"
GuildBossRankPlayerDialog.AssetName = "GuildBossRankPlayerFrame"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function GuildBossRankPlayerDialog:Ctor(...)
  GuildBossRankPlayerDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossRankPlayerDialog:OnCreate()
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = TableFrame.Create(self._rankFrame, self, true, true, true)
  self._emptyText = self:GetChild("EmptyTxt")
  self._emptyText:SetActive(false)
  self._personalRankPanel = self:GetChild("Char")
  self._myEmptyText = self:GetChild("Char/EmptyTxt")
  self._myEmptyText:SetActive(false)
  self._personalRankPanel_rankIcon = {}
  self._personalRankPanel_cellBack = {}
  for i = 1, 3 do
    self._personalRankPanel_rankIcon[i] = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Rank" .. i)
    self._personalRankPanel_cellBack[i] = self:GetChild("Char/GuildBossRankPlayerCell/Back" .. i)
  end
  self:GetChild("Char/GuildBossRankPlayerCell/BackPlayer"):SetActive(true)
  self:GetChild("Char/GuildBossRankPlayerCell/Back"):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Rank")
  self._personalRankPanel_battleTimes = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Number1")
  self._personalRankPanel_battleTimes:SetText("")
  self._personalRankPanel_damageNum = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Number2")
  self._personalRankPanel_damageNum:SetText("")
  self._personalRankPanel_photo = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._personalRankPanel_photoFrame = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._personalRankPanel_name = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/NameBack/Name")
  self._personalRankPanel_selfName = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._personalRankPanel_level = self:GetChild("Char/GuildBossRankPlayerCell/Panel/PlayerInfo/LvBack/Level")
  self._personalRankPanel_click = self:GetChild("Char/GuildBossRankPlayerCell/Panel/Click")
  self._personalRankPanel_click:SetActive(false)
end

function GuildBossRankPlayerDialog:OnDestroy()
end

function GuildBossRankPlayerDialog:Refresh(selectBossId, rankList, personalRankData)
  self._selectBossId = selectBossId
  self._rankList = rankList
  self._personalRankData = personalRankData
  self._rankHelper:ReloadAllCell()
  self._rankHelper:MoveToTop()
  self:RefreshPersonalRank()
  local rankNum = #self._rankList
  self._emptyText:SetActive(rankNum == 0)
end

function GuildBossRankPlayerDialog:NumberOfCell(helper)
  return #self._rankList
end

function GuildBossRankPlayerDialog:CellAtIndex(helper, index)
  return "guildboss.guildbossrankplayercell"
end

function GuildBossRankPlayerDialog:DataAtIndex(helper, index)
  return self._rankList[index]
end

function GuildBossRankPlayerDialog:RefreshPersonalRank()
  if self._personalRankData then
    self._personalRankPanel:SetActive(true)
    if self._personalRankData.rank > 3 then
      self._personalRankPanel_rank:SetActive(true)
      self._personalRankPanel_rank:SetText(self._personalRankData.rank)
    elseif self._personalRankData.rank == -1 then
      self._personalRankPanel_rank:SetActive(true)
      self._personalRankPanel_rank:SetText("未上榜")
    elseif self._personalRankData.rank == -2 then
      self._personalRankPanel_rank:SetActive(true)
      self._personalRankPanel_rank:SetText("未挑战")
    else
      self._personalRankPanel_rank:SetActive(false)
    end
    for i = 1, 3 do
      self._personalRankPanel_rankIcon[i]:SetActive(i == self._personalRankData.rank)
      self._personalRankPanel_cellBack[i]:SetActive(i == self._personalRankData.rank)
    end
    self._personalRankPanel_level:SetText(self._personalRankData.lv)
    self._personalRankPanel_name:SetActive(false)
    self._personalRankPanel_selfName:SetText(self._personalRankData.name)
    self._personalRankPanel_battleTimes:SetText(self._personalRankData.extra)
    local recorder = CGuildBossInfo:GetRecorder(self._selectBossId)
    if recorder then
      local Num = string.format("%.2f", self._personalRankData.score / recorder.point1 * 100)
      Num = Num .. "%"
      self._personalRankPanel_damageNum:SetText(Num)
    end
    local headPhotoRecord = HeadPhotoTable:GetRecorder(self._personalRankData.avatarId)
    if headPhotoRecord then
      local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
      self._personalRankPanel_photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._personalRankPanel_photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._personalRankData.frameId)
    if headPhotoFrameRecord then
      local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
      self._personalRankPanel_photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._personalRankPanel_photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    end
  else
    self._personalRankPanel:SetActive(false)
  end
end

return GuildBossRankPlayerDialog
