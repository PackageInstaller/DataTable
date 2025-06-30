-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2teamchangecharactercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2TeamChangeCharacterCell = class("TowerV2TeamChangeCharacterCell", Dialog)
TowerV2TeamChangeCharacterCell.AssetBundleName = "ui/layouts.mainline"
TowerV2TeamChangeCharacterCell.AssetName = "TowerTeamChangeCell"
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerV2TeamChangeCharacterCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : TowerV2TeamChangeCharacterCell
  ((TowerV2TeamChangeCharacterCell.super).Ctor)(self, ...)
  self._sameTag = false
  self._groupName = "Cell"
end

TowerV2TeamChangeCharacterCell.OnCreate = function(self)
  -- function num : 0_2
  self._cell = self:GetChild("Cell")
  self._back = self:GetChild("Cell/Back")
  self._photo = self:GetChild("Cell/Photo")
  self._grey = self:GetChild("Cell/Grey")
  self._rankFrame = self:GetChild("Cell/Frame")
  self._rank = self:GetChild("Cell/Rank")
  self._job = self:GetChild("Cell/Job")
  self._level = self:GetChild("Cell/Level/Num")
  self._maxLevel = self:GetChild("Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self._txt = self:GetChild("Cell/Txt")
  self._hurt = self:GetChild("Cell/Hurt")
  self._same = self:GetChild("Cell/Same")
  self._cur = self:GetChild("Cell/Current")
  self._sub = self:GetChild("Cell/Sub")
  self._select = self:GetChild("Cell/Select")
  self._hpProgress = self:GetChild("Cell/HpBack/Hp")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._element = self:GetChild("Cell/Element")
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._charUpgrade = {panel = self:GetChild("Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
end

TowerV2TeamChangeCharacterCell.OnDestroy = function(self)
  -- function num : 0_3
end

TowerV2TeamChangeCharacterCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, ShowCharUpgrade
  self._role = data
  ;
  (self._cell):SetActive(true)
  local image = (self._role):GetSmallRarityBackRecord()
  ;
  (self._back):SetSprite(image.assetBundle, image.assetName)
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
    else
      ;
      (self._cur):SetActive(false)
      ;
      (self._grey):SetActive(true)
      local alter = (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id)
      ;
      (self._txt):SetActive(not alter)
      ;
      (self._sub):SetActive(alter)
    end
    do
      ;
      (self._same):SetActive(false)
      self._sameTag = false
      ;
      (self._grey):SetActive(false)
      ;
      (self._txt):SetActive(false)
      ;
      (self._cur):SetActive(false)
      ;
      (self._sub):SetActive(false)
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
        (self._rank):SetActive(false)
      else
        ;
        (self._rank):SetActive(true)
        image = (self._role):GetRarityImageRecord()
        ;
        (self._rank):SetSprite(image.assetBundle, image.assetName)
      end
      image = (self._role):GetVocationImageRecord()
      ;
      (self._job):SetSprite(image.assetBundle, image.assetName)
      image = (self._role):GetElementImageRecord()
      ;
      (self._element):SetSprite(image.assetBundle, image.assetName)
      image = (self._role):GetRarityBottomBackRecord()
      ;
      (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._level):SetText((self._role):GetShowLv())
      ;
      (self._maxLevel):SetText((self._role):GetShowMaxBreakLv())
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
        ;
        (self._hpProgress):SetActive(false)
        if (self._role):GetHurtExtent() ~= 0 and not self._index then
          (self._hurt):SetActive(true)
          ;
          (self._same):SetActive(false)
          self._sameTag = false
        else
          (self._hurt):SetActive(false)
          if self:IsSameWithTeamRoles() then
            (self._same):SetActive(true)
            self._sameTag = true
          elseif not self._index then
            (self._same):SetActive(false)
            self._sameTag = false
          end
        end
        ShowCharUpgrade(self, (self._role):GetRuneLevel())
        -- DECOMPILER ERROR: 7 unprocessed JMP targets
      end
    end
  end
end

TowerV2TeamChangeCharacterCell.IsSameWithTeamRoles = function(self)
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

TowerV2TeamChangeCharacterCell.OnCellClicked = function(self)
  -- function num : 0_6
  if (self._role):GetRoleId() == ((self._delegate)._curStationInfo).roleKey then
    (self._delegate):SetSelectedID("RoleLeave", (self._role):GetRoleId())
  else
    ;
    (self._delegate):SetSelectedID("RoleAdd", (self._role):GetRoleId())
  end
end

TowerV2TeamChangeCharacterCell.OnCellLongPress = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if not dialog and self._role then
    dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    dialog:Refresh(self._role)
  end
end

TowerV2TeamChangeCharacterCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_8 , upvalues : _ENV
  if eventName == "RoleLeave" then
    self._index = (table.keyof)(((self._delegate)._curTeam).roles, (self._role):GetRoleId())
    if self._index then
      if (self._delegate)._curRoleKey == (self._role):GetRoleId() then
        (self._cur):SetActive(true)
        ;
        (self._txt):SetActive(false)
        ;
        (self._sub):SetActive(false)
      else
        ;
        (self._cur):SetActive(false)
        local alter = (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id)
        ;
        (self._txt):SetActive(not alter)
        ;
        (self._sub):SetActive(alter)
      end
      do
        ;
        (self._same):SetActive(false)
        self._sameTag = false
        ;
        (self._cur):SetActive(false)
        ;
        (self._txt):SetActive(false)
        ;
        (self._sub):SetActive(false)
        if (self._role):GetHurtExtent() ~= 0 and not self._index then
          (self._hurt):SetActive(true)
          ;
          (self._same):SetActive(false)
          self._sameTag = false
        else
          ;
          (self._hurt):SetActive(false)
          if self:IsSameWithTeamRoles() then
            (self._same):SetActive(true)
            self._sameTag = true
          else
            if not self._index then
              (self._same):SetActive(false)
              self._sameTag = false
            end
          end
        end
        if eventName == "RoleAdd" then
          self._index = (table.keyof)(((self._delegate)._curTeam).roles, (self._role):GetRoleId())
          if self._index then
            if (self._delegate)._curRoleKey == (self._role):GetRoleId() then
              (self._cur):SetActive(true)
              ;
              (self._txt):SetActive(false)
              ;
              (self._sub):SetActive(false)
            else
              ;
              (self._cur):SetActive(false)
              local alter = (self._role):IsInAlternativeTeams(((self._delegate)._curTeam).id)
              ;
              (self._txt):SetActive(not alter)
              ;
              (self._sub):SetActive(alter)
            end
            do
              ;
              (self._same):SetActive(false)
              self._sameTag = false
              ;
              (self._cur):SetActive(false)
              ;
              (self._txt):SetActive(false)
              ;
              (self._sub):SetActive(false)
              if (self._role):GetHurtExtent() ~= 0 and not self._index then
                (self._hurt):SetActive(true)
                ;
                (self._same):SetActive(false)
                self._sameTag = false
              else
                ;
                (self._hurt):SetActive(false)
                if self:IsSameWithTeamRoles() then
                  (self._same):SetActive(true)
                  self._sameTag = true
                else
                  if not self._index then
                    (self._same):SetActive(false)
                    self._sameTag = false
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
            end
          end
        end
      end
    end
  end
end

return TowerV2TeamChangeCharacterCell

