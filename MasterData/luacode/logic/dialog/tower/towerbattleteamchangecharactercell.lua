local TowerBattleTeamChangeCharacterCell = class("TowerBattleTeamChangeCharacterCell", Dialog)
TowerBattleTeamChangeCharacterCell.AssetBundleName = "ui/layouts.mainline"
TowerBattleTeamChangeCharacterCell.AssetName = "TowerTeamChangeCell"

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function TowerBattleTeamChangeCharacterCell:Ctor(...)
  TowerBattleTeamChangeCharacterCell.super.Ctor(self, ...)
  self._sameTag = false
  self._groupName = "Cell"
end

function TowerBattleTeamChangeCharacterCell:OnCreate()
  self._cell = self:GetChild("Cell")
  self._back = self:GetChild("Cell/Back")
  self._photo = self:GetChild("Cell/Photo")
  self._grey = self:GetChild("Cell/Grey")
  self._rankFrame = self:GetChild("Cell/Frame")
  self._rank = self:GetChild("Cell/Rank")
  self._job = self:GetChild("Cell/Job")
  self._level = self:GetChild("Cell/Level/Num")
  self._maxLevel = self:GetChild("Cell/Level/MaxNum")
  self._txt = self:GetChild("Cell/Txt")
  self._hurt = self:GetChild("Cell/Hurt")
  self._same = self:GetChild("Cell/Same")
  self._cur = self:GetChild("Cell/Current")
  self._select = self:GetChild("Cell/Select")
  self._hpProgress = self:GetChild("Cell/HpBack/Hp")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._element = self:GetChild("Cell/Element")
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._charUpgrade = {
    panel = self:GetChild("Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
end

function TowerBattleTeamChangeCharacterCell:OnDestroy()
end

function TowerBattleTeamChangeCharacterCell:RefreshCell(data)
  self._role = data
  self._cell:SetActive(true)
  local image = self._role:GetSmallRarityBackRecord()
  self._back:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  self._index = table.keyof(self._delegate._curTeam.roles, self._role:GetRoleId())
  if self._index then
    if self._delegate._curRoleKey == self._role:GetRoleId() then
      self._cur:SetActive(true)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
    else
      self._cur:SetActive(false)
      self._grey:SetActive(true)
      self._txt:SetActive(true)
    end
    self._same:SetActive(false)
    self._sameTag = false
  else
    self._grey:SetActive(false)
    self._txt:SetActive(false)
    self._cur:SetActive(false)
  end
  if self._role:GetRoleId() == self._delegate._curStationInfo.roleKey then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  image = self._role:GetSmallRarityFrameRecord()
  self._rankFrame:SetSprite(image.assetBundle, image.assetName)
  if self._role:GetIsLeader() then
    self._rank:SetActive(false)
  else
    self._rank:SetActive(true)
    image = self._role:GetRarityImageRecord()
    self._rank:SetSprite(image.assetBundle, image.assetName)
  end
  image = self._role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(self._role:GetLevel())
  self._maxLevel:SetText(self._role:GetMaxLevelIgnorePlayerLv())
  if self._role:GetHurtExtent() ~= 0 and not self._index then
    self._hurt:SetActive(true)
    self._same:SetActive(false)
    self._sameTag = false
  else
    self._hurt:SetActive(false)
    if self:IsSameWithTeamRoles() then
      self._grey:SetActive(true)
      self._same:SetActive(true)
      self._sameTag = true
    elseif not self._index then
      self._grey:SetActive(false)
      self._same:SetActive(false)
      self._sameTag = false
    end
  end
  self._hp = NekoData.BehaviorManager.BM_Tower:GetRoleHP(self._role:GetRoleId())
  self._hpProgress:SetFillAmount(self._hp)
  if 0 >= self._hp then
    self._grey:SetActive(true)
  else
    self._grey:SetActive(false)
  end
  ShowCharUpgrade(self, self._role:GetRuneLevel())
end

function TowerBattleTeamChangeCharacterCell:IsSameWithTeamRoles()
  for k, v in pairs(self._delegate._curTeam.roles) do
    if v ~= 0 and self._role:GetRoleId() ~= v then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
      if self._role:GetId() == role:GetId() then
        return true
      end
    end
  end
  for i, v in ipairs(self._delegate._curTeam.roles) do
    if v ~= 0 and self._role:GetRoleId() ~= v then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
      if self._role:GetId() == role:GetId() then
        return true
      end
    end
  end
  return false
end

function TowerBattleTeamChangeCharacterCell:OnCellClicked()
  if self._role:GetRoleId() == self._delegate._curStationInfo.roleKey then
    self._delegate:SetSelectedID("RoleLeave", self._role:GetRoleId())
  else
    if NekoData.BehaviorManager.BM_Tower:GetRoleHP(self._role:GetRoleId()) <= 0 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100142)
      return
    end
    self._delegate:SetSelectedID("RoleAdd", self._role:GetRoleId())
  end
end

function TowerBattleTeamChangeCharacterCell:OnCellLongPress()
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if not dialog and self._role then
    dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    dialog:Refresh(self._role)
  end
end

function TowerBattleTeamChangeCharacterCell:OnEvent(eventName, arg)
  if eventName == "RoleLeave" then
    self._index = table.keyof(self._delegate._curTeam.roles, self._role:GetRoleId())
    if self._index then
      if self._delegate._curRoleKey == self._role:GetRoleId() then
        self._cur:SetActive(true)
        self._grey:SetActive(false)
        self._txt:SetActive(false)
      else
        self._cur:SetActive(false)
        self._grey:SetActive(true)
        self._txt:SetActive(true)
      end
      self._same:SetActive(false)
      self._sameTag = false
    else
      self._cur:SetActive(false)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
    end
    if self._role:GetHurtExtent() ~= 0 and not self._index then
      self._hurt:SetActive(true)
      self._same:SetActive(false)
      self._sameTag = false
    else
      self._hurt:SetActive(false)
      if self:IsSameWithTeamRoles() then
        self._grey:SetActive(true)
        self._same:SetActive(true)
        self._sameTag = true
      elseif not self._index then
        self._grey:SetActive(false)
        self._same:SetActive(false)
        self._sameTag = false
      end
    end
    if 0 >= self._hp then
      self._grey:SetActive(true)
    else
      self._grey:SetActive(false)
    end
  end
  if eventName == "RoleAdd" then
    self._index = table.keyof(self._delegate._curTeam.roles, self._role:GetRoleId())
    if self._index then
      if self._delegate._curRoleKey == self._role:GetRoleId() then
        self._cur:SetActive(true)
        self._grey:SetActive(false)
        self._txt:SetActive(false)
      else
        self._cur:SetActive(false)
        self._grey:SetActive(true)
        self._txt:SetActive(true)
      end
      self._same:SetActive(false)
      self._sameTag = false
    else
      self._cur:SetActive(false)
      self._grey:SetActive(false)
      self._txt:SetActive(false)
    end
    if self._role:GetHurtExtent() ~= 0 and not self._index then
      self._hurt:SetActive(true)
      self._same:SetActive(false)
      self._sameTag = false
    else
      self._hurt:SetActive(false)
      if self:IsSameWithTeamRoles() then
        self._grey:SetActive(true)
        self._same:SetActive(true)
        self._sameTag = true
      elseif not self._index then
        self._grey:SetActive(false)
        self._same:SetActive(false)
        self._sameTag = false
      end
    end
    if 0 >= self._hp then
      self._grey:SetActive(true)
    else
      self._grey:SetActive(false)
    end
  end
  if self._role:GetRoleId() == self._delegate._curStationInfo.roleKey then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
end

return TowerBattleTeamChangeCharacterCell
