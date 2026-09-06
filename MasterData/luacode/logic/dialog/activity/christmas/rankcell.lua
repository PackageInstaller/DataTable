local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local RankCell = class("RankCell", Dialog)
RankCell.AssetBundleName = "ui/layouts.activitystar"
RankCell.AssetName = "ActivityStarRankCell"

function RankCell:Ctor(...)
  RankCell.super.Ctor(self, ...)
end

function RankCell:OnCreate()
  self._backs = {}
  self._ranks = {}
  for i = 1, 3 do
    self._backs[i] = self:GetChild("Back" .. i)
    self._ranks[i] = self:GetChild("Panel/Rank" .. i)
  end
  self._selfBack = self:GetChild("BackPlayer")
  self._normalBack = self:GetChild("Back")
  self._normalRank = self:GetChild("Panel/Rank")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._charIcons = {}
  self._charIcons[LineUpStation.BACK_ROW] = self:GetChild("Panel/CharBack" .. 1 .. "/Char")
  self._charIcons[LineUpStation.MIDDLE_ROW] = self:GetChild("Panel/CharBack" .. 2 .. "/Char")
  self._charIcons[LineUpStation.FRONT_ROW] = self:GetChild("Panel/CharBack" .. 3 .. "/Char")
  self._time = self:GetChild("Panel/Time")
  self._difficultyTxt = self:GetChild("Panel/Level")
  self:GetChild("Panel/Click"):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

function RankCell:OnDestroy()
end

function RankCell:RefreshCell(data)
  self._normalRank:SetText(data.rank)
  self._normalRank:SetActive(data.rank > 3)
  for i = 1, 3 do
    self._ranks[i]:SetActive(i == data.rank)
    self._backs[i]:SetActive(i == data.rank)
  end
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  self._selfBack:SetActive(data.rank > 3 and data.baseUserData.userId == userInfo.userid)
  self._normalBack:SetActive(data.rank > 3 and data.baseUserData.userId ~= userInfo.userid)
  self._selfName:SetActive(data.baseUserData.userId == userInfo.userid)
  self._name:SetActive(data.baseUserData.userId ~= userInfo.userid)
  self._selfName:SetText(data.baseUserData.userName)
  self._name:SetText(data.baseUserData.userName)
  self._level:SetText(data.baseUserData.userLv)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  local num = data.bossPanelData.passTime / 1000
  local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
  str = string.gsub(str, "%$parameter1%$", ret)
  self._time:SetText(str)
  self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(data.bossPanelData.times, "Christmas"))
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.baseUserData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankCell", "headPhotoRecord not found. avatarId = %s", data.baseUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.baseUserData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankCell", "headPhotoFrameRecord not found. frameId = %s", data.baseUserData.frameId)
  end
  for index, roleid in ipairs(data.bossPanelData.roleIdList) do
    if self._charIcons[index] then
      if 0 < roleid then
        self._charIcons[index]:SetActive(true)
        local shapeCfg
        local skinId = data.bossPanelData.roleSkinList[index]
        if 0 < skinId then
          local skin = CSkin:GetRecorder(skinId)
          shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
        else
          local roleCfg = RoleConfigTable:GetRecorder(roleid)
          shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
        end
        local imageRecord = CImagePathTable:GetRecorder(shapeCfg.skillHeadID) or DataCommon.DefaultImageAsset
        self._charIcons[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        index = index + 1
      else
        self._charIcons[index]:SetActive(false)
      end
    end
  end
end

function RankCell:OnTeamClicked()
  DialogManager.CreateSingletonDialog("activity.christmas.rankteaminfodialog"):InitDataInfo(self._cellData, self._delegate._delegate._tabType)
end

return RankCell
