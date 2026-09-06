local MaxChooseNum = 4
local ChangeSupportRoleCell = class("ChangeSupportRoleCell", Dialog)
ChangeSupportRoleCell.AssetBundleName = "ui/layouts.friends"
ChangeSupportRoleCell.AssetName = "ChangeShowCell"

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function ChangeSupportRoleCell:Ctor(...)
  ChangeSupportRoleCell.super.Ctor(self, ...)
end

function ChangeSupportRoleCell:OnCreate()
  self._back = self:GetChild("Cell/Back")
  self._photo = self:GetChild("Cell/Photo")
  self._grey = self:GetChild("Cell/Grey")
  self._frame = self:GetChild("Cell/Frame")
  self._rank = self:GetChild("Cell/Rank")
  self._job = self:GetChild("Cell/Job")
  self._level = self:GetChild("Cell/Level/Num")
  self._maxLevel = self:GetChild("Cell/Level/MaxNum")
  self._breakLevelBack = self:GetChild("Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Cell/BreakLevelNum")
  self._teamTxt = self:GetChild("Cell/Txt")
  self._lockTag = self:GetChild("Cell/SkillLock")
  self._downRankBack = self:GetChild("Cell/DownRankBack")
  self._element = self:GetChild("Cell/Element")
  self._select = self:GetChild("Cell/Select")
  self._charUpgrade = {
    panel = self:GetChild("Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ChangeSupportRoleCell:OnDestroy()
end

function ChangeSupportRoleCell:RefreshCell(data)
  self._role = nil
  if table.nums(data) == 2 then
    self._role = data.role
    self._grey:SetActive(false)
    self._teamTxt:SetActive(false)
    self._lockTag:SetActive(false)
  elseif self._delegate._dialogName == "assistbattle.changesupportroledialog" then
    self._role = data
    if self._delegate._selectedRole and self._role:GetRoleId() == self._delegate._selectedRole:GetRoleId() then
      self._grey:SetActive(true)
      self._teamTxt:SetActive(true)
    else
      self._grey:SetActive(false)
      self._teamTxt:SetActive(false)
    end
    if not self._role:GetShowSkillData()[2].unlock then
      self._lockTag:SetActive(true)
      self._grey:SetActive(true)
    else
      self._lockTag:SetActive(false)
    end
  elseif self._delegate._dialogName == "assistbattle.changedisplayrolesdialog" then
    self._role = data
    if self._delegate:IsInSelectedRoleList(self._role:GetRoleId()) then
      self._grey:SetActive(true)
      self._teamTxt:SetActive(true)
    else
      self._grey:SetActive(false)
      self._teamTxt:SetActive(false)
    end
    self._lockTag:SetActive(false)
  end
  local ImageRecord = self._role:GetSmallRarityBackRecord()
  self._back:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ImageRecord = self._role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ImageRecord = self._role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  if self._role:GetIsLeader() then
    self._rank:SetActive(false)
  else
    self._rank:SetActive(true)
    ImageRecord = self._role:GetRarityImageRecord()
    self._rank:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  end
  ImageRecord = self._role:GetVocationImageRecord()
  self._job:SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  self._level:SetText(self._role:GetShowLv())
  self._maxLevel:SetText(self._role:GetShowMaxBreakLv())
  local imageRecord = self._role:GetCurBreakFrame1ImageRecord()
  self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._breakLevel:SetText(self._role:GetBreakLv())
  imageRecord = self._role:GetElementImageRecord()
  self._element:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ShowCharUpgrade(self, self._role:GetRuneLevel())
end

function ChangeSupportRoleCell:OnCellLongPress()
  if self._role then
    local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    if not dialog then
      dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
      dialog:Refresh(self._role)
    end
  end
end

function ChangeSupportRoleCell:OnCellClicked()
  if self._delegate._lock then
    local croleLock = LuaNetManager.CreateProtocol("protocol.login.crolelock")
    if croleLock then
      croleLock.roleId = self._cellData:GetRoleId()
      croleLock:Send()
    end
  elseif self._delegate._dialogName == "assistbattle.changesupportroledialog" then
    if self._role:GetShowSkillData()[2].unlock then
      self._delegate:SetSelectedRole(self._role:GetRoleId())
    end
  elseif self._delegate._dialogName == "assistbattle.changedisplayrolesdialog" and (#self._delegate._selectedRoleList < MaxChooseNum or self._delegate:IsInSelectedRoleList(self._role:GetRoleId())) then
    self._delegate:SetSelectedRoles(self._role:GetRoleId())
  end
end

function ChangeSupportRoleCell:OnEvent(eventName, arg)
  if eventName == "SetRoleSelectedState" then
    if arg == self._cellData:GetRoleId() then
      self._grey:SetActive(true)
      self._teamTxt:SetActive(true)
    else
      self._grey:SetActive(false)
      self._teamTxt:SetActive(false)
    end
    if not self._cellData:GetShowSkillData()[2].unlock then
      self._lockTag:SetActive(true)
      self._grey:SetActive(true)
    else
      self._lockTag:SetActive(false)
    end
  elseif eventName == "SetRolesSelectedState" then
    if self._delegate:IsInSelectedRoleList(self._cellData:GetRoleId()) then
      self._grey:SetActive(true)
      self._teamTxt:SetActive(true)
    else
      self._grey:SetActive(false)
      self._teamTxt:SetActive(false)
    end
    self._lockTag:SetActive(false)
  elseif eventName == "UniqueEquipLevelUp" and self._role and arg == self._role:GetRoleId() then
    self:RefreshCell(self._cellData)
  end
end

return ChangeSupportRoleCell
