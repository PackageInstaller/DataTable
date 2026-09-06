local TeamRecordCharCell = class("TeamRecordCharCell", Dialog)
TeamRecordCharCell.AssetBundleName = "ui/layouts.fragment"
TeamRecordCharCell.AssetName = "TeamRecordCharCell"
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function TeamRecordCharCell:Ctor(...)
  TeamRecordCharCell.super.Ctor(self, ...)
end

function TeamRecordCharCell:OnCreate()
  self._jobIcon = self:GetChild("Cell/Job")
  self._rankIcon = self:GetChild("Cell/Rank")
  self._rankIconBack = self:GetChild("Cell/RankBack")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._level = self:GetChild("Cell/Level/Num")
  self._breakLevelBackBlack = self:GetChild("Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self._element = self:GetChild("Cell/Element")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._charUpgrade = {
    panel = self:GetChild("Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
end

function TeamRecordCharCell:OnDestroy()
end

function TeamRecordCharCell:RefreshCell(data)
  local role
  if type(data) == "table" then
    role = data
  else
    role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(data)
  end
  local spriteRecord = role:GetVocationImageRecord()
  self._jobIcon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = role:GetRarityImageRecord()
  self._rankIcon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = role:GetElementImageRecord()
  self._element:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._level:SetText(role:GetShowLv())
  local breakLv = role:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevel:SetActive(0 < breakLv)
  if 0 < breakLv then
    local imageRecord = role:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._breakLevel:SetText(breakLv)
  end
  ShowCharUpgrade(self, role:GetRuneLevel())
end

return TeamRecordCharCell
