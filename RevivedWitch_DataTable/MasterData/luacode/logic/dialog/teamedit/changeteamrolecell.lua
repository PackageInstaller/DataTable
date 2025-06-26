-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/changeteamrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChangeTeamRoleCell = class("ChangeTeamRoleCell", Dialog)
ChangeTeamRoleCell.AssetBundleName = "ui/layouts.teamedit"
ChangeTeamRoleCell.AssetName = "TeamEditChangeNewCell"
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ChangeTeamRoleCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ChangeTeamRoleCell
  ((ChangeTeamRoleCell.super).Ctor)(self, ...)
  self._sameTag = false
end

ChangeTeamRoleCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
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
  self._charUpgrade = {panel = self:GetChild("Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
  self._isJobLimit = false
  if not ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(10) then
    (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  end
end

ChangeTeamRoleCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChangeTeamRoleCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, ShowCharUpgrade
  if type(data) == "table" then
    self._role = data
    ;
    (self._cell):SetActive(true)
    ;
    (self._grey):SetActive(false)
    ;
    (self._txt):SetActive(false)
    ;
    (self._sub):SetActive(false)
    ;
    (self._cur):SetActive(false)
    local image = (self._role):GetSmallRarityBackRecord()
    image = (self._role):GetShapeLittleHeadImageRecord()
    ;
    (self._photo):SetSprite(image.assetBundle, image.assetName)
    self._index = (table.keyof)(((self._delegate)._curTeam).roles, (self._role):GetRoleId())
    if self._index then
      if (self._delegate)._curRoleKey == (self._role):GetRoleId() then
        (self._cur):SetActive(true)
        ;
        (self._grey):SetActive(false)
        ;
        (self._txt):SetActive(false)
        ;
        (self._sub):SetActive(false)
      else
        ;
        (self._cur):SetActive(false)
        if ((self._delegate)._curTeam).id and (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id) then
          (self._txt):SetActive(false)
          ;
          (self._sub):SetActive(true)
        else
          ;
          (self._grey):SetActive(true)
          ;
          (self._txt):SetActive(true)
          ;
          (self._sub):SetActive(false)
        end
      end
      self._sameTag = false
    else
      ;
      (self._grey):SetActive(false)
      ;
      (self._txt):SetActive(false)
      ;
      (self._sub):SetActive(false)
      ;
      (self._cur):SetActive(false)
    end
    if (self._role):GetRoleId() == ((self._delegate)._curStationInfo).roleKey then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
    image = (self._role):GetSmallRarityFrameRecord()
    ;
    (self._rankFrame):SetSprite(image.assetBundle, image.assetName)
    if (self._role):GetIsLeader() then
      (self._rankBack):SetActive(false)
      ;
      (self._rank):SetActive(false)
    else
      ;
      (self._rankBack):SetActive(true)
      ;
      (self._rank):SetActive(true)
      image = (self._role):GetRarityImageRecord()
      ;
      (self._rank):SetSprite(image.assetBundle, image.assetName)
    end
    image = (self._role):GetVocationImageRecord()
    ;
    (self._job):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._level):SetText((self._role):GetShowLv())
    ;
    (self._maxLevel):SetText((self._role):GetShowMaxBreakLv())
    image = (self._role):GetElementImageRecord()
    ;
    (self._elementImg):SetSprite(image.assetBundle, image.assetName)
    image = (self._role):GetRarityBottomBackRecord()
    ;
    (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
    local breakLv = (self._role):GetBreakLv()
    ;
    (self._breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._breakLevel):SetActive(breakLv > 0)
    do
      if breakLv > 0 then
        local imageRecord = (self._role):GetCurBreakFrame1ImageRecord()
        ;
        (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._breakLevel):SetText(breakLv)
      end
      if (self._role):GetHurtExtent() ~= 0 and not self._index then
        self._sameTag = false
      elseif self:IsSameWithTeamRoles() then
        (self._grey):SetActive(true)
        self._sameTag = true
      elseif not self._index then
        (self._grey):SetActive(false)
        self._sameTag = false
      end
      self._isJobLimit = not ((NekoData.BehaviorManager).BM_Vocation):GetVocationIsSupport(self._role, (self._delegate)._supportVocationTable)
      if self._isJobLimit and (self._delegate)._curRoleKey ~= (self._role):GetRoleId() then
        (self._jobLimit):SetActive(true)
        ;
        (self._grey):SetActive(true)
        ;
        (self._sub):SetActive(false)
        ;
        (self._txt):SetActive(false)
      else
        (self._jobLimit):SetActive(false)
      end
      do
        local value = (self._role):IsBoost()
        if not value then
          (self._starMirageUpPanel):SetActive(false)
        else
          (self._starMirageUpPanel):SetActive(true)
          ;
          (self._starMirageUpPanel_txt):SetText(value.changeTeamRoleCellStr)
        end
        ShowCharUpgrade(self, (self._role):GetRuneLevel())
        -- DECOMPILER ERROR: 12 unprocessed JMP targets
      end
    end
  end
end

ChangeTeamRoleCell.IsSameWithTeamRoles = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(((self._delegate)._curTeam).roles) do
    if v ~= 0 and (self._role):GetRoleId() ~= v then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
      if (self._role):GetId() == role:GetId() then
        return true
      end
    end
  end
  for i,v in ipairs(((self._delegate)._curTeam).roles) do
    if v ~= 0 and (self._role):GetRoleId() ~= v then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
      if (self._role):GetId() == role:GetId() then
        return true
      end
    end
  end
  return false
end

ChangeTeamRoleCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._isJobLimit and (self._role):GetRoleId() ~= ((self._delegate)._curStationInfo).roleKey then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100227)
    return 
  end
  if (self._role):GetRoleId() == ((self._delegate)._curStationInfo).roleKey then
    (self._delegate):SetSelectedID("RoleLeave", (self._role):GetRoleId())
  else
    ;
    (self._delegate):SetSelectedID("RoleAdd", (self._role):GetRoleId())
  end
end

ChangeTeamRoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "RoleLeave" then
    self._index = (table.keyof)(((self._delegate)._curTeam).roles, (self._role):GetRoleId())
    if self._index then
      if (self._delegate)._curRoleKey == (self._role):GetRoleId() then
        (self._cur):SetActive(true)
        ;
        (self._grey):SetActive(false)
        ;
        (self._txt):SetActive(false)
        ;
        (self._sub):SetActive(false)
      else
        ;
        (self._cur):SetActive(false)
        if ((self._delegate)._curTeam).id and (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id) then
          (self._txt):SetActive(false)
          ;
          (self._sub):SetActive(true)
        else
          ;
          (self._grey):SetActive(true)
          ;
          (self._txt):SetActive(true)
          ;
          (self._sub):SetActive(false)
        end
      end
      self._sameTag = false
    else
      ;
      (self._cur):SetActive(false)
      ;
      (self._grey):SetActive(false)
      ;
      (self._txt):SetActive(false)
      ;
      (self._sub):SetActive(false)
    end
    if (self._role):GetHurtExtent() ~= 0 and not self._index then
      self._sameTag = false
    else
      if self:IsSameWithTeamRoles() then
        (self._grey):SetActive(true)
        self._sameTag = true
      else
        if not self._index then
          (self._grey):SetActive(false)
          self._sameTag = false
        end
      end
    end
  end
  if eventName == "RoleAdd" then
    self._index = (table.keyof)(((self._delegate)._curTeam).roles, (self._role):GetRoleId())
    if self._index then
      if (self._delegate)._curRoleKey == (self._role):GetRoleId() then
        (self._cur):SetActive(true)
        ;
        (self._grey):SetActive(false)
        ;
        (self._txt):SetActive(false)
        ;
        (self._sub):SetActive(false)
      else
        ;
        (self._cur):SetActive(false)
        if ((self._delegate)._curTeam).id and (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id) then
          (self._txt):SetActive(false)
          ;
          (self._sub):SetActive(true)
        else
          ;
          (self._grey):SetActive(true)
          ;
          (self._txt):SetActive(true)
          ;
          (self._sub):SetActive(false)
        end
      end
      self._sameTag = false
    else
      ;
      (self._cur):SetActive(false)
      ;
      (self._grey):SetActive(false)
      ;
      (self._txt):SetActive(false)
      ;
      (self._sub):SetActive(false)
    end
    if (self._role):GetHurtExtent() ~= 0 and not self._index then
      self._sameTag = false
    else
      if self:IsSameWithTeamRoles() then
        (self._grey):SetActive(true)
        self._sameTag = true
      else
        if not self._index then
          (self._grey):SetActive(false)
          self._sameTag = false
        end
      end
    end
  end
  if eventName == "UniqueEquipLevelUp" and arg == (self._role):GetRoleId() then
    self:RefreshCell(self._role)
  end
  if (self._role):GetRoleId() == ((self._delegate)._curStationInfo).roleKey then
    (self._select):SetActive(true)
  else
    ;
    (self._select):SetActive(false)
  end
  self._isJobLimit = not ((NekoData.BehaviorManager).BM_Vocation):GetVocationIsSupport(self._role, (self._delegate)._supportVocationTable)
  if self._isJobLimit and (self._delegate)._curRoleKey ~= (self._role):GetRoleId() then
    (self._jobLimit):SetActive(true)
    ;
    (self._grey):SetActive(true)
    ;
    (self._sub):SetActive(false)
    ;
    (self._txt):SetActive(false)
  else
    ;
    (self._jobLimit):SetActive(false)
  end
end

return ChangeTeamRoleCell

