-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/newresourcedialogcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CActivityMidautumnReTips = (BeanManager.GetTableByName)("activity.cactivitymidautumnretips")
local Item = require("logic.manager.experimental.types.item")
local NewResourceDialogCell = class("NewResourceDialogCell", Dialog)
NewResourceDialogCell.AssetBundleName = "ui/layouts.mainline"
NewResourceDialogCell.AssetName = "ResourceDungeonPanel"
local oneline = 4
local slideRow = 2
NewResourceDialogCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewResourceDialogCell, CActivityMidautumnReTips
  ((NewResourceDialogCell.super).Ctor)(self, ...)
  self._limitItemTipsRecords = {}
  local allIds = CActivityMidautumnReTips:GetAllIds()
  local len = #allIds
  for i = 1, len do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

    (self._limitItemTipsRecords)[allIds[i]] = CActivityMidautumnReTips:GetRecorder(allIds[i])
  end
end

NewResourceDialogCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._field = self:GetChild("Frame")
  self._tips = self:GetChild("Hint")
  self._tipsImg = self:GetChild("Hint/Image")
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(6)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetExtraItemUI, Common.n_OnExtraItemLeftEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetExtraItemUI, Common.n_SDragonBoatFestivalInfo, nil)
end

NewResourceDialogCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
end

local AddActivityGameTimer = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if not self._gameTimerID then
    self._gameTimerID = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:SetExtraItemUI()
  end
)
  end
end

NewResourceDialogCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : oneline, TableFrame, slideRow, GridFrame, AddActivityGameTimer
  self._data = data
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  if oneline < #self._data then
    self._frame = (TableFrame.Create)(self._field, self, false, true)
  else
    if oneline * slideRow < #self._data then
      self._frame = (TableFrame.Create)(self._field, self, false, true)
    else
      self._frame = (GridFrame.Create)(self._field, self, true, oneline, false)
    end
  end
  ;
  (self._frame):ReloadAllCell()
  AddActivityGameTimer(self)
end

NewResourceDialogCell.SetExtraItemUI = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item, CImagePathTable
  local itemId = self:GetActivityLimitItemId()
  if itemId then
    (self._tips):SetActive(true)
    ;
    (self._tips):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1595))
    local item = (Item.Create)(itemId)
    local imageRecord = item:GetIcon()
    ;
    (self._tipsImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)):GetWishIsOpen() then
        (self._tips):SetActive(true)
        ;
        (self._tips):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1595))
        if not CImagePathTable:GetRecorder(14635) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._tipsImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          ;
          (self._tips):SetActive(false)
        end
      end
    end
  end
end

NewResourceDialogCell.GetDateMap = function(self, str)
  -- function num : 0_6 , upvalues : _ENV
  local strList1 = (string.split)(str, " ")
  local dateList = (string.split)(strList1[1], "-")
  local timeList = (string.split)(strList1[2], ":")
  return {year = dateList[1], month = dateList[2], day = dateList[3], hour = timeList[1], min = timeList[2], sec = timeList[3]}
end

NewResourceDialogCell.GetActivityLimitItemId = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in pairs(self._limitItemTipsRecords) do
    local startTime = (os.time)(self:GetDateMap(v.startTime))
    local endTime = (os.time)(self:GetDateMap(v.endTime))
    local curTime = (os.time)((ServerGameTimer.GetDateForecast)())
    if startTime <= curTime and curTime <= endTime then
      return v.itemId
    end
  end
end

NewResourceDialogCell.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._data
end

NewResourceDialogCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "mainline.resource.newresourcedialogcellcell"
end

NewResourceDialogCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._data)[index]
end

NewResourceDialogCell.OnWorldIClicked = function(self, i, fromItemTipsJump)
  -- function num : 0_11
  local logicCell = (self._frame):GetLogicCell(i)
  if not logicCell._cell then
    (self._frame):GetCellDialog(logicCell)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (logicCell._cell)._delegate = self._delegate
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (logicCell._cell)._cellData = logicCell._data
    ;
    (logicCell._cell):RefreshCell(logicCell._data)
  end
  ;
  (logicCell._cell):OnCellClicked(nil, nil, fromItemTipsJump)
end

return NewResourceDialogCell

