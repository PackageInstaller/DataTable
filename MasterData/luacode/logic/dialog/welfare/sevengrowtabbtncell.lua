local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CActiveConfig = BeanManager.GetTableByName("mission.cactiveconfig")
local CActiveMissionGroupConfig = BeanManager.GetTableByName("mission.cactivemissiongroupconfig")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local SevenGrowTabBtnCell = class("SevenGrowTabBtnCell", Dialog)
SevenGrowTabBtnCell.AssetBundleName = "ui/layouts.welfare"
SevenGrowTabBtnCell.AssetName = "SevenGrow"

function SevenGrowTabBtnCell:Ctor(...)
  SevenGrowTabBtnCell.super.Ctor(self, ...)
  self._nowTaskDay = 1
  self._lastTaskDay = 1
  self._theDayIsLock = false
  self._theDayIsClear = {}
  self._cellDataList1 = {}
  self._cellDataList2 = {}
  if NekoData.BehaviorManager.BM_SevenGrow:GetVersionIsNew() then
    CActiveMissionGroupConfig = BeanManager.GetTableByName("mission.cactivemissiongroupconfignew")
  end
  local activeCfg = CActiveConfig:GetRecorder(CActiveConfig:GetAllIds()[1])
  self._backgroundid = activeCfg.backgroundid
  self._figureid = activeCfg.figureid
  self._textID = activeCfg.TextID
  self._timeID = activeCfg.TimeID
end

function SevenGrowTabBtnCell:OnCreate()
  self._backImage = self:GetChild("BackImage")
  local imageRecord = CImagePathTable:GetRecorder(self._backgroundid) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._backText = self:GetChild("BackImage/TxtBack/Txt")
  self._backText:SetText(TextManager.GetText(self._textID))
  self._timeText = self:GetChild("BackImage/Time/Time")
  self._frame1 = self:GetChild("BackImage/Frame1")
  self._frame2 = self:GetChild("BackImage/Frame2")
  self._detailBtn = self:GetChild("BackImage/DetailBtn")
  self._lockTxt = self:GetChild("BackImage/LockTxt")
  self._lockTxt:SetActive(self._theDayIsLock)
  self._allClear = self:GetChild("BackImage/AllClear")
  self._allClear:SetActive(false)
  self._btnDays = {}
  self._btnDaysSelect = {}
  self._btnDaysLock = {}
  self._btnDaysNormal = {}
  self._btnDaysText = {}
  self._btnDaysRedDot = {}
  for _, cid in ipairs(CActiveMissionGroupConfig:GetAllIds()) do
    local record = CActiveMissionGroupConfig:GetRecorder(cid)
    self._btnDays[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id))
    self._btnDays[record.id]:Subscribe_PointerClickEvent(function()
      self:OnBtnDaysClick(record.id)
    end, self)
    self._btnDaysSelect[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id) .. "/Select")
    self._btnDaysSelect[record.id]:SetActive(false)
    self._btnDaysLock[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id) .. "/Lock")
    self._btnDaysLock[record.id]:SetActive(true)
    self._btnDaysNormal[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id) .. "/Normal")
    self._btnDaysNormal[record.id]:SetActive(false)
    self._btnDaysText[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id) .. "/Text")
    self._btnDaysText[record.id]:SetText(TextManager.GetText(record.groupnameTextID))
    self._btnDaysRedDot[record.id] = self:GetChild("BackImage/BtnFrame/Day" .. tostring(record.id) .. "/RedDot")
    self._btnDaysRedDot[record.id]:SetActive(false)
    self._cellDataList2[record.id] = {}
  end
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailBtnClick, self)
  self._cellFrame1 = TableFrame.Create(self._frame1, self, true, false, false, true)
  self._cellFrame2 = TableFrame.Create(self._frame2, self, true, true, true, true)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnSActivityTasksUpdate(false)
  end, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnSActivityTasksUpdate(true)
  end, Common.n_OnSRefreshActivityTask, nil)
end

function SevenGrowTabBtnCell:OnDestroy()
  self._cellFrame1:Destroy()
  self._cellFrame2:Destroy()
end

function SevenGrowTabBtnCell:RefreshTabCell(refresh)
  local lt = os.date("!*t", NekoData.BehaviorManager.BM_SevenGrow:GetRemainTime() // 1000)
  self._timeText:SetText(string.gsub(string.gsub(TextManager.GetText(self._timeID), "%$parameter1%$", lt.day - 1), "%$parameter2%$", lt.hour))
  self:SendProtocol()
end

function SevenGrowTabBtnCell:SendProtocol()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  if protocol then
    protocol.activityID = protocol.SEVEN_DAYS
    protocol:Send()
  end
end

function SevenGrowTabBtnCell:NumberOfCell(frame)
  if frame == self._cellFrame1 then
    return 1
  else
    return #self._cellDataList2[self._nowTaskDay]
  end
end

function SevenGrowTabBtnCell:CellAtIndex(frame, index)
  return "welfare.sevengrowcell"
end

function SevenGrowTabBtnCell:DataAtIndex(frame, index)
  if frame == self._cellFrame1 then
    return {
      data = self._cellDataList1[self._nowTaskDay],
      isFirst = true
    }
  else
    return {
      data = self._cellDataList2[self._nowTaskDay][index],
      isFirst = false
    }
  end
end

function SevenGrowTabBtnCell:OnSActivityTasksUpdate(refresh)
  self:ClearCellDataList()
  local activityTasks = NekoData.BehaviorManager.BM_ActivityTasks:GetSevenDaysTasks()
  if activityTasks then
    for _, cid in ipairs(CActiveMissionGroupConfig:GetAllIds()) do
      local record = CActiveMissionGroupConfig:GetRecorder(cid)
      local showBtnReddot = false
      local isFirst = true
      local theDayIsClearTemp = true
      for _, value in ipairs(record.missionidlist) do
        local task = activityTasks[value]
        if task then
          if isFirst then
            self._cellDataList1[record.id] = task
            if self._lastTaskDay < record.id and task:GetStatus() ~= TaskStatus.ACCEPTED then
              self._lastTaskDay = record.id
            end
          else
            table.insert(self._cellDataList2[record.id], task)
          end
          if showBtnReddot == false and task:GetStatus() == TaskStatus.FINISHED then
            showBtnReddot = true
          end
          if theDayIsClearTemp == true and task:GetStatus() ~= TaskStatus.COMMITED then
            theDayIsClearTemp = false
          end
        end
        isFirst = false
      end
      self._theDayIsClear[record.id] = theDayIsClearTemp
      self._btnDaysRedDot[record.id]:SetActive(showBtnReddot)
    end
    for key, _ in pairs(self._btnDaysLock) do
      if key <= self._lastTaskDay then
        self._btnDaysLock[key]:SetActive(false)
        self._btnDaysNormal[key]:SetActive(true)
      else
        self._btnDaysLock[key]:SetActive(true)
        self._btnDaysNormal[key]:SetActive(false)
      end
    end
    self:SortCellDataList2()
    if refresh then
      self:OnBtnDaysClick(self._nowTaskDay)
    else
      self:OnBtnDaysClick(self._lastTaskDay)
    end
  end
end

local sortHelper = {
  [TaskStatus.FINISHED] = 1,
  [TaskStatus.PROCESSING] = 2,
  [TaskStatus.ACCEPTED] = 3,
  [TaskStatus.COMMITED] = 4
}

function SevenGrowTabBtnCell:SortCellDataList2()
  for tempDayID, _ in pairs(self._cellDataList2) do
    table.sort(self._cellDataList2[tempDayID], function(taskA, taskB)
      local sortIdA1 = sortHelper[taskA:GetStatus()]
      local sortIdB1 = sortHelper[taskB:GetStatus()]
      if sortIdA1 == nil then
        sortIdA1 = 99
      end
      if sortIdB1 == nil then
        sortIdB1 = 99
      end
      local sortIdA2 = taskA:GetID()
      local sortIdB2 = taskB:GetID()
      if sortIdA1 == sortIdB1 then
        return sortIdA2 < sortIdB2
      else
        return sortIdA1 < sortIdB1
      end
    end)
  end
end

function SevenGrowTabBtnCell:ClearCellDataList()
  for key, _ in pairs(self._cellDataList1) do
    self._cellDataList1[key] = nil
  end
  for key, _ in pairs(self._cellDataList2) do
    for key2, _ in pairs(self._cellDataList2[key]) do
      self._cellDataList2[key][key2] = nil
    end
  end
end

function SevenGrowTabBtnCell:OnBtnDaysClick(btnId)
  self._nowTaskDay = btnId
  self:ReloadFrames()
  self._theDayIsLock = self._nowTaskDay > self._lastTaskDay
  self._lockTxt:SetActive(self._theDayIsLock)
  self._allClear:SetActive(self._theDayIsClear[self._nowTaskDay] or false)
  for tempBtnId, tempBtn in pairs(self._btnDaysSelect) do
    if tempBtnId == btnId then
      tempBtn:SetActive(true)
    else
      tempBtn:SetActive(false)
    end
  end
end

function SevenGrowTabBtnCell:OnDetailBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  if dialog then
    dialog:Init({
      roleIdList = {
        self._figureid
      },
      cfgIdList = {6},
      index = 1
    }, dialog.ShowType.BaseLevelInfo)
  end
end

function SevenGrowTabBtnCell:ReloadFrames()
  self._cellFrame1:ReloadAllCell()
  self._cellFrame2:ReloadAllCell()
  self._cellFrame2:MoveToTop(false)
end

return SevenGrowTabBtnCell
