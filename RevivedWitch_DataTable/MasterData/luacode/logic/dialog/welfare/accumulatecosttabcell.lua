-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/accumulatecosttabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local AccumulateCostTabCell = class("AccumulateCostTabCell", Dialog)
AccumulateCostTabCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTabCell.AssetName = "ActivityConsumption"
AccumulateCostTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateCostTabCell
  ((AccumulateCostTabCell.super).Ctor)(self, ...)
  self._init = false
  self._accumulateCost = nil
  self._activityClose = false
  self._activityTask = nil
  self._taskList = {}
end

AccumulateCostTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._restTime = self:GetChild("BackImage/TxtFrame/Time")
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, true, true, true)
  ;
  (self:GetChild("Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2196))
end

AccumulateCostTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

local FirstCanGetIndex = function(self)
  -- function num : 0_3 , upvalues : _ENV, CommonAwardsSatus
  if not self._activityClose then
    for i,v in ipairs(self._taskList) do
      if v.status == CommonAwardsSatus.UNLOCKED then
        return i
      end
    end
  end
end

AccumulateCostTabCell.RefreshTabCell = function(self, refresh, notChangeSlidePos)
  -- function num : 0_4 , upvalues : _ENV, FirstCanGetIndex
  if not self._init or refresh then
    local accumulateCost = ((NekoData.BehaviorManager).BM_Welfare):GetAccumulateCost()
    if not accumulateCost and self._accumulateCost then
      self._activityClose = true
    end
    if self._activityClose then
      if self._activityTask then
        (GameTimer.RemoveTask)(self._activityTask)
        self._activityTask = nil
      end
      ;
      (self._restTime):SetActive(false)
    else
      ;
      (self._restTime):SetActive(true)
      if not self._activityTask then
        self._activityTask = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshTime()
  end
)
      end
      self._accumulateCost = clone(accumulateCost)
      while (self._taskList)[#self._taskList] do
        (table.remove)(self._taskList, #self._taskList)
      end
      for k,v in pairs((self._accumulateCost).awardStatus) do
        (table.insert)(self._taskList, {id = k, status = v.status, awards = v.awards})
      end
      ;
      (table.sort)(self._taskList, function(a, b)
    -- function num : 0_4_1
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    local lastPos = (self._cellFrame):GetCurrentPosition()
    local firstCanGetIndex = FirstCanGetIndex(self)
    ;
    (self._cellFrame):ReloadAllCell()
    if firstCanGetIndex then
      (self._cellFrame):MoveTopToIndex(firstCanGetIndex)
    else
      if notChangeSlidePos and lastPos then
        (self._cellFrame):MoveToAssignedPos(lastPos)
      else
        ;
        (self._cellFrame):MoveToTop()
      end
    end
  end
end

AccumulateCostTabCell.RefreshTime = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local leftTime = ((NekoData.BehaviorManager).BM_Activity):GetOtherActivityLeftTimeWithActivityId((DataCommon.Activities).AccumulateCost)
  if leftTime then
    local time = leftTime / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = ((math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60))
    local str = nil
    if day > 0 then
      local str1 = ((NekoData.BehaviorManager).BM_Message):GetString(1043)
      local str2 = ((NekoData.BehaviorManager).BM_Message):GetString(1044)
      str = day .. str1 .. hour .. str2
    else
      do
        if hour > 0 then
          local str2 = ((NekoData.BehaviorManager).BM_Message):GetString(1044)
          str = hour .. str2
        else
          do
            local str3 = ((NekoData.BehaviorManager).BM_Message):GetString(1045)
            do
              local str4 = ((NekoData.BehaviorManager).BM_Message):GetString(1107, {sec})
              str = min .. str3 .. str4
              ;
              (self._restTime):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2197, {str}))
            end
          end
        end
      end
    end
  end
end

AccumulateCostTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._taskList
end

AccumulateCostTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "welfare.accumulatecosttaskcell"
end

AccumulateCostTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._taskList)[index]
end

return AccumulateCostTabCell

