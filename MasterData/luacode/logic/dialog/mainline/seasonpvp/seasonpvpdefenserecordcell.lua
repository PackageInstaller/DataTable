local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local SeasonPvpDefenseRecordCell = class("SeasonPvpDefenseRecordCell", Dialog)
SeasonPvpDefenseRecordCell.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpDefenseRecordCell.AssetName = "SeasonPVPDefenseRecordCell"

function SeasonPvpDefenseRecordCell:Ctor(...)
  SeasonPvpDefenseRecordCell.super.Ctor(self, ...)
end

function SeasonPvpDefenseRecordCell:OnCreate()
  self._photo = self:GetChild("Panel/Player/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/Player/HeadPhoto/Frame")
  self._levelNum = self:GetChild("Panel/Player/LvBack/Level")
  self._userName = self:GetChild("Panel/Player/NameBack/Name")
  self._time = self:GetChild("Panel/Player/TimeBack/Time")
  self._time:SetText("")
  self._resultText = self:GetChild("Panel/Txt")
  self._resultText:SetText("")
  self.enemyTeams = {}
  for i = 1, 3 do
    self.enemyTeams[i] = {}
    self.enemyTeams[i].charPanel = self:GetChild("Panel/Team1/CharSmallCell" .. i)
    self.enemyTeams[i]._frame = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Frame")
    self.enemyTeams[i]._photo = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Photo")
    self.enemyTeams[i]._unkown = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Unknown")
    self.enemyTeams[i]._unkown:SetActive(false)
    self.enemyTeams[i]._downRankBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/DownRankBack")
    self.enemyTeams[i]._level = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Level/Num")
    self.enemyTeams[i]._level:SetText("")
    self.enemyTeams[i]._rankBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/RankBack")
    self.enemyTeams[i]._rank = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Rank")
    self.enemyTeams[i]._rank:SetActive(false)
    self.enemyTeams[i]._job = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Job")
    self.enemyTeams[i]._job:SetActive(false)
    self.enemyTeams[i]._breakLevelBackBlack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelBackBlack")
    self.enemyTeams[i]._breakLevelBack = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelBack")
    self.enemyTeams[i]._breakLevelNum = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevelNum")
    self.enemyTeams[i]._breakLevelNum:SetText("")
    self.enemyTeams[i]._breakLevel = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/BreakLevel")
    self.enemyTeams[i]._element = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Element")
    self.enemyTeams[i]._element:SetActive(false)
    self.enemyTeams[i]._grey = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Grey")
    self.enemyTeams[i]._select = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/Select")
    self.enemyTeams[i]._frame:Subscribe_PointerClickEvent(function()
      self:OnEnemyCellClicked(i)
    end, self)
    self.enemyTeams[i].charUpgrade = {}
    self.enemyTeams[i].charUpgrade = {
      panel = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/CharUpgrade"),
      levelImage = {}
    }
    for k = 1, 5 do
      self.enemyTeams[i].charUpgrade.levelImage[k] = self:GetChild("Panel/Team1/CharSmallCell" .. i .. "/CharUpgrade/Img" .. k)
    end
  end
  self.myTeams = {}
  for i = 1, 3 do
    self.myTeams[i] = {}
    self.myTeams[i].charPanel = self:GetChild("Panel/Team2/CharSmallCell" .. i)
    self.myTeams[i]._frame = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Frame")
    self.myTeams[i]._photo = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Photo")
    self.myTeams[i]._unkown = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Unknown")
    self.myTeams[i]._unkown:SetActive(false)
    self.myTeams[i]._downRankBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/DownRankBack")
    self.myTeams[i]._level = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Level/Num")
    self.myTeams[i]._level:SetText("")
    self.myTeams[i]._rankBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/RankBack")
    self.myTeams[i]._rank = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Rank")
    self.myTeams[i]._rank:SetActive(false)
    self.myTeams[i]._job = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Job")
    self.myTeams[i]._job:SetActive(false)
    self.myTeams[i]._breakLevelBackBlack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelBackBlack")
    self.myTeams[i]._breakLevelBack = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelBack")
    self.myTeams[i]._breakLevelNum = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevelNum")
    self.myTeams[i]._breakLevelNum:SetText("")
    self.myTeams[i]._breakLevel = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/BreakLevel")
    self.myTeams[i]._element = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Element")
    self.myTeams[i]._element:SetActive(false)
    self.myTeams[i]._grey = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Grey")
    self.myTeams[i]._select = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/Select")
    self.myTeams[i]._frame:Subscribe_PointerClickEvent(function()
      self:OnMyCellClicked(i)
    end, self)
    self.myTeams[i].charUpgrade = {}
    self.myTeams[i].charUpgrade = {
      panel = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/CharUpgrade"),
      levelImage = {}
    }
    for k = 1, 5 do
      self.myTeams[i].charUpgrade.levelImage[k] = self:GetChild("Panel/Team2/CharSmallCell" .. i .. "/CharUpgrade/Img" .. k)
    end
  end
end

function SeasonPvpDefenseRecordCell:OnDestroy()
end

function SeasonPvpDefenseRecordCell:SetBack(rank)
end

function SeasonPvpDefenseRecordCell:formatTimestampToUTC(timestamp)
  local t = os.date("*t", timestamp)
  return string.format("%d年%d月%d日 %02d:%02d:%02d", t.year, t.month, t.day, t.hour, t.min, t.sec)
end

function SeasonPvpDefenseRecordCell:RefreshCell(data)
  if data.result == 1 then
    self._resultText:SetText(TextManager.GetText(CStringRes:GetRecorder(2253).msgTextID))
  else
    self._resultText:SetText(TextManager.GetText(CStringRes:GetRecorder(2254).msgTextID))
  end
  self._time:SetText(self:formatTimestampToUTC(math.floor(data.time / 1000)))
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.enemyUserData.avatarId)
  local imageRecord
  if headPhotoRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.enemyUserData.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._levelNum:SetText(data.enemyUserData.userLv)
  self._userName:SetText(data.enemyUserData.userName)
  for i = 1, 3 do
    local roleInfo = data.enemyRoleList[i]
    if roleInfo then
      self.enemyTeams[i].charPanel:SetActive(true)
      local tempRole = Role.Create(roleInfo.id)
      tempRole:SetLevel(roleInfo.lv)
      tempRole:SetBreakLv(roleInfo.breakLv)
      tempRole:SetRuneLevel(roleInfo.runeLevel)
      local image = tempRole:GetShapeLittleHeadImageRecord()
      self.enemyTeams[i]._photo:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._photo:SetActive(true)
      image = tempRole:GetSmallRarityFrameRecord()
      self.enemyTeams[i]._frame:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._frame:SetActive(true)
      image = tempRole:GetRarityBottomBackRecord()
      self.enemyTeams[i]._downRankBack:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._downRankBack:SetActive(true)
      self.enemyTeams[i]._level:SetText(tempRole:GetShowLv())
      image = tempRole:GetRarityImageRecord()
      self.enemyTeams[i]._rank:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._rank:SetActive(true)
      image = tempRole:GetVocationImageRecord()
      self.enemyTeams[i]._job:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._job:SetActive(true)
      local breakLv = tempRole:GetBreakLv()
      self.enemyTeams[i]._breakLevelBackBlack:SetActive(breakLv == 0)
      self.enemyTeams[i]._breakLevelBack:SetActive(0 < breakLv)
      self.enemyTeams[i]._breakLevelNum:SetActive(0 < breakLv)
      if 0 < breakLv then
        image = tempRole:GetCurBreakFrame1ImageRecord()
        self.enemyTeams[i]._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
        self.enemyTeams[i]._breakLevelBack:SetActive(true)
        self.enemyTeams[i]._breakLevelNum:SetText(breakLv)
        self.enemyTeams[i]._breakLevelNum:SetActive(true)
      end
      image = tempRole:GetElementImageRecord()
      self.enemyTeams[i]._element:SetSprite(image.assetBundle, image.assetName)
      self.enemyTeams[i]._element:SetActive(true)
      local level = tempRole:GetRuneLevel()
      self.enemyTeams[i].charUpgrade.panel:SetActive(level ~= 0)
      for k = 1, 5 do
        self.enemyTeams[i].charUpgrade.levelImage[k]:SetActive(level == k)
      end
    else
      self.enemyTeams[i].charPanel:SetActive(true)
    end
  end
  for i = 1, 3 do
    local roleInfo = data.mineRoleList[i]
    if roleInfo then
      self.myTeams[i].charPanel:SetActive(true)
      local tempRole = Role.Create(roleInfo.id)
      tempRole:SetLevel(roleInfo.lv)
      tempRole:SetBreakLv(roleInfo.breakLv)
      tempRole:SetRuneLevel(roleInfo.runeLevel)
      local image = tempRole:GetShapeLittleHeadImageRecord()
      self.myTeams[i]._photo:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._photo:SetActive(true)
      image = tempRole:GetSmallRarityFrameRecord()
      self.myTeams[i]._frame:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._frame:SetActive(true)
      image = tempRole:GetRarityBottomBackRecord()
      self.myTeams[i]._downRankBack:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._downRankBack:SetActive(true)
      self.myTeams[i]._level:SetText(tempRole:GetShowLv())
      image = tempRole:GetRarityImageRecord()
      self.myTeams[i]._rank:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._rank:SetActive(true)
      image = tempRole:GetVocationImageRecord()
      self.myTeams[i]._job:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._job:SetActive(true)
      local breakLv = tempRole:GetBreakLv()
      self.myTeams[i]._breakLevelBackBlack:SetActive(breakLv == 0)
      self.myTeams[i]._breakLevelBack:SetActive(0 < breakLv)
      self.myTeams[i]._breakLevelNum:SetActive(0 < breakLv)
      if 0 < breakLv then
        image = tempRole:GetCurBreakFrame1ImageRecord()
        self.myTeams[i]._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
        self.myTeams[i]._breakLevelBack:SetActive(true)
        self.myTeams[i]._breakLevelNum:SetText(breakLv)
        self.myTeams[i]._breakLevelNum:SetActive(true)
      end
      image = tempRole:GetElementImageRecord()
      self.myTeams[i]._element:SetSprite(image.assetBundle, image.assetName)
      self.myTeams[i]._element:SetActive(true)
      local level = tempRole:GetRuneLevel()
      self.myTeams[i].charUpgrade.panel:SetActive(level ~= 0)
      for k = 1, 5 do
        self.myTeams[i].charUpgrade.levelImage[k]:SetActive(level == k)
      end
    else
      self.myTeams[i].charPanel:SetActive(true)
    end
  end
end

function SeasonPvpDefenseRecordCell:OnEnemyCellClicked(roleIndex)
end

function SeasonPvpDefenseRecordCell:OnMyCellClicked(roleIndex)
end

return SeasonPvpDefenseRecordCell
