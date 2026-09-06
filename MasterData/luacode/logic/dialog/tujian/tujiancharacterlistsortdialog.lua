local GridFrame = require("framework.ui.frame.grid.gridframe")
local CHandbookConditionsTable = BeanManager.GetTableByName("handbook.cscreeningconditions_handbook")
local TuJianCharacterListSortDialog = class("TuJianCharacterListSortDialog", Dialog)
TuJianCharacterListSortDialog.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterListSortDialog.AssetName = "TuJianCharListSort"

function TuJianCharacterListSortDialog:Ctor(...)
  TuJianCharacterListSortDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._nameIdList1 = {}
  self._nameIdList2 = {}
  self._filterList1 = {}
  self._filterList2 = {}
end

function TuJianCharacterListSortDialog:OnCreate()
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._toggleBtn = self:GetChild("Back/ToggleGroup")
  self._toggle_0 = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._cellFrame1 = self:GetChild("Back/Frame")
  self._cellFrame2 = self:GetChild("Back/Frame2")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackPressed, self)
  self._toggle_0:SetUserData(0)
  self._toggle_0:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._toggle_1:SetUserData(1)
  self._toggle_1:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._frame1 = GridFrame.Create(self._cellFrame1, self, true, 4)
  self._frame2 = GridFrame.Create(self._cellFrame2, self, true, 4)
end

function TuJianCharacterListSortDialog:OnDestroy()
  self._frame1:Destroy()
  self._frame2:Destroy()
end

function TuJianCharacterListSortDialog:SetData(list1, list2)
  self:LoadLocalData()
  if #list1 == #self._nameIdList1 and #list2 == #self._nameIdList2 then
    self._toggle_0:SetIsOnType(true)
    self._toggle_0:SetInteractable(false)
    self._toggle_1:SetIsOnType(false)
    self._toggle_1:SetInteractable(true)
    for _, v in pairs(self._nameIdList1) do
      table.insert(self._filterList1, v)
    end
    for _, v in pairs(self._nameIdList2) do
      table.insert(self._filterList2, v)
    end
  elseif #list1 == 0 and #list2 == 0 then
    self._toggle_0:SetIsOnType(false)
    self._toggle_0:SetInteractable(true)
    self._toggle_1:SetIsOnType(true)
    self._toggle_1:SetInteractable(false)
    self._filterList1 = {}
    self._filterList2 = {}
  else
    self._toggle_0:SetIsOnType(false)
    self._toggle_0:SetInteractable(true)
    self._toggle_1:SetIsOnType(false)
    self._toggle_1:SetInteractable(true)
    for _, v in pairs(list1) do
      table.insert(self._filterList1, v)
    end
    for _, v in pairs(list2) do
      table.insert(self._filterList2, v)
    end
  end
  self._frame1:ReloadAllCell()
  self._frame2:ReloadAllCell()
end

function TuJianCharacterListSortDialog:LoadLocalData()
  for _, v in pairs(CHandbookConditionsTable:GetAllIds()) do
    local data = CHandbookConditionsTable:GetRecorder(v)
    if data.index == 1 then
      table.insert(self._nameIdList1, data.nameid)
    elseif data.index == 2 then
      table.insert(self._nameIdList2, data.nameid)
    end
  end
end

function TuJianCharacterListSortDialog:OnFilterCellClick(nameId)
  for _, v in pairs(CHandbookConditionsTable:GetAllIds()) do
    local data = CHandbookConditionsTable:GetRecorder(v)
    if data.nameid == nameId then
      if data.index == 1 then
        local pos
        for i, u in pairs(self._filterList1) do
          if u == nameId then
            pos = i
            break
          end
        end
        if pos then
          table.remove(self._filterList1, pos)
          break
        else
          table.insert(self._filterList1, nameId)
          break
        end
      elseif data.index == 2 then
        local pos
        for i, u in pairs(self._filterList2) do
          if u == nameId then
            pos = i
            break
          end
        end
        if pos then
          table.remove(self._filterList2, pos)
          break
        else
          table.insert(self._filterList2, nameId)
          break
        end
      end
    end
  end
  if #self._filterList1 == #self._nameIdList1 and #self._filterList2 == #self._nameIdList2 then
    self._toggle_0:SetIsOnType(true)
    self._toggle_0:SetInteractable(false)
    self._toggle_1:SetIsOnType(false)
    self._toggle_1:SetInteractable(true)
  elseif #self._filterList1 == 0 and #self._filterList2 == 0 then
    self._toggle_0:SetIsOnType(false)
    self._toggle_0:SetInteractable(true)
    self._toggle_1:SetIsOnType(true)
    self._toggle_1:SetInteractable(false)
  else
    self._toggle_0:SetIsOnType(false)
    self._toggle_0:SetInteractable(true)
    self._toggle_1:SetIsOnType(false)
    self._toggle_1:SetInteractable(true)
  end
end

function TuJianCharacterListSortDialog:DataAtIndex(frame, index)
  if frame == self._frame1 then
    return self._nameIdList1[index]
  elseif frame == self._frame2 then
    return self._nameIdList2[index]
  end
end

function TuJianCharacterListSortDialog:NumberOfCell(frame)
  if frame == self._frame1 then
    return #self._nameIdList1
  elseif frame == self._frame2 then
    return #self._nameIdList2
  end
end

function TuJianCharacterListSortDialog:CellAtIndex(frame)
  return "tujian.tujiancharacterlistsortcell"
end

function TuJianCharacterListSortDialog:OnValueChanged(args, luawindow)
  if args and luawindow:GetUserData() == 0 then
    self._toggle_0:SetInteractable(false)
    self._toggle_1:SetInteractable(true)
    self._filterList1 = {}
    self._filterList2 = {}
    for _, v in pairs(self._nameIdList1) do
      table.insert(self._filterList1, v)
    end
    for _, v in pairs(self._nameIdList2) do
      table.insert(self._filterList2, v)
    end
  elseif args and luawindow:GetUserData() == 1 then
    self._toggle_0:SetInteractable(true)
    self._toggle_1:SetInteractable(false)
    self._filterList1 = {}
    self._filterList2 = {}
  end
  if self._frame1 and self._frame2 then
    self._frame1:ReloadAllCell()
    self._frame2:ReloadAllCell()
  end
end

function TuJianCharacterListSortDialog:OnConfirmBtnClick()
  local dialog = DialogManager.GetDialog("tujian.tujianpagedialog")
  if dialog then
    dialog:OnFilter(self._filterList1, self._filterList2)
  end
  self:Destroy()
end

function TuJianCharacterListSortDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

return TuJianCharacterListSortDialog
