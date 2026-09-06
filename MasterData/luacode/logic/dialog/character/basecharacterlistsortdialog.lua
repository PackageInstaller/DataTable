local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSortCriteria = BeanManager.GetTableByName("role.csortcriteria")
local CSkillSortCriteria = BeanManager.GetTableByName("skill.cskillsortcriteria")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BaseCharacterListSortDialog = class("BaseCharacterListSortDialog", Dialog)
BaseCharacterListSortDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSortDialog.AssetName = "BaseCharacterListSort"

function BaseCharacterListSortDialog:Ctor(...)
  BaseCharacterListSortDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._sortTable = {}
  self._type = ""
  self._nameId = nil
  self._selectedId = nil
end

function BaseCharacterListSortDialog:OnCreate()
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._cellFrame = self:GetChild("Back/Frame")
  self._frame = GridFrame.Create(self._cellFrame, self, true, 4)
  self._frame:SetMargin(20, 20)
end

function BaseCharacterListSortDialog:OnDestroy()
  self._frame:Destroy()
end

function BaseCharacterListSortDialog:SetScreenedListDialog(dialog, type)
  self._type = type
  self:LoadSortData()
  self._screenedListDialog = dialog
end

function BaseCharacterListSortDialog:LoadSortData()
  local sortTable = {}
  if self._type == "sort" then
    for _, v in pairs(CSortCriteria:GetAllIds()) do
      table.insert(sortTable, CSortCriteria:GetRecorder(v))
    end
  else
    for _, v in pairs(CSkillSortCriteria:GetAllIds()) do
      table.insert(sortTable, CSkillSortCriteria:GetRecorder(v))
    end
  end
  table.sort(sortTable, function(a, b)
    return a.sort < b.sort
  end)
  for _, v in pairs(sortTable) do
    table.insert(self._sortTable, v.nameid)
  end
  if self._type == "sort" then
    self._nameId = CSortCriteria:GetRecorder(1).nameid
  elseif self._type == "skillsort" then
    self._nameId = CSkillSortCriteria:GetRecorder(1).nameid
  end
  self._selectedId = self._nameId
end

function BaseCharacterListSortDialog:NumberOfCell(frame)
  return #self._sortTable
end

function BaseCharacterListSortDialog:CellAtIndex(frame)
  return "character.basecharacterlistsortcell"
end

function BaseCharacterListSortDialog:DataAtIndex(frame, index)
  return self._sortTable[index]
end

function BaseCharacterListSortDialog:OnSortCellClick(nameId)
  self._selectedId = nameId
end

function BaseCharacterListSortDialog:SetSelect(arg)
  self._selectedId = arg
  self._frame:FireEvent("ChangedSelected", arg)
end

function BaseCharacterListSortDialog:GetSelect()
  return self._selectedId
end

function BaseCharacterListSortDialog:GetOperateType()
  return self._type
end

function BaseCharacterListSortDialog:OnConfirmBtnClick()
  self._screenedListDialog:OnSelectCellClick(self._selectedId)
  self:Destroy()
  return true, true
end

function BaseCharacterListSortDialog:OnBackBtnClicked()
  if self._type == "sort" then
    self:SetScreenedListTypeTxt(TextManager.GetText(self._nameId))
  elseif self._type == "skillsort" then
    local str = TextManager.GetText(CStringRes:GetRecorder(self._nameId).msgTextID)
    self:SetScreenedListTypeTxt(str)
  end
  self:Destroy()
  return true, true
end

function BaseCharacterListSortDialog:SetStatus(nameId)
  if nameId then
    self._nameId = nameId
    self:SetSelect(nameId)
  else
    if self._type == "sort" then
      self._nameId = CSortCriteria:GetRecorder(1).nameid
    elseif self._type == "skillsort" then
      self._nameId = CSkillSortCriteria:GetRecorder(1).nameid
    end
    self:SetSelect(self._nameId)
  end
  if self._frame then
    self._frame:ReloadAllCell()
  end
end

function BaseCharacterListSortDialog:SetScreenedListTypeTxt(str)
  local _text_component = self._screenedListDialog:GetTypeBtnTxt()
  if _text_component.SetText then
    _text_component:SetText(str)
  else
    LogError("BaseCharacterListSortDialog", "get wrong text component, doesn't have SetText function")
  end
end

return BaseCharacterListSortDialog
