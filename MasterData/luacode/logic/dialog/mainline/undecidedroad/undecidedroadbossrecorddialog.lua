local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadBossRecordDialog = class("UndecidedRoadBossRecordDialog", Dialog)
UndecidedRoadBossRecordDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadBossRecordDialog.AssetName = "ActivityRoadBossRecord"
local BottomToTop = 2

function UndecidedRoadBossRecordDialog:Ctor(...)
  UndecidedRoadBossRecordDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function UndecidedRoadBossRecordDialog:OnCreate()
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._panel = self:GetChild("Back/Frame")
  self._width, self._height = self._panel:GetRectSize()
  self._scrollbar = self:GetChild("Back/Scrollbar")
  self._scrollbar:SetScrollDirection(BottomToTop)
  self._frame = TableFrame.Create(self._panel, self, true, true, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function UndecidedRoadBossRecordDialog:OnDestroy()
  self._frame:Destroy()
end

function UndecidedRoadBossRecordDialog:SetData(data)
  while #self._data > 0 do
    table.remove(self._data, #self._data)
  end
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
          skin = record.roleSkinList[k]
        }
      end
    end
    temp.type = k
    temp.score = v.score
    temp.time = v.time
    table.insert(self._data, temp)
  end
  self._emptyTxt:SetActive(#self._data == 0)
  self._frame:ReloadAllCell()
end

function UndecidedRoadBossRecordDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollbar:SetActive(true)
    self._scrollbar:SetScrollSize(self._height / total)
    self._scrollbar:SetScrollValue(proportion)
  else
    self._scrollbar:SetActive(false)
  end
end

function UndecidedRoadBossRecordDialog:NumberOfCell(frame)
  return #self._data
end

function UndecidedRoadBossRecordDialog:CellAtIndex(frame, index)
  return "mainline.undecidedroad.undecidedroadbossrecordcell"
end

function UndecidedRoadBossRecordDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function UndecidedRoadBossRecordDialog:OnBackBtnClicked()
  self:Destroy()
end

return UndecidedRoadBossRecordDialog
