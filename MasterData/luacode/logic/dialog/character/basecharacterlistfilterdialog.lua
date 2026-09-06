local GridFrame = require("framework.ui.frame.grid.gridframe")
local CScreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
local CSkillScreeningConditions = BeanManager.GetTableByName("skill.cskillscreeningconditions")
local BaseCharacterListFilterDialog = class("BaseCharacterListFilterDialog", Dialog)
BaseCharacterListFilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListFilterDialog.AssetName = "BaseCharacterListFliter"

function BaseCharacterListFilterDialog:Ctor(...)
  BaseCharacterListFilterDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._filterRankTable = {}
  self._filterVocationTable = {}
  self._nameIdListRank = {}
  self._nameIdListVocation = {}
  self._type = ""
end

function BaseCharacterListFilterDialog:OnCreate()
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggleBtn = self:GetChild("Back/ToggleGroup")
  self._toggle_0 = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggle_0:SetUserData(0)
  self._toggle_0:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_1 = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._toggle_1:SetUserData(1)
  self._toggle_1:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_0:SetIsOnType(false)
  self._toggle_1:SetIsOnType(false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rankCellFrame = self:GetChild("Back/Frame")
  self._vocationCellFrame = self:GetChild("Back/Frame2")
  self._rankFrame = GridFrame.Create(self._rankCellFrame, self, true, 4)
  self._rankFrame:SetMargin(15, 0)
  self._vocationFrame = GridFrame.Create(self._vocationCellFrame, self, true, 4)
  self._vocationFrame:SetMargin(15, 0)
end

function BaseCharacterListFilterDialog:OnDestroy()
  self._rankFrame:Destroy()
  self._vocationFrame:Destroy()
end

function BaseCharacterListFilterDialog:SetScreenedListDialog(dialog, type)
  self._type = type
  self:LoadFilterData()
  self:LoadVocationData()
  self._screenedListDialog = dialog
end

function BaseCharacterListFilterDialog:LoadVocationData()
  local filterTable = {}
  if self._type == "filter" then
    for _, v in pairs(CScreeningConditions:GetAllIds()) do
      if 10 < v then
        table.insert(filterTable, CScreeningConditions:GetRecorder(v))
      end
    end
  elseif self._type == "skillfilter" then
    for _, v in pairs(CSkillScreeningConditions:GetAllIds()) do
      if 10 < v then
        table.insert(filterTable, CSkillScreeningConditions:GetRecorder(v))
      end
    end
  end
  table.sort(filterTable, function(a, b)
    return a.sort > b.sort
  end)
  for _, v in pairs(filterTable) do
    table.insert(self._filterVocationTable, v.nameid)
  end
  for _, v in pairs(self._filterVocationTable) do
    table.insert(self._nameIdListVocation, v)
  end
end

function BaseCharacterListFilterDialog:LoadFilterData()
  local filterTable = {}
  if self._type == "filter" then
    for _, v in pairs(CScreeningConditions:GetAllIds()) do
      if v < 10 then
        table.insert(filterTable, CScreeningConditions:GetRecorder(v))
      end
    end
  elseif self._type == "skillfilter" then
    for _, v in pairs(CSkillScreeningConditions:GetAllIds()) do
      if v < 10 then
        table.insert(filterTable, CSkillScreeningConditions:GetRecorder(v))
      end
    end
  end
  table.sort(filterTable, function(a, b)
    return a.sort > b.sort
  end)
  for _, v in pairs(filterTable) do
    table.insert(self._filterRankTable, v.nameid)
  end
  for _, v in pairs(self._filterRankTable) do
    table.insert(self._nameIdListRank, v)
  end
end

function BaseCharacterListFilterDialog:NumberOfCell(frame)
  if frame == self._rankFrame then
    return #self._filterRankTable
  elseif frame == self._vocationFrame then
    return #self._filterVocationTable
  end
end

function BaseCharacterListFilterDialog:CellAtIndex(frame)
  return "character.basecharacterlistsortcell"
end

function BaseCharacterListFilterDialog:DataAtIndex(frame, index)
  if frame == self._rankFrame then
    return self._filterRankTable[index]
  elseif frame == self._vocationFrame then
    return self._filterVocationTable[index]
  end
end

local function ContainValue(valueList, value)
  for _, v in ipairs(valueList) do
    if v == value then
      return true
    end
  end
  return false
end

function BaseCharacterListFilterDialog:OnFilterCellClick(nameId)
  local pos
  if ContainValue(self._filterRankTable, nameId) then
    for i, v in pairs(self._nameIdListRank) do
      if v == nameId then
        pos = i
        break
      end
    end
    if pos then
      table.remove(self._nameIdListRank, pos)
    else
      table.insert(self._nameIdListRank, nameId)
    end
  elseif ContainValue(self._filterVocationTable, nameId) then
    for i, v in pairs(self._nameIdListVocation) do
      if v == nameId then
        pos = i
        break
      end
    end
    if pos then
      table.remove(self._nameIdListVocation, pos)
    else
      table.insert(self._nameIdListVocation, nameId)
    end
  end
  if #self._nameIdListRank == 0 and #self._nameIdListVocation == 0 then
    self._toggle_1:SetIsOnType(true)
    self._toggle_0:SetIsOnType(false)
  elseif #self._nameIdListRank == #self._filterRankTable and #self._nameIdListVocation == #self._filterVocationTable then
    self._toggle_1:SetIsOnType(false)
    self._toggle_0:SetIsOnType(true)
  else
    self._toggle_1:SetIsOnType(false)
    self._toggle_0:SetIsOnType(false)
  end
  self._rankFrame:ReloadAllCell()
  self._vocationFrame:ReloadAllCell()
end

function BaseCharacterListFilterDialog:GetOperateType()
  return self._type
end

function BaseCharacterListFilterDialog:OnValueChanged(args, luawindow)
  if args and luawindow:GetUserData() == 0 then
    self._nameIdListRank = {}
    for _, v in pairs(self._filterRankTable) do
      table.insert(self._nameIdListRank, v)
    end
    self._nameIdListVocation = {}
    for _, v in pairs(self._filterVocationTable) do
      table.insert(self._nameIdListVocation, v)
    end
  elseif args and luawindow:GetUserData() == 1 then
    self._nameIdListRank = {}
    self._nameIdListVocation = {}
  end
  if self._rankFrame then
    self._rankFrame:ReloadAllCell()
  end
  if self._vocationFrame then
    self._vocationFrame:ReloadAllCell()
  end
end

function BaseCharacterListFilterDialog:OnConfirmBtnClick()
  self._screenedListDialog:OnSelectCellClick(nil, self._nameIdListVocation, self._nameIdListRank)
  self:Destroy()
  return true, true
end

function BaseCharacterListFilterDialog:OnBackBtnClicked()
  self:Destroy()
  return true, true
end

function BaseCharacterListFilterDialog:SetStatus(nameIdListRank, nameIdListVocation)
  if nameIdListRank then
    self._nameIdListRank = nameIdListRank
  else
    self._nameIdListRank = {}
    for _, v in pairs(self._filterRankTable) do
      table.insert(self._nameIdListRank, v)
    end
  end
  if nameIdListVocation then
    self._nameIdListVocation = nameIdListVocation
  else
    self._nameIdListVocation = {}
    for _, v in pairs(self._filterVocationTable) do
      table.insert(self._nameIdListVocation, v)
    end
  end
  if #self._nameIdListRank == 0 and #self._nameIdListVocation == 0 then
    self._toggle_1:SetIsOnType(true)
    self._toggle_0:SetIsOnType(false)
  elseif #self._nameIdListRank == #self._filterRankTable and #self._nameIdListVocation == #self._filterVocationTable then
    self._toggle_1:SetIsOnType(false)
    self._toggle_0:SetIsOnType(true)
  else
    self._toggle_1:SetIsOnType(false)
    self._toggle_0:SetIsOnType(false)
  end
  if self._rankFrame then
    self._rankFrame:ReloadAllCell()
  end
  if self._vocationFrame then
    self._vocationFrame:ReloadAllCell()
  end
end

return BaseCharacterListFilterDialog
