local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local GuildBossRankPlayerCell = class("GuildBossRankPlayerCell", Dialog)
GuildBossRankPlayerCell.AssetBundleName = "ui/layouts.guild"
GuildBossRankPlayerCell.AssetName = "GuildBossRankPlayerCell"

function GuildBossRankPlayerCell:Ctor(...)
  GuildBossRankPlayerCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossRankPlayerCell:OnCreate()
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    self._rankIcon[i] = self:GetChild("Panel/Rank" .. i)
    self._cellBack[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._battleTimes = self:GetChild("Panel/Number1")
  self._battleTimes:SetText("")
  self._damageNum = self:GetChild("Panel/Number2")
  self._damageNum:SetText("")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
end

function GuildBossRankPlayerCell:OnDestroy()
end

function GuildBossRankPlayerCell:RefreshCell()
  if self._cellData.rank > 3 then
    self._rank:SetText(self._cellData.rank)
  end
  self._rank:SetActive(self._cellData.rank > 3)
  for i = 1, 3 do
    self._rankIcon[i]:SetActive(i == self._cellData.rank)
    self._cellBack[i]:SetActive(i == self._cellData.rank)
  end
  self._selfBack:SetActive(self._cellData.rank > 3 and self._cellData.id == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._commonBack:SetActive(self._cellData.rank > 3 and self._cellData.id ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetActive(self._cellData.id == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._name:SetActive(self._cellData.id ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetText(self._cellData.name)
  self._name:SetText(self._cellData.name)
  self._level:SetText(self._cellData.lv)
  self._battleTimes:SetText(self._cellData.extra)
  local recorder = CGuildBossInfo:GetRecorder(self._delegate._selectBossId)
  if recorder then
    local Num = string.format("%.2f", self._cellData.score / recorder.point1 * 100)
    Num = Num .. "%"
    self._damageNum:SetText(Num)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._cellData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._cellData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
  end
end

return GuildBossRankPlayerCell
