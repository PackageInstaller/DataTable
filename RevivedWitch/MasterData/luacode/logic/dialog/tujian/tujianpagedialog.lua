-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujianpagedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CHandbookConditionsTable = (BeanManager.GetTableByName)("handbook.cscreeningconditions_handbook")
local TuJianPageDialog = class("TuJianPageDialog", Dialog)
TuJianPageDialog.AssetBundleName = "ui/layouts.tujian"
TuJianPageDialog.AssetName = "TuJianPage"
TuJianPageDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianPageDialog
  ((TuJianPageDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._filterList = {}
  self._filter = false
  self._nameIdList1 = {}
  self._nameIdList2 = {}
end

TuJianPageDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, CRoleConfigTable, _ENV
  self._btn1 = self:GetChild("GroupButtons/GroupButton1")
  self._btn2 = self:GetChild("GroupButtons/GroupButton2")
  self._btn3 = self:GetChild("GroupButtons/GroupButton3")
  self._btn4 = self:GetChild("GroupButtons/GroupButton4")
  self._filterBtn = self:GetChild("FliterBtn")
  self._num1 = self:GetChild("Txt1/Num")
  self._num2 = self:GetChild("Txt2/Num")
  self._cellFrame = self:GetChild("CellFrame")
  self._frame = (GridFrame.Create)(self._cellFrame, self, true, 3)
  self._allIdListExcludeMaterial = CRoleConfigTable:GetAllIds()
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self:LoadLocalData()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._num1):SetText(#((NekoData.BehaviorManager).BM_Game):GetTuJianList())
  ;
  (self._num2):SetText(#self._allIdListExcludeMaterial)
end

TuJianPageDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TuJianPageDialog.LoadLocalData = function(self)
  -- function num : 0_3 , upvalues : _ENV, CHandbookConditionsTable
  local all = self._allIdListExcludeMaterial
  ;
  (table.sort)(all, function(a, b)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local own = ((NekoData.BehaviorManager).BM_Game):GetTuJianList()
  for _,v in pairs(all) do
    local data = {}
    data.id = v
    data.own = false
    for _,u in pairs(own) do
      if v == u.id then
        data.own = true
        break
      end
    end
    do
      do
        ;
        (table.insert)(self._data, data)
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
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

TuJianPageDialog.OnFilter = function(self, list1, list2)
  -- function num : 0_4 , upvalues : _ENV, CRoleConfigTable, CVocationCfgTable
  self._nameIdList1 = list1
  self._nameIdList2 = list2
  self._filterList = self._data
  if #list1 > 0 then
    self._filterList = {}
    for _,v in pairs(self._data) do
      local rarity = (CRoleConfigTable:GetRecorder(v.id)).rarity
      for _,u in pairs(list1) do
        if u == 21 and rarity == 1 then
          (table.insert)(self._filterList, v)
          break
        else
          if u == 22 and rarity == 2 then
            (table.insert)(self._filterList, v)
            break
          else
            if u == 23 and rarity == 3 then
              (table.insert)(self._filterList, v)
              break
            else
              if u == 27 and rarity == 4 then
                (table.insert)(self._filterList, v)
                break
              end
            end
          end
        end
      end
    end
  end
  do
    local list = self._filterList
    if #list2 > 0 then
      self._filterList = {}
      for _,v in pairs(list) do
        local nameId = (CVocationCfgTable:GetRecorder((CRoleConfigTable:GetRecorder(v.id)).vocation)).nameid
        for _,u in pairs(list2) do
          if u == nameId then
            (table.insert)(self._filterList, v)
            break
          end
        end
      end
    end
    do
      if #list1 == 0 or #list2 == 0 then
        self._filterList = {}
      end
      self._filter = true
      ;
      (self._frame):ReloadAllCell()
    end
  end
end

TuJianPageDialog.ReturnData = function(self)
  -- function num : 0_5
  if self._filter then
    return self._filterList
  else
    return self._data
  end
end

TuJianPageDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if self._filter then
    return (self._filterList)[index]
  else
    return (self._data)[index]
  end
end

TuJianPageDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if self._filter then
    return #self._filterList
  else
    return #self._data
  end
end

TuJianPageDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "tujian.tujiancharcell"
end

TuJianPageDialog.OnFilterBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("tujian.tujiancharacterlistsortdialog")):SetData(self._nameIdList1, self._nameIdList2)
end

TuJianPageDialog.OnBackPressed = function(self)
  -- function num : 0_10
  self:Destroy()
  return true, true
end

TuJianPageDialog.AddNewModal = function(self)
  -- function num : 0_11
end

TuJianPageDialog.SetActive = function(self, value)
  -- function num : 0_12
  (self:GetRootWindow()):SetActive(value)
end

return TuJianPageDialog

