local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local BossChallenge = LuaNetManager.GetBeanDef("protocol.ranking.bosschallenge")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local RankTabCell = class("RankTabCell", Dialog)
RankTabCell.AssetBundleName = "ui/layouts.activitystar"
RankTabCell.AssetName = "ActivityStarRankFrame"

function RankTabCell:Ctor(...)
  RankTabCell.super.Ctor(self, ...)
end

function RankTabCell:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Frame")
  self._emptyTxt = self:GetChild("EmptyTxt")
  self._personalRankPanel = self:GetChild("Char")
  self._notChallengePanel = self:GetChild("Char/EmptyTxt")
  self._challengePanel = self:GetChild("Char/ActivityStarRankCell")
  self._challengePanel_backs = {}
  self._challengePanel_ranks = {}
  for i = 1, 3 do
    self._challengePanel_backs[i] = self:GetChild("Char/ActivityStarRankCell/Back" .. i)
    self._challengePanel_ranks[i] = self:GetChild("Char/ActivityStarRankCell/Panel/Rank" .. i)
  end
  self._challengePanel_normalRank = self:GetChild("Char/ActivityStarRankCell/Panel/Rank")
  self:GetChild("Char/ActivityStarRankCell/Panel/PlayerInfo/NameBack/Name"):SetActive(false)
  self._challengePanel_name = self:GetChild("Char/ActivityStarRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._challengePanel_photo = self:GetChild("Char/ActivityStarRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._challengePanel_photoFrame = self:GetChild("Char/ActivityStarRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._challengePanel_level = self:GetChild("Char/ActivityStarRankCell/Panel/PlayerInfo/LvBack/Level")
  self._challengePanel_charIcons = {}
  self._challengePanel_charIcons[LineUpStation.BACK_ROW] = self:GetChild("Char/ActivityStarRankCell/Panel/CharBack1/Char")
  self._challengePanel_charIcons[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/ActivityStarRankCell/Panel/CharBack2/Char")
  self._challengePanel_charIcons[LineUpStation.FRONT_ROW] = self:GetChild("Char/ActivityStarRankCell/Panel/CharBack3/Char")
  self._challengePanel_txt = self:GetChild("Char/ActivityStarRankCell/Panel/Txt")
  self._challengePanel_time = self:GetChild("Char/ActivityStarRankCell/Panel/Time")
  self._challengePanel_difficultyTxt = self:GetChild("Char/ActivityStarRankCell/Panel/Level")
  self._challengePanel_clickPanel = self:GetChild("Char/ActivityStarRankCell/Panel/Click")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self._challengePanel_clickPanel:Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

function RankTabCell:OnDestroy()
  self._frame:Destroy()
end

local function RefreshPersonalRank(self, data)
  if data then
    self._personalRankPanel:SetActive(true)
    if data.rank == BossChallenge.NOT_Challenge then
      self._notChallengePanel:SetActive(true)
      self._challengePanel:SetActive(false)
      self._challengePanel_clickPanel:SetActive(false)
    else
      self._notChallengePanel:SetActive(false)
      self._challengePanel:SetActive(true)
      if data.rank == BossChallenge.NOT_ON_LIST then
        self._notChallengePanel:SetActive(false)
        self._challengePanel:SetActive(true)
        self._challengePanel_clickPanel:SetActive(false)
        local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
        self._challengePanel_name:SetText(userInfo.username)
        self._challengePanel_level:SetText(userInfo.userlevel)
        local imageRecord
        local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
        if headPhotoRecord then
          imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
          self._challengePanel_photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          LogErrorFormat("RankTabCell", "userInfo.avatarId %s is wrong", userInfo.avatarId)
        end
        local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
        if headPhotoFrameRecord then
          imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
          self._challengePanel_photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          LogErrorFormat("RankTabCell", "userInfo.frameId %s is wrong", userInfo.frameId)
        end
        self._challengePanel_normalRank:SetActive(true)
        self._challengePanel_normalRank:SetText(NekoData.BehaviorManager.BM_Message:GetString(1421))
        for i = 1, 3 do
          self._challengePanel_ranks[i]:SetActive(false)
          self._challengePanel_backs[i]:SetActive(false)
        end
      else
        self._challengePanel_clickPanel:SetActive(true)
        self._challengePanel_name:SetText(data.baseUserData.userName)
        self._challengePanel_level:SetText(data.baseUserData.userLv)
        local headPhotoRecord = HeadPhotoTable:GetRecorder(data.baseUserData.avatarId)
        if headPhotoRecord then
          local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
          self._challengePanel_photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          self._challengePanel_photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
          LogErrorFormat("RankTabCell", "headPhotoRecord not found. avatarId = %s", data.baseUserData.avatarId)
        end
        local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.baseUserData.frameId)
        if headPhotoFrameRecord then
          local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
          self._challengePanel_photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          self._challengePanel_photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
          LogErrorFormat("RankTabCell", "headPhotoFrameRecord not found. frameId = %s", data.baseUserData.frameId)
        end
        if data.rank > 3 then
          self._challengePanel_normalRank:SetActive(true)
          self._challengePanel_normalRank:SetText(data.rank)
        else
          self._challengePanel_normalRank:SetActive(false)
        end
        for i = 1, 3 do
          self._challengePanel_ranks[i]:SetActive(i == data.rank)
          self._challengePanel_backs[i]:SetActive(i == data.rank)
        end
      end
    end
    if data.rank ~= BossChallenge.NOT_Challenge then
      for index, roleid in ipairs(data.bossPanelData.roleIdList) do
        if self._challengePanel_charIcons[index] then
          if 0 < roleid then
            self._challengePanel_charIcons[index]:SetActive(true)
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
            self._challengePanel_charIcons[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            index = index + 1
          else
            self._challengePanel_charIcons[index]:SetActive(false)
          end
        end
      end
      self._challengePanel_time:SetActive(true)
      self._challengePanel_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1419))
      local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
      str = TextManager.GetText(str)
      local num = data.bossPanelData.passTime / 1000
      local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
      str = string.gsub(str, "%$parameter1%$", ret)
      self._challengePanel_time:SetText(str)
      self._challengePanel_difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(data.bossPanelData.times, self._delegate._typeData.difficultyColorStrType))
    end
  else
    self._personalRankPanel:SetActive(false)
  end
end

function RankTabCell:RefreshTabCell(data, refresh)
  if not self._init or refresh then
    self._init = true
    self._data = data
    RefreshPersonalRank(self, self._data.personalRankData)
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
end

function RankTabCell:OnTeamClicked()
  DialogManager.CreateSingletonDialog("activity.starmirage.rankteaminfodialog"):InitDataInfo(self._delegate._typeData.difficultyColorStrType, self._data.personalRankData, self._delegate._tabType)
end

function RankTabCell:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function RankTabCell:NumberOfCell(frame)
  return #self._data.allRankData
end

function RankTabCell:CellAtIndex(frame, index)
  return "activity.starmirage.rankcell"
end

function RankTabCell:DataAtIndex(frame, index)
  return self._data.allRankData[index]
end

return RankTabCell
