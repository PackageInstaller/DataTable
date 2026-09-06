local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CWeeklyBossRush = BeanManager.GetTableByName("dungeonselect.cweeklybossrush")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local BossChallenge = LuaNetManager.GetBeanDef("protocol.ranking.bosschallenge")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BossRushWeekRankDialog = class("BossRushWeekRankDialog", Dialog)
BossRushWeekRankDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekRankDialog.AssetName = "BossRushWeekRank"
local BottomToTop = 2

function BossRushWeekRankDialog:Ctor(...)
  BossRushWeekRankDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._rankList = {}
  self._selectBossRushId = 0
  self._personalRankData = {}
  self._lastWeekRankList = {}
  self._isWeekBoss = true
end

function BossRushWeekRankDialog:OnCreate()
  self._lastWeekPanel = self:GetChild("WeekFrame")
  self._lastWeekPanelTitle = self:GetChild("WeekFrame/Txt")
  self._lastWeekPanelEmptyTxt = self:GetChild("WeekFrame/TxtNone")
  self._lastWeekFrame = TableFrame.Create(self._lastWeekPanel, self, true, false, true)
  self._bossNameTxt = self:GetChild("BossFrame/Name")
  self._difficultyTxt = self:GetChild("BossFrame/Difficulty/Txt")
  self._bossImg = self:GetChild("BossFrame/Photo")
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = TableFrame.Create(self._rankFrame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._emptyText = self:GetChild("EmptyTxt")
  self._personalRankPanel = self:GetChild("Char")
  self._personalRankPanel_rankIcon = {}
  self._personalRankPanel_cellBack = {}
  for i = 1, 3 do
    self._personalRankPanel_rankIcon[i] = self:GetChild("Char/BossRushRankCell/Panel/Rank" .. i)
    self._personalRankPanel_cellBack[i] = self:GetChild("Char/BossRushRankCell/Back" .. i)
  end
  self:GetChild("Char/BossRushRankCell/BackPlayer"):SetActive(true)
  self:GetChild("Char/BossRushRankCell/Back"):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/BossRushRankCell/Panel/Rank")
  self._personalRankPanel_photo = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._personalRankPanel_photoFrame = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/NameBack/Name"):SetActive(false)
  self._personalRankPanel_selfName = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._personalRankPanel_level = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/LvBack/Level")
  self._personalRankPanel_charIcon = {}
  self._personalRankPanel_charIcon[LineUpStation.FRONT_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 3 .. "/Char")
  self._personalRankPanel_charIcon[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 2 .. "/Char")
  self._personalRankPanel_charIcon[LineUpStation.BACK_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 1 .. "/Char")
  self._personalRankPanel_txt = self:GetChild("Char/BossRushRankCell/Panel/Txt")
  self._personalRankPanel_time = self:GetChild("Char/BossRushRankCell/Panel/Time")
  self._personalRankPanel_difficultyTxt = self:GetChild("Char/BossRushRankCell/Panel/Time/DifficultyTxt")
  self._personalRankPanel_click = self:GetChild("Char/BossRushRankCell/Panel/Click")
  self._personalRankPanel_click:SetActive(false)
  self._personalRankPanel_click:Subscribe_PointerClickEvent(self.OnTeamClicked, self)
  self._backBtn = self:GetChild("Top/BackBtn")
  self._menuBtn = self:GetChild("Top/MenuBtn")
  self._titleTxt = self:GetChild("Top/Title")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSLastWeekChallengeRanking, Common.n_SLastWeekChallengeRanking, nil)
  self:Init()
end

function BossRushWeekRankDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._lastWeekFrame:Destroy()
  self._rankHelper:Destroy()
end

function BossRushWeekRankDialog:Init()
  self._selectBossRushId = NekoData.BehaviorManager.BM_WeekBoss:GetWeekBossRushData().bosses.id
  local recorder = CWeeklyBossRush:GetRecorder(self._selectBossRushId)
  local image = CImagePathTable:GetRecorder(recorder.image)
  self._bossImg:SetSprite(image.assetBundle, image.assetName)
  self._bossNameTxt:SetText(TextManager.GetText(recorder.nameTextID))
  self._lastWeekPanelTitle:SetText(TextManager.GetText(1901578))
  self._lastWeekPanelEmptyTxt:SetText(TextManager.GetText(1901624))
end

function BossRushWeekRankDialog:RefreshLastWeekPanel()
  self._lastWeekRankList = NekoData.BehaviorManager.BM_WeekBoss:GetLastWeekRankData()
  if #self._lastWeekRankList == 0 then
    self._lastWeekPanelEmptyTxt:SetActive(true)
  else
    self._lastWeekPanelEmptyTxt:SetActive(false)
    self._lastWeekFrame:ReloadAllCell()
  end
end

function BossRushWeekRankDialog:SetData(rankData, personalData)
  self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(personalData.bossPanelData.times, nil, true))
  self._rankList = rankData or {}
  self._personalRankData = personalData
  self._emptyText:SetActive(#self._rankList == 0)
  self._rankHelper:ReloadAllCell()
  self._rankHelper:MoveToTop()
  self:RefreshLastWeekPanel()
  self:RefreshPersonalRank()
end

function BossRushWeekRankDialog:RefreshPersonalRank()
  local personalRankData = self._personalRankData
  if personalRankData then
    self._personalRankPanel:SetActive(true)
    if personalRankData.rank == BossChallenge.NOT_Challenge or personalRankData.rank == BossChallenge.NOT_ON_LIST then
      local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
      self._personalRankPanel_selfName:SetText(userInfo.username)
      self._personalRankPanel_level:SetText(userInfo.userlevel)
      local imageRecord
      local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
      if headPhotoRecord then
        imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
        self._personalRankPanel_photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BossRushWeekRankDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
      if headPhotoFrameRecord then
        imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
        self._personalRankPanel_photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BossRushWeekRankDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
      end
      self._personalRankPanel_rank:SetActive(true)
      self._personalRankPanel_rank:SetText(NekoData.BehaviorManager.BM_Message:GetString(1421))
      for i = 1, 3 do
        self._personalRankPanel_rankIcon[i]:SetActive(false)
        self._personalRankPanel_cellBack[i]:SetActive(false)
      end
      self._personalRankPanel_click:SetActive(false)
    else
      self._personalRankPanel_selfName:SetText(personalRankData.baseUserData.userName)
      self._personalRankPanel_level:SetText(personalRankData.baseUserData.userLv)
      local headPhotoRecord = HeadPhotoTable:GetRecorder(personalRankData.baseUserData.avatarId)
      if headPhotoRecord then
        local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
        self._personalRankPanel_photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        self._personalRankPanel_photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
        LogErrorFormat("BossRushWeekRankDialog", "headPhotoRecord not found. avatarId = %s", personalRankData.baseUserData.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(personalRankData.baseUserData.frameId)
      if headPhotoFrameRecord then
        local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
        self._personalRankPanel_photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        self._personalRankPanel_photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
        LogErrorFormat("BossRushWeekRankDialog", "headPhotoFrameRecord not found. frameId = %s", personalRankData.baseUserData.frameId)
      end
      if personalRankData.rank > 3 then
        self._personalRankPanel_rank:SetActive(true)
        self._personalRankPanel_rank:SetText(personalRankData.rank)
      else
        self._personalRankPanel_rank:SetActive(false)
      end
      for i = 1, 3 do
        self._personalRankPanel_rankIcon[i]:SetActive(i == personalRankData.rank)
        self._personalRankPanel_cellBack[i]:SetActive(i == personalRankData.rank)
      end
      self._personalRankPanel_click:SetActive(true)
    end
    if personalRankData.rank == BossChallenge.NOT_Challenge then
      self._personalRankPanel_time:SetActive(false)
      self._personalRankPanel_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1420))
      for k, v in pairs(self._personalRankPanel_charIcon) do
        v:SetActive(false)
      end
    else
      for index, roleid in ipairs(personalRankData.bossPanelData.roleIdList) do
        if self._personalRankPanel_charIcon[index] then
          if 0 < roleid then
            self._personalRankPanel_charIcon[index]:SetActive(true)
            local shapeCfg
            local skinId = personalRankData.bossPanelData.roleSkinList[index]
            if 0 < skinId then
              local skin = CSkin:GetRecorder(skinId)
              shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
            else
              local roleCfg = RoleConfigTable:GetRecorder(roleid)
              shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
            end
            local imageRecord = CImagePathTable:GetRecorder(shapeCfg.skillHeadID) or DataCommon.DefaultImageAsset
            self._personalRankPanel_charIcon[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            index = index + 1
          else
            self._personalRankPanel_charIcon[index]:SetActive(false)
          end
        end
      end
      self._personalRankPanel_time:SetActive(true)
      self._personalRankPanel_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1419))
      local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
      str = TextManager.GetText(str)
      local num = personalRankData.bossPanelData.passTime / 1000
      local ret = NekoData.BehaviorManager.BM_Game:GetPreciseDecimal(num, 1)
      str = string.gsub(str, "%$parameter1%$", ret)
      self._personalRankPanel_time:SetText(str)
      self._personalRankPanel_difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(personalRankData.bossPanelData.times, nil, true))
    end
  else
    self._personalRankPanel:SetActive(false)
  end
end

function BossRushWeekRankDialog:OnTeamClicked()
  DialogManager.CreateSingletonDialog("mainline.bossrush.bossrushteaminfodialog"):InitDataInfo(self._personalRankData, self._selectBossRushId, self._isWeekBoss, NekoData.BehaviorManager.BM_WeekBoss:GetWeekBossRushRankId())
end

function BossRushWeekRankDialog:NumberOfCell(helper)
  if helper == self._lastWeekFrame then
    return #self._lastWeekRankList
  else
    return #self._rankList
  end
end

function BossRushWeekRankDialog:CellAtIndex(helper, index)
  if helper == self._lastWeekFrame then
    return "mainline.bossrush.bossrushweekrankcell"
  else
    return "mainline.bossrush.bossrushrankcell"
  end
end

function BossRushWeekRankDialog:DataAtIndex(helper, index)
  if helper == self._lastWeekFrame then
    return self._lastWeekRankList[index]
  else
    return self._rankList[index]
  end
end

function BossRushWeekRankDialog:OnCurPosChange(helper, proportion)
  local width, height = self._rankFrame:GetRectSize()
  local total = self._rankHelper:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function BossRushWeekRankDialog:OnSLastWeekChallengeRanking(notification)
  self:RefreshLastWeekPanel()
end

function BossRushWeekRankDialog:OnBackBtnClicked()
  self:Destroy()
end

function BossRushWeekRankDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return BossRushWeekRankDialog
