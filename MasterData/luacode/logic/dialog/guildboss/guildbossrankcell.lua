local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local GuildBossRankCell = class("GuildBossRankCell", Dialog)
GuildBossRankCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankCell.AssetName = "GuildBossRankGuildCell"

function GuildBossRankCell:Ctor(...)
  GuildBossRankCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossRankCell:OnCreate()
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    self._rankIcon[i] = self:GetChild("Panel/Rank" .. i)
    self._cellBack[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._score = self:GetChild("Panel/Number")
  self._score:SetText("")
  self._guildName = self:GetChild("Panel/GuildInfo/NameBack/NameGuild")
  self._guildName:SetText("")
  self._guildLevel = self:GetChild("Panel/GuildInfo/NameBack/Name")
  self._guildLevel:SetText("")
  self._guildLogo = self:GetChild("Panel/GuildInfo/IntroductionBack")
end

function GuildBossRankCell:OnDestroy()
end

function GuildBossRankCell:RefreshCell()
  if self._cellData.rank > 3 then
    self._rank:SetText(self._cellData.rank)
  end
  self._rank:SetActive(self._cellData.rank > 3)
  for i = 1, 3 do
    self._rankIcon[i]:SetActive(i == self._cellData.rank)
    self._cellBack[i]:SetActive(i == self._cellData.rank)
  end
  self._guildName:SetText(self._cellData.name)
  self._guildLevel:SetText("Lv" .. self._cellData.lv)
  self._score:SetText(self._cellData.score)
  local headPhotoRecord = CGuildHead:GetRecorder(self._cellData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePath:GetRecorder(headPhotoRecord.UiId) or DataCommon.DefaultImageAsset
    self._guildLogo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

return GuildBossRankCell
