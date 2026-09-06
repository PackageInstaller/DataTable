local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local BossRushWeekRankCell = class("BossRushWeekRankCell", Dialog)
BossRushWeekRankCell.AssetBundleName = "ui/layouts.mainline"
BossRushWeekRankCell.AssetName = "BossRushWeekRankCell"

function BossRushWeekRankCell:Ctor(...)
  BossRushWeekRankCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function BossRushWeekRankCell:OnCreate()
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    self._rankIcon[i] = self:GetChild("Panel/Rank" .. i)
    self._cellBack[i] = self:GetChild("Back" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._commonBack = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self:GetChild("Panel/Click"):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

function BossRushWeekRankCell:OnDestroy()
end

function BossRushWeekRankCell:RefreshCell()
  if self._cellData.rank > 3 then
    self._rank:SetText(self._cellData.rank)
  end
  self._rank:SetActive(self._cellData.rank > 3)
  for i = 1, 3 do
    self._rankIcon[i]:SetActive(i == self._cellData.rank)
    self._cellBack[i]:SetActive(i == self._cellData.rank)
  end
  self._selfBack:SetActive(self._cellData.rank > 3 and self._cellData.baseUserData.userId == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._commonBack:SetActive(self._cellData.rank > 3 and self._cellData.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetActive(self._cellData.baseUserData.userId == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._name:SetActive(self._cellData.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid)
  self._selfName:SetText(self._cellData.baseUserData.userName)
  self._name:SetText(self._cellData.baseUserData.userName)
  self._level:SetText(self._cellData.baseUserData.userLv)
  local str = CStringRes:GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = self._cellData.bossPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._cellData.baseUserData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("BossRushWeekRankCell", "headPhotoRecord not found. avatarId = %s", self._cellData.baseUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._cellData.baseUserData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("BossRushWeekRankCell", "headPhotoFrameRecord not found. frameId = %s", self._cellData.baseUserData.frameId)
  end
end

function BossRushWeekRankCell:OnTeamClicked()
  local rankId = NekoData.BehaviorManager.BM_WeekBoss:GetLastWeekRankId()
  if not rankId then
    LogError("BossRushWeekRankCell", "lastweek topThree rankId is nil")
    return
  end
  DialogManager.CreateSingletonDialog("mainline.bossrush.bossrushteaminfodialog"):InitDataInfo(self._cellData, NekoData.BehaviorManager.BM_WeekBoss:GetLastWeekBossId(), self._delegate._isWeekBoss, rankId)
end

return BossRushWeekRankCell
