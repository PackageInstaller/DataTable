-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvpdefenserecordcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local SeasonPvpDefenseRecordCell = class("SeasonPvpDefenseRecordCell", Dialog)
SeasonPvpDefenseRecordCell.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpDefenseRecordCell.AssetName = "SeasonPVPDefenseRecordCell"
SeasonPvpDefenseRecordCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpDefenseRecordCell
  ((SeasonPvpDefenseRecordCell.super).Ctor)(self, ...)
end

SeasonPvpDefenseRecordCell.OnCreate = function(self)
  -- function num : 0_1
  self._photo = self:GetChild("Panel/Player/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/Player/HeadPhoto/Frame")
  self._levelNum = self:GetChild("Panel/Player/LvBack/Level")
  self._userName = self:GetChild("Panel/Player/NameBack/Name")
  self._time = self:GetChild("Panel/Player/TimeBack/Time")
  ;
  (self._time):SetText("")
  self._resultText = self:GetChild("Panel/Txt")
  ;
  (self._resultText):SetText("")
  self.enemyTeams = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      (self.enemyTeams)[i] = {}
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i]).charPanel = self:GetChild("Panel/Team1/CharSmallCell" .. i)
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._frame = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Frame")
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._photo = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Photo")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._unkown = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Unknown")
      ;
      (((self.enemyTeams)[i])._unkown):SetActive(false)
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._downRankBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/DownRankBack")
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._level = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Level/Num")
      ;
      (((self.enemyTeams)[i])._level):SetText("")
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._rankBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/RankBack")
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._rank = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Rank")
      ;
      (((self.enemyTeams)[i])._rank):SetActive(false)
      -- DECOMPILER ERROR at PC138: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._job = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Job")
      ;
      (((self.enemyTeams)[i])._job):SetActive(false)
      -- DECOMPILER ERROR at PC153: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._breakLevelBackBlack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelBackBlack")
      -- DECOMPILER ERROR at PC162: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._breakLevelBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelBack")
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._breakLevelNum = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelNum")
      ;
      (((self.enemyTeams)[i])._breakLevelNum):SetText("")
      -- DECOMPILER ERROR at PC186: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._breakLevel = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevel")
      -- DECOMPILER ERROR at PC195: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._element = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Element")
      ;
      (((self.enemyTeams)[i])._element):SetActive(false)
      -- DECOMPILER ERROR at PC210: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._grey = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Grey")
      -- DECOMPILER ERROR at PC219: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i])._select = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Select")
      ;
      (((self.enemyTeams)[i])._frame):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnEnemyCellClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC230: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i]).charUpgrade = {}
      -- DECOMPILER ERROR at PC243: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.enemyTeams)[i]).charUpgrade = {panel = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/CharUpgrade"), 
levelImage = {}
}
      for k = 1, 5 do
        -- DECOMPILER ERROR at PC259: Confused about usage of register: R9 in 'UnsetPending'

        ((((self.enemyTeams)[i]).charUpgrade).levelImage)[k] = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/CharUpgrade/Img" .. k)
      end
    end
  end
  self.myTeams = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC271: Confused about usage of register: R5 in 'UnsetPending'

    (self.myTeams)[i] = {}
    -- DECOMPILER ERROR at PC279: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i]).charPanel = self:GetChild("Panel/Team2/CharSmallCell" .. i)
    -- DECOMPILER ERROR at PC288: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._frame = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Frame")
    -- DECOMPILER ERROR at PC297: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._photo = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Photo")
    -- DECOMPILER ERROR at PC306: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._unkown = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Unknown")
    ;
    (((self.myTeams)[i])._unkown):SetActive(false)
    -- DECOMPILER ERROR at PC321: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._downRankBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/DownRankBack")
    -- DECOMPILER ERROR at PC330: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._level = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Level/Num")
    ;
    (((self.myTeams)[i])._level):SetText("")
    -- DECOMPILER ERROR at PC345: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._rankBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/RankBack")
    -- DECOMPILER ERROR at PC354: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._rank = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Rank")
    ;
    (((self.myTeams)[i])._rank):SetActive(false)
    -- DECOMPILER ERROR at PC369: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._job = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Job")
    ;
    (((self.myTeams)[i])._job):SetActive(false)
    -- DECOMPILER ERROR at PC384: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._breakLevelBackBlack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelBackBlack")
    -- DECOMPILER ERROR at PC393: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._breakLevelBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelBack")
    -- DECOMPILER ERROR at PC402: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._breakLevelNum = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelNum")
    ;
    (((self.myTeams)[i])._breakLevelNum):SetText("")
    -- DECOMPILER ERROR at PC417: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._breakLevel = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevel")
    -- DECOMPILER ERROR at PC426: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._element = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Element")
    ;
    (((self.myTeams)[i])._element):SetActive(false)
    -- DECOMPILER ERROR at PC441: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._grey = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Grey")
    -- DECOMPILER ERROR at PC450: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i])._select = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Select")
    ;
    (((self.myTeams)[i])._frame):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnMyCellClicked(i)
  end
, self)
    -- DECOMPILER ERROR at PC461: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i]).charUpgrade = {}
    -- DECOMPILER ERROR at PC474: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.myTeams)[i]).charUpgrade = {panel = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/CharUpgrade"), 
levelImage = {}
}
    for k = 1, 5 do
      -- DECOMPILER ERROR at PC490: Confused about usage of register: R9 in 'UnsetPending'

      ((((self.myTeams)[i]).charUpgrade).levelImage)[k] = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/CharUpgrade/Img" .. k)
    end
  end
end

SeasonPvpDefenseRecordCell.OnDestroy = function(self)
  -- function num : 0_2
end

SeasonPvpDefenseRecordCell.SetBack = function(self, rank)
  -- function num : 0_3
end

SeasonPvpDefenseRecordCell.formatTimestampToUTC = function(self, timestamp)
  -- function num : 0_4 , upvalues : _ENV
  local t = (os.date)("!*t", timestamp)
  return (string.format)("%d年%d月%d日 %02d:%02d:%02d", t.year, t.month, t.day, t.hour, t.min, t.sec)
end

SeasonPvpDefenseRecordCell.RefreshCell = function(self, data)
  -- function num : 0_5 , upvalues : _ENV, CStringRes, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, Role
  if data.result == 1 then
    (self._resultText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2253)).msgTextID))
  else
    ;
    (self._resultText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2254)).msgTextID))
  end
  ;
  (self._time):SetText(self:formatTimestampToUTC(data.time))
  local headPhotoRecord = (HeadPhotoTable:GetRecorder((data.enemyUserData).avatarId))
  -- DECOMPILER ERROR at PC37: Overwrote pending register: R3 in 'AssignReg'

  local imageRecord = .end
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((data.enemyUserData).frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._levelNum):SetText((data.enemyUserData).userLv)
  ;
  (self._userName):SetText((data.enemyUserData).userName)
  for i = 1, 3 do
    local roleInfo = (data.enemyRoleList)[i]
    if roleInfo then
      (((self.enemyTeams)[i]).charPanel):SetActive(true)
      local tempRole = (Role.Create)(roleInfo.id)
      tempRole:SetLevel(roleInfo.lv)
      tempRole:SetBreakLv(roleInfo.breakLv)
      tempRole:SetRuneLevel(roleInfo.runeLevel)
      local image = tempRole:GetShapeLittleHeadImageRecord()
      ;
      (((self.enemyTeams)[i])._photo):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._photo):SetActive(true)
      image = tempRole:GetSmallRarityFrameRecord()
      ;
      (((self.enemyTeams)[i])._frame):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._frame):SetActive(true)
      image = tempRole:GetRarityBottomBackRecord()
      ;
      (((self.enemyTeams)[i])._downRankBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._downRankBack):SetActive(true)
      ;
      (((self.enemyTeams)[i])._level):SetText(tempRole:GetShowLv())
      image = tempRole:GetRarityImageRecord()
      ;
      (((self.enemyTeams)[i])._rank):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._rank):SetActive(true)
      image = tempRole:GetVocationImageRecord()
      ;
      (((self.enemyTeams)[i])._job):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._job):SetActive(true)
      local breakLv = tempRole:GetBreakLv()
      ;
      (((self.enemyTeams)[i])._breakLevelBackBlack):SetActive(breakLv == 0)
      ;
      (((self.enemyTeams)[i])._breakLevelBack):SetActive(breakLv > 0)
      ;
      (((self.enemyTeams)[i])._breakLevelNum):SetActive(breakLv > 0)
      if breakLv > 0 then
        image = tempRole:GetCurBreakFrame1ImageRecord()
        ;
        (((self.enemyTeams)[i])._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
        ;
        (((self.enemyTeams)[i])._breakLevelBack):SetActive(true)
        ;
        (((self.enemyTeams)[i])._breakLevelNum):SetText(breakLv)
        ;
        (((self.enemyTeams)[i])._breakLevelNum):SetActive(true)
      end
      image = tempRole:GetElementImageRecord()
      ;
      (((self.enemyTeams)[i])._element):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.enemyTeams)[i])._element):SetActive(true)
      local level = tempRole:GetRuneLevel()
      ;
      ((((self.enemyTeams)[i]).charUpgrade).panel):SetActive(level ~= 0)
      for k = 1, 5 do
        (((((self.enemyTeams)[i]).charUpgrade).levelImage)[k]):SetActive(level == k)
      end
    else
      (((self.enemyTeams)[i]).charPanel):SetActive(true)
    end
  end
  for i = 1, 3 do
    local roleInfo = (data.enemyRoleList)[i]
    if roleInfo then
      (((self.myTeams)[i]).charPanel):SetActive(true)
      local tempRole = (Role.Create)(roleInfo.id)
      tempRole:SetLevel(roleInfo.lv)
      tempRole:SetBreakLv(roleInfo.breakLv)
      tempRole:SetRuneLevel(roleInfo.runeLevel)
      local image = tempRole:GetShapeLittleHeadImageRecord()
      ;
      (((self.myTeams)[i])._photo):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._photo):SetActive(true)
      image = tempRole:GetSmallRarityFrameRecord()
      ;
      (((self.myTeams)[i])._frame):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._frame):SetActive(true)
      image = tempRole:GetRarityBottomBackRecord()
      ;
      (((self.myTeams)[i])._downRankBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._downRankBack):SetActive(true)
      ;
      (((self.myTeams)[i])._level):SetText(tempRole:GetShowLv())
      image = tempRole:GetRarityImageRecord()
      ;
      (((self.myTeams)[i])._rank):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._rank):SetActive(true)
      image = tempRole:GetVocationImageRecord()
      ;
      (((self.myTeams)[i])._job):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._job):SetActive(true)
      local breakLv = tempRole:GetBreakLv()
      ;
      (((self.myTeams)[i])._breakLevelBackBlack):SetActive(breakLv == 0)
      ;
      (((self.myTeams)[i])._breakLevelBack):SetActive(breakLv > 0)
      ;
      (((self.myTeams)[i])._breakLevelNum):SetActive(breakLv > 0)
      if breakLv > 0 then
        image = tempRole:GetCurBreakFrame1ImageRecord()
        ;
        (((self.myTeams)[i])._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
        ;
        (((self.myTeams)[i])._breakLevelBack):SetActive(true)
        ;
        (((self.myTeams)[i])._breakLevelNum):SetText(breakLv)
        ;
        (((self.myTeams)[i])._breakLevelNum):SetActive(true)
      end
      image = tempRole:GetElementImageRecord()
      ;
      (((self.myTeams)[i])._element):SetSprite(image.assetBundle, image.assetName)
      ;
      (((self.myTeams)[i])._element):SetActive(true)
      local level = tempRole:GetRuneLevel()
      ;
      ((((self.myTeams)[i]).charUpgrade).panel):SetActive(level ~= 0)
      for k = 1, 5 do
        (((((self.myTeams)[i]).charUpgrade).levelImage)[k]):SetActive(level == k)
      end
    else
      (((self.myTeams)[i]).charPanel):SetActive(true)
    end
  end
  -- DECOMPILER ERROR: 16 unprocessed JMP targets
end

SeasonPvpDefenseRecordCell.OnEnemyCellClicked = function(self, roleIndex)
  -- function num : 0_6
end

SeasonPvpDefenseRecordCell.OnMyCellClicked = function(self, roleIndex)
  -- function num : 0_7
end

return SeasonPvpDefenseRecordCell

