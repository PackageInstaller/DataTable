-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushrankdialog.lua 

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
local BossRushRankDialog = class("BossRushRankDialog", Dialog)
BossRushRankDialog.AssetBundleName = "ui/layouts.mainline"
BossRushRankDialog.AssetName = "BossRushRank"
local TableFrame = require("framework.ui.frame.table.tableframe")
BossRushRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushRankDialog
  ((BossRushRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bossList = {}
  self._rankList = {}
  self._selectBossRushId = 0
  self._timer = nil
  self._cacheRankData = {}
  self._personalRankData = {}
end

BossRushRankDialog.OnCreate = function(self)
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

    (self._personalRankPanel_rankIcon)[i] = self:GetChild("Char/BossRushRankCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

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
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.FRONT_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 3 .. "/Char")
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.MIDDLE_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 2 .. "/Char")
  -- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._personalRankPanel_charIcon)[LineUpStation.BACK_ROW] = self:GetChild("Char/BossRushRankCell/Panel/CharBack" .. 1 .. "/Char")
  self._personalRankPanel_txt = self:GetChild("Char/BossRushRankCell/Panel/Txt")
  self._personalRankPanel_time = self:GetChild("Char/BossRushRankCell/Panel/Time")
  self._personalRankPanel_difficultyTxt = self:GetChild("Char/BossRushRankCell/Panel/Time/DifficultyTxt")
  self._personalRankPanel_click = self:GetChild("Char/BossRushRankCell/Panel/Click")
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

BossRushRankDialog.OnDestroy = function(self)
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

BossRushRankDialog.InitBossList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._bossList = {}
  local bossdata = ((NekoData.BehaviorManager).BM_Game):GetBossRushInfo()
  for _,v in pairs(bossdata) do
    local record = v.cfg
    local data = {}
    data.id = v.id
    data.name = record.name
    data.image = record.tapimageid
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

BossRushRankDialog.RefreshRankList = function(self, protocol)
  -- function num : 0_4
  local id = protocol.id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._cacheRankData)[id] = protocol.ranking
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._personalRankData)[id] = protocol.personRank
  if self._selectBossRushId ~= protocol.id then
    return 
  end
  self:RefreshWithCache()
end

BossRushRankDialog.RefreshWithCache = function(self)
  -- function num : 0_5
  local rankNum = 0
  if not (self._cacheRankData)[self._selectBossRushId] then
    self._rankList = {}
    rankNum = #self._rankList
    ;
    (self._emptyText):SetActive(rankNum == 0)
    ;
    (self._rankHelper):ReloadAllCell()
    ;
    (self._rankHelper):MoveToTop()
    self:RefreshPersonalRank()
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

BossRushRankDialog.RefreshPersonalRank = function(self)
  -- function num : 0_6 , upvalues : BossChallenge, _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  local personalRankData = (self._personalRankData)[self._selectBossRushId]
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
        LogErrorFormat("BossRushRankDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._personalRankPanel_photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        LogErrorFormat("BossRushRankDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
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
            LogErrorFormat("BossRushRankDialog", "headPhotoRecord not found. avatarId = %s", (personalRankData.baseUserData).avatarId)
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
                  LogErrorFormat("BossRushRankDialog", "headPhotoFrameRecord not found. frameId = %s", (personalRankData.baseUserData).frameId)
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
                    (self._personalRankPanel_difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((personalRankData.bossPanelData).times))
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

BossRushRankDialog.OnTeamClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.bossrushteaminfodialog")):InitDataInfo((self._personalRankData)[self._selectBossRushId], self._selectBossRushId)
end

BossRushRankDialog.DoReq = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cbosschallengeranking")
  protocol.id = self._selectBossRushId
  protocol:Send()
  self:RefreshWithCache()
end

BossRushRankDialog.StartTimer = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._timer = (GameTimer.AddTask)(5, -1, function(self)
    -- function num : 0_9_0
    self._timer = nil
  end
, self)
end

BossRushRankDialog.OnSelectBossCell = function(self, bossCellData)
  -- function num : 0_10
  if self._selectBossRushId == bossCellData.id then
    return 
  end
  self._selectBossRushId = bossCellData.id
  local needReq = false
  if not (self._cacheRankData)[self._selectBossRushId] then
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
  (self._bossHelper):FireEvent("ChooseBossRush", self._selectBossRushId)
end

BossRushRankDialog.NumberOfCell = function(self, helper)
  -- function num : 0_11
  if helper == self._bossHelper then
    return #self._bossList
  else
    return #self._rankList
  end
end

BossRushRankDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  if helper == self._bossHelper then
    return "mainline.bossrush.bossrushrankbosscell"
  else
    return "mainline.bossrush.bossrushrankcell"
  end
end

BossRushRankDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  if helper == self._bossHelper then
    return (self._bossList)[index]
  else
    return (self._rankList)[index]
  end
end

BossRushRankDialog.OnCurPosChange = function(self, helper, proportion)
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

BossRushRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

BossRushRankDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return BossRushRankDialog

