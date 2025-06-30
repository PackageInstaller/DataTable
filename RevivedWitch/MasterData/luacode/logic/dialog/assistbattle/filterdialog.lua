-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/filterdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSkillScreeningConditions = (BeanManager.GetTableByName)("skill.cskillscreeningconditions")
local FilterDialog = class("FilterDialog", Dialog)
FilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterDialog.AssetName = "BaseCharacterListFliter"
FilterDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FilterDialog
  ((FilterDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._rankList = {}
  self._skillTypeList = {}
  self._delegate = nil
  self._selectedList = {
rank = {}
, 
skillType = {}
}
  self._toggle1Tag = false
  self._toggle2Tag = false
end

FilterDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._rankPanel = self:GetChild("Back/Frame")
  self._skillTypePanel = self:GetChild("Back/Frame2")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggles = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      (self._toggles)[i] = self:GetChild("Back/ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._toggles)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
  self._rankFrame = (GridFrame.Create)(self._rankPanel, self, true, 4)
  ;
  (self._rankFrame):SetMargin(15, 0)
  self._skillTypeFrame = (GridFrame.Create)(self._skillTypePanel, self, true, 4)
  ;
  (self._skillTypeFrame):SetMargin(15, 0)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnCancelBtnClick, self)
  self:Init()
end

FilterDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._rankFrame):Destroy()
  ;
  (self._skillTypeFrame):Destroy()
end

FilterDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CSkillScreeningConditions
  for _,v in pairs(CSkillScreeningConditions:GetAllIds()) do
    local record = CSkillScreeningConditions:GetRecorder(v)
    if v < 10 then
      (table.insert)(self._rankList, record)
    end
    if v > 10 then
      (table.insert)(self._skillTypeList, record)
    end
  end
  ;
  (table.sort)(self._rankList, function(a, b)
    -- function num : 0_3_0
    do return b.sort < a.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(self._skillTypeList, function(a, b)
    -- function num : 0_3_1
    do return b.sort < a.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

FilterDialog.SetFilterList = function(self, delegate, filterList)
  -- function num : 0_4 , upvalues : _ENV
  self._delegate = delegate
  for k,v in pairs(filterList.rank) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

    ((self._selectedList).rank)[k] = v
  end
  for k,v in pairs(filterList.skillType) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R8 in 'UnsetPending'

    ((self._selectedList).skillType)[k] = v
  end
  self:ChangeTogglesState()
  ;
  (self._rankFrame):ReloadAllCell()
  ;
  (self._skillTypeFrame):ReloadAllCell()
end

FilterDialog.SetSelectedList = function(self, data)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if data.id < 10 then
    if ((self._selectedList).rank)[data.nameid] then
      ((self._selectedList).rank)[data.nameid] = nil
    else
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._selectedList).rank)[data.nameid] = true
    end
    ;
    (self._rankFrame):FireEvent("ChangeSelectNameId")
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    if data.id > 10 then
      if ((self._selectedList).skillType)[data.nameid] then
        ((self._selectedList).skillType)[data.nameid] = nil
      else
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self._selectedList).skillType)[data.nameid] = true
      end
      ;
      (self._skillTypeFrame):FireEvent("ChangeSelectNameId")
    end
  end
  self:ChangeTogglesState()
end

FilterDialog.IsInSelectedList = function(self, data)
  -- function num : 0_6
  if data.id < 10 then
    return ((self._selectedList).rank)[data.nameid]
  else
    if data.id > 10 then
      return ((self._selectedList).skillType)[data.nameid]
    end
  end
end

FilterDialog.ChangeTogglesState = function(self)
  -- function num : 0_7 , upvalues : _ENV, CSkillScreeningConditions
  local count = (table.nums)((self._selectedList).rank) + (table.nums)((self._selectedList).skillType)
  if count == #CSkillScreeningConditions:GetAllIds() then
    if not ((self._toggles)[1]):GetIsOnType() then
      self._toggle1Tag = true
      ;
      ((self._toggles)[1]):SetIsOnType(true)
    end
    ;
    ((self._toggles)[1]):SetInteractable(false)
    if ((self._toggles)[2]):GetIsOnType() then
      self._toggle2Tag = false
      ;
      ((self._toggles)[2]):SetIsOnType(false)
    end
    ;
    ((self._toggles)[2]):SetInteractable(true)
  else
    if count == 0 then
      if ((self._toggles)[1]):GetIsOnType() then
        self._toggle1Tag = false
        ;
        ((self._toggles)[1]):SetIsOnType(false)
      end
      ;
      ((self._toggles)[1]):SetInteractable(true)
      if not ((self._toggles)[2]):GetIsOnType() then
        self._toggle2Tag = true
        ;
        ((self._toggles)[2]):SetIsOnType(true)
      end
      ;
      ((self._toggles)[2]):SetInteractable(false)
    else
      if ((self._toggles)[1]):GetIsOnType() then
        self._toggle1Tag = false
        ;
        ((self._toggles)[1]):SetIsOnType(false)
      end
      ;
      ((self._toggles)[1]):SetInteractable(true)
      if ((self._toggles)[2]):GetIsOnType() then
        self._toggle2Tag = false
        ;
        ((self._toggles)[2]):SetIsOnType(false)
      end
      ;
      ((self._toggles)[2]):SetInteractable(true)
    end
  end
end

FilterDialog.OnValueChanged = function(self, id)
  -- function num : 0_8 , upvalues : _ENV, CSkillScreeningConditions
  if id == 1 and not self._toggle1Tag and ((self._toggles)[1]):GetIsOnType() then
    for k,v in pairs((self._selectedList).rank) do
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      ((self._selectedList).rank)[k] = nil
    end
    for k,v in pairs((self._selectedList).skillType) do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

      ((self._selectedList).skillType)[k] = nil
    end
    for k,v in pairs(CSkillScreeningConditions:GetAllIds()) do
      local record = CSkillScreeningConditions:GetRecorder(v)
      if v < 10 then
        (table.insert)(self._rankList, record)
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self._selectedList).rank)[record.nameid] = true
      end
      if v > 10 then
        (table.insert)(self._skillTypeList, record)
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self._selectedList).skillType)[record.nameid] = true
      end
    end
    ;
    ((self._toggles)[1]):SetInteractable(false)
    ;
    ((self._toggles)[2]):SetInteractable(true)
    ;
    (self._rankFrame):FireEvent("ChangeSelectNameId")
    ;
    (self._skillTypeFrame):FireEvent("ChangeSelectNameId")
  end
  if id == 2 and not self._toggle2Tag and ((self._toggles)[2]):GetIsOnType() then
    for k,v in pairs((self._selectedList).rank) do
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

      ((self._selectedList).rank)[k] = nil
    end
    for k,v in pairs((self._selectedList).skillType) do
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R7 in 'UnsetPending'

      ((self._selectedList).skillType)[k] = nil
    end
    ;
    ((self._toggles)[1]):SetInteractable(true)
    ;
    ((self._toggles)[2]):SetInteractable(false)
    ;
    (self._rankFrame):FireEvent("ChangeSelectNameId")
    ;
    (self._skillTypeFrame):FireEvent("ChangeSelectNameId")
  end
end

FilterDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_9
  (self._delegate):SetScreeningConditions(self._selectedList)
  self:Destroy()
end

FilterDialog.OnCancelBtnClick = function(self)
  -- function num : 0_10
  self:Destroy()
end

FilterDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11
  if frame == self._rankFrame then
    return #self._rankList
  else
    if frame == self._skillTypeFrame then
      return #self._skillTypeList
    end
  end
end

FilterDialog.CellAtIndex = function(self, frame)
  -- function num : 0_12
  return "assistbattle.filtersortcell"
end

FilterDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._rankFrame then
    return (self._rankList)[index]
  else
    if frame == self._skillTypeFrame then
      return (self._skillTypeList)[index]
    end
  end
end

return FilterDialog

