local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSkillScreeningConditions = BeanManager.GetTableByName("skill.cskillscreeningconditions")
local FilterDialog = class("FilterDialog", Dialog)
FilterDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterDialog.AssetName = "BaseCharacterListFliter"

function FilterDialog:Ctor(...)
  FilterDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._rankList = {}
  self._skillTypeList = {}
  self._delegate = nil
  self._selectedList = {
    rank = {},
    skillType = {}
  }
  self._toggle1Tag = false
  self._toggle2Tag = false
end

function FilterDialog:OnCreate()
  self._rankPanel = self:GetChild("Back/Frame")
  self._skillTypePanel = self:GetChild("Back/Frame2")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggles = {}
  for i = 1, 2 do
    self._toggles[i] = self:GetChild("Back/ToggleGroup/_Toggle_" .. i - 1)
    self._toggles[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
  self._rankFrame = GridFrame.Create(self._rankPanel, self, true, 4)
  self._rankFrame:SetMargin(15, 0)
  self._skillTypeFrame = GridFrame.Create(self._skillTypePanel, self, true, 4)
  self._skillTypeFrame:SetMargin(15, 0)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnCancelBtnClick, self)
  self:Init()
end

function FilterDialog:OnDestroy()
  self._rankFrame:Destroy()
  self._skillTypeFrame:Destroy()
end

function FilterDialog:Init()
  for _, v in pairs(CSkillScreeningConditions:GetAllIds()) do
    local record = CSkillScreeningConditions:GetRecorder(v)
    if v < 10 then
      table.insert(self._rankList, record)
    end
    if 10 < v then
      table.insert(self._skillTypeList, record)
    end
  end
  table.sort(self._rankList, function(a, b)
    return a.sort > b.sort
  end)
  table.sort(self._skillTypeList, function(a, b)
    return a.sort > b.sort
  end)
end

function FilterDialog:SetFilterList(delegate, filterList)
  self._delegate = delegate
  for k, v in pairs(filterList.rank) do
    self._selectedList.rank[k] = v
  end
  for k, v in pairs(filterList.skillType) do
    self._selectedList.skillType[k] = v
  end
  self:ChangeTogglesState()
  self._rankFrame:ReloadAllCell()
  self._skillTypeFrame:ReloadAllCell()
end

function FilterDialog:SetSelectedList(data)
  if data.id < 10 then
    if self._selectedList.rank[data.nameid] then
      self._selectedList.rank[data.nameid] = nil
    else
      self._selectedList.rank[data.nameid] = true
    end
    self._rankFrame:FireEvent("ChangeSelectNameId")
  elseif data.id > 10 then
    if self._selectedList.skillType[data.nameid] then
      self._selectedList.skillType[data.nameid] = nil
    else
      self._selectedList.skillType[data.nameid] = true
    end
    self._skillTypeFrame:FireEvent("ChangeSelectNameId")
  end
  self:ChangeTogglesState()
end

function FilterDialog:IsInSelectedList(data)
  if data.id < 10 then
    return self._selectedList.rank[data.nameid]
  elseif data.id > 10 then
    return self._selectedList.skillType[data.nameid]
  end
end

function FilterDialog:ChangeTogglesState()
  local count = table.nums(self._selectedList.rank) + table.nums(self._selectedList.skillType)
  if count == #CSkillScreeningConditions:GetAllIds() then
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

function FilterDialog:OnValueChanged(id)
  if id == 1 then
    if not self._toggle1Tag and self._toggles[1]:GetIsOnType() then
      for k, v in pairs(self._selectedList.rank) do
        self._selectedList.rank[k] = nil
      end
      for k, v in pairs(self._selectedList.skillType) do
        self._selectedList.skillType[k] = nil
      end
      for k, v in pairs(CSkillScreeningConditions:GetAllIds()) do
        local record = CSkillScreeningConditions:GetRecorder(v)
        if v < 10 then
          table.insert(self._rankList, record)
          self._selectedList.rank[record.nameid] = true
        end
        if 10 < v then
          table.insert(self._skillTypeList, record)
          self._selectedList.skillType[record.nameid] = true
        end
      end
      self._toggles[1]:SetInteractable(false)
      self._toggles[2]:SetInteractable(true)
      self._rankFrame:FireEvent("ChangeSelectNameId")
      self._skillTypeFrame:FireEvent("ChangeSelectNameId")
    end
  elseif id == 2 and not self._toggle2Tag and self._toggles[2]:GetIsOnType() then
    for k, v in pairs(self._selectedList.rank) do
      self._selectedList.rank[k] = nil
    end
    for k, v in pairs(self._selectedList.skillType) do
      self._selectedList.skillType[k] = nil
    end
    self._toggles[1]:SetInteractable(true)
    self._toggles[2]:SetInteractable(false)
    self._rankFrame:FireEvent("ChangeSelectNameId")
    self._skillTypeFrame:FireEvent("ChangeSelectNameId")
  end
end

function FilterDialog:OnConfirmBtnClick()
  self._delegate:SetScreeningConditions(self._selectedList)
  self:Destroy()
end

function FilterDialog:OnCancelBtnClick()
  self:Destroy()
end

function FilterDialog:NumberOfCell(frame)
  if frame == self._rankFrame then
    return #self._rankList
  elseif frame == self._skillTypeFrame then
    return #self._skillTypeList
  end
end

function FilterDialog:CellAtIndex(frame)
  return "assistbattle.filtersortcell"
end

function FilterDialog:DataAtIndex(frame, index)
  if frame == self._rankFrame then
    return self._rankList[index]
  elseif frame == self._skillTypeFrame then
    return self._skillTypeList[index]
  end
end

return FilterDialog
