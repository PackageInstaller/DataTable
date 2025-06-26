-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadbossrecorddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadBossRecordDialog = class("UndecidedRoadBossRecordDialog", Dialog)
UndecidedRoadBossRecordDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadBossRecordDialog.AssetName = "ActivityRoadBossRecord"
local BottomToTop = 2
UndecidedRoadBossRecordDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadBossRecordDialog
  ((UndecidedRoadBossRecordDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

UndecidedRoadBossRecordDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._panel = self:GetChild("Back/Frame")
  self._width = (self._panel):GetRectSize()
  self._scrollbar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollbar):SetScrollDirection(BottomToTop)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

UndecidedRoadBossRecordDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

UndecidedRoadBossRecordDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  while #self._data > 0 do
    (table.remove)(self._data, #self._data)
  end
  self._battleType = data.battleType
  for k,v in pairs(data.record) do
    local record = v
    local temp = {}
    temp.roleIdList = {}
    for k,v in pairs(record.roleIdList) do
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R14 in 'UnsetPending'

      if v ~= 0 then
        (temp.roleIdList)[k] = {id = v, lv = (record.roleLvList)[k], breakLv = (record.roleBreakList)[k], skin = (record.roleSkinList)[k]}
      end
    end
    temp.type = k
    temp.score = v.score
    temp.time = v.time
    ;
    (table.insert)(self._data, temp)
  end
  ;
  (self._emptyTxt):SetActive(#self._data == 0)
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UndecidedRoadBossRecordDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollbar):SetActive(true)
    ;
    (self._scrollbar):SetScrollSize(self._height / total)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  else
    ;
    (self._scrollbar):SetActive(false)
  end
end

UndecidedRoadBossRecordDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

UndecidedRoadBossRecordDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.undecidedroad.undecidedroadbossrecordcell"
end

UndecidedRoadBossRecordDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

UndecidedRoadBossRecordDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return UndecidedRoadBossRecordDialog

