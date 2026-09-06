local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local UndecidedRoadRankTeamAlternateCell = class("UndecidedRoadRankTeamAlternateCell", Dialog)
UndecidedRoadRankTeamAlternateCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRankTeamAlternateCell.AssetName = "ActivityRoadTeamCharCell"

function UndecidedRoadRankTeamAlternateCell:Ctor(...)
  UndecidedRoadRankTeamAlternateCell.super.Ctor(self, ...)
end

function UndecidedRoadRankTeamAlternateCell:OnCreate()
  self._cell = self:GetChild("Cell")
  self._frame = self:GetChild("Cell/Frame")
  self._photo = self:GetChild("Cell/Photo")
  self._rank = self:GetChild("Cell/Rank")
  self._rankBack = self:GetChild("Cell/RankBack")
  self._job = self:GetChild("Cell/Job")
  self._level = self:GetChild("Cell/Level/Num")
  self._maxLevel = self:GetChild("Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function UndecidedRoadRankTeamAlternateCell:OnDestroy()
end

function UndecidedRoadRankTeamAlternateCell:RefreshCell(data)
  if data.roleId == 0 then
    self._cell:SetActive(false)
  else
    self._cell:SetActive(true)
    self._role = Role.Create(data.roleId)
    self._role:SetFashionId(data.skin)
    self._role:SetLevel(data.level)
    self._role:SetBreakLv(data.breakLv)
    local image = self._role:GetShapeLittleHeadImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetSmallRarityFrameRecord()
    self._frame:SetSprite(image.assetBundle, image.assetName)
    if self._role:GetIsLeader() then
      self._rank:SetActive(false)
      self._rankBack:SetActive(false)
    else
      self._rank:SetActive(true)
      self._rankBack:SetActive(true)
      image = self._role:GetRarityImageRecord()
      self._rank:SetSprite(image.assetBundle, image.assetName)
      image = self._role:GetRarityRankDownRecord()
      self._rankBack:SetSprite(image.assetBundle, image.assetName)
    end
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    self._level:SetText(self._role:GetShowLv())
    local breakLv = self._role:GetBreakLv()
    self._breakLevelBackBlack:SetActive(breakLv == 0)
    self._breakLevelBack:SetActive(0 < breakLv)
    self._breakLevel:SetActive(0 < breakLv)
    if 0 < breakLv then
      local imageRecord = self._role:GetCurBreakFrame1ImageRecord()
      self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._breakLevel:SetText(breakLv)
    end
  end
end

function UndecidedRoadRankTeamAlternateCell:OnCellClicked()
  if self._delegate._protoData then
    local roleList = self._delegate:GetRoleList()
    local newList = {}
    local idx = 0
    local curIdx = 0
    for index, v in ipairs(roleList) do
      if index <= 3 and v.roleId ~= 0 then
        idx = idx + 1
        v.index = idx
        table.insert(newList, v)
        if v.roleId == self._cellData.roleId then
          curIdx = idx
        end
      end
    end
    local dlg = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dlg then
      dlg:Init({dataIndex = curIdx, allRoleData = newList}, CheckOtherRoleInfoDialog.ShowType.BossRushRank)
      dlg:UpdateProtocol(self._delegate._protoData)
    end
  else
    LogInfo("UndecidedRoadRankTeamAlternateCell", "waiting suserlineupdata.")
  end
end

return UndecidedRoadRankTeamAlternateCell
