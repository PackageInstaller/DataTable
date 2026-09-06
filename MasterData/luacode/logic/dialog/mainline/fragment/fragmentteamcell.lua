local FragmentTeamCell = class("FragmentTeamCell", Dialog)
FragmentTeamCell.AssetBundleName = "ui/layouts.fragment"
FragmentTeamCell.AssetName = "FragmentTeamCell"
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function FragmentTeamCell:Ctor(...)
  FragmentTeamCell.super.Ctor(self, ...)
  self._id = nil
  self._index = -1
  self._isSelect = false
end

function FragmentTeamCell:OnCreate()
  self._jobIcon = self:GetChild("Cell/Job")
  self._rankIcon = self:GetChild("Cell/Rank")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._level = self:GetChild("Cell/Level/Num")
  self._breakLevelBackBlack = self:GetChild("Cell/Level/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/Level/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/Level/BreakLevelNum")
  self._select = self:GetChild("Cell/Select")
  self._selectText = {
    self:GetChild("Cell/SelectTxt1"),
    self:GetChild("Cell/SelectTxt2"),
    self:GetChild("Cell/SelectTxt3")
  }
  self._grey = self:GetChild("Cell/Grey")
  self._used = self:GetChild("Cell/Used")
  self._elementImg = self:GetChild("Cell/Element")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._charUpgrade = {
    panel = self:GetChild("Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
end

function FragmentTeamCell:OnDestroy()
end

function FragmentTeamCell:RefreshCell(data)
  local spriteRecord = data:GetVocationImageRecord()
  self._jobIcon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetSmallRarityFrameRecord()
  self._frame:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetRarityImageRecord()
  self._rankIcon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetElementImageRecord()
  self._elementImg:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._level:SetText(data:GetShowLv())
  local breakLv = data:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevel:SetActive(0 < breakLv)
  if 0 < breakLv then
    local imageRecord = data:GetCurBreakFrame2ImageRecord()
    self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._breakLevel:SetText(breakLv)
  end
  spriteRecord = data:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._id = data:GetId()
  local teamData = self._delegate:GetCurrentTeamData()
  for i, v in ipairs(teamData) do
    if v == self._id then
      self._index = i
      break
    end
    self._index = -1
  end
  for i, v in ipairs(self._selectText) do
    v:SetActive(false)
  end
  if self._index == -1 then
    self._select:SetActive(false)
  else
    self._select:SetActive(true)
    self._selectText[self._index]:SetActive(true)
  end
  self._used:SetActive(self:IsRoleDisable())
  self._grey:SetActive(self:IsRoleDisable())
  ShowCharUpgrade(self, data:GetRuneLevel())
end

function FragmentTeamCell:IsRoleDisable()
  if self._delegate:IsRoleUnfrozen(self._id) then
    return false
  elseif self._delegate:IsRoleLock(self._id) then
    return true
  else
    return false
  end
end

function FragmentTeamCell:OnCellClicked()
  if self._index ~= -1 then
    self._delegate:OnCharCellClick(self._id, self._index)
  else
    self._delegate:OnCharCellClick(self._id)
  end
end

function FragmentTeamCell:OnEvent(eventName, arg)
  if eventName == "select" then
    if arg.id == self._id then
      self._select:SetActive(true)
      self._selectText[arg.index]:SetActive(true)
      self._index = arg.index
    end
  elseif eventName == "unselect" then
    if arg.id == self._id then
      self._select:SetActive(false)
      for i, v in ipairs(self._selectText) do
        v:SetActive(false)
      end
      self._index = -1
    end
  elseif eventName == "unselectAll" then
    self._select:SetActive(false)
    for i, v in ipairs(self._selectText) do
      v:SetActive(false)
    end
    self._index = -1
  end
end

return FragmentTeamCell
