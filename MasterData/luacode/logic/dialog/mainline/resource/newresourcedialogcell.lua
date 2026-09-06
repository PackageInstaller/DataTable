local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CActivityMidautumnReTips = BeanManager.GetTableByName("activity.cactivitymidautumnretips")
local Item = require("logic.manager.experimental.types.item")
local NewResourceDialogCell = class("NewResourceDialogCell", Dialog)
NewResourceDialogCell.AssetBundleName = "ui/layouts.mainline"
NewResourceDialogCell.AssetName = "ResourceDungeonPanel"
local oneline = 4
local slideRow = 2

function NewResourceDialogCell:Ctor(...)
  NewResourceDialogCell.super.Ctor(self, ...)
  self._limitItemTipsRecords = {}
  local allIds = CActivityMidautumnReTips:GetAllIds()
  local len = #allIds
  for i = 1, len do
    self._limitItemTipsRecords[allIds[i]] = CActivityMidautumnReTips:GetRecorder(allIds[i])
  end
end

function NewResourceDialogCell:OnCreate()
  self._field = self:GetChild("Frame")
  self._tips = self:GetChild("Hint")
  self._tipsImg = self:GetChild("Hint/Image")
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
  LuaNotificationCenter.AddObserver(self, self.SetExtraItemUI, Common.n_OnExtraItemLeftEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.SetExtraItemUI, Common.n_SDragonBoatFestivalInfo, nil)
end

function NewResourceDialogCell:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  UIBackManager.SetUIBackShow(false)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
end

local function AddActivityGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if not self._gameTimerID then
    self._gameTimerID = GameTimer.AddTask(0, 1, function()
      self:SetExtraItemUI()
    end)
  end
end

function NewResourceDialogCell:RefreshCell(data)
  self._data = data
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  if #self._data > oneline then
    self._frame = TableFrame.Create(self._field, self, false, true)
  elseif #self._data > oneline * slideRow then
    self._frame = TableFrame.Create(self._field, self, false, true)
  else
    self._frame = GridFrame.Create(self._field, self, true, oneline, false)
  end
  self._frame:ReloadAllCell()
  AddActivityGameTimer(self)
end

function NewResourceDialogCell:SetExtraItemUI()
  local itemId = self:GetActivityLimitItemId()
  if itemId then
    self._tips:SetActive(true)
    self._tips:SetText(NekoData.BehaviorManager.BM_Message:GetString(1595))
    local item = Item.Create(itemId)
    local imageRecord = item:GetIcon()
    self._tipsImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  elseif NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID):GetWishIsOpen() then
    self._tips:SetActive(true)
    self._tips:SetText(NekoData.BehaviorManager.BM_Message:GetString(1595))
    local imageRecord = CImagePathTable:GetRecorder(14635) or DataCommon.DefaultImageAsset
    self._tipsImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._tips:SetActive(false)
  end
end

function NewResourceDialogCell:GetDateMap(str)
  local strList1 = string.split(str, " ")
  local dateList = string.split(strList1[1], "-")
  local timeList = string.split(strList1[2], ":")
  return {
    year = dateList[1],
    month = dateList[2],
    day = dateList[3],
    hour = timeList[1],
    min = timeList[2],
    sec = timeList[3]
  }
end

function NewResourceDialogCell:GetActivityLimitItemId()
  for _, v in pairs(self._limitItemTipsRecords) do
    local startTime = os.time(self:GetDateMap(v.startTime))
    local endTime = os.time(self:GetDateMap(v.endTime))
    local curTime = os.time(ServerGameTimer.GetDateForecast())
    if startTime <= curTime and endTime >= curTime then
      return v.itemId
    end
  end
end

function NewResourceDialogCell:NumberOfCell(frame)
  return #self._data
end

function NewResourceDialogCell:CellAtIndex(frame, index)
  return "mainline.resource.newresourcedialogcellcell"
end

function NewResourceDialogCell:DataAtIndex(frame, index)
  return self._data[index]
end

function NewResourceDialogCell:OnWorldIClicked(i, fromItemTipsJump)
  local logicCell = self._frame:GetLogicCell(i)
  if not logicCell._cell then
    self._frame:GetCellDialog(logicCell)
    logicCell._cell._delegate = self._delegate
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
  end
  logicCell._cell:OnCellClicked(nil, nil, fromItemTipsJump)
end

return NewResourceDialogCell
