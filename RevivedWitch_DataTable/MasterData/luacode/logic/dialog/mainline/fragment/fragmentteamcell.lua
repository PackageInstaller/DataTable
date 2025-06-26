-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmentteamcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FragmentTeamCell = class("FragmentTeamCell", Dialog)
FragmentTeamCell.AssetBundleName = "ui/layouts.fragment"
FragmentTeamCell.AssetName = "FragmentTeamCell"
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

FragmentTeamCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : FragmentTeamCell
  ((FragmentTeamCell.super).Ctor)(self, ...)
  self._id = nil
  self._index = -1
  self._isSelect = false
end

FragmentTeamCell.OnCreate = function(self)
  -- function num : 0_2
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
  self._selectText = {self:GetChild("Cell/SelectTxt1"), self:GetChild("Cell/SelectTxt2"), self:GetChild("Cell/SelectTxt3")}
  self._grey = self:GetChild("Cell/Grey")
  self._used = self:GetChild("Cell/Used")
  self._elementImg = self:GetChild("Cell/Element")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._charUpgrade = {panel = self:GetChild("Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
end

FragmentTeamCell.OnDestroy = function(self)
  -- function num : 0_3
end

FragmentTeamCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, ShowCharUpgrade
  local spriteRecord = data:GetVocationImageRecord()
  ;
  (self._jobIcon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetRarityImageRecord()
  ;
  (self._rankIcon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetElementImageRecord()
  ;
  (self._elementImg):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  ;
  (self._level):SetText(data:GetShowLv())
  local breakLv = data:GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevel):SetActive(breakLv > 0)
  do
    if breakLv > 0 then
      local imageRecord = data:GetCurBreakFrame2ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
    spriteRecord = data:GetRarityBottomBackRecord()
    ;
    (self._downRankBack):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
    self._id = data:GetId()
    local teamData = (self._delegate):GetCurrentTeamData()
    for i,v in ipairs(teamData) do
      if v == self._id then
        self._index = i
        break
      end
      self._index = -1
    end
    for i,v in ipairs(self._selectText) do
      v:SetActive(false)
    end
    if self._index == -1 then
      (self._select):SetActive(false)
    else
      (self._select):SetActive(true)
      ;
      ((self._selectText)[self._index]):SetActive(true)
    end
    ;
    (self._used):SetActive(self:IsRoleDisable())
    ;
    (self._grey):SetActive(self:IsRoleDisable())
    ShowCharUpgrade(self, data:GetRuneLevel())
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
  end
end

FragmentTeamCell.IsRoleDisable = function(self)
  -- function num : 0_5
  if (self._delegate):IsRoleUnfrozen(self._id) then
    return false
  else
    if (self._delegate):IsRoleLock(self._id) then
      return true
    else
      return false
    end
  end
end

FragmentTeamCell.OnCellClicked = function(self)
  -- function num : 0_6
  if self._index ~= -1 then
    (self._delegate):OnCharCellClick(self._id, self._index)
  else
    ;
    (self._delegate):OnCharCellClick(self._id)
  end
end

FragmentTeamCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if eventName == "select" and arg.id == self._id then
    (self._select):SetActive(true)
    ;
    ((self._selectText)[arg.index]):SetActive(true)
    self._index = arg.index
  end
  -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

  if eventName == "unselect" and arg.id == self._id then
    (self._select):SetActive(false)
    for i,v in ipairs(self._selectText) do
      v:SetActive(false)
    end
    self._index = -1
  end
  if eventName == "unselectAll" then
    (self._select):SetActive(false)
    for i,v in ipairs(self._selectText) do
      v:SetActive(false)
    end
    self._index = -1
  end
end

return FragmentTeamCell

