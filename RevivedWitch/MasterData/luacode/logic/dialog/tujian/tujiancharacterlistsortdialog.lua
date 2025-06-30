-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterlistsortdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CHandbookConditionsTable = (BeanManager.GetTableByName)("handbook.cscreeningconditions_handbook")
local TuJianCharacterListSortDialog = class("TuJianCharacterListSortDialog", Dialog)
TuJianCharacterListSortDialog.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterListSortDialog.AssetName = "TuJianCharListSort"
TuJianCharacterListSortDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterListSortDialog
  ((TuJianCharacterListSortDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._nameIdList1 = {}
  self._nameIdList2 = {}
  self._filterList1 = {}
  self._filterList2 = {}
end

TuJianCharacterListSortDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggleBtn = self:GetChild("Back/ToggleGroup")
  self._toggle_0 = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._cellFrame1 = self:GetChild("Back/Frame")
  self._cellFrame2 = self:GetChild("Back/Frame2")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackPressed, self)
  ;
  (self._toggle_0):SetUserData(0)
  ;
  (self._toggle_0):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  ;
  (self._toggle_1):SetUserData(1)
  ;
  (self._toggle_1):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._frame1 = (GridFrame.Create)(self._cellFrame1, self, true, 4)
  self._frame2 = (GridFrame.Create)(self._cellFrame2, self, true, 4)
end

TuJianCharacterListSortDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame1):Destroy()
  ;
  (self._frame2):Destroy()
end

TuJianCharacterListSortDialog.SetData = function(self, list1, list2)
  -- function num : 0_3 , upvalues : _ENV
  self:LoadLocalData()
  if #list1 == #self._nameIdList1 and #list2 == #self._nameIdList2 then
    (self._toggle_0):SetIsOnType(true)
    ;
    (self._toggle_0):SetInteractable(false)
    ;
    (self._toggle_1):SetIsOnType(false)
    ;
    (self._toggle_1):SetInteractable(true)
    for _,v in pairs(self._nameIdList1) do
      (table.insert)(self._filterList1, v)
    end
    for _,v in pairs(self._nameIdList2) do
      (table.insert)(self._filterList2, v)
    end
  else
    do
      if #list1 == 0 and #list2 == 0 then
        (self._toggle_0):SetIsOnType(false)
        ;
        (self._toggle_0):SetInteractable(true)
        ;
        (self._toggle_1):SetIsOnType(true)
        ;
        (self._toggle_1):SetInteractable(false)
        self._filterList1 = {}
        self._filterList2 = {}
      else
        ;
        (self._toggle_0):SetIsOnType(false)
        ;
        (self._toggle_0):SetInteractable(true)
        ;
        (self._toggle_1):SetIsOnType(false)
        ;
        (self._toggle_1):SetInteractable(true)
        for _,v in pairs(list1) do
          (table.insert)(self._filterList1, v)
        end
        for _,v in pairs(list2) do
          (table.insert)(self._filterList2, v)
        end
      end
      do
        ;
        (self._frame1):ReloadAllCell()
        ;
        (self._frame2):ReloadAllCell()
      end
    end
  end
end

TuJianCharacterListSortDialog.LoadLocalData = function(self)
  -- function num : 0_4 , upvalues : _ENV, CHandbookConditionsTable
  for _,v in pairs(CHandbookConditionsTable:GetAllIds()) do
    local data = CHandbookConditionsTable:GetRecorder(v)
    if data.index == 1 then
      (table.insert)(self._nameIdList1, data.nameid)
    else
      if data.index == 2 then
        (table.insert)(self._nameIdList2, data.nameid)
      end
    end
  end
end

TuJianCharacterListSortDialog.OnFilterCellClick = function(self, nameId)
  -- function num : 0_5 , upvalues : _ENV, CHandbookConditionsTable
  for _,v in pairs(CHandbookConditionsTable:GetAllIds()) do
    local data = CHandbookConditionsTable:GetRecorder(v)
    if data.nameid == nameId then
      if data.index == 1 then
        local pos = nil
        for i,u in pairs(self._filterList1) do
          if u == nameId then
            pos = i
            break
          end
        end
        do
          do
            if pos then
              (table.remove)(self._filterList1, pos)
              break
            else
              ;
              (table.insert)(self._filterList1, nameId)
              break
            end
            if data.index == 2 then
              local pos = nil
              for i,u in pairs(self._filterList2) do
                if u == nameId then
                  pos = i
                  break
                end
              end
              do
                do
                  if pos then
                    (table.remove)(self._filterList2, pos)
                    break
                  else
                    ;
                    (table.insert)(self._filterList2, nameId)
                    break
                  end
                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  if #self._filterList1 == #self._nameIdList1 and #self._filterList2 == #self._nameIdList2 then
    (self._toggle_0):SetIsOnType(true)
    ;
    (self._toggle_0):SetInteractable(false)
    ;
    (self._toggle_1):SetIsOnType(false)
    ;
    (self._toggle_1):SetInteractable(true)
  else
    if #self._filterList1 == 0 and #self._filterList2 == 0 then
      (self._toggle_0):SetIsOnType(false)
      ;
      (self._toggle_0):SetInteractable(true)
      ;
      (self._toggle_1):SetIsOnType(true)
      ;
      (self._toggle_1):SetInteractable(false)
    else
      ;
      (self._toggle_0):SetIsOnType(false)
      ;
      (self._toggle_0):SetInteractable(true)
      ;
      (self._toggle_1):SetIsOnType(false)
      ;
      (self._toggle_1):SetInteractable(true)
    end
  end
end

TuJianCharacterListSortDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._frame1 then
    return (self._nameIdList1)[index]
  else
    if frame == self._frame2 then
      return (self._nameIdList2)[index]
    end
  end
end

TuJianCharacterListSortDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._frame1 then
    return #self._nameIdList1
  else
    if frame == self._frame2 then
      return #self._nameIdList2
    end
  end
end

TuJianCharacterListSortDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "tujian.tujiancharacterlistsortcell"
end

TuJianCharacterListSortDialog.OnValueChanged = function(self, args, luawindow)
  -- function num : 0_9 , upvalues : _ENV
  if args and luawindow:GetUserData() == 0 then
    (self._toggle_0):SetInteractable(false)
    ;
    (self._toggle_1):SetInteractable(true)
    self._filterList1 = {}
    self._filterList2 = {}
    for _,v in pairs(self._nameIdList1) do
      (table.insert)(self._filterList1, v)
    end
    for _,v in pairs(self._nameIdList2) do
      (table.insert)(self._filterList2, v)
    end
  else
    do
      if args and luawindow:GetUserData() == 1 then
        (self._toggle_0):SetInteractable(true)
        ;
        (self._toggle_1):SetInteractable(false)
        self._filterList1 = {}
        self._filterList2 = {}
      end
      if self._frame1 and self._frame2 then
        (self._frame1):ReloadAllCell()
        ;
        (self._frame2):ReloadAllCell()
      end
    end
  end
end

TuJianCharacterListSortDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("tujian.tujianpagedialog")
  if dialog then
    dialog:OnFilter(self._filterList1, self._filterList2)
  end
  self:Destroy()
end

TuJianCharacterListSortDialog.OnBackPressed = function(self)
  -- function num : 0_11
  self:Destroy()
  return true, true
end

return TuJianCharacterListSortDialog

