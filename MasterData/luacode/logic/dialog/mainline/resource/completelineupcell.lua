local DungeonInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeoninfo")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local Role = require("logic.manager.experimental.types.role")
local CompleteLineupCell = class("CompleteLineupCell", Dialog)
CompleteLineupCell.AssetBundleName = "ui/layouts.mainline"
CompleteLineupCell.AssetName = "ResourceSelectTeamCell"

function CompleteLineupCell:Ctor(...)
  CompleteLineupCell.super.Ctor(self, ...)
  self._data = {}
end

function CompleteLineupCell:OnCreate()
  self._nameBtn = self:GetChild("Panel/PlayerInfo/Click")
  self._nameTxt = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._headphotoImg = self:GetChild("Panel/PlayerInfo/CharFrame/Char")
  self._headFrameImg = self:GetChild("Panel/PlayerInfo/CharFrame")
  self._levelTxt = self:GetChild("Panel/PlayerInfo/LvBack/Level")
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
      self._teams[i]._frame[j]:Subscribe_PointerClickEvent(function()
        self:OnCellClicked(index)
      end, self)
    end
  end
  self._nameBtn:Subscribe_PointerClickEvent(self.OnNameBtnClicked, self)
end

function CompleteLineupCell:OnDestroy()
end

function CompleteLineupCell:RefreshCell(data)
  self._data = data
  self._nameTxt:SetText(self._data.userName)
  self._levelTxt:SetText(self._data.userLv)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._data.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headphotoImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headphotoImg:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CompleteLineupCell", "headPhotoRecord not found. avatarId = %s", self._data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._data.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headFrameImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headFrameImg:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CompleteLineupCell", "headPhotoFrameRecord not found. frameId = %s", self._data.frameId)
  end
  for i = 1, 2 do
    for j = 1, 3 do
      local temp = j
      if 1 < i then
        j = 3 + j
      end
      local roleInfo = self._data.roles[j]
      j = temp
      if roleInfo then
        self._teams[i].cellNode[j]:SetActive(true)
        local tempRole = Role.Create(roleInfo.id)
        tempRole:SetLevel(roleInfo.lv)
        tempRole:SetBreakLv(roleInfo.breakLv)
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
      else
        self._teams[i].cellNode[j]:SetActive(false)
      end
    end
  end
end

function CompleteLineupCell:OnCellClicked(index)
  if self._data.roles[index] then
    local roleList = self._data.roles
    local dlg = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dlg then
      dlg:Init({index = index, roleList = roleList}, dlg.ShowType.CompleteLineup)
    end
  end
end

function CompleteLineupCell:OnNameBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  protocol.userId = self._data.userId
  protocol:Send()
end

return CompleteLineupCell
