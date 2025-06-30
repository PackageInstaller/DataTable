-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipstrengthen/filterdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local FilterDialog = class("FilterDialog", Dialog)
FilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterDialog.AssetName = "BaseCharacterListFliterNew"
FilterDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FilterDialog
  ((FilterDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._list = {}
  self._tag = "Filter"
  self._delegate = nil
  self._conditions = {}
  self._toggle1Tag = false
  self._toggle2Tag = false
  self._cscreeningConditions = nil
  self._target = nil
end

FilterDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggles = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      (self._toggles)[i] = self:GetChild("Back/ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._toggles)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
  self._frame = (TableFrame.Create)(self._framePanel, self, true, true, true)
  ;
  (self._frame):SetMargin(20, 20)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (self:GetRootWindow()):PlayAnimation("SortShow")
end

FilterDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FilterDialog.SetData = function(self, delegate, conditions, target)
  -- function num : 0_3 , upvalues : _ENV
  self._target = target
  self._conditions = conditions
  if not target or target == "Equip" or target == "EquipBook" or target == "EquipChange" then
    self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipscreeningconditions")
  else
    if target == "EquipStrengthenItem" then
      self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipstrengthenitemscreeningconditions")
    else
      if target == "EquipEnchantItem" then
        self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipenchantitemscreeningconditions")
      else
        if target == "Role" then
          self._cscreeningConditions = (BeanManager.GetTableByName)("role.cscreeningconditions")
        else
          if target == "Monster" then
            self._cscreeningConditions = (BeanManager.GetTableByName)("handbook.cmonster_handbookscreeningconditions")
          else
            if target == "SupportRole" then
              self._cscreeningConditions = (BeanManager.GetTableByName)("skill.cskillscreeningconditions")
            end
          end
        end
      end
    end
  end
  self._delegate = delegate
  self._list = {}
  local map = {}
  for k,v in pairs((self._cscreeningConditions):GetAllIds()) do
    local record = (self._cscreeningConditions):GetRecorder(v)
    -- DECOMPILER ERROR at PC91: Unhandled construct in 'MakeBoolean' P1

    if target == "EquipBook" and (v == 5 or v == 6 or v == 7) then
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    end
    -- DECOMPILER ERROR at PC122: Unhandled construct in 'MakeBoolean' P1

    if target == "EquipChange" and (v ~= 5 or v ~= 6 or v ~= 7) then
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    end
    if not map[record.type] then
      map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
    end
    ;
    (table.insert)((map[record.type]).list, record)
  end
  for k,v in pairs(map) do
    (table.sort)(v.list, function(a, b)
    -- function num : 0_3_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (table.insert)(self._list, v)
  end
  ;
  (table.sort)(self._list, function(a, b)
    -- function num : 0_3_1
    do return a.mType < b.mType end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self:ChangeTogglesState()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

FilterDialog.OnValueChanged = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  if id == 1 and not self._toggle1Tag and ((self._toggles)[1]):GetIsOnType() then
    self._toggle1Tag = true
    self._toggle2Tag = false
    for k,v in pairs(self._conditions) do
      while ((self._conditions)[k])[#(self._conditions)[k]] do
        (table.remove)((self._conditions)[k], #(self._conditions)[k])
      end
    end
    for k,v in pairs((self._cscreeningConditions):GetAllIds()) do
      local record = (self._cscreeningConditions):GetRecorder(v)
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

      if not (self._conditions)[record.type] then
        (self._conditions)[record.type] = {}
      end
      ;
      (table.insert)((self._conditions)[record.type], record)
    end
    ;
    ((self._toggles)[1]):SetInteractable(false)
    ;
    ((self._toggles)[2]):SetInteractable(true)
    ;
    (self._frame):FireEvent("ChangeSelectNameId")
  end
  if id == 2 and not self._toggle2Tag and ((self._toggles)[2]):GetIsOnType() then
    self._toggle1Tag = false
    self._toggle2Tag = true
    for k,v in pairs(self._conditions) do
      while ((self._conditions)[k])[#(self._conditions)[k]] do
        (table.remove)((self._conditions)[k], #(self._conditions)[k])
      end
    end
    ;
    ((self._toggles)[1]):SetInteractable(true)
    ;
    ((self._toggles)[2]):SetInteractable(false)
    ;
    (self._frame):FireEvent("ChangeSelectNameId")
  end
end

FilterDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_5
  (self:GetRootWindow()):PlayAnimation("SortHide")
end

FilterDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == "SortHide" then
    self:Destroy()
  end
end

FilterDialog.ChangeTogglesState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self._conditions) do
    count = count + #v
  end
  if count == #(self._cscreeningConditions):GetAllIds() then
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

FilterDialog.SetSelectedNameId = function(self, data)
  -- function num : 0_8 , upvalues : _ENV
  local index = self:IsInFilterConditions(data.type, data.nameid)
  if index then
    (table.remove)((self._conditions)[data.type], index)
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    if not (self._conditions)[data.type] then
      (self._conditions)[data.type] = {}
    end
    ;
    (table.insert)((self._conditions)[data.type], data)
  end
  self:ChangeTogglesState()
  ;
  (self._frame):FireEvent("ChangeSelectNameId")
  ;
  (self._delegate):SetScreeningConditions(self._conditions)
end

FilterDialog.IsInFilterConditions = function(self, type, nameId)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs(self._conditions) do
    if k == type then
      for index,value in ipairs(v) do
        if value.nameid == nameId then
          return index
        end
      end
    end
  end
  return nil
end

FilterDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._list
end

FilterDialog.CellAtIndex = function(self, frame)
  -- function num : 0_11
  return "equipstrengthen.filterframecell"
end

FilterDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._list)[index]
end

FilterDialog.ShouldLengthChange = function(self)
  -- function num : 0_13
  return true
end

return FilterDialog

