-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/changesupportrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaxChooseNum = 4
local ChangeSupportRoleCell = class("ChangeSupportRoleCell", Dialog)
ChangeSupportRoleCell.AssetBundleName = "ui/layouts.friends"
ChangeSupportRoleCell.AssetName = "ChangeShowCell"
local ShowCharUpgrade = function(self, level)
  -- function num : 0_0
  ((self._charUpgrade).panel):SetActive(level ~= 0)
  for i = 1, 5 do
    (((self._charUpgrade).levelImage)[i]):SetActive(level == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ChangeSupportRoleCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ChangeSupportRoleCell
  ((ChangeSupportRoleCell.super).Ctor)(self, ...)
end

ChangeSupportRoleCell.OnCreate = function(self)
  -- function num : 0_2
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
  self._charUpgrade = {panel = self:GetChild("Cell/CharUpgrade"), 
levelImage = {}
}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

    ((self._charUpgrade).levelImage)[i] = self:GetChild("Cell/CharUpgrade/Img" .. i)
  end
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ChangeSupportRoleCell.OnDestroy = function(self)
  -- function num : 0_3
end

ChangeSupportRoleCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, ShowCharUpgrade
  self._role = nil
  if (table.nums)(data) == 2 then
    self._role = data.role
    ;
    (self._grey):SetActive(false)
    ;
    (self._teamTxt):SetActive(false)
    ;
    (self._lockTag):SetActive(false)
  else
    if (self._delegate)._dialogName == "assistbattle.changesupportroledialog" then
      self._role = data
      if (self._delegate)._selectedRole and (self._role):GetRoleId() == ((self._delegate)._selectedRole):GetRoleId() then
        (self._grey):SetActive(true)
        ;
        (self._teamTxt):SetActive(true)
      else
        ;
        (self._grey):SetActive(false)
        ;
        (self._teamTxt):SetActive(false)
      end
      if not (((self._role):GetShowSkillData())[2]).unlock then
        (self._lockTag):SetActive(true)
        ;
        (self._grey):SetActive(true)
      else
        ;
        (self._lockTag):SetActive(false)
      end
    else
      if (self._delegate)._dialogName == "assistbattle.changedisplayrolesdialog" then
        self._role = data
        if (self._delegate):IsInSelectedRoleList((self._role):GetRoleId()) then
          (self._grey):SetActive(true)
          ;
          (self._teamTxt):SetActive(true)
        else
          ;
          (self._grey):SetActive(false)
          ;
          (self._teamTxt):SetActive(false)
        end
        ;
        (self._lockTag):SetActive(false)
      end
    end
  end
  local ImageRecord = (self._role):GetSmallRarityBackRecord()
  ;
  (self._back):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ImageRecord = (self._role):GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ImageRecord = (self._role):GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  if (self._role):GetIsLeader() then
    (self._rank):SetActive(false)
  else
    ;
    (self._rank):SetActive(true)
    ImageRecord = (self._role):GetRarityImageRecord()
    ;
    (self._rank):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  end
  ImageRecord = (self._role):GetVocationImageRecord()
  ;
  (self._job):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ;
  (self._level):SetText((self._role):GetShowLv())
  ;
  (self._maxLevel):SetText((self._role):GetShowMaxBreakLv())
  local imageRecord = (self._role):GetCurBreakFrame1ImageRecord()
  ;
  (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._breakLevel):SetText((self._role):GetBreakLv())
  imageRecord = (self._role):GetElementImageRecord()
  ;
  (self._element):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._role):GetRarityBottomBackRecord()
  ;
  (self._downRankBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ShowCharUpgrade(self, (self._role):GetRuneLevel())
end

ChangeSupportRoleCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._role then
    local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
      dialog:Refresh(self._role)
    end
  end
end

ChangeSupportRoleCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, MaxChooseNum
  if (self._delegate)._lock then
    local croleLock = (LuaNetManager.CreateProtocol)("protocol.login.crolelock")
    if croleLock then
      croleLock.roleId = (self._cellData):GetRoleId()
      croleLock:Send()
    end
  else
    do
      if (self._delegate)._dialogName == "assistbattle.changesupportroledialog" and (((self._role):GetShowSkillData())[2]).unlock then
        (self._delegate):SetSelectedRole((self._role):GetRoleId())
      end
      if (self._delegate)._dialogName == "assistbattle.changedisplayrolesdialog" and (#(self._delegate)._selectedRoleList < MaxChooseNum or (self._delegate):IsInSelectedRoleList((self._role):GetRoleId())) then
        (self._delegate):SetSelectedRoles((self._role):GetRoleId())
      end
    end
  end
end

ChangeSupportRoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if eventName == "SetRoleSelectedState" then
    if arg == (self._cellData):GetRoleId() then
      (self._grey):SetActive(true)
      ;
      (self._teamTxt):SetActive(true)
    else
      ;
      (self._grey):SetActive(false)
      ;
      (self._teamTxt):SetActive(false)
    end
    if not (((self._cellData):GetShowSkillData())[2]).unlock then
      (self._lockTag):SetActive(true)
      ;
      (self._grey):SetActive(true)
    else
      ;
      (self._lockTag):SetActive(false)
    end
  else
    if eventName == "SetRolesSelectedState" then
      if (self._delegate):IsInSelectedRoleList((self._cellData):GetRoleId()) then
        (self._grey):SetActive(true)
        ;
        (self._teamTxt):SetActive(true)
      else
        ;
        (self._grey):SetActive(false)
        ;
        (self._teamTxt):SetActive(false)
      end
      ;
      (self._lockTag):SetActive(false)
    else
      if eventName == "UniqueEquipLevelUp" and self._role and arg == (self._role):GetRoleId() then
        self:RefreshCell(self._cellData)
      end
    end
  end
end

return ChangeSupportRoleCell

