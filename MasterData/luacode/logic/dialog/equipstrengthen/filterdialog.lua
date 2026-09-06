local TableFrame = require("framework.ui.frame.table.tableframe")
local FilterDialog = class("FilterDialog", Dialog)
FilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterDialog.AssetName = "BaseCharacterListFliterNew"

function FilterDialog:Ctor(...)
  FilterDialog.super.Ctor(self, ...)
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

function FilterDialog:OnCreate()
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggles = {}
  for i = 1, 2 do
    self._toggles[i] = self:GetChild("Back/ToggleGroup/_Toggle_" .. i - 1)
    self._toggles[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
  self._frame = TableFrame.Create(self._framePanel, self, true, true, true)
  self._frame:SetMargin(20, 20)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  self:GetRootWindow():PlayAnimation("SortShow")
end

function FilterDialog:OnDestroy()
  self._frame:Destroy()
end

function FilterDialog:SetData(delegate, conditions, target)
  self._target = target
  self._conditions = conditions
  if not target or target == "Equip" or target == "EquipBook" or target == "EquipChange" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipscreeningconditions")
  elseif target == "EquipStrengthenItem" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipstrengthenitemscreeningconditions")
  elseif target == "EquipEnchantItem" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipenchantitemscreeningconditions")
  elseif target == "Role" then
    self._cscreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
  elseif target == "Monster" then
    self._cscreeningConditions = BeanManager.GetTableByName("handbook.cmonster_handbookscreeningconditions")
  elseif target == "SupportRole" then
    self._cscreeningConditions = BeanManager.GetTableByName("skill.cskillscreeningconditions")
  end
  self._delegate = delegate
  self._list = {}
  local map = {}
  for k, v in pairs(self._cscreeningConditions:GetAllIds()) do
    local record = self._cscreeningConditions:GetRecorder(v)
    if target == "EquipBook" then
      if v == 5 or v == 6 or v == 7 then
        if not map[record.type] then
          map[record.type] = {
            mType = record.type,
            list = {},
            TypeNameId = record.typename,
            target = self._target
          }
        end
        table.insert(map[record.type].list, record)
      end
    elseif target == "EquipChange" then
      if v ~= 5 or v ~= 6 or v ~= 7 then
        if not map[record.type] then
          map[record.type] = {
            mType = record.type,
            list = {},
            TypeNameId = record.typename,
            target = self._target
          }
        end
        table.insert(map[record.type].list, record)
      end
    else
      if not map[record.type] then
        map[record.type] = {
          mType = record.type,
          list = {},
          TypeNameId = record.typename,
          target = self._target
        }
      end
      table.insert(map[record.type].list, record)
    end
  end
  for k, v in pairs(map) do
    table.sort(v.list, function(a, b)
      return a.sort < b.sort
    end)
    table.insert(self._list, v)
  end
  table.sort(self._list, function(a, b)
    return a.mType < b.mType
  end)
  self:ChangeTogglesState()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function FilterDialog:OnValueChanged(id)
  if id == 1 then
    if not self._toggle1Tag and self._toggles[1]:GetIsOnType() then
      self._toggle1Tag = true
      self._toggle2Tag = false
      for k, v in pairs(self._conditions) do
        while self._conditions[k][#self._conditions[k]] do
          table.remove(self._conditions[k], #self._conditions[k])
        end
      end
      for k, v in pairs(self._cscreeningConditions:GetAllIds()) do
        local record = self._cscreeningConditions:GetRecorder(v)
        if not self._conditions[record.type] then
          self._conditions[record.type] = {}
        end
        table.insert(self._conditions[record.type], record)
      end
      self._toggles[1]:SetInteractable(false)
      self._toggles[2]:SetInteractable(true)
      self._frame:FireEvent("ChangeSelectNameId")
    end
  elseif id == 2 and not self._toggle2Tag and self._toggles[2]:GetIsOnType() then
    self._toggle1Tag = false
    self._toggle2Tag = true
    for k, v in pairs(self._conditions) do
      while self._conditions[k][#self._conditions[k]] do
        table.remove(self._conditions[k], #self._conditions[k])
      end
    end
    self._toggles[1]:SetInteractable(true)
    self._toggles[2]:SetInteractable(false)
    self._frame:FireEvent("ChangeSelectNameId")
  end
end

function FilterDialog:OnConfirmBtnClick()
  self:GetRootWindow():PlayAnimation("SortHide")
end

function FilterDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "SortHide" then
    self:Destroy()
  end
end

function FilterDialog:ChangeTogglesState()
  local count = 0
  for k, v in pairs(self._conditions) do
    count = count + #v
  end
  if count == #self._cscreeningConditions:GetAllIds() then
    if not self._toggles[1]:GetIsOnType() then
      self._toggle1Tag = true
      self._toggles[1]:SetIsOnType(true)
    end
    self._toggles[1]:SetInteractable(false)
    if self._toggles[2]:GetIsOnType() then
      self._toggle2Tag = false
      self._toggles[2]:SetIsOnType(false)
    end
    self._toggles[2]:SetInteractable(true)
  elseif count == 0 then
    if self._toggles[1]:GetIsOnType() then
      self._toggle1Tag = false
      self._toggles[1]:SetIsOnType(false)
    end
    self._toggles[1]:SetInteractable(true)
    if not self._toggles[2]:GetIsOnType() then
      self._toggle2Tag = true
      self._toggles[2]:SetIsOnType(true)
    end
    self._toggles[2]:SetInteractable(false)
  else
    if self._toggles[1]:GetIsOnType() then
      self._toggle1Tag = false
      self._toggles[1]:SetIsOnType(false)
    end
    self._toggles[1]:SetInteractable(true)
    if self._toggles[2]:GetIsOnType() then
      self._toggle2Tag = false
      self._toggles[2]:SetIsOnType(false)
    end
    self._toggles[2]:SetInteractable(true)
  end
end

function FilterDialog:SetSelectedNameId(data)
  local index = self:IsInFilterConditions(data.type, data.nameid)
  if index then
    table.remove(self._conditions[data.type], index)
  else
    if not self._conditions[data.type] then
      self._conditions[data.type] = {}
    end
    table.insert(self._conditions[data.type], data)
  end
  self:ChangeTogglesState()
  self._frame:FireEvent("ChangeSelectNameId")
  self._delegate:SetScreeningConditions(self._conditions)
end

function FilterDialog:IsInFilterConditions(type, nameId)
  for k, v in pairs(self._conditions) do
    if k == type then
      for index, value in ipairs(v) do
        if value.nameid == nameId then
          return index
        end
      end
    end
  end
  return nil
end

function FilterDialog:NumberOfCell(frame)
  return #self._list
end

function FilterDialog:CellAtIndex(frame)
  return "equipstrengthen.filterframecell"
end

function FilterDialog:DataAtIndex(frame, index)
  return self._list[index]
end

function FilterDialog:ShouldLengthChange()
  return true
end

return FilterDialog
