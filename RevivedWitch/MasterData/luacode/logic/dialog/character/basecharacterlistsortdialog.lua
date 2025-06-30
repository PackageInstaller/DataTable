-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistsortdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSortCriteria = (BeanManager.GetTableByName)("role.csortcriteria")
local CSkillSortCriteria = (BeanManager.GetTableByName)("skill.cskillsortcriteria")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BaseCharacterListSortDialog = class("BaseCharacterListSortDialog", Dialog)
BaseCharacterListSortDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSortDialog.AssetName = "BaseCharacterListSort"
BaseCharacterListSortDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListSortDialog
  ((BaseCharacterListSortDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._sortTable = {}
  self._type = ""
  self._nameId = nil
  self._selectedId = nil
end

BaseCharacterListSortDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._cellFrame = self:GetChild("Back/Frame")
  self._frame = (GridFrame.Create)(self._cellFrame, self, true, 4)
  ;
  (self._frame):SetMargin(20, 20)
end

BaseCharacterListSortDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

BaseCharacterListSortDialog.SetScreenedListDialog = function(self, dialog, type)
  -- function num : 0_3
  self._type = type
  self:LoadSortData()
  self._screenedListDialog = dialog
end

BaseCharacterListSortDialog.LoadSortData = function(self)
  -- function num : 0_4 , upvalues : _ENV, CSortCriteria, CSkillSortCriteria
  local sortTable = {}
  if self._type == "sort" then
    for _,v in pairs(CSortCriteria:GetAllIds()) do
      (table.insert)(sortTable, CSortCriteria:GetRecorder(v))
    end
  else
    do
      for _,v in pairs(CSkillSortCriteria:GetAllIds()) do
        (table.insert)(sortTable, CSkillSortCriteria:GetRecorder(v))
      end
      do
        ;
        (table.sort)(sortTable, function(a, b)
    -- function num : 0_4_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for _,v in pairs(sortTable) do
          (table.insert)(self._sortTable, v.nameid)
        end
        if self._type == "sort" then
          self._nameId = (CSortCriteria:GetRecorder(1)).nameid
        else
          if self._type == "skillsort" then
            self._nameId = (CSkillSortCriteria:GetRecorder(1)).nameid
          end
        end
        self._selectedId = self._nameId
      end
    end
  end
end

BaseCharacterListSortDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._sortTable
end

BaseCharacterListSortDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "character.basecharacterlistsortcell"
end

BaseCharacterListSortDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._sortTable)[index]
end

BaseCharacterListSortDialog.OnSortCellClick = function(self, nameId)
  -- function num : 0_8
  self._selectedId = nameId
end

BaseCharacterListSortDialog.SetSelect = function(self, arg)
  -- function num : 0_9
  self._selectedId = arg
  ;
  (self._frame):FireEvent("ChangedSelected", arg)
end

BaseCharacterListSortDialog.GetSelect = function(self)
  -- function num : 0_10
  return self._selectedId
end

BaseCharacterListSortDialog.GetOperateType = function(self)
  -- function num : 0_11
  return self._type
end

BaseCharacterListSortDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_12
  (self._screenedListDialog):OnSelectCellClick(self._selectedId)
  self:Destroy()
  return true, true
end

BaseCharacterListSortDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, CStringRes
  if self._type == "sort" then
    self:SetScreenedListTypeTxt((TextManager.GetText)(self._nameId))
  else
    if self._type == "skillsort" then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(self._nameId)).msgTextID)
      self:SetScreenedListTypeTxt(str)
    end
  end
  do
    self:Destroy()
    return true, true
  end
end

BaseCharacterListSortDialog.SetStatus = function(self, nameId)
  -- function num : 0_14 , upvalues : CSortCriteria, CSkillSortCriteria
  if nameId then
    self._nameId = nameId
    self:SetSelect(nameId)
  else
    if self._type == "sort" then
      self._nameId = (CSortCriteria:GetRecorder(1)).nameid
    else
      if self._type == "skillsort" then
        self._nameId = (CSkillSortCriteria:GetRecorder(1)).nameid
      end
    end
    self:SetSelect(self._nameId)
  end
  if self._frame then
    (self._frame):ReloadAllCell()
  end
end

BaseCharacterListSortDialog.SetScreenedListTypeTxt = function(self, str)
  -- function num : 0_15 , upvalues : _ENV
  local _text_component = (self._screenedListDialog):GetTypeBtnTxt()
  if _text_component.SetText then
    _text_component:SetText(str)
  else
    LogError("BaseCharacterListSortDialog", "get wrong text component, doesn\'t have SetText function")
  end
end

return BaseCharacterListSortDialog

