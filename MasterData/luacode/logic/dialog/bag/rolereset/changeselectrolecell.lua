local ChangeSelectRoleCell = class("ChangeSelectRoleCell", Dialog)
ChangeSelectRoleCell.AssetBundleName = "ui/layouts.teamedit"
ChangeSelectRoleCell.AssetName = "TeamEditChangeNewCell"

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function ChangeSelectRoleCell:Ctor(...)
  ChangeSelectRoleCell.super.Ctor(self, ...)
  self._sameTag = false
end

function ChangeSelectRoleCell:OnCreate()
  self._empty = self:GetChild("Empty")
  self._cell = self:GetChild("Cell")
  self._photo = self:GetChild("Cell/Photo")
  self._grey = self:GetChild("Cell/Grey")
  self._rankFrame = self:GetChild("Cell/Frame")
  self._rankBack = self:GetChild("Cell/RankBack")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._rank = self:GetChild("Cell/Rank")
  self._job = self:GetChild("Cell/Job")
  self._level = self:GetChild("Cell/Level/Num")
  self._maxLevel = self:GetChild("Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self._txt = self:GetChild("Cell/Txt")
  self._cur = self:GetChild("Cell/Current")
  self._select = self:GetChild("Cell/Select")
  self._sub = self:GetChild("Cell/Sub")
  self._jobLimit = self:GetChild("Cell/JobLimit")
  self._starMirageUpPanel = self:GetChild("Cell/ActivityStarUp")
  self._starMirageUpPanel_txt = self:GetChild("Cell/ActivityStarUp/Text")
  self._elementImg = self:GetChild("Cell/Element")
  self._charUpgrade = {
    panel = self:GetChild("Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
  self._isJobLimit = false
  if not NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(10) then
  end
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ChangeSelectRoleCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChangeSelectRoleCell:RefreshCell(data)
  if type(data) == "table" then
    self._role = data
    self._cell:SetActive(true)
    self._grey:SetActive(false)
    self._txt:SetActive(false)
    self._sub:SetActive(false)
    self._cur:SetActive(false)
    local image = self._role:GetSmallRarityBackRecord()
    image = self._role:GetShapeLittleHeadImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    if self._delegate._curRoleKey == self._role:GetRoleId() then
      self._cur:SetActive(true)
    else
      self._grey:SetActive(false)
      self._txt:SetActive(false)
      self._sub:SetActive(false)
      self._cur:SetActive(false)
    end
    if self._role:GetRoleId() == self._delegate._curSelectRoleKey then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
    image = self._role:GetSmallRarityFrameRecord()
    self._rankFrame:SetSprite(image.assetBundle, image.assetName)
    if self._role:GetIsLeader() then
      self._rankBack:SetActive(false)
      self._rank:SetActive(false)
    else
      self._rankBack:SetActive(true)
      self._rank:SetActive(true)
      image = self._role:GetRarityImageRecord()
      self._rank:SetSprite(image.assetBundle, image.assetName)
    end
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    self._level:SetText(self._role:GetShowLv())
    self._maxLevel:SetText(self._role:GetShowMaxBreakLv())
    image = self._role:GetElementImageRecord()
    self._elementImg:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityBottomBackRecord()
    self._downRankBack:SetSprite(image.assetBundle, image.assetName)
    local breakLv = self._role:GetBreakLv()
    self._breakLevelBackBlack:SetActive(breakLv == 0)
    self._breakLevelBack:SetActive(0 < breakLv)
    self._breakLevel:SetActive(0 < breakLv)
    if 0 < breakLv then
      local imageRecord = self._role:GetCurBreakFrame1ImageRecord()
      self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._breakLevel:SetText(breakLv)
    end
    if self._role:GetHurtExtent() ~= 0 and not self._index then
      self._sameTag = false
    elseif not self._index then
      self._grey:SetActive(false)
      self._sameTag = false
    end
    self._isJobLimit = not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(self._role, self._delegate._supportVocationTable)
    if self._isJobLimit and self._delegate._curRoleKey ~= self._role:GetRoleId() then
      self._jobLimit:SetActive(true)
      self._grey:SetActive(true)
      self._sub:SetActive(false)
      self._txt:SetActive(false)
    else
      self._jobLimit:SetActive(false)
    end
    local value = self._role:IsBoost()
    if not value then
      self._starMirageUpPanel:SetActive(false)
    else
      self._starMirageUpPanel:SetActive(true)
      self._starMirageUpPanel_txt:SetText(value.changeTeamRoleCellStr)
    end
    ShowCharUpgrade(self, self._role:GetRuneLevel())
  end
end

function ChangeSelectRoleCell:OnCellClicked()
  if self._isJobLimit and self._role:GetRoleId() ~= self._delegate._curSelectRoleKey then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100227)
    return
  end
  if self._role:GetRoleId() == self._delegate._curSelectRoleKey then
    self._delegate:SetSelectedID("RoleLeave", self._role:GetRoleId())
  else
    self._delegate:SetSelectedID("RoleAdd", self._role:GetRoleId())
  end
end

function ChangeSelectRoleCell:OnEvent(eventName, arg)
  if eventName == "RoleLeave" then
    if self._delegate._curRoleKey == self._role:GetRoleId() then
      self._cur:SetActive(true)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
      self._sub:SetActive(false)
    else
      self._cur:SetActive(false)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
      self._sub:SetActive(false)
    end
  end
  if eventName == "RoleAdd" then
    if self._delegate._curRoleKey == self._role:GetRoleId() then
      self._cur:SetActive(true)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
      self._sub:SetActive(false)
    else
      self._cur:SetActive(false)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
      self._sub:SetActive(false)
    end
  end
  if eventName == "UniqueEquipLevelUp" and arg == self._role:GetRoleId() then
    self:RefreshCell(self._role)
  end
  if self._role:GetRoleId() == self._delegate._curSelectRoleKey then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  self._isJobLimit = not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(self._role, self._delegate._supportVocationTable)
  if self._isJobLimit and self._delegate._curRoleKey ~= self._role:GetRoleId() then
    self._jobLimit:SetActive(true)
    self._grey:SetActive(true)
    self._sub:SetActive(false)
    self._txt:SetActive(false)
  else
    self._jobLimit:SetActive(false)
  end
end

return ChangeSelectRoleCell
