local TableFrame = require("framework.ui.frame.table.tableframe")
local CVocationCFG = BeanManager.GetTableByName("role.cvocationcfg")
local BaseCharacterListSelectDialog = class("BaseCharacterListSelectDialog", Dialog)
BaseCharacterListSelectDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSelectDialog.AssetName = "BaseCharacterListSelect"

function BaseCharacterListSelectDialog:Ctor(...)
  BaseCharacterListSelectDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._filterTable = {}
  self._nameIdList = {}
end

function BaseCharacterListSelectDialog:OnCreate()
  self._cellFrame = self:GetChild("Back/CellFrame")
  self._arrow = self:GetChild("Arrow")
  self._arrow:SetActive(false)
  self._back = self:GetChild("BackPanel")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._frame = TableFrame.Create(self._cellFrame, self, true, true)
  self:LoadLocalData()
  self._frame:ReloadAllCell()
end

function BaseCharacterListSelectDialog:OnDestroy()
  self._frame:Destroy()
end

function BaseCharacterListSelectDialog:LoadLocalData()
  local filterTable = {}
  for _, v in pairs(CVocationCFG:GetAllIds()) do
    table.insert(filterTable, CVocationCFG:GetRecorder(v))
  end
  table.sort(filterTable, function(a, b)
    return a.id > b.id
  end)
  table.insert(self._filterTable, 38)
  table.insert(self._filterTable, 37)
  for _, v in pairs(filterTable) do
    table.insert(self._filterTable, v.nameid)
  end
  for _, v in pairs(self._filterTable) do
    if v ~= 38 then
      table.insert(self._nameIdList, v)
    end
  end
end

function BaseCharacterListSelectDialog:OnBackBtnClicked()
  self:Destroy()
end

function BaseCharacterListSelectDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function BaseCharacterListSelectDialog:NumberOfCell(frame)
  return #self._filterTable
end

function BaseCharacterListSelectDialog:CellAtIndex(frame)
  return "character.basecharacterlistselectcell"
end

function BaseCharacterListSelectDialog:DataAtIndex(frame, index)
  return self._filterTable[index]
end

function BaseCharacterListSelectDialog:OnFilterCellClick(nameId)
  local all, none = 37, 38
  if nameId == all then
    self._nameIdList = {}
    for _, v in pairs(self._filterTable) do
      if v ~= none then
        table.insert(self._nameIdList, v)
      end
    end
    self._frame:ReloadAllCell()
  elseif nameId == none then
    self._nameIdList = {}
    table.insert(self._nameIdList, nameId)
    self._frame:ReloadAllCell()
  else
    local pos
    for i, v in pairs(self._nameIdList) do
      if v == nameId then
        pos = i
        break
      end
    end
    if pos then
      table.remove(self._nameIdList, pos)
    else
      table.insert(self._nameIdList, nameId)
    end
    local pos1
    if #self._nameIdList < #self._filterTable - 1 then
      for i, v in pairs(self._nameIdList) do
        if v == all then
          pos1 = i
          break
        end
      end
      if pos1 then
        table.remove(self._nameIdList, pos1)
        self._frame:FireEvent("Remove", all)
      end
    end
    if #self._nameIdList == 0 then
      table.insert(self._nameIdList, none)
      self._frame:FireEvent("Insert", none)
    end
    if #self._nameIdList == #self._filterTable - 2 then
      table.insert(self._nameIdList, all)
      self._frame:FireEvent("Insert", all)
    end
    if #self._nameIdList > 1 then
      for i, v in pairs(self._nameIdList) do
        if v == none then
          pos1 = i
          break
        end
      end
      if pos1 then
        table.remove(self._nameIdList, pos1)
        self._frame:FireEvent("Remove", none)
      end
    end
  end
  self._screenedListDialog:OnSelectCellClick(nil, self._nameIdList)
end

function BaseCharacterListSelectDialog:SetScreenedListDialog(dialog)
  self._screenedListDialog = dialog
end

function BaseCharacterListSelectDialog:SetStatus(nameIdList)
  if #nameIdList ~= 0 then
    self._nameIdList = nameIdList
  else
    for _, v in pairs(self._filterTable) do
      table.insert(self._nameIdList, v)
    end
  end
end

return BaseCharacterListSelectDialog
