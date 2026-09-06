local UndecidedRoadRecordCell = class("UndecidedRoadRecordCell", Dialog)
UndecidedRoadRecordCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRecordCell.AssetName = "ActivityRoadRecordCell"
local Role = require("logic.manager.experimental.types.role")

function UndecidedRoadRecordCell:Ctor(...)
  UndecidedRoadRecordCell.super.Ctor(self, ...)
end

function UndecidedRoadRecordCell:OnCreate()
  self._teams = {}
  for i = 1, 2 do
    self._teams[i] = {}
    self._teams[i].cellNode = {}
    self._teams[i]._frame = {}
    self._teams[i]._photo = {}
    self._teams[i]._downRankBack = {}
    self._teams[i]._level = {}
    self._teams[i]._rankBack = {}
    self._teams[i]._rank = {}
    self._teams[i]._job = {}
    self._teams[i]._breakLevelBackBlack = {}
    self._teams[i]._breakLevelBack = {}
    self._teams[i]._breakLevelNum = {}
    self._teams[i]._breakLevel = {}
    self._teams[i]._element = {}
    self._teams[i]._grey = {}
    self._teams[i]._select = {}
    self._teams[i]._charUpgrade = {}
    for j = 1, 3 do
      self._teams[i].cellNode[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j)
      self._teams[i]._frame[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Frame")
      self._teams[i]._photo[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Photo")
      self._teams[i]._downRankBack[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/DownRankBack")
      self._teams[i]._level[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Level/Num")
      self._teams[i]._rankBack[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/RankBack")
      self._teams[i]._rank[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Rank")
      self._teams[i]._job[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Job")
      self._teams[i]._breakLevelBackBlack[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBackBlack")
      self._teams[i]._breakLevelBack[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelBack")
      self._teams[i]._breakLevelNum[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevelNum")
      self._teams[i]._breakLevel[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/BreakLevel")
      self._teams[i]._element[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Element")
      self._teams[i]._grey[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Grey")
      self._teams[i]._select[j] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/Select")
      local index = (i - 1) * 3 + j
      self._teams[i]._charUpgrade[j] = {
        panel = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/CharUpgrade"),
        levelImage = {}
      }
      for k = 1, 5 do
        self._teams[i]._charUpgrade[j].levelImage[k] = self:GetChild("Panel/Team" .. i .. "/CharSmallCell" .. j .. "/CharUpgrade/Img" .. k)
      end
    end
  end
  self._title = self:GetChild("Panel/Title")
  self._scoreTxt = self:GetChild("Panel/Num")
  self._timeTxt = self:GetChild("Panel/Time")
end

function UndecidedRoadRecordCell:OnDestroy()
end

function UndecidedRoadRecordCell:RefreshCell(data)
  self._data = data
  if data.type == 100 then
    self._title:SetText(TextManager.GetText(1901007))
  else
    self._title:SetText(TextManager.GetText(1901008) .. " " .. data.type)
  end
  self._scoreTxt:SetText(data.score)
  self._timeTxt:SetText(os.date("%Y-%m-%d %H:%M:%S", data.time // 1000))
  for i = 1, 2 do
    for j = 1, 3 do
      local temp = j
      if 1 < i then
        j = 3 + j
      end
      local roleInfo = self._data.roleIdList[j]
      j = temp
      if roleInfo then
        self._teams[i].cellNode[j]:SetActive(true)
        local tempRole = Role.Create(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
        tempRole:SetFashionId(roleInfo.skin)
        local image = tempRole:GetShapeLittleHeadImageRecord()
        self._teams[i]._photo[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetSmallRarityFrameRecord()
        self._teams[i]._frame[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetRarityBottomBackRecord()
        self._teams[i]._downRankBack[j]:SetSprite(image.assetBundle, image.assetName)
        self._teams[i]._level[j]:SetText(tempRole:GetShowLv())
        image = tempRole:GetRarityImageRecord()
        self._teams[i]._rank[j]:SetSprite(image.assetBundle, image.assetName)
        image = tempRole:GetVocationImageRecord()
        self._teams[i]._job[j]:SetSprite(image.assetBundle, image.assetName)
        local breakLv = tempRole:GetBreakLv()
        self._teams[i]._breakLevelBackBlack[j]:SetActive(breakLv == 0)
        self._teams[i]._breakLevelBack[j]:SetActive(0 < breakLv)
        self._teams[i]._breakLevelNum[j]:SetActive(0 < breakLv)
        if 0 < breakLv then
          image = tempRole:GetCurBreakFrame1ImageRecord()
          self._teams[i]._breakLevelBack[j]:SetSprite(image.assetBundle, image.assetName)
          self._teams[i]._breakLevelNum[j]:SetText(breakLv)
        end
        image = tempRole:GetElementImageRecord()
        self._teams[i]._element[j]:SetSprite(image.assetBundle, image.assetName)
        tempRole:SetRuneLevel(roleInfo.runeLevel)
        local level = tempRole:GetRuneLevel()
        self._teams[i]._charUpgrade[j].panel:SetActive(level ~= 0)
        for k = 1, 5 do
          self._teams[i]._charUpgrade[j].levelImage[k]:SetActive(level == k)
        end
      else
        self._teams[i].cellNode[j]:SetActive(false)
      end
    end
  end
end

return UndecidedRoadRecordCell
