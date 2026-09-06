local TableFrame = require("framework.ui.frame.table.tableframe")
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local AccumulateCostTabCell = class("AccumulateCostTabCell", Dialog)
AccumulateCostTabCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTabCell.AssetName = "ActivityConsumption"

function AccumulateCostTabCell:Ctor(...)
  AccumulateCostTabCell.super.Ctor(self, ...)
  self._init = false
  self._accumulateCost = nil
  self._activityClose = false
  self._activityTask = nil
  self._taskList = {}
end

function AccumulateCostTabCell:OnCreate()
  self._restTime = self:GetChild("BackImage/TxtFrame/Time")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, true, true, true)
  self:GetChild("Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2196))
end

function AccumulateCostTabCell:OnDestroy()
  self._cellFrame:Destroy()
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

local function FirstCanGetIndex(self)
  if not self._activityClose then
    for i, v in ipairs(self._taskList) do
      if v.status == CommonAwardsSatus.UNLOCKED then
        return i
      end
    end
  end
end

function AccumulateCostTabCell:RefreshTabCell(refresh, notChangeSlidePos)
  if not self._init or refresh then
    local accumulateCost = NekoData.BehaviorManager.BM_Welfare:GetAccumulateCost()
    if not accumulateCost and self._accumulateCost then
      self._activityClose = true
    end
    if self._activityClose then
      if self._activityTask then
        GameTimer.RemoveTask(self._activityTask)
        self._activityTask = nil
      end
      self._restTime:SetActive(false)
    else
      self._restTime:SetActive(true)
      if not self._activityTask then
        self._activityTask = GameTimer.AddTask(0, 1, function()
          self:RefreshTime()
        end)
      end
      self._accumulateCost = clone(accumulateCost)
      while self._taskList[#self._taskList] do
        table.remove(self._taskList, #self._taskList)
      end
      for k, v in pairs(self._accumulateCost.awardStatus) do
        table.insert(self._taskList, {
          id = k,
          status = v.status,
          awards = v.awards
        })
      end
      table.sort(self._taskList, function(a, b)
        return a.id < b.id
      end)
    end
    local lastPos = self._cellFrame:GetCurrentPosition()
    local firstCanGetIndex = FirstCanGetIndex(self)
    self._cellFrame:ReloadAllCell()
    if firstCanGetIndex then
      self._cellFrame:MoveTopToIndex(firstCanGetIndex)
    elseif notChangeSlidePos and lastPos then
      self._cellFrame:MoveToAssignedPos(lastPos)
    else
      self._cellFrame:MoveToTop()
    end
  end
end

function AccumulateCostTabCell:RefreshTime()
  local leftTime = NekoData.BehaviorManager.BM_Activity:GetOtherActivityLeftTimeWithActivityId(DataCommon.Activities.AccumulateCost)
  if leftTime then
    local time = leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str
    if 0 < day then
      local str1 = NekoData.BehaviorManager.BM_Message:GetString(1043)
      local str2 = NekoData.BehaviorManager.BM_Message:GetString(1044)
      str = day .. str1 .. hour .. str2
    elseif 0 < hour then
      local str2 = NekoData.BehaviorManager.BM_Message:GetString(1044)
      str = hour .. str2
    else
      local str3 = NekoData.BehaviorManager.BM_Message:GetString(1045)
      local str4 = NekoData.BehaviorManager.BM_Message:GetString(1107, {sec})
      str = min .. str3 .. str4
    end
    self._restTime:SetText(NekoData.BehaviorManager.BM_Message:GetString(2197, {str}))
  end
end

function AccumulateCostTabCell:NumberOfCell(frame)
  return #self._taskList
end

function AccumulateCostTabCell:CellAtIndex(frame, index)
  return "welfare.accumulatecosttaskcell"
end

function AccumulateCostTabCell:DataAtIndex(frame, index)
  return self._taskList[index]
end

return AccumulateCostTabCell
