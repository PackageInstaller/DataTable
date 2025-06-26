-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadrankteamcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local UndecidedRoadRankTeamRoleCell = class("UndecidedRoadRankTeamRoleCell", Dialog)
UndecidedRoadRankTeamRoleCell.AssetBundleName = "ui/widgets"
UndecidedRoadRankTeamRoleCell.AssetName = "CharacterCellLarge"
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UndecidedRoadRankTeamRoleCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : UndecidedRoadRankTeamRoleCell
  ((UndecidedRoadRankTeamRoleCell.super).Ctor)(self, ...)
  self._handler = 0
end

UndecidedRoadRankTeamRoleCell.OnCreate = function(self)
  -- function num : 0_2
  self._empty = self:GetChild("_Empty")
  self._add = self:GetChild("_Add")
  self._cell = self:GetChild("_Cell")
  self._back = self:GetChild("_Cell/Back")
  self._photo = self:GetChild("_Cell/Photo")
  self._rank = self:GetChild("_Cell/Rank")
  self._rankDownBackBottom = self:GetChild("_Cell/RankDownBack")
  self._level = self:GetChild("_Cell/Level/Num")
  self._maxLevel = self:GetChild("_Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("_Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("_Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("_Cell/BreakLevelNum")
  self._job = self:GetChild("_Cell/Job")
  self._model = self:GetChild("_Cell/Model")
  self._detailBtn = self:GetChild("_Cell/DetailBtn")
  self._elementImg = self:GetChild("_Cell/Element")
  ;
  (self._detailBtn):SetActive(false)
  self._charUpgrade = {panel = self:GetChild("_Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("_Cell/CharUpgrade/Img" .. i)
  end
  ;
  (self:GetChild("_Add")):SetActive(false)
  ;
  (self:GetChild("_Cell/Level/Text")):SetActive(false)
  self._handler = (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

UndecidedRoadRankTeamRoleCell.OnDestroy = function(self)
  -- function num : 0_3
end

UndecidedRoadRankTeamRoleCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Role, ShowCharUpgrade
  if data.roleId == 0 then
    (self._cell):SetActive(false)
    return 
  end
  ;
  (self._cell):SetActive(true)
  self._role = (Role.Create)(data.roleId)
  ;
  (self._role):SetFashionId(data.skin)
  local image = (self._role):GetShapeBigBustImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = (self._role):GetTeamRarityBackRecord()
  ;
  (self._back):SetSprite(image.assetBundle, image.assetName)
  if (self._role):GetIsLeader() then
    (self._rank):SetActive(false)
    ;
    (self._rankDownBackBottom):SetActive(false)
  else
    ;
    (self._rank):SetActive(true)
    image = (self._role):GetTeamRarityImageRecord()
    ;
    (self._rank):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetRarityRankDownRecord()
    ;
    (self._rankDownBackBottom):SetSprite(image.assetBundle, image.assetName)
  end
  ;
  (self._role):SetLevel(data.level)
  ;
  (self._role):SetBreakLv(data.breakLv)
  ;
  (self._level):SetText((self._role):GetShowLv())
  ;
  (self._maxLevel):SetText("")
  local breakLv = (self._role):GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevel):SetActive(breakLv > 0)
  do
    if breakLv > 0 then
      local imageRecord = (self._role):GetCurBreakFrame2ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
    image = (self._role):GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetElementImageRecord()
    ;
    (self._elementImg):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetModelRecord()
    if self._handler ~= 0 then
      (self._model):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._model):AddModelSync(image.assetBundle, image.assetName)
    ;
    (self._role):SetRuneLevel(data.runeLevel)
    ShowCharUpgrade(self, (self._role):GetRuneLevel())
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

UndecidedRoadRankTeamRoleCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CheckOtherRoleInfoDialog
  if (self._cellData).roleId ~= 0 then
    if (self._delegate)._protoData then
      local roleList = (self._delegate):GetRoleList()
      local newList = {}
      local idx = 0
      local curIdx = 0
      for index,v in ipairs(roleList) do
        if index > 3 and v.roleId ~= 0 then
          idx = idx + 1
          v.index = idx
          ;
          (table.insert)(newList, v)
          if v.roleId == (self._cellData).roleId then
            curIdx = idx
          end
        end
      end
      local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
      if dlg then
        dlg:Init({dataIndex = curIdx, allRoleData = newList}, (CheckOtherRoleInfoDialog.ShowType).BossRushRank)
        dlg:UpdateProtocol((self._delegate)._protoData)
      end
    else
      do
        LogInfo("UndecidedRoadRankTeamRoleCell", "waiting suserlineupdata.")
      end
    end
  end
end

return UndecidedRoadRankTeamRoleCell

