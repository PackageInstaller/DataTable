-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekrankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CWeeklyBossRush = (BeanManager.GetTableByName)("dungeonselect.cweeklybossrush")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BossRushWeekRankDialog = class("BossRushWeekRankDialog", Dialog)
BossRushWeekRankDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekRankDialog.AssetName = "BossRushWeekRank"
local BottomToTop = 2
BossRushWeekRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekRankDialog
  ((BossRushWeekRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._rankList = {}
  self._selectBossRushId = 0
  self._personalRankData = {}
  self._lastWeekRankList = {}
  self._isWeekBoss = true
end

BossRushWeekRankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, BottomToTop, LineUpStation, _ENV
  self._lastWeekPanel = self:GetChild("WeekFrame")
  self._lastWeekPanelTitle = self:GetChild("WeekFrame/Txt")
  self._lastWeekPanelEmptyTxt = self:GetChild("WeekFrame/TxtNone")
  self._lastWeekFrame = (TableFrame.Create)(self._lastWeekPanel, self, true, false, true)
  self._bossNameTxt = self:GetChild("BossFrame/Name")
  self._difficultyTxt = self:GetChild("BossFrame/Difficulty/Txt")
  self._bossImg = self:GetChild("BossFrame/Photo")
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = (TableFrame.Create)(self._rankFrame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._emptyText = self:GetChild("EmptyTxt")
  self._personalRankPanel = self:GetChild("Char")
  self._personalRankPanel_rankIcon = {}
  self._personalRankPanel_cellBack = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

    (self._personalRankPanel_rankIcon)[i] = self:GetChild("Char/BossRushRankCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._personalRankPanel_cellBack)[i] = self:GetChild("Char/BossRushRankCell/Back" .. i)
  end
  ;
  (self:GetChild("Char/BossRushRankCell/BackPlayer")):SetActive(true)
  ;
  (self:GetChild("Char/BossRushRankCell/Back")):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/BossRushRankCell/Panel/Rank")
  self._personalRankPanel_photo = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._personalRankPanel_photoFrame = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  ;
  (self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/NameBack/Name")):SetActive(false)
  self._personalRankPanel_selfName = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._personalRankPanel_level = self:GetChild("Char/BossRushRankCell/Panel/PlayerInfo/LvBack/Level")
  self._personalRankPanel_charIcon = {}
  -- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.FRONT_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 3 .. "/Char")
  -- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 2 .. "/Char")
  -- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.BACK_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 1 .. "/Char")
  self._personalRankPanel_txt = self:GetChild("Char/BossRushRankCell/Panel/Txt")
  self._personalRankPanel_time = self:GetChild("Char/BossRushRankCell/Panel/Time")
  self._personalRankPanel_difficultyTxt = self:GetChild("Char/BossRushRankCell/Panel/Time/DifficultyTxt")
  self._personalRankPanel_click = self:GetChild("Char/BossRushRankCell/Panel/Click")
  ;
  (self._personalRankPanel_click):SetActive(false)
  ;
  (self._personalRankPanel_click):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
  self._backBtn = self:GetChild("Top/BackBtn")
  self._menuBtn = self:GetChild("Top/MenuBtn")
  self._titleTxt = self:GetChild("Top/Title")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSLastWeekChallengeRanking, Common.n_SLastWeekChallengeRanking, nil)
  self:Init()
end

BossRushWeekRankDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._lastWeekFrame):Destroy()
  ;
  (self._rankHelper):Destroy()
end

BossRushWeekRankDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CWeeklyBossRush, CImagePathTable
  self._selectBossRushId = ((((NekoData.BehaviorManager).BM_WeekBoss):GetWeekBossRushData()).bosses).id
  local recorder = CWeeklyBossRush:GetRecorder(self._selectBossRushId)
  local image = CImagePathTable:GetRecorder(recorder.image)
  ;
  (self._bossImg):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._bossNameTxt):SetText((TextManager.GetText)(recorder.nameTextID))
  ;
  (self._lastWeekPanelTitle):SetText((TextManager.GetText)(1901578))
  ;
  (self._lastWeekPanelEmptyTxt):SetText((TextManager.GetText)(1901624))
end

BossRushWeekRankDialog.RefreshLastWeekPanel = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._lastWeekRankList = ((NekoData.BehaviorManager).BM_WeekBoss):GetLastWeekRankData()
  if #self._lastWeekRankList == 0 then
    (self._lastWeekPanelEmptyTxt):SetActive(true)
  else
    ;
    (self._lastWeekPanelEmptyTxt):SetActive(false)
    ;
    (self._lastWeekFrame):ReloadAllCell()
  end
end

BossRushWeekRankDialog.SetData = function(self, rankData, personalData)
  -- function num : 0_5 , upvalues : _ENV
  (self._difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((personalData.bossPanelData).times, nil, true))
  if not rankData then
    self._rankList = {}
    self._personalRankData = personalData
    ;
    (self._emptyText):SetActive(#self._rankList == 0)
    ;
    (self._rankHelper):ReloadAllCell()
    ;
    (self._rankHelper):MoveToTop()
    self:RefreshLastWeekPanel()
    self:RefreshPersonalRank()
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

BossRushWeekRankDialog.RefreshPersonalRank = function(self)
  -- function num : 0_6 , upvalues : BossChallenge, _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  local personalRankData = self._personalRankData
  if personalRankData then
    (self._personalRankPanel):SetActive(true)
    if personalRankData.rank == BossChallenge.NOT_Challenge or personalRankData.rank == BossChallenge.NOT_ON_LIST then
      local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
      ;
      (self._personalRankPanel_selfName):SetText(userInfo.username)
      ;
      (self._personalRankPanel_level):SetText(userInfo.userlevel)
      local imageRecord = nil
      local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
      if headPhotoRecord then
        if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._personalRankPanel_photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BossRushWeekRankDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._personalRankPanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BossRushWeekRankDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
      end
      ;
      (self._personalRankPanel_rank):SetActive(true)
      ;
      (self._personalRankPanel_rank):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1421))
      for i = 1, 3 do
        ((self._personalRankPanel_rankIcon)[i]):SetActive(false)
        ;
        ((self._personalRankPanel_cellBack)[i]):SetActive(false)
      end
      ;
      (self._personalRankPanel_click):SetActive(false)
    else
      do
        ;
        (self._personalRankPanel_selfName):SetText((personalRankData.baseUserData).userName)
        ;
        (self._personalRankPanel_level):SetText((personalRankData.baseUserData).userLv)
        local headPhotoRecord = HeadPhotoTable:GetRecorder((personalRankData.baseUserData).avatarId)
        if headPhotoRecord then
          if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._personalRankPanel_photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          do
            ;
            (self._personalRankPanel_photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
            LogErrorFormat("BossRushWeekRankDialog", "headPhotoRecord not found. avatarId = %s", (personalRankData.baseUserData).avatarId)
            local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((personalRankData.baseUserData).frameId)
            if headPhotoFrameRecord then
              if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
                local imageRecord = DataCommon.DefaultImageAsset
              end
              ;
              (self._personalRankPanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            else
              do
                do
                  ;
                  (self._personalRankPanel_photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
                  LogErrorFormat("BossRushWeekRankDialog", "headPhotoFrameRecord not found. frameId = %s", (personalRankData.baseUserData).frameId)
                  if personalRankData.rank > 3 then
                    (self._personalRankPanel_rank):SetActive(true)
                    ;
                    (self._personalRankPanel_rank):SetText(personalRankData.rank)
                  else
                    ;
                    (self._personalRankPanel_rank):SetActive(false)
                  end
                  for i = 1, 3 do
                    ((self._personalRankPanel_rankIcon)[i]):SetActive(i == personalRankData.rank)
                    ;
                    ((self._personalRankPanel_cellBack)[i]):SetActive(i == personalRankData.rank)
                  end
                  ;
                  (self._personalRankPanel_click):SetActive(true)
                  if personalRankData.rank == BossChallenge.NOT_Challenge then
                    (self._personalRankPanel_time):SetActive(false)
                    ;
                    (self._personalRankPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1420))
                    for k,v in pairs(self._personalRankPanel_charIcon) do
                      v:SetActive(false)
                    end
                  else
                    for index,roleid in ipairs((personalRankData.bossPanelData).roleIdList) do
                      if (self._personalRankPanel_charIcon)[index] then
                        if roleid > 0 then
                          ((self._personalRankPanel_charIcon)[index]):SetActive(true)
                          local shapeCfg = nil
                          local skinId = ((personalRankData.bossPanelData).roleSkinList)[index]
                          if skinId > 0 then
                            local skin = CSkin:GetRecorder(skinId)
                            shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
                          else
                            local roleCfg = RoleConfigTable:GetRecorder(roleid)
                            shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
                          end
                          if not CImagePathTable:GetRecorder(shapeCfg.skillHeadID) then
                            local imageRecord = DataCommon.DefaultImageAsset
                          end
                          ;
                          ((self._personalRankPanel_charIcon)[index]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
                          index = index + 1
                        else
                          ((self._personalRankPanel_charIcon)[index]):SetActive(false)
                        end
                      end
                    end
                    ;
                    (self._personalRankPanel_time):SetActive(true)
                    ;
                    (self._personalRankPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1419))
                    local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
                    str = (TextManager.GetText)(str)
                    local num = (personalRankData.bossPanelData).passTime / 1000
                    local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
                    str = (string.gsub)(str, "%$parameter1%$", ret)
                    ;
                    (self._personalRankPanel_time):SetText(str)
                    ;
                    (self._personalRankPanel_difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((personalRankData.bossPanelData).times, nil, true))
                  end
                  ;
                  (self._personalRankPanel):SetActive(false)
                  -- DECOMPILER ERROR: 12 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

BossRushWeekRankDialog.OnTeamClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushteaminfodialog")):InitDataInfo(self._personalRankData, self._selectBossRushId, self._isWeekBoss, ((NekoData.BehaviorManager).BM_WeekBoss):GetWeekBossRushRankId())
end

BossRushWeekRankDialog.NumberOfCell = function(self, helper)
  -- function num : 0_8
  if helper == self._lastWeekFrame then
    return #self._lastWeekRankList
  else
    return #self._rankList
  end
end

BossRushWeekRankDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_9
  if helper == self._lastWeekFrame then
    return "mainline.bossrush.bossrushweekrankcell"
  else
    return "mainline.bossrush.bossrushrankcell"
  end
end

BossRushWeekRankDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_10
  if helper == self._lastWeekFrame then
    return (self._lastWeekRankList)[index]
  else
    return (self._rankList)[index]
  end
end

BossRushWeekRankDialog.OnCurPosChange = function(self, helper, proportion)
  -- function num : 0_11
  local width, height = (self._rankFrame):GetRectSize()
  local total = (self._rankHelper):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

BossRushWeekRankDialog.OnSLastWeekChallengeRanking = function(self, notification)
  -- function num : 0_12
  self:RefreshLastWeekPanel()
end

BossRushWeekRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

BossRushWeekRankDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return BossRushWeekRankDialog

