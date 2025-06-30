-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistselectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CVocationCFG = (BeanManager.GetTableByName)("role.cvocationcfg")
local BaseCharacterListSelectDialog = class("BaseCharacterListSelectDialog", Dialog)
BaseCharacterListSelectDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSelectDialog.AssetName = "BaseCharacterListSelect"
BaseCharacterListSelectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListSelectDialog
  ((BaseCharacterListSelectDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._filterTable = {}
  self._nameIdList = {}
end

BaseCharacterListSelectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cellFrame = self:GetChild("Back/CellFrame")
  self._arrow = self:GetChild("Arrow")
  ;
  (self._arrow):SetActive(false)
  self._back = self:GetChild("BackPanel")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._frame = (TableFrame.Create)(self._cellFrame, self, true, true)
  self:LoadLocalData()
  ;
  (self._frame):ReloadAllCell()
end

BaseCharacterListSelectDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

BaseCharacterListSelectDialog.LoadLocalData = function(self)
  -- function num : 0_3 , upvalues : _ENV, CVocationCFG
  local filterTable = {}
  for _,v in pairs(CVocationCFG:GetAllIds()) do
    (table.insert)(filterTable, CVocationCFG:GetRecorder(v))
  end
  ;
  (table.sort)(filterTable, function(a, b)
    -- function num : 0_3_0
    do return b.id < a.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.insert)(self._filterTable, 38)
  ;
  (table.insert)(self._filterTable, 37)
  for _,v in pairs(filterTable) do
    (table.insert)(self._filterTable, v.nameid)
  end
  for _,v in pairs(self._filterTable) do
    if v ~= 38 then
      (table.insert)(self._nameIdList, v)
    end
  end
end

BaseCharacterListSelectDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BaseCharacterListSelectDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

BaseCharacterListSelectDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._filterTable
end

BaseCharacterListSelectDialog.CellAtIndex = function(self, frame)
  -- function num : 0_7
  return "character.basecharacterlistselectcell"
end

BaseCharacterListSelectDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._filterTable)[index]
end

BaseCharacterListSelectDialog.OnFilterCellClick = function(self, nameId)
  -- function num : 0_9 , upvalues : _ENV
  local all, none = 37, 38
  if nameId == all then
    self._nameIdList = {}
    for _,v in pairs(self._filterTable) do
      if v ~= none then
        (table.insert)(self._nameIdList, v)
      end
    end
    ;
    (self._frame):ReloadAllCell()
  else
    if nameId == none then
      self._nameIdList = {}
      ;
      (table.insert)(self._nameIdList, nameId)
      ;
      (self._frame):ReloadAllCell()
    else
      local pos = nil
      for i,v in pairs(self._nameIdList) do
        if v == nameId then
          pos = i
          break
        end
      end
      do
        if pos then
          (table.remove)(self._nameIdList, pos)
        else
          ;
          (table.insert)(self._nameIdList, nameId)
        end
        local pos1 = nil
        if #self._nameIdList < #self._filterTable - 1 then
          for i,v in pairs(self._nameIdList) do
            if v == all then
              pos1 = i
              break
            end
          end
          do
            if pos1 then
              (table.remove)(self._nameIdList, pos1)
              ;
              (self._frame):FireEvent("Remove", all)
            end
            if #self._nameIdList == 0 then
              (table.insert)(self._nameIdList, none)
              ;
              (self._frame):FireEvent("Insert", none)
            end
            if #self._nameIdList == #self._filterTable - 2 then
              (table.insert)(self._nameIdList, all)
              ;
              (self._frame):FireEvent("Insert", all)
            end
            if #self._nameIdList > 1 then
              for i,v in pairs(self._nameIdList) do
                if v == none then
                  pos1 = i
                  break
                end
              end
              do
                do
                  if pos1 then
                    (table.remove)(self._nameIdList, pos1)
                    ;
                    (self._frame):FireEvent("Remove", none)
                  end
                  ;
                  (self._screenedListDialog):OnSelectCellClick(nil, self._nameIdList)
                end
              end
            end
          end
        end
      end
    end
  end
end

BaseCharacterListSelectDialog.SetScreenedListDialog = function(self, dialog)
  -- function num : 0_10
  self._screenedListDialog = dialog
end

BaseCharacterListSelectDialog.SetStatus = function(self, nameIdList)
  -- function num : 0_11 , upvalues : _ENV
  if #nameIdList ~= 0 then
    self._nameIdList = nameIdList
  else
    for _,v in pairs(self._filterTable) do
      (table.insert)(self._nameIdList, v)
    end
  end
end

return BaseCharacterListSelectDialog

