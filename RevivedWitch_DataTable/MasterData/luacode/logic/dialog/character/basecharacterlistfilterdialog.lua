-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistfilterdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CScreeningConditions = (BeanManager.GetTableByName)("role.cscreeningconditions")
local CSkillScreeningConditions = (BeanManager.GetTableByName)("skill.cskillscreeningconditions")
local BaseCharacterListFilterDialog = class("BaseCharacterListFilterDialog", Dialog)
BaseCharacterListFilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListFilterDialog.AssetName = "BaseCharacterListFliter"
BaseCharacterListFilterDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListFilterDialog
  ((BaseCharacterListFilterDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._filterRankTable = {}
  self._filterVocationTable = {}
  self._nameIdListRank = {}
  self._nameIdListVocation = {}
  self._type = ""
end

BaseCharacterListFilterDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggleBtn = self:GetChild("Back/ToggleGroup")
  self._toggle_0 = self:GetChild("Back/ToggleGroup/_Toggle_0")
  ;
  (self._toggle_0):SetUserData(0)
  ;
  (self._toggle_0):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_1 = self:GetChild("Back/ToggleGroup/_Toggle_1")
  ;
  (self._toggle_1):SetUserData(1)
  ;
  (self._toggle_1):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  ;
  (self._toggle_0):SetIsOnType(false)
  ;
  (self._toggle_1):SetIsOnType(false)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rankCellFrame = self:GetChild("Back/Frame")
  self._vocationCellFrame = self:GetChild("Back/Frame2")
  self._rankFrame = (GridFrame.Create)(self._rankCellFrame, self, true, 4)
  ;
  (self._rankFrame):SetMargin(15, 0)
  self._vocationFrame = (GridFrame.Create)(self._vocationCellFrame, self, true, 4)
  ;
  (self._vocationFrame):SetMargin(15, 0)
end

BaseCharacterListFilterDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._rankFrame):Destroy()
  ;
  (self._vocationFrame):Destroy()
end

BaseCharacterListFilterDialog.SetScreenedListDialog = function(self, dialog, type)
  -- function num : 0_3
  self._type = type
  self:LoadFilterData()
  self:LoadVocationData()
  self._screenedListDialog = dialog
end

BaseCharacterListFilterDialog.LoadVocationData = function(self)
  -- function num : 0_4 , upvalues : _ENV, CScreeningConditions, CSkillScreeningConditions
  local filterTable = {}
  if self._type == "filter" then
    for _,v in pairs(CScreeningConditions:GetAllIds()) do
      if v > 10 then
        (table.insert)(filterTable, CScreeningConditions:GetRecorder(v))
      end
    end
  else
    do
      if self._type == "skillfilter" then
        for _,v in pairs(CSkillScreeningConditions:GetAllIds()) do
          if v > 10 then
            (table.insert)(filterTable, CSkillScreeningConditions:GetRecorder(v))
          end
        end
      end
      do
        ;
        (table.sort)(filterTable, function(a, b)
    -- function num : 0_4_0
    do return b.sort < a.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for _,v in pairs(filterTable) do
          (table.insert)(self._filterVocationTable, v.nameid)
        end
        for _,v in pairs(self._filterVocationTable) do
          (table.insert)(self._nameIdListVocation, v)
        end
      end
    end
  end
end

BaseCharacterListFilterDialog.LoadFilterData = function(self)
  -- function num : 0_5 , upvalues : _ENV, CScreeningConditions, CSkillScreeningConditions
  local filterTable = {}
  if self._type == "filter" then
    for _,v in pairs(CScreeningConditions:GetAllIds()) do
      if v < 10 then
        (table.insert)(filterTable, CScreeningConditions:GetRecorder(v))
      end
    end
  else
    do
      if self._type == "skillfilter" then
        for _,v in pairs(CSkillScreeningConditions:GetAllIds()) do
          if v < 10 then
            (table.insert)(filterTable, CSkillScreeningConditions:GetRecorder(v))
          end
        end
      end
      do
        ;
        (table.sort)(filterTable, function(a, b)
    -- function num : 0_5_0
    do return b.sort < a.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for _,v in pairs(filterTable) do
          (table.insert)(self._filterRankTable, v.nameid)
        end
        for _,v in pairs(self._filterRankTable) do
          (table.insert)(self._nameIdListRank, v)
        end
      end
    end
  end
end

BaseCharacterListFilterDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._rankFrame then
    return #self._filterRankTable
  else
    if frame == self._vocationFrame then
      return #self._filterVocationTable
    end
  end
end

BaseCharacterListFilterDialog.CellAtIndex = function(self, frame)
  -- function num : 0_7
  return "character.basecharacterlistsortcell"
end

BaseCharacterListFilterDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._rankFrame then
    return (self._filterRankTable)[index]
  else
    if frame == self._vocationFrame then
      return (self._filterVocationTable)[index]
    end
  end
end

local ContainValue = function(valueList, value)
  -- function num : 0_9 , upvalues : _ENV
  for _,v in ipairs(valueList) do
    if v == value then
      return true
    end
  end
  return false
end

BaseCharacterListFilterDialog.OnFilterCellClick = function(self, nameId)
  -- function num : 0_10 , upvalues : ContainValue, _ENV
  local pos = nil
  if ContainValue(self._filterRankTable, nameId) then
    for i,v in pairs(self._nameIdListRank) do
      if v == nameId then
        pos = i
        break
      end
    end
    do
      if pos then
        (table.remove)(self._nameIdListRank, pos)
      else
        ;
        (table.insert)(self._nameIdListRank, nameId)
      end
      if ContainValue(self._filterVocationTable, nameId) then
        for i,v in pairs(self._nameIdListVocation) do
          if v == nameId then
            pos = i
            break
          end
        end
        do
          if pos then
            (table.remove)(self._nameIdListVocation, pos)
          else
            ;
            (table.insert)(self._nameIdListVocation, nameId)
          end
          if #self._nameIdListRank == 0 and #self._nameIdListVocation == 0 then
            (self._toggle_1):SetIsOnType(true)
            ;
            (self._toggle_0):SetIsOnType(false)
          else
            if #self._nameIdListRank == #self._filterRankTable and #self._nameIdListVocation == #self._filterVocationTable then
              (self._toggle_1):SetIsOnType(false)
              ;
              (self._toggle_0):SetIsOnType(true)
            else
              ;
              (self._toggle_1):SetIsOnType(false)
              ;
              (self._toggle_0):SetIsOnType(false)
            end
          end
          ;
          (self._rankFrame):ReloadAllCell()
          ;
          (self._vocationFrame):ReloadAllCell()
        end
      end
    end
  end
end

BaseCharacterListFilterDialog.GetOperateType = function(self)
  -- function num : 0_11
  return self._type
end

BaseCharacterListFilterDialog.OnValueChanged = function(self, args, luawindow)
  -- function num : 0_12 , upvalues : _ENV
  if args and luawindow:GetUserData() == 0 then
    self._nameIdListRank = {}
    for _,v in pairs(self._filterRankTable) do
      (table.insert)(self._nameIdListRank, v)
    end
    self._nameIdListVocation = {}
    for _,v in pairs(self._filterVocationTable) do
      (table.insert)(self._nameIdListVocation, v)
    end
  else
    do
      if args and luawindow:GetUserData() == 1 then
        self._nameIdListRank = {}
        self._nameIdListVocation = {}
      end
      if self._rankFrame then
        (self._rankFrame):ReloadAllCell()
      end
      if self._vocationFrame then
        (self._vocationFrame):ReloadAllCell()
      end
    end
  end
end

BaseCharacterListFilterDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_13
  (self._screenedListDialog):OnSelectCellClick(nil, self._nameIdListVocation, self._nameIdListRank)
  self:Destroy()
  return true, true
end

BaseCharacterListFilterDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
  return true, true
end

BaseCharacterListFilterDialog.SetStatus = function(self, nameIdListRank, nameIdListVocation)
  -- function num : 0_15 , upvalues : _ENV
  if nameIdListRank then
    self._nameIdListRank = nameIdListRank
  else
    self._nameIdListRank = {}
    for _,v in pairs(self._filterRankTable) do
      (table.insert)(self._nameIdListRank, v)
    end
  end
  do
    if nameIdListVocation then
      self._nameIdListVocation = nameIdListVocation
    else
      self._nameIdListVocation = {}
      for _,v in pairs(self._filterVocationTable) do
        (table.insert)(self._nameIdListVocation, v)
      end
    end
    do
      if #self._nameIdListRank == 0 and #self._nameIdListVocation == 0 then
        (self._toggle_1):SetIsOnType(true)
        ;
        (self._toggle_0):SetIsOnType(false)
      else
        if #self._nameIdListRank == #self._filterRankTable and #self._nameIdListVocation == #self._filterVocationTable then
          (self._toggle_1):SetIsOnType(false)
          ;
          (self._toggle_0):SetIsOnType(true)
        else
          ;
          (self._toggle_1):SetIsOnType(false)
          ;
          (self._toggle_0):SetIsOnType(false)
        end
      end
      if self._rankFrame then
        (self._rankFrame):ReloadAllCell()
      end
      if self._vocationFrame then
        (self._vocationFrame):ReloadAllCell()
      end
    end
  end
end

return BaseCharacterListFilterDialog

