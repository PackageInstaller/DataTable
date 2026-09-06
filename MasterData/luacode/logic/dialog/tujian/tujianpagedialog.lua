local GridFrame = require("framework.ui.frame.grid.gridframe")
local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CHandbookConditionsTable = BeanManager.GetTableByName("handbook.cscreeningconditions_handbook")
local TuJianPageDialog = class("TuJianPageDialog", Dialog)
TuJianPageDialog.AssetBundleName = "ui/layouts.tujian"
TuJianPageDialog.AssetName = "TuJianPage"

function TuJianPageDialog:Ctor(...)
  TuJianPageDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._filterList = {}
  self._filter = false
  self._nameIdList1 = {}
  self._nameIdList2 = {}
end

function TuJianPageDialog:OnCreate()
  self._btn1 = self:GetChild("GroupButtons/GroupButton1")
  self._btn2 = self:GetChild("GroupButtons/GroupButton2")
  self._btn3 = self:GetChild("GroupButtons/GroupButton3")
  self._btn4 = self:GetChild("GroupButtons/GroupButton4")
  self._filterBtn = self:GetChild("FliterBtn")
  self._num1 = self:GetChild("Txt1/Num")
  self._num2 = self:GetChild("Txt2/Num")
  self._cellFrame = self:GetChild("CellFrame")
  self._frame = GridFrame.Create(self._cellFrame, self, true, 3)
  self._allIdListExcludeMaterial = CRoleConfigTable:GetAllIds()
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self:LoadLocalData()
  self._frame:ReloadAllCell()
  self._num1:SetText(#NekoData.BehaviorManager.BM_Game:GetTuJianList())
  self._num2:SetText(#self._allIdListExcludeMaterial)
end

function TuJianPageDialog:OnDestroy()
  self._frame:Destroy()
end

function TuJianPageDialog:LoadLocalData()
  local all = self._allIdListExcludeMaterial
  table.sort(all, function(a, b)
    return a < b
  end)
  local own = NekoData.BehaviorManager.BM_Game:GetTuJianList()
  for _, v in pairs(all) do
    local data = {}
    data.id = v
    data.own = false
    for _, u in pairs(own) do
      if v == u.id then
        data.own = true
        break
      end
    end
    table.insert(self._data, data)
  end
  for _, v in pairs(CHandbookConditionsTable:GetAllIds()) do
    local data = CHandbookConditionsTable:GetRecorder(v)
    if data.index == 1 then
      table.insert(self._nameIdList1, data.nameid)
    elseif data.index == 2 then
      table.insert(self._nameIdList2, data.nameid)
    end
  end
end

function TuJianPageDialog:OnFilter(list1, list2)
  self._nameIdList1 = list1
  self._nameIdList2 = list2
  self._filterList = self._data
  if 0 < #list1 then
    self._filterList = {}
    for _, v in pairs(self._data) do
      local rarity = CRoleConfigTable:GetRecorder(v.id).rarity
      for _, u in pairs(list1) do
        if u == 21 and rarity == 1 then
          table.insert(self._filterList, v)
          break
        elseif u == 22 and rarity == 2 then
          table.insert(self._filterList, v)
          break
        elseif u == 23 and rarity == 3 then
          table.insert(self._filterList, v)
          break
        elseif u == 27 and rarity == 4 then
          table.insert(self._filterList, v)
          break
        end
      end
    end
  end
  local list = self._filterList
  if 0 < #list2 then
    self._filterList = {}
    for _, v in pairs(list) do
      local nameId = CVocationCfgTable:GetRecorder(CRoleConfigTable:GetRecorder(v.id).vocation).nameid
      for _, u in pairs(list2) do
        if u == nameId then
          table.insert(self._filterList, v)
          break
        end
      end
    end
  end
  if #list1 == 0 or #list2 == 0 then
    self._filterList = {}
  end
  self._filter = true
  self._frame:ReloadAllCell()
end

function TuJianPageDialog:ReturnData()
  if self._filter then
    return self._filterList
  else
    return self._data
  end
end

function TuJianPageDialog:DataAtIndex(frame, index)
  if self._filter then
    return self._filterList[index]
  else
    return self._data[index]
  end
end

function TuJianPageDialog:NumberOfCell(frame)
  if self._filter then
    return #self._filterList
  else
    return #self._data
  end
end

function TuJianPageDialog:CellAtIndex(frame)
  return "tujian.tujiancharcell"
end

function TuJianPageDialog:OnFilterBtnClick()
  DialogManager.CreateSingletonDialog("tujian.tujiancharacterlistsortdialog"):SetData(self._nameIdList1, self._nameIdList2)
end

function TuJianPageDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

function TuJianPageDialog:AddNewModal()
end

function TuJianPageDialog:SetActive(value)
  self:GetRootWindow():SetActive(value)
end

return TuJianPageDialog
