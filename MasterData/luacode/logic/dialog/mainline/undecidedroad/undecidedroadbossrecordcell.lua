local UndecidedRoadBossRecordCell = class("UndecidedRoadBossRecordCell", Dialog)
UndecidedRoadBossRecordCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadBossRecordCell.AssetName = "ActivityRoadBossRecordCell"
local Role = require("logic.manager.experimental.types.role")

function UndecidedRoadBossRecordCell:Ctor(...)
  UndecidedRoadBossRecordCell.super.Ctor(self, ...)
  self._data = {}
  self._data.roleIdList = {}
end

function UndecidedRoadBossRecordCell:OnCreate()
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
    end
  end
  self._title1 = self:GetChild("Panel/Title1")
  self._title2 = self:GetChild("Panel/Title2")
  self._scoreTxt = self:GetChild("Panel/Num")
  self._timeTxt = self:GetChild("Panel/NumTime")
  self._applyBtn = self:GetChild("Panel/ApplyBtn")
  self._applyBtn:Subscribe_PointerClickEvent(self.OnApplyBtnClicked, self)
end

function UndecidedRoadBossRecordCell:OnDestroy()
end

function UndecidedRoadBossRecordCell:RefreshCell(data)
  self._data = data
  self._title1:SetActive(data.type == 0)
  self._title2:SetActive(data.type == 1)
  self._scoreTxt:SetText(data.score)
  self._timeTxt:SetText(os.date("!%Y-%m-%d", data.time // 1000))
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
      else
        self._teams[i].cellNode[j]:SetActive(false)
      end
    end
  end
end

function UndecidedRoadBossRecordCell:OnApplyBtnClicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100383)
  local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
  local req = LuaNetManager.CreateProtocol("protocol.login.cconfirmroles")
  req.lineupId = 7000
  req.roles = {}
  for k, v in pairs(self._data.roleIdList) do
    req.roles[k] = v.id
  end
  req:Send()
end

return UndecidedRoadBossRecordCell
