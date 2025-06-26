-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadrankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local UndecidedRoadRankDialog = class("UndecidedRoadRankDialog", Dialog)
UndecidedRoadRankDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRankDialog.AssetName = "ActivityRoadRank"
local TableFrame = require("framework.ui.frame.table.tableframe")
UndecidedRoadRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadRankDialog
  ((UndecidedRoadRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bossList = {}
  self._rankList = {}
  self._selectDayId = 0
  self._timer = nil
  self._cacheRankData = {}
  self._personalRankData = {}
end

UndecidedRoadRankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, LineUpStation
  self._bossFrame = self:GetChild("BossFrame")
  self._bossHelper = (TableFrame.Create)(self._bossFrame, self, true, true, true)
  self._topArrow = self:GetChild("TopArrow")
  self._bottomArrow = self:GetChild("DownArrow")
  self._rankFrame = self:GetChild("Frame")
  self._rankHelper = (TableFrame.Create)(self._rankFrame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(2)
  self._emptyText = self:GetChild("EmptyTxt")
  self._personalRankPanel = self:GetChild("Char")
  self._personalRankPanel_rankIcon = {}
  self._personalRankPanel_cellBack = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R5 in 'UnsetPending'

    (self._personalRankPanel_rankIcon)[i] = self:GetChild("Char/ActivityRoadRankCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._personalRankPanel_cellBack)[i] = self:GetChild("Char/ActivityRoadRankCell/Back" .. i)
  end
  ;
  (self:GetChild("Char/ActivityRoadRankCell/BackPlayer")):SetActive(true)
  ;
  (self:GetChild("Char/ActivityRoadRankCell/Back")):SetActive(false)
  self._personalRankPanel_rank = self:GetChild("Char/ActivityRoadRankCell/Panel/Rank")
  self._personalRankPanel_photo = self:GetChild("Char/ActivityRoadRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._personalRankPanel_photoFrame = self:GetChild("Char/ActivityRoadRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  ;
  (self:GetChild("Char/ActivityRoadRankCell/Panel/PlayerInfo/NameBack/Name")):SetActive(false)
  self._personalRankPanel_selfName = self:GetChild("Char/ActivityRoadRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._personalRankPanel_level = self:GetChild("Char/ActivityRoadRankCell/Panel/PlayerInfo/LvBack/Level")
  self._personalRankPanel_charIcon = {}
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.FRONT_ROW] = self:GetChild("Char/ActivityRoadRankCell/Panel/CharBack" .. 3 .. "/Char")
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/ActivityRoadRankCell/Panel/CharBack" .. 2 .. "/Char")
  -- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.BACK_ROW] = self:GetChild("Char/ActivityRoadRankCell/Panel/CharBack" .. 1 .. "/Char")
  self._personalRankPanel_txt = self:GetChild("Char/ActivityRoadRankCell/Panel/Txt")
  self._personalRankPanel_time = self:GetChild("Char/ActivityRoadRankCell/Panel/Time")
  self._personalRankPanel_scoreTxt = self:GetChild("Char/ActivityRoadRankCell/Panel/Time/DifficultyTxt")
  self._personalRankPanel_click = self:GetChild("Char/ActivityRoadRankCell/Panel/Click")
  ;
  (self._personalRankPanel_click):Subscribe_PointerClickEvent(self.OnTeamClicked, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:InitBossList()
  self._requestMyRankTime = nil
end

UndecidedRoadRankDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._bossHelper):Destroy()
  ;
  (self._rankHelper):Destroy()
  self._cacheRankData = {}
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

UndecidedRoadRankDialog.InitBossList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._personalRankPanel):SetActive(false)
  ;
  (self._scrollBar):SetActive(false)
  while #self._bossList > 0 do
    (table.remove)(self._bossList, #self._bossList)
  end
  local bossdata = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetBossInfo()
  for _,v in pairs(bossdata) do
    local record = v.cfg
    local data = {}
    data.id = v.id
    data.name = (TextManager.GetText)(record.nameTextID)
    data.image = record.photoid
    ;
    (table.insert)(self._bossList, data)
  end
  ;
  (self._bossHelper):ReloadAllCell()
  ;
  (self._bossHelper):MoveToTop()
  if #self._bossList > 0 then
    self:OnSelectBossCell((self._bossList)[1])
  end
  if #self._bossList > 4 then
    (self._bottomArrow):SetActive(true)
  else
    ;
    (self._topArrow):SetActive(false)
    ;
    (self._bottomArrow):SetActive(false)
  end
end

UndecidedRoadRankDialog.RefreshRankList = function(self, protocol)
  -- function num : 0_4
  local id = 1
  if protocol.day == 100 then
    id = 1
  else
    id = protocol.day
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._cacheRankData)[id] = protocol.ranking
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._personalRankData)[id] = protocol.personRank
  if self._selectDayId ~= id then
    return 
  end
  self:RefreshWithCache()
end

UndecidedRoadRankDialog.RefreshWithCache = function(self)
  -- function num : 0_5
  local rankNum = 0
  if not (self._cacheRankData)[self._selectDayId] then
    self._rankList = {}
    rankNum = #self._rankList
    ;
    (self._scrollBar):SetActive(rankNum ~= 0)
    ;
    (self._emptyText):SetActive(rankNum == 0)
    ;
    (self._rankHelper):ReloadAllCell()
    ;
    (self._rankHelper):MoveToTop()
    self:RefreshPersonalRank()
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UndecidedRoadRankDialog.RefreshPersonalRank = function(self)
  -- function num : 0_6 , upvalues : BossChallenge, _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  local personalRankData = (self._personalRankData)[self._selectDayId]
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
        LogErrorFormat("UndecidedRoadRankDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._personalRankPanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("UndecidedRoadRankDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
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
            LogErrorFormat("UndecidedRoadRankDialog", "headPhotoRecord not found. avatarId = %s", (personalRankData.baseUserData).avatarId)
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
                  LogErrorFormat("UndecidedRoadRankDialog", "headPhotoFrameRecord not found. frameId = %s", (personalRankData.baseUserData).frameId)
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
                    for index,roleid in ipairs((personalRankData.undrPanelData).roleIdList) do
                      if (self._personalRankPanel_charIcon)[index] then
                        if roleid > 0 then
                          ((self._personalRankPanel_charIcon)[index]):SetActive(true)
                          local shapeCfg = nil
                          local skinId = ((personalRankData.undrPanelData).roleSkinList)[index]
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
                    (self._personalRankPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1606))
                    local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
                    str = (TextManager.GetText)(str)
                    local num = (personalRankData.undrPanelData).passTime / 1000
                    local ret = ((NekoData.BehaviorManager).BM_Game):GetPreciseDecimal(num, 1)
                    str = (string.gsub)(str, "%$parameter1%$", ret)
                    ;
                    (self._personalRankPanel_time):SetText(str)
                    ;
                    (self._personalRankPanel_scoreTxt):SetText((personalRankData.undrPanelData).score)
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

UndecidedRoadRankDialog.OnTeamClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadteaminfodialog")):InitDataInfo((self._personalRankData)[self._selectDayId], self._selectDayId)
end

UndecidedRoadRankDialog.DoReq = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cundrchallengeranking")
  protocol.seasonId = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonId()
  if self._selectDayId == 1 then
    protocol.day = 100
  else
    protocol.day = self._selectDayId
  end
  protocol:Send()
  self:RefreshWithCache()
end

UndecidedRoadRankDialog.StartTimer = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._timer = (GameTimer.AddTask)(5, -1, function(self)
    -- function num : 0_9_0
    self._timer = nil
  end
, self)
end

UndecidedRoadRankDialog.OnSelectBossCell = function(self, bossCellData)
  -- function num : 0_10
  if self._selectDayId == bossCellData.id then
    return 
  end
  self._selectDayId = bossCellData.id
  local needReq = false
  if not (self._cacheRankData)[self._selectDayId] then
    needReq = true
  end
  if needReq or not self._timer then
    self:DoReq()
    if not self._timer then
      self:StartTimer()
    end
  else
    self:RefreshWithCache()
  end
  ;
  (self._bossHelper):FireEvent("ChooseBossRush", self._selectDayId)
end

UndecidedRoadRankDialog.NumberOfCell = function(self, helper)
  -- function num : 0_11
  if helper == self._bossHelper then
    return #self._bossList
  else
    return #self._rankList
  end
end

UndecidedRoadRankDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  if helper == self._bossHelper then
    return "mainline.undecidedroad.undecidedroadrankbosscell"
  else
    return "mainline.undecidedroad.undecidedroadrankcell"
  end
end

UndecidedRoadRankDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  if helper == self._bossHelper then
    return (self._bossList)[index]
  else
    return (self._rankList)[index]
  end
end

UndecidedRoadRankDialog.OnCurPosChange = function(self, helper, proportion)
  -- function num : 0_14
  if helper == self._bossHelper then
    local width, height = (self._bossFrame):GetRectSize()
    local total = (self._bossHelper):GetTotalLength()
    if height < total then
      if proportion == 1 then
        (self._topArrow):SetActive(false)
      else
        ;
        (self._topArrow):SetActive(true)
      end
      if proportion == 0 then
        (self._bottomArrow):SetActive(false)
      else
        ;
        (self._bottomArrow):SetActive(true)
      end
    else
      ;
      (self._topArrow):SetActive(false)
      ;
      (self._bottomArrow):SetActive(false)
    end
    return 
  end
  do
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
end

UndecidedRoadRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

UndecidedRoadRankDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return UndecidedRoadRankDialog

