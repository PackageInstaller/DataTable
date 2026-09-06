local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadRecordDialog = class("UndecidedRoadRecordDialog", Dialog)
UndecidedRoadRecordDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRecordDialog.AssetName = "ActivityRoadRecord"
local BottomToTop = 2

function UndecidedRoadRecordDialog:Ctor(...)
  UndecidedRoadRecordDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function UndecidedRoadRecordDialog:OnCreate()
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._panel = self:GetChild("Back/Frame")
  self._width, self._height = self._panel:GetRectSize()
  self._scrollbar = self:GetChild("Back/Scrollbar")
  self._scrollbar:SetScrollDirection(BottomToTop)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function UndecidedRoadRecordDialog:OnDestroy()
  self._frame:Destroy()
end

function UndecidedRoadRecordDialog:SetData(data)
  while #self._data > 0 do
    table.remove(self._data, #self._data)
  end
  local weekData = {}
  local dayData = {}
  self._battleType = data.battleType
  for k, v in pairs(data.record) do
    local record = v
    local temp = {}
    temp.roleIdList = {}
    for k, v in pairs(record.roleIdList) do
      if v ~= 0 then
        temp.roleIdList[k] = {
          id = v,
          lv = record.roleLvList[k],
          breakLv = record.roleBreakList[k],
          skin = record.roleSkinList[k],
          runeLevel = record.runeLevelList[k]
        }
      end
    end
    if k ~= 100 then
      temp.type = k - 1
    else
      temp.type = k
    end
    temp.score = v.score
    temp.time = v.time
    if tonumber(k) == 100 then
      table.insert(weekData, temp)
    else
      table.insert(dayData, temp)
    end
  end
  table.sort(dayData, function(a, b)
    return a.type < b.type
  end)
  for _, v in pairs(weekData) do
    table.insert(self._data, v)
  end
  for _, v in pairs(dayData) do
    table.insert(self._data, v)
  end
  self._emptyTxt:SetActive(#self._data == 0)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function UndecidedRoadRecordDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollbar:SetActive(true)
    self._scrollbar:SetScrollSize(self._height / total)
    self._scrollbar:SetScrollValue(proportion)
  else
    self._scrollbar:SetActive(false)
  end
end

function UndecidedRoadRecordDialog:NumberOfCell(frame)
  return #self._data
end

function UndecidedRoadRecordDialog:CellAtIndex(frame, index)
  return "mainline.undecidedroad.undecidedroadrecordcell"
end

function UndecidedRoadRecordDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function UndecidedRoadRecordDialog:OnBackBtnClicked()
  self:Destroy()
end

return UndecidedRoadRecordDialog
