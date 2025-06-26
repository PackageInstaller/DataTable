-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/rank/ranktabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local RankTabCell = class("RankTabCell", Dialog)
RankTabCell.AssetBundleName = "ui/layouts.activitysummer2"
RankTabCell.AssetName = "ActivitySummer2XiGuaRankFrame"
RankTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankTabCell
  ((RankTabCell.super).Ctor)(self, ...)
end

RankTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, LineUpStation, TableFrame
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Frame")
  self._emptyTxt = self:GetChild("EmptyTxt")
  self._personalRankPanel = self:GetChild("Char")
  self._notChallengePanel = self:GetChild("Char/EmptyTxt")
  self._challengePanel = self:GetChild("Char/ActivitySummer2XiGuaRankCell")
  self._challengePanel_backs = {}
  self._challengePanel_ranks = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    (self._challengePanel_backs)[i] = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Back" .. i)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._challengePanel_ranks)[i] = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Rank" .. i)
  end
  self._challengePanel_normalRank = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Rank")
  ;
  (self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/PlayerInfo/NameBack/Name")):SetActive(false)
  self._challengePanel_name = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._challengePanel_photo = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._challengePanel_photoFrame = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._challengePanel_level = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/PlayerInfo/LvBack/Level")
  self._challengePanel_charIcons = {}
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._challengePanel_charIcons)[LineUpStation.BACK_ROW] = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/CharBack1/Char")
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._challengePanel_charIcons)[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/CharBack2/Char")
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._challengePanel_charIcons)[LineUpStation.FRONT_ROW] = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/CharBack3/Char")
  self._challengePanel_txt = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Txt")
  self._challengePanel_time = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Time")
  self._challengePanel_difficultyTxt = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Level")
  self._challengePanel_clickPanel = self:GetChild("Char/ActivitySummer2XiGuaRankCell/Panel/Click")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
  ;
  (self._challengePanel_clickPanel):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
end

RankTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

local RefreshPersonalRank = function(self, data)
  -- function num : 0_3 , upvalues : BossChallenge, _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  if data then
    (self._personalRankPanel):SetActive(true)
    if data.rank == BossChallenge.NOT_Challenge then
      (self._notChallengePanel):SetActive(true)
      ;
      (self._challengePanel):SetActive(false)
      ;
      (self._challengePanel_clickPanel):SetActive(false)
    else
      ;
      (self._notChallengePanel):SetActive(false)
      ;
      (self._challengePanel):SetActive(true)
      if data.rank == BossChallenge.NOT_ON_LIST then
        (self._notChallengePanel):SetActive(false)
        ;
        (self._challengePanel):SetActive(true)
        ;
        (self._challengePanel_clickPanel):SetActive(false)
        local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
        ;
        (self._challengePanel_name):SetText(userInfo.username)
        ;
        (self._challengePanel_level):SetText(userInfo.userlevel)
        local imageRecord = nil
        local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
        if headPhotoRecord then
          if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
            imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._challengePanel_photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          LogErrorFormat("RankTabCell", "userInfo.avatarId %s is wrong", userInfo.avatarId)
        end
        local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
        if headPhotoFrameRecord then
          if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
            imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._challengePanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          LogErrorFormat("RankTabCell", "userInfo.frameId %s is wrong", userInfo.frameId)
        end
        ;
        (self._challengePanel_normalRank):SetActive(true)
        ;
        (self._challengePanel_normalRank):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1421))
        for i = 1, 3 do
          ((self._challengePanel_ranks)[i]):SetActive(false)
          ;
          ((self._challengePanel_backs)[i]):SetActive(false)
        end
      else
        do
          ;
          (self._challengePanel_clickPanel):SetActive(true)
          ;
          (self._challengePanel_name):SetText((data.baseUserData).userName)
          ;
          (self._challengePanel_level):SetText((data.baseUserData).userLv)
          local headPhotoRecord = HeadPhotoTable:GetRecorder((data.baseUserData).avatarId)
          if headPhotoRecord then
            if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
              local imageRecord = DataCommon.DefaultImageAsset
            end
            ;
            (self._challengePanel_photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          else
            do
              ;
              (self._challengePanel_photo):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
              LogErrorFormat("RankTabCell", "headPhotoRecord not found. avatarId = %s", (data.baseUserData).avatarId)
              local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((data.baseUserData).frameId)
              if headPhotoFrameRecord then
                if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
                  local imageRecord = DataCommon.DefaultImageAsset
                end
                ;
                (self._challengePanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
              else
                do
                  ;
                  (self._challengePanel_photoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
                  LogErrorFormat("RankTabCell", "headPhotoFrameRecord not found. frameId = %s", (data.baseUserData).frameId)
                  if data.rank > 3 then
                    (self._challengePanel_normalRank):SetActive(true)
                    ;
                    (self._challengePanel_normalRank):SetText(data.rank)
                  else
                    ;
                    (self._challengePanel_normalRank):SetActive(false)
                  end
                  for i = 1, 3 do
                    ((self._challengePanel_ranks)[i]):SetActive(i == data.rank)
                    ;
                    ((self._challengePanel_backs)[i]):SetActive(i == data.rank)
                  end
                  if data.rank ~= BossChallenge.NOT_Challenge then
                    for index,roleid in ipairs((data.undrPanelData).roleIdList) do
                      if (self._challengePanel_charIcons)[index] then
                        if roleid > 0 then
                          ((self._challengePanel_charIcons)[index]):SetActive(true)
                          local shapeCfg = nil
                          local skinId = ((data.undrPanelData).roleSkinList)[index]
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
                          ((self._challengePanel_charIcons)[index]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
                          index = index + 1
                        else
                          ((self._challengePanel_charIcons)[index]):SetActive(false)
                        end
                      end
                    end
                    ;
                    (self._challengePanel_time):SetActive(true)
                    ;
                    (self._challengePanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2156))
                    local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
                    str = (TextManager.GetText)(str)
                    local num = (data.undrPanelData).passTime / 1000
                    local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
                    str = (string.gsub)(str, "%$parameter1%$", ret)
                    ;
                    (self._challengePanel_time):SetText(str)
                    ;
                    (self._challengePanel_difficultyTxt):SetText((data.undrPanelData).score)
                  end
                  ;
                  (self._personalRankPanel):SetActive(false)
                  -- DECOMPILER ERROR: 10 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

RankTabCell.RefreshTabCell = function(self, data, refresh)
  -- function num : 0_4 , upvalues : RefreshPersonalRank
  if not self._init or refresh then
    self._init = true
    self._data = data
    RefreshPersonalRank(self, (self._data).personalRankData)
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

RankTabCell.OnTeamClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.rank.rankteaminfodialog")):InitDataInfo((self._data).personalRankData, (self._delegate)._tabType)
end

RankTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_6
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

RankTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #(self._data).allRankData
end

RankTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.swimsuitechoes.challenge.rank.rankcell"
end

RankTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return ((self._data).allRankData)[index]
end

return RankTabCell

